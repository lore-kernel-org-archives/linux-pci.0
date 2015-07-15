Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55A6AD1F.902@caviumnetworks.com>
Date: Wed, 15 Jul 2015 11:57:35 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Robert Richter <rrichter@cavium.com>,
	<linux-kernel@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 4/5] irqchip: gic-v3: Add gic_get_irq_domain() to get
 the irqdomain of the GIC.
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com> <1436979285-8177-5-git-send-email-ddaney.cavm@gmail.com> <55A6947F.8070903@arm.com>
In-Reply-To: <55A6947F.8070903@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/15/2015 10:12 AM, Marc Zyngier wrote:
> On 15/07/15 17:54, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Needed to map SPI interrupt sources.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/irqchip/irq-gic-v3.c       | 5 +++++
>>   include/linux/irqchip/arm-gic-v3.h | 1 +
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index c52f7ba..0019fed 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -58,6 +58,11 @@ static struct gic_chip_data gic_data __read_mostly;
>>   /* Our default, arbitrary priority value. Linux only uses one anyway. */
>>   #define DEFAULT_PMR_VALUE	0xf0
>>
>> +struct irq_domain *gic_get_irq_domain(void)
>> +{
>> +	return gic_data.domain;
>> +}
>> +
>>   static inline unsigned int gic_irq(struct irq_data *d)
>>   {
>>   	return d->hwirq;
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 18e3757..5992224 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -391,6 +391,7 @@ int its_init(struct device_node *node, struct rdists *rdists,
>>
>>   typedef u32 (*its_pci_requester_id_t)(struct pci_dev *, u16);
>>   void set_its_pci_requester_id(its_pci_requester_id_t fn);
>> +struct irq_domain *gic_get_irq_domain(void);
>>   #endif
>>
>>   #endif
>>
>
> Hmmmffff... You need the domain for SPIs??
>
> What is wrong with putting these interrupts in your device tree?
>

There is no device tree node for ECAM based "PCIe" devices, they are 
discovered in the PCI bus scan, yet they still need to use SPI interrupts.

We need a way to be able to map these.

David Daney



> 	M.
>

