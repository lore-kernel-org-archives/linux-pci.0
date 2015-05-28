Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og121.obsmtp.com ([64.18.0.139]:55523 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815AbbE1RQz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 13:16:55 -0400
Received: by oifu123 with SMTP id u123so37586089oif.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2015 10:16:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5566CC58.8080400@arm.com>
References: <20150525125206.64d15861@arm.com> <cover.1432747280.git.dhdang@apm.com>
 <8d5049d8c03f8f5883ea626596dafc7d3f1c99f1.1432747280.git.dhdang@apm.com> <5566CC58.8080400@arm.com>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 28 May 2015 10:16:23 -0700
Message-ID: <CADaLNDk12d7DO_YDYXmb0NaMeYhsFCHC2Am24=3Je7qP4iZP+w@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 1:05 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 27/05/15 19:27, Duc Dang wrote:
>> APM X-Gene v1 SoC supports its own implementation of MSI, which is not
>> compliant to GIC V2M specification for MSI Termination.
>>
>> There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports.
>> This MSI block supports 2048 MSI termination ports coalesced into 16
>> physical HW IRQ lines and shared across all 5 PCIe ports.
>>
>> As there are only 16 HW IRQs to serve 2048 MSI vectors, to support
>> set_affinity correctly for each MSI vectors, the 16 HW IRQs are statically
>> allocated to 8 X-Gene v1 cores (2 HW IRQs for each cores). To steer MSI
>> interrupt to target CPU, MSI vector is moved around these HW IRQs lines.
>> With this approach, the total MSI vectors this driver supports is reduced
>> to 256.
>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/pci/host/Kconfig         |  10 +
>>  drivers/pci/host/Makefile        |   1 +
>>  drivers/pci/host/pci-xgene-msi.c | 595 +++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/host/pci-xgene.c     |  21 ++
>>  4 files changed, 627 insertions(+)
>>  create mode 100644 drivers/pci/host/pci-xgene-msi.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 1dfb567..a93fda8 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -89,11 +89,21 @@ config PCI_XGENE
>>         depends on ARCH_XGENE
>>         depends on OF
>>         select PCIEPORTBUS
>> +       select PCI_MSI_IRQ_DOMAIN if PCI_MSI
>>         help
>>           Say Y here if you want internal PCI support on APM X-Gene SoC.
>>           There are 5 internal PCIe ports available. Each port is GEN3 capable
>>           and have varied lanes from x1 to x8.
>>
>> +config PCI_XGENE_MSI
>> +       bool "X-Gene v1 PCIe MSI feature"
>> +       depends on PCI_XGENE && PCI_MSI
>> +       default y
>> +       help
>> +         Say Y here if you want PCIE MSI support for APM X-Gene v1 SoC.
>> +         This MSI driver will provide MSI support for 5 PCIe ports of
>> +         APM X-Gene v1 SoC
>> +
>>  config PCI_LAYERSCAPE
>>         bool "Freescale Layerscape PCIe controller"
>>         depends on OF && ARM
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index f733b4e..1957431 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>>  obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>> +obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
>> new file mode 100644
>> index 0000000..461cb11
>> --- /dev/null
>> +++ b/drivers/pci/host/pci-xgene-msi.c
>> @@ -0,0 +1,595 @@
>> +/*
>> + * APM X-Gene MSI Driver
>> + *
>> + * Copyright (c) 2014, Applied Micro Circuits Corporation
>> + * Author: Tanmay Inamdar <tinamdar@apm.com>
>> + *        Duc Dang <dhdang@apm.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +#include <linux/cpu.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/msi.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of_pci.h>
>> +
>> +#define MSI_IR0                        0x000000
>> +#define MSI_INT0               0x800000
>> +#define IDX_PER_GROUP          8
>> +#define IRQS_PER_IDX           16
>> +#define NR_HW_IRQS             16
>> +#define NR_MSI_VEC             (IDX_PER_GROUP * IRQS_PER_IDX * NR_HW_IRQS)
>> +
>> +struct xgene_msi_group {
>> +       struct xgene_msi                *msi;
>> +       int                             gic_irq;
>> +       u32                             msi_grp;
>> +};
>> +
>> +struct xgene_msi {
>> +       struct device_node              *node;
>> +       struct msi_controller           mchip;
>> +       struct irq_domain               *domain;
>> +       u64                             msi_addr;
>> +       void __iomem                    *msi_regs;
>> +       unsigned long                   *bitmap;
>> +       struct mutex                    bitmap_lock;
>> +       struct xgene_msi_group          *msi_groups;
>> +       int                             num_cpus;
>> +};
>> +
>> +/* Global data */
>> +static struct xgene_msi xgene_msi_ctrl;
>> +
>> +static struct irq_chip xgene_msi_top_irq_chip = {
>> +       .name           = "X-Gene1 MSI",
>> +       .irq_enable     = pci_msi_unmask_irq,
>> +       .irq_disable    = pci_msi_mask_irq,
>> +       .irq_mask       = pci_msi_mask_irq,
>> +       .irq_unmask     = pci_msi_unmask_irq,
>> +};
>> +
>> +static struct  msi_domain_info xgene_msi_domain_info = {
>> +       .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> +                 MSI_FLAG_PCI_MSIX),
>> +       .chip   = &xgene_msi_top_irq_chip,
>> +};
>> +
>> +/*
>> + * X-Gene v1 has 16 groups of MSI termination registers MSInIRx, where
>> + * n is group number (0..F), x is index of registers in each group (0..7)
>> + * The registers layout is like following:
>> + * MSI0IR0                     base_addr
>> + * MSI0IR1                     base_addr +  0x10000
>> + * ...                         ...
>> + * MSI0IR6                     base_addr +  0x60000
>> + * MSI0IR7                     base_addr +  0x70000
>> + * MSI1IR0                     base_addr +  0x80000
>> + * MSI1IR1                     base_addr +  0x90000
>> + * ...                         ...
>> + * MSI1IR7                     base_addr +  0xF0000
>> + * MSI2IR0                     base_addr + 0x100000
>> + * ...                         ...
>> + * MSIFIR0                     base_addr + 0x780000
>> + * MSIFIR1                     base_addr + 0x790000
>> + * ...                         ...
>> + * MSIFIR7                     base_addr + 0x7F0000
>> + * MSIINT0                     base_addr + 0x800000
>> + * MSIINT1                     base_addr + 0x810000
>> + * ...                         ...
>> + * MSIINTF                     base_addr + 0x8F0000
>> + *
>> + * Each index register support 16 MSI vectors (0..15) to generate interrupt.
>> + * There are total 16 GIC IRQs assigned for these 16 groups of MSI termination
>> + * registers.
>> + *
>> + * Each MSI termination group has 1 MSIINTn register (n is 0..15) to indicate
>> + * the MSI pending status caused by 1 of its 8 index registers.
>> + */
>> +
>> +/* MSInIRx read helper */
>> +static inline u32 xgene_msi_ir_read(struct xgene_msi *msi,
>> +                                   u32 msi_grp, u32 msir_idx)
>> +{
>> +       return readl_relaxed(msi->msi_regs + MSI_IR0 +
>> +                             (msi_grp << 19) + (msir_idx << 16));
>> +}
>> +
>> +/* MSIINTn read helper */
>> +static inline u32 xgene_msi_int_read(struct xgene_msi *msi, u32 msi_grp)
>> +{
>> +       return readl_relaxed(msi->msi_regs + MSI_INT0 + (msi_grp << 16));
>> +}
>> +
>> +/* With 2048 MSI vectors supported, the MSI message can be construct using
>> + * following scheme:
>> + * - Divide into 8 256-vector groups
>> + *             Group 0: 0-255
>> + *             Group 1: 256-511
>> + *             Group 2: 512-767
>> + *             ...
>> + *             Group 7: 1792-2047
>> + * - Each 256-vector group is divided into 16 16-vector groups
>> + *     As an example: 16 16-vector groups for 256-vector group 0-255 is
>> + *             Group 0: 0-15
>> + *             Group 1: 16-32
>> + *             ...
>> + *             Group 15: 240-255
>> + * - The termination address of MSI vector in 256-vector group n and 16-vector
>> + * group x is the address of MSIxIRn
>> + * - The data for MSI vector in 16-vector group x is x
>> + */
>> +static inline u32 hwirq_to_reg_set(unsigned long hwirq)
>> +{
>> +       return (hwirq / (NR_HW_IRQS * IRQS_PER_IDX));
>> +}
>> +
>> +static inline u32 hwirq_to_group(unsigned long hwirq)
>> +{
>> +       return (hwirq % NR_HW_IRQS);
>> +}
>> +
>> +static inline u32 hwirq_to_msi_data(unsigned long hwirq)
>> +{
>> +       return ((hwirq / NR_HW_IRQS) % IRQS_PER_IDX);
>> +}
>
> These "inline" are superfluous (including the ones for the HW
> accessors). The compiler is bright enough to do it itself.

