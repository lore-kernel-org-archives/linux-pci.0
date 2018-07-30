Return-Path: <SRS0=XCJX=KO=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=XCJX=KO=gmail.com=hkallweit1@kernel.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d4666725-b459-832d-fb29-25ce930debe2@gmail.com>
Date: Mon, 30 Jul 2018 23:50:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 30.07.2018 23:30, Bjorn Helgaas wrote:
> [+cc Thomas, Christoph, LKML]
> 
> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
>> If we have a threaded interrupt with the handler being NULL, then
>> request_threaded_irq() -> __setup_irq() will complain and bail out
>> if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
>> being NULL and set IRQF_ONESHOT in this case.
>>
>> This change is needed to migrate the mei_me driver to
>> pci_alloc_irq_vectors() and pci_request_irq().
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> usage isn't mentioned in the request_threaded_irq() function doc or
> Documentation/
> 
Sure.

That's the related comment in __setup_irq():

 * The interrupt was requested with handler = NULL, so
 * we use the default primary handler for it. But it
 * does not have the oneshot flag set. In combination
 * with level interrupts this is deadly, because the
 * default primary handler just wakes the thread, then
 * the irq lines is reenabled, but the device still
 * has the level irq asserted. Rinse and repeat....
 *
 * While this works for edge type interrupts, we play
 * it safe and reject unconditionally because we can't
 * say for sure which type this interrupt really
 * has. The type flags are unreliable as the
 * underlying chip implementation can override them.
 */


>> ---
>>  drivers/pci/irq.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
>> index 2a808e10..a1de501a 100644
>> --- a/drivers/pci/irq.c
>> +++ b/drivers/pci/irq.c
>> @@ -86,13 +86,17 @@ int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
>>  	va_list ap;
>>  	int ret;
>>  	char *devname;
>> +	unsigned long irqflags = IRQF_SHARED;
>> +
>> +	if (!handler)
>> +		irqflags |= IRQF_ONESHOT;
>>  
>>  	va_start(ap, fmt);
>>  	devname = kvasprintf(GFP_KERNEL, fmt, ap);
>>  	va_end(ap);
>>  
>>  	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
>> -			IRQF_SHARED, devname, dev_id);
>> +				   irqflags, devname, dev_id);
>>  	if (ret)
>>  		kfree(devname);
>>  	return ret;
>> -- 
>> 2.18.0
>>
> 
