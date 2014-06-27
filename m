Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:46029
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753187AbaF0Pnf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Jun 2014 11:43:35 -0400
Message-ID: <53AD911C.6040301@amd.com>
Date: Fri, 27 Jun 2014 10:43:24 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
CC: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm/gic: Add supports for GICv2m MSI(-X)
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1403569980-12913-3-git-send-email-suravee.suthikulpanit@amd.com>
 <53A94A46.1010801@arm.com>
In-Reply-To: <53A94A46.1010801@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

After looking at the GICv3 implementation and trying to understand how 
you architect the driver, I have a couple questions below.

 > On 06/24/2014 04:52 AM, Marc Zyngier wrote:
> Hi Suravee,
>
> On 24/06/14 01:33, suravee.suthikulpanit@amd.com wrote:
>> +       pr_info("GICv2m: SPI range [%d:%d]\n",
>> +               msi->spi_start, (msi->spi_start + msi->max_spi_cnt));
>> +
>> +       gic_arch_extn.irq_mask = gicv2m_mask_msi;
>> +       gic_arch_extn.irq_unmask = gicv2m_unmask_msi;
>
> Right, I now see why you need to test on the MSI descriptor. Don't do
> that. The gic_arch_extn crap should *never* *be* *used*.

Hm, sounds like this should be removed all together then? In that case, 
this would require changes in the irq-gic.c to call these functions 
directly.

>
> What you want to do is do assign a different irq_chip to your MSI
> interrupts. This will require a different integration with the main GIC
> code though. For the GICv3 ITS, I do it when the interrupt gets mapped.

Ah, that's what I was trying to avoid. Why should we need a whole 
different irq_chip just to add the MSI register frame support on top of 
the GICv2 which is already supported by the current irq-gic.c?

>
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(gicv2m_msi_init);
>> +
>> +
>> +
>> +/**
>> + * Override arch_setup_msi_irq in drivers/pci/msi.c
>> + * since we don't want to change the chip_data
>> + */
>> +int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
>> +{
>> +       struct msi_chip *chip = pdev->bus->msi;
>> +
>> +       if (!chip || !chip->setup_irq)
>> +               return -EINVAL;
>> +
>> +       return chip->setup_irq(chip, pdev, desc);
>> +}
>> +
>> +/**
>> + * Override arch_teardown_msi_irq in drivers/pci/msi.c
>> + */
>> +void arch_teardown_msi_irq(unsigned int irq)
>> +{
>> +       struct msi_desc *desc;
>> +       struct msi_chip *chip;
>> +
>> +       desc = irq_get_msi_desc(irq);
>> +       if (!desc)
>> +               return;a
>> +
>> +       chip = desc->dev->bus->msi;
>> +       if (!chip)
>> +               return;
>> +
>> +       chip->teardown_irq(chip, irq);
>> +}
>
> Please don't overtide those. There shouldn't be any reason for a
> *driver* to do so. Only architecture code should do it. And nothing in
> your code requires it (at least once you've stopped playing with the
> silly gic extension...).

The reason I need these because the __weak version of arch_setup_msi_irq 
function in driver/pci/msi.c calls irq_set_chip_data and replace the 
chip_data with msi_chip (originally was pointing to the gic_chip_data 
structure). This ended up breaking the GIC.

Looking at the GICv3 ITS implementation, this seems to also have similar 
implementation. So, this was not an issue for you?

Thanks,

Suravee
