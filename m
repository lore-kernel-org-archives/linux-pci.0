Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53FEEF7C.1090902@amd.com>
Date: Thu, 28 Aug 2014 03:59:40 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
CC: Mark Rutland <Mark.Rutland@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Harish.Kasiviswanathan@amd.com" <Harish.Kasiviswanathan@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2 V4] irqchip: gic: Add supports for ARM GICv2m MSI(-X)
References: <1407942041-3291-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1407942041-3291-2-git-send-email-suravee.suthikulpanit@amd.com>
 <87fvgxrgte.fsf@approximate.cambridge.arm.com>
In-Reply-To: <87fvgxrgte.fsf@approximate.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 08/15/2014 09:03 AM, Marc Zyngier wrote:
>> +
>> +static struct irq_chip gicv2m_chip;
>> +
>> +#ifdef CONFIG_OF
>
> Is there any reason why this should be guarded by CONFIG_OF? Surely the
> v2m capability should only be enabled if OF is.

[Suravee]
We are also planning to support ACPI in the future also, which will be 
using a different init function.  Also, there is the same #ifdef in the 
irq-gic.c for the gic_of_init().  So, I am just trying to be consistent 
here.


>> +
>> +       memcpy(&gicv2m_chip, gic->irq_chip, sizeof(struct irq_chip));
>> +       gicv2m_chip.name = "GICv2m",
>> +       gicv2m_chip.irq_mask = gicv2m_mask_irq;
>> +       gicv2m_chip.irq_unmask = gicv2m_unmask_irq;
>> +       gic->irq_chip = &gicv2m_chip;
>
> I liked it until this last line. You're overriding the irq_chip for the
> whole GIC. I was expecting you'd only use it for the MSI range
> (basically return a range to the caller, together with your brand new
> irq_chip).

[Suravee]
I'm not sure if I understand you point here. Actually, I don't see the 
whole point of the need to have a whole different irq_chip for v2m 
stuff.  All I need is just a way to overwrite the irq_chip.irq_mask() 
and irq_chip.irq_unmask() with the v2m version which should check for 
MSI before calling mask/unmask_msi_irq(). I should be able to just do:

	gic->irq_chip.irq_mask = gicv2m_mask_irq;
	gic->irq_chip.irq_unmask = gicv2m_unmask_irq;


>> @@ -768,19 +768,21 @@ void __init gic_init_physaddr(struct device_node *node)
>>   static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>                                  irq_hw_number_t hw)
>>   {
>> +       struct gic_chip_data *gic = d->host_data;
>> +
>>          if (hw < 32) {
>>                  irq_set_percpu_devid(irq);
>> -               irq_set_chip_and_handler(irq, &gic_chip,
>> +               irq_set_chip_and_handler(irq, gic->irq_chip,
>>                                           handle_percpu_devid_irq);
>>                  set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
>>          } else {
>> -               irq_set_chip_and_handler(irq, &gic_chip,
>> +               irq_set_chip_and_handler(irq, gic->irq_chip,
>>                                           handle_fasteoi_irq);
>
> And here you should discriminate on whether this is MSI or not, based on
> the range you got from above.
>

[Suravee]
 From above, since we only use one irq_chip (i.e. the gic_chip), there 
is no need to differentiate here, and I don't need to make these two 
line changes.

>> @@ -1009,6 +1012,16 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>>          if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
>>                  percpu_offset = 0;
>>
>> +       gic_data[gic_cnt].irq_chip = &gic_chip;
>> +
>> +       /* Currently, we only support one v2m subnode. */
>> +       child = of_get_child_by_name(node, "v2m");
>
> If you only support one v2m node, then you should also enforce it for
> potential secondaty GICs (just probing it for gic_cnt == 0 should be
> enough).

[Suravee]
Actually, if we have multiple (N) GICs, we should be able to also 
support multiple (N) V2Ms with the followings entries.
	gic0 {
		.....
		v2m {
			....
		}
	}

	gic1 {
		.....
		v2m {
			....
		}
	}

What I am not trying to support at this point is the following:

	gic0 {
		....
		v2m {
			....
		}
		v2m {
			....
		}
	}


>> diff --git a/drivers/irqchip/irq-gic.h b/drivers/irqchip/irq-gic.h
>> new file mode 100644
>> index 0000000..2ec6bc3
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-gic.h
>> @@ -0,0 +1,48 @@
>> +#ifndef _IRQ_GIC_H_
>> +#define _IRQ_GIC_H_
>> +
>> +#include <linux/msi.h>
>> +
>> +union gic_base {
>> +       void __iomem *common_base;
>> +       void __percpu * __iomem *percpu_base;
>> +};
>> +
>> +#ifdef CONFIG_ARM_GIC_V2M
>> +struct v2m_data {
>> +       spinlock_t msi_cnt_lock;
>> +       struct msi_chip msi_chip;
>> +       struct resource res;      /* GICv2m resource */
>> +       void __iomem *base;       /* GICv2m virt address */
>> +       unsigned int spi_start;   /* The SPI number that MSIs start */
>> +       unsigned int nr_spis;     /* The number of SPIs for MSIs */
>> +       unsigned long *bm;        /* MSI vector bitmap */
>> +};
>> +#endif
>
> So if you put the #ifdef/#endif *inside* the v2m_data structure...

[Suravee] Are you suggesting an empty struct v2m_data{}; Hm.. I guess I 
can do that.

Thanks,

Suravee