I will remove these "inline"
>
>> +
>> +static void xgene_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>> +{
>> +       struct xgene_msi *msi = irq_data_get_irq_chip_data(data);
>> +       u32 reg_set = hwirq_to_reg_set(data->hwirq);
>> +       u32 group = hwirq_to_group(data->hwirq);
>> +       u64 target_addr = msi->msi_addr + (((8 * group) + reg_set) << 16);
>> +
>> +       msg->address_hi = upper_32_bits(target_addr);
>> +       msg->address_lo = lower_32_bits(target_addr);
>> +       msg->data = hwirq_to_msi_data(data->hwirq);
>> +}
>> +
>> +/*
>> + * X-Gene v1 only has 16 MSI GIC IRQs for 2048 MSI vectors.
>> + * To maintain the expected behaviour of .set_affinity for each MSI
>> + * interrupt, the 16 MSI GIC IRQs are statically allocated to 8 X-Gene
>> + * v1 cores (2 GIC IRQs for each core). The MSI vector is moved fom 1
>> + * MSI GIC IRQ to another MSI GIC IRQ to steer its MSI interrupt to
>> + * correct X-Gene v1 core. As a consequence, the total MSI vectors that
>> + * X-Gene v1 supports will be reduced to 256 (2048/8) vectors.
>> + */
>> +static inline int hwirq_to_cpu(unsigned long hwirq)
>> +{
>> +       return ((hwirq % NR_HW_IRQS) % xgene_msi_ctrl.num_cpus);
>> +}
>> +
>> +static inline unsigned long hwirq_to_canonical_hwirq(unsigned long hwirq)
>> +{
>> +       return (hwirq - (hwirq % xgene_msi_ctrl.num_cpus));
>> +}
>
> Hmmm. This is weird. The canonical hwirq is defined as the IRQ seen from
> CPU0. So it is possible to write hwirq_to_canonical_hwirq as:
>
> static irq_hw_number_t hwirq_to_canonical_hwirq(irq_hw_number_t hwirq)
> {
>         return hwirq - hwirq_to_cpu(hwirq);
> }
>
> But you've defined hwirq_to_cpu as "(hwirq % NR_HW_IRQS) %
> xgene_msi_ctrl.num_cpus", which doesn't match your definition of a
> canonical hwirq. Can you explain the discrepancy?
>
In "(hwirq % NR_HW_IRQS) % xgene_msi_ctrl.num_cpus", I looked for the
group IRQ that the hwirq belongs to first, then figure out the CPU
that this group IRQ assigned to. With hwirq allocation scheme that is
using in this driver, defining hwirq_to_cpu as "hwirq %
xgene_msi_ctrl.num_cpus" also provides the same result. So I will
change it and use hwirq_to_cpu in hwirq_to_canonical_hwirq
implementation.

>> +
>> +static int xgene_msi_set_affinity(struct irq_data *irq_data,
>> +                                 const struct cpumask *mask, bool force)
>> +{
>> +       int target_cpu = cpumask_first(mask);
>> +       int curr_cpu;
>> +
>> +       curr_cpu = hwirq_to_cpu(irq_data->hwirq);
>> +       if (curr_cpu == target_cpu)
>> +               return IRQ_SET_MASK_OK_DONE;
>> +
>> +       /* Update MSI number to target the new CPU */
>> +       irq_data->hwirq = irq_data->hwirq + (target_cpu - curr_cpu);
>
> irq_data->hwirq = hwirq_to_canonical_hwirq(irq_data->hwirq) + target_cpu;
>
>> +
>> +       return IRQ_SET_MASK_OK;
>> +}
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
Regards,
Duc Dang.
