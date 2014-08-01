Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0206.outbound.protection.outlook.com ([207.46.163.206]:33754
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750851AbaHAQaS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Aug 2014 12:30:18 -0400
Message-ID: <53DBC074.3030309@amd.com>
Date: Fri, 1 Aug 2014 11:29:40 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
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
Subject: Re: [PATCH 3/4 V3] irqchip: gic: Add supports for ARM GICv2m MSI(-X)
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1404947104-21345-4-git-send-email-suravee.suthikulpanit@amd.com>
 <87zjfqj3mc.fsf@approximate.cambridge.arm.com> <53DBB562.5020003@amd.com>
In-Reply-To: <53DBB562.5020003@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/1/2014 10:42 AM, Suravee Suthikulanit wrote:
>>> +#ifdef CONFIG_SMP
>>> +       .irq_set_affinity       = gic_set_affinity,
>>> +#endif
>>> +#ifdef CONFIG_PM
>>> +       .irq_set_wake           = gic_set_wake,
>>> +#endif
>>> +};
>>> +
>>> +#ifdef CONFIG_OF
>>> +static int __init
>>> +gicv2m_of_init(struct device_node *node, struct device_node *parent)
>>> +{
>>> +       struct gic_chip_data *gic;
>>> +       int ret;
>>> +
>>> +       ret = _gic_of_init(node, parent, &gicv2m_chip, &gic);
>>> +       if (ret) {
>>> +               pr_err("GICv2m: Failed to initialize GIC\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       gic->msi_chip.owner = THIS_MODULE;
>>> +       gic->msi_chip.of_node = node;
>>> +       gic->msi_chip.setup_irq = gicv2m_setup_msi_irq;
>>> +       gic->msi_chip.teardown_irq = gicv2m_teardown_msi_irq;
>>> +       ret = of_pci_msi_chip_add(&gic->msi_chip);
>>> +       if (ret) {
>>> +               /* MSI is optional and not supported here */
>>> +               pr_info("GICv2m: MSI is not supported.\n");
>>> +               return 0;
>>> +       }
>>> +
>>> +       ret = gicv2m_msi_init(node, &gic->v2m_data);
>>> +       if (ret)
>>> +               return ret;
>>> +       return ret;
>>> +}
>>> +
>>> +IRQCHIP_DECLARE(arm_gic_400_v2m, "arm,gic-400-v2m", gicv2m_of_init);
>>
>> So if you follow my advise of reversing your probing and call into the
>> v2m init from the main GIC driver, you could take a irq_chip as a
>> parameter, and use it to populate the v2m irq_chip, only overriding the
>> two methods that actually differ.
>>
>> This would have the net effect of completely dropping patch #2, which
>> becomes effectively useless.
>>
>
> [Suravee] Ok, lemme look into this.

So, in previous revision, you mentioned that we should have a separate 
irq_chip for gicv2m stuff, is that is still the case here?

Thanks,

Suravee

