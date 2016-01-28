Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56A9681E.7090603@cn.fujitsu.com>
Date: Thu, 28 Jan 2016 09:00:14 +0800
From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rjw@rjwysocki.net>, <lenb@kernel.org>,
	<izumi.taku@jp.fujitsu.com>, <wency@cn.fujitsu.com>,
	<caoj.fnst@cn.fujitsu.com>, <ddaney.cavm@gmail.com>,
	<okaya@codeaurora.org>, <bhelgaas@google.com>,
	<jiang.liu@linux.intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by BIOS
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com> <20160125205803.GA10272@localhost> <alpine.DEB.2.11.1601260825510.3886@nanos> <20160126152221.GB9279@localhost> <alpine.DEB.2.11.1601261628450.3886@nanos> <20160127002505.GA3329@localhost> <alpine.DEB.2.11.1601270941190.3886@nanos> <20160127223237.GA6190@localhost>
In-Reply-To: <20160127223237.GA6190@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 01/28/2016 06:32 AM, Bjorn Helgaas wrote:
> On Wed, Jan 27, 2016 at 10:13:36AM +0100, Thomas Gleixner wrote:
>> On Tue, 26 Jan 2016, Bjorn Helgaas wrote:
>>> On Tue, Jan 26, 2016 at 04:48:25PM +0100, Thomas Gleixner wrote:
>>>> Right. So we could certainly do something like this INVALID_IRQ thingy, but
>>>> that looks a bit weird. What would request_irq() return?
>>>>
>>>> If it returns success, then drivers might make the wrong decision. If it
>>>> returns an error code, then the i801 one works, but we might have to fix
>>>> others anyway.
>>> I was thinking request_irq() could return -EINVAL if the caller passed
>>> INVALID_IRQ.  That should tell drivers that this interrupt won't work.
>>>
>>> We'd be making request_irq() return -EINVAL in some cases where it
>>> currently returns success.  But even though it returns success today,
>>> I don't think the driver is getting interrupts, because the wire isn't
>>> connected.
>> Correct. What I meant is that the i801 driver can handle the -EINVAL return
>> from request_irq() today, but other drivers don't. I agree that we need to fix
>> them anyway and a failure to request the interrupt is better than a silent 'no
>> interrupts delivered' issue.
>>   
>> Though instead of returning -EINVAL I prefer an explicit error code for this
>> case. That way a driver can distinguish between the 'not connected' case and
>> other failure modes. Something like the patch below should work.
> This patch looks great to me, thanks for all your help!
>
> Chen, do you want to put all this together as formal patches with
> changelogs and post to the mailing lists?
With pleasure. I will test it on my environment first and send it out.
thank all of you for this problem.

Chen

>
> Bjorn
>
>> 8<------------------
>> --- a/drivers/acpi/pci_irq.c
>> +++ b/drivers/acpi/pci_irq.c
>> @@ -387,6 +387,22 @@ static inline int acpi_isa_register_gsi(
>>   }
>>   #endif
>>   
>> +static inline bool acpi_pci_irq_valid(struc pci_dev *dev)
>> +{
>> +#ifdef CONFIG_X86
>> +	/*
>> +	 * On x86 irq line 0xff means "unknown" or "no connection" (PCI 3.0,
>> +	 * Section 6.2.4, footnote on page 223).
>> +	 */
>> +	if (dev->irq == 0xff) {
>> +		dev->irq = IRQ_NOTCONNECTED;
>> +		dev_warn(&dev->dev, "PCI INT not connected\n");
>> +		return false;
>> +	}
>> +#endif
>> +	return true;
>> +}
>> +
>>   int acpi_pci_irq_enable(struct pci_dev *dev)
>>   {
>>   	struct acpi_prt_entry *entry;
>> @@ -409,6 +425,9 @@ int acpi_pci_irq_enable(struct pci_dev *
>>   	if (pci_has_managed_irq(dev))
>>   		return 0;
>>   
>> +	if (!acpi_pci_irq_valid(dev))
>> +		return 0;
>> +
>>   	entry = acpi_pci_irq_lookup(dev, pin);
>>   	if (!entry) {
>>   		/*
>> --- a/include/linux/interrupt.h
>> +++ b/include/linux/interrupt.h
>> @@ -125,6 +125,16 @@ struct irqaction {
>>   
>>   extern irqreturn_t no_action(int cpl, void *dev_id);
>>   
>> +/*
>> + * If a (PCI) device interrupt is not connected we set dev->irq to
>> + * IRQ_NOTCONNECTED. This causes request_irq() to fail with -ENOTCONN, so we
>> + * can distingiush that case from other error returns.
>> + *
>> + * 0x80000000 is guaranteed to be outside the available range of interrupts
>> + * and easy to distinguish from other possible incorrect values.
>> + */
>> +#define IRQ_NOTCONNECTED	(1U << 31)
>> +
>>   extern int __must_check
>>   request_threaded_irq(unsigned int irq, irq_handler_t handler,
>>   		     irq_handler_t thread_fn,
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -1609,6 +1609,9 @@ int request_threaded_irq(unsigned int ir
>>   	struct irq_desc *desc;
>>   	int retval;
>>   
>> +	if (irq == IRQ_NOTCONNECTED)
>> +		return -ENOTCONN;
>> +
>>   	/*
>>   	 * Sanity-check: shared interrupts must pass in a real dev-ID,
>>   	 * otherwise we'll have trouble later trying to figure out
>> @@ -1699,9 +1702,13 @@ EXPORT_SYMBOL(request_threaded_irq);
>>   int request_any_context_irq(unsigned int irq, irq_handler_t handler,
>>   			    unsigned long flags, const char *name, void *dev_id)
>>   {
>> -	struct irq_desc *desc = irq_to_desc(irq);
>> +	struct irq_desc *desc;
>>   	int ret;
>>   
>> +	if (irq == IRQ_NOTCONNECTED)
>> +		return -ENOTCONN;
>> +
>> +	desc = irq_to_desc(irq);
>>   	if (!desc)
>>   		return -EINVAL;
>>   
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>
