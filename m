Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37727 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeC0MEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Mar 2018 08:04:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id r131so14390143wmb.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Mar 2018 05:04:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309174800.GB10137@red-moon>
References: <1519734024-32253-1-git-send-email-l.subrahmanya@mobiveil.co.in> <20180309174800.GB10137@red-moon>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 27 Mar 2018 17:34:08 +0530
Message-ID: <CAFZiPx0+QWf9TwFtNaT=iswVhebT9hv24FLXhHOF1UQ0C3Do6A@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Peter W Newton <peter.newton@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lorenzo,

On Fri, Mar 9, 2018 at 11:18 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Feb 27, 2018 at 07:20:24AM -0500, Subrahmanya Lingappa wrote:
>> Adds driver for Mobiveil AXI PCIe Host Bridge Soft IP -
>> GPEX 4.0, a PCIe gen4 IP. This IP has upto 8
>> outbound and inbound windows for the address translation.
>>
>> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> ---
>>  drivers/pci/host/pcie-mobiveil.c | 692 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 692 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-mobiveil.c
>>
>> diff --git a/drivers/pci/host/pcie-mobiveil.c b/drivers/pci/host/pcie-mobiveil.c
>> new file mode 100644
>> index 0000000..4270387
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-mobiveil.c
>> @@ -0,0 +1,692 @@
>> +/*
>> + * PCIe host controller driver for Mobiveil PCIe Host controller
>> + *
>> + * SPDX-License-Identifier: GPL-2.0
>> + * Copyright (c) 2017 Mobiveil Inc.
>> + * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/init.h>
>
> Nit: swap init.h and interrupt.h, alphabetical order.
>
> [...]
>
>> +/* supported number of interrupts */
>> +#define PCI_NUM_INTX    4
>
> It is already defined in PCI includes, remove it.
>
>> +#define PAB_INTA_POS    5
>                        ^^^^
> This ought to be a tab.
>
>> +/* outbound and inbound window definitions */
>> +#define WIN_NUM_0            0
>> +#define WIN_NUM_1            1
>> +#define CFG_WINDOW_TYPE              0
>> +#define IO_WINDOW_TYPE               1
>> +#define MEM_WINDOW_TYPE              2
>> +#define IB_WIN_SIZE          (256 * 1024 * 1024 * 1024)
>> +#define MAX_PIO_WINDOWS              8
>> +
>> +/* Parameters for the waiting for link up routine */
>> +#define LINK_WAIT_MAX_RETRIES        10
>> +#define LINK_WAIT_MIN                90000
>> +#define LINK_WAIT_MAX                100000
>> +
>> +struct mobiveil_pcie {
>> +     struct platform_device *pdev;
>> +     struct list_head resources;
>> +     void __iomem *config_axi_slave_base;    /* endpoint config base */
>> +     void __iomem *csr_axi_slave_base;   /* root port config base */
>                                         ^^^^
>
> A tab please.
>
>> +     void __iomem *pcie_reg_base;    /* Physical PCIe Controller Base */
> Ditto.
>
>> +     struct irq_domain *intx_domain;
>> +     raw_spinlock_t intx_mask_lock;
>> +     int irq;
>> +     int apio_wins;
>> +     int ppio_wins;
>> +     int ob_wins_configured; /*  configured outbound windows */
>> +     int ib_wins_configured; /*  configured inbound windows */
>> +     struct resource *ob_io_res;
>> +     char root_bus_nr;
>> +};
>> +
>> +static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
>> +             const u32 reg)
>> +{
>> +     writel_relaxed(value, pcie->csr_axi_slave_base + reg);
>> +}
>> +
>> +static inline u32 csr_readl(struct mobiveil_pcie *pcie,      const u32 reg)
>> +{
>> +     return readl_relaxed(pcie->csr_axi_slave_base + reg);
>> +}
>> +
>> +/*
>> + * Routine to check the downstream link status, its recommended to
>> + * check the link status before accessing downstream config resources.
>> + */
>> +static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
>> +{
>> +     return (csr_readl(pcie, LTSSM_STATUS) &
>> +             LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
>> +}
>> +
>> +static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>> +{
>> +     struct mobiveil_pcie *pcie = bus->sysdata;
>> +
>> +     /* Check if link is up when trying to access downstream ports */
>> +     if (bus->number != pcie->root_bus_nr)
>> +             if (!mobiveil_pcie_link_up(pcie))
>
> Do you really need this racy check ? Bjorn wants to remove it
> from other drivers - what happens on surprise link loss on
> your platform ?
>
link below gave multiple reasons why we might need this; looks like no
common consensus was reached.
can we keep it with the comment ?
https://www.spinics.net/lists/linux-pci/msg67910.html
>> +                     return false;
>> +
>> +     /* Only one device down on each root port */
>> +     if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
>> +             return false;
>> +
>> +     /*
>> +      * Do not read more than one device on the bus directly
>> +      * attached to RC
>> +      */
>> +     if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
>> +             return false;
>> +
>> +     return true;
>> +}
>> +
>> +/*
>> + * mobiveil_pcie_map_bus - routine to get the configuration base of either
>> + * root port or endpoint
>> + */
>> +static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
>> +                                     unsigned int devfn, int where)
>> +{
>> +     struct mobiveil_pcie *pcie = bus->sysdata;
>> +
>> +     if (!mobiveil_pcie_valid_device(bus, devfn))
>> +             return NULL;
>> +
>> +     if (bus->number == pcie->root_bus_nr) {
>> +             /* RC config access */
>> +             return pcie->csr_axi_slave_base + where;
>> +     } else {
>> +             /*
>> +              * EP config access (in Config/APIO space)
>> +              * Program PEX Address base (31..16 bits) with appropriate value
>> +              * (BDF) in PAB_AXI_AMAP_PEX_WIN_L0 Register.
>> +              * Relies on pci_lock serialization
>> +              */
>> +             csr_writel(pcie,
>> +                     bus->number << PAB_BUS_SHIFT |
>> +                     PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
>> +                     PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT,
>> +                     PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
>> +             return pcie->config_axi_slave_base + where;
>> +     }
>> +}
>> +
>> +static struct pci_ops mobiveil_pcie_ops = {
>> +     .map_bus = mobiveil_pcie_map_bus,
>> +     .read = pci_generic_config_read,
>> +     .write = pci_generic_config_write,
>> +};
>> +
>> +static void mobiveil_pcie_isr(struct irq_desc *desc)
>> +{
>> +     struct irq_chip *chip = irq_desc_get_chip(desc);
>> +     struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
>> +     struct device *dev = &pcie->pdev->dev;
>> +     unsigned long shifted_status;
>> +     u32 bit, virq;
>> +     u32 val, mask;
>
> Nit: why two lines for same type.
>
>> +     /*
>> +      * The core provides a single interrupt for both INTx/MSI messages.
>> +      * So we'll read both INTx and MSI status
>
> Add a comment for INTX and update it in the next patch. This patch
> only deals with INTX and the comment should reflect that.
>
>> +      */
>> +
>> +     chained_irq_enter(chip, desc);
>> +
>> +     /* read INTx status */
>> +     val = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
>> +     mask = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
>> +     intr_status = val & mask;
>> +
>> +     /* Handle INTx */
>> +     if (intr_status & PAB_INTP_INTX_MASK) {
>> +             shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) >>
>> +                     PAB_INTA_POS;
>> +             do {
>> +                     for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
>> +                             virq = irq_find_mapping(pcie->intx_domain,
>> +                                             bit + 1);
>
> It must be bit, not bit + 1. See DT bindings comment.
>
>> +                             if (virq)
>> +                                     generic_handle_irq(virq);
>> +                             else
>> +                                     dev_err_ratelimited(dev,
>> +                                             "unexpected IRQ, INT%d\n", bit);
>> +
>> +                             /* clear interrupt */
>> +                             csr_writel(pcie, shifted_status << PAB_INTA_POS,
>> +                                             PAB_INTP_AMBA_MISC_STAT);
>> +                     }
>> +             } while ((shifted_status >>  PAB_INTA_POS) != 0);
>> +     }
>> +
>> +     /* Clear the interrupt status */
>> +     csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
>> +     chained_irq_exit(chip, desc);
>> +}
>> +
>> +static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>> +{
>> +     struct device *dev = &pcie->pdev->dev;
>> +     struct platform_device *pdev = pcie->pdev;
>> +     struct device_node *node = dev->of_node;
>> +     struct resource *res;
>> +     const char *type;
>> +
>> +     type = of_get_property(node, "device_type", NULL);
>> +     if (!type || strcmp(type, "pci")) {
>> +             dev_err(dev, "invalid \"device_type\" %s\n", type);
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* map config resource */
>> +     res = platform_get_resource_byname(pdev,
>> +             IORESOURCE_MEM, "config_axi_slave");
>
> What can fit in a line should stay in a line, so update this wrapping.
>
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>                                            "config_axi_slave");
>
>> +     pcie->config_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
>> +     if (IS_ERR(pcie->config_axi_slave_base))
>> +             return PTR_ERR(pcie->config_axi_slave_base);
>> +     pcie->ob_io_res = res;
>> +
>> +     /* map csr resource */
>> +     res = platform_get_resource_byname(pdev,
>> +             IORESOURCE_MEM, "csr_axi_slave");
>
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>                                            "csr_axi_slave");
>
>> +     pcie->csr_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
>> +     if (IS_ERR(pcie->csr_axi_slave_base))
>> +             return PTR_ERR(pcie->csr_axi_slave_base);
>> +     pcie->pcie_reg_base = res->start;
>> +
>> +     /* read the number of windows requested */
>> +     if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
>> +             pcie->apio_wins = MAX_PIO_WINDOWS;
>> +
>> +     if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
>> +             pcie->ppio_wins = MAX_PIO_WINDOWS;
>> +
>> +     pcie->irq = platform_get_irq(pdev, 0);
>> +     if (pcie->irq <= 0) {
>> +             dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
>> +             return -ENODEV;
>> +     }
>> +
>> +     irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * select_paged_register - routine to access paged register of root complex
>> + *
>> + * registers of RC are paged, for this scheme to work
>> + * extracted higher 6 bits of the offset will be written to pg_sel
>> + * field of PAB_CTRL register and rest of the lower 10 bits enabled with
>> + * PAGE_SEL_EN are used as offset of the register.
>> + *
>> + */
>> +static void select_paged_register(struct mobiveil_pcie *pcie, u32 offset)
>> +{
>> +     int pab_ctrl_dw, pg_sel;
>> +
>> +     /* clear pg_sel field */
>> +     pab_ctrl_dw = csr_readl(pcie, PAB_CTRL);
>> +     pab_ctrl_dw = (pab_ctrl_dw & ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT));
>> +
>> +     /* set pg_sel field */
>> +     pg_sel = (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
>> +     pab_ctrl_dw |= ((pg_sel << PAGE_SEL_SHIFT));
>> +     csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
>> +}
>> +
>> +static void write_paged_register(struct mobiveil_pcie *pcie,
>> +             u32 val, u32 offset)
>> +{
>> +     u32 off = (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
>> +
>> +     select_paged_register(pcie, offset);
>> +     csr_writel(pcie, val, off);
>> +}
>> +
>> +static u32 read_paged_register(struct mobiveil_pcie *pcie, u32 offset)
>> +{
>> +     u32 off = (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
>> +
>> +     select_paged_register(pcie, offset);
>> +     return csr_readl(pcie, off);
>> +}
>> +
>> +static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
>> +             int pci_addr, u32 type, int size)
>
> size must certainly not be a signed int and must be u64, for this reason
> current windows are truncated if I am not mistaken so this is a bug.
>
>> +{
>> +     int pio_ctrl_val;
>> +     int amap_ctrl_dw;
>> +     u64 size64 =  ~(size-1);
>
> Nit: 1 space before ~ is enough and you should add on both sides of
> the minus sign (-).
>
> I think you should round it though.
>
> u64 mask = (1ULL << fls(size - 1)) - 1;
>
> (mask or whatever you may call it)
>
>> +
>> +     if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
>> +             dev_err(&pcie->pdev->dev,
>> +                     "ERROR: max inbound windows reached !\n");
>> +             return;
>> +     }
>> +
>> +     pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
>> +     csr_writel(pcie,
>> +             pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
>> +     amap_ctrl_dw =  read_paged_register(pcie, PAB_PEX_AMAP_CTRL(win_num));
>> +     amap_ctrl_dw = (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
>> +     amap_ctrl_dw = (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
>> +
>> +     write_paged_register(pcie, amap_ctrl_dw | lower_32_bits(size64),
>> +                             PAB_PEX_AMAP_CTRL(win_num));
>> +
>> +     write_paged_register(pcie, upper_32_bits(size64),
>> +                             PAB_EXT_PEX_AMAP_SIZEN(win_num));
>> +
>> +     write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
>> +     write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
>> +     write_paged_register(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
>> +}
>> +
>> +/*
>> + * routine to program the outbound windows
>> + */
>> +static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
>> +             u64 cpu_addr, u64 pci_addr, u32 config_io_bit,
>> +             int size)
>
> You have a funny way of wrapping lines, even when that's not needed,
> as in the last line.
>
>> +{
>> +
>> +     u32 value, type;
>> +     u64 size64 =  ~(size-1);
>
> See above.
>
>> +     if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
>> +             dev_err(&pcie->pdev->dev,
>> +                     "ERROR: max outbound windows reached !\n");
>> +             return;
>> +     }
>> +
>> +     /*
>> +      * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
>> +      * to 4 KB in PAB_AXI_AMAP_CTRL register
>> +      */
>> +     type = config_io_bit;
>> +     value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
>> +     csr_writel(pcie,
>> +                     1 << WIN_ENABLE_SHIFT |
>
> What fits in a line should stay in a line.
>
>> +                     type << WIN_TYPE_SHIFT |
>> +                     lower_32_bits(size64),
>> +                     PAB_AXI_AMAP_CTRL(win_num));
>
> Here:
>         csr_writel(pcie, 1 << WIN_ENABLE_SHIFT |
>                         type << WIN_TYPE_SHIFT |
>                         lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
>> +     write_paged_register(pcie, upper_32_bits(size64),
>> +                             PAB_EXT_AXI_AMAP_SIZE(win_num));
>> +
>> +     /*
>> +      * program AXI window base with appropriate value in
>> +      * PAB_AXI_AMAP_AXI_WIN0 register
>> +      */
>> +     value = csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
>> +     csr_writel(pcie,
>> +                     cpu_addr >> AXI_WINDOW_BASE_SHIFT <<
>> +                     AXI_WINDOW_BASE_SHIFT, PAB_AXI_AMAP_AXI_WIN(win_num));
>
> Can you explain to me what this >> << is there for ?
>
>> +     value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
>> +
>> +     csr_writel(pcie, lower_32_bits(pci_addr),
>> +                     PAB_AXI_AMAP_PEX_WIN_L(win_num));
>> +     csr_writel(pcie, upper_32_bits(pci_addr),
>> +                     PAB_AXI_AMAP_PEX_WIN_H(win_num));
>> +
>> +     pcie->ob_wins_configured++;
>> +}
>> +
>> +static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>> +{
>> +     int retries;
>> +
>> +     /* check if the link is up or not */
>> +     for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>> +             if (mobiveil_pcie_link_up(pcie))
>> +                     return 0;
>> +
>> +             usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
>> +     }
>> +     dev_err(&pcie->pdev->dev, "link never came up\n");
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>> +{
>> +     u32 value;
>> +     u32 type = 0;
>> +     u32 pab_ctrl;
>
> Why do you need three lines for the same type ?
>
>> +     int err;
>> +     struct resource_entry *win, *tmp;
>> +
>> +     err = mobiveil_bringup_link(pcie);
>> +     if (err) {
>> +             dev_info(&pcie->pdev->dev, "link bring-up failed\n");
>> +             return err;
>> +     }
>> +
>> +     /*
>> +      * program Bus Master Enable Bit in Command Register in PAB Config
>> +      * Space
>> +      */
>> +     value = csr_readl(pcie, PCI_COMMAND);
>> +     csr_writel(pcie, value | PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
>> +             PCI_COMMAND_MASTER,     PCI_COMMAND);
>                                    ^
>
> Tab not needed, just a space.
>
>> +     /*
>> +      * program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in PAB_CTRL
>> +      * register
>> +      */
>> +     pab_ctrl = csr_readl(pcie, PAB_CTRL);
>> +     csr_writel(pcie, pab_ctrl | (1 << AMBA_PIO_ENABLE_SHIFT) |
>> +             (1 << PEX_PIO_ENABLE_SHIFT),
>> +             PAB_CTRL);
>> +
>> +     csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
>> +             PAB_INTP_AMBA_MISC_ENB);
>> +
>> +     /* program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
>> +      * PAB_AXI_PIO_CTRL Register
>> +      */
>> +     value = csr_readl(pcie, PAB_AXI_PIO_CTRL);
>> +     csr_writel(pcie, value | APIO_EN_MASK, PAB_AXI_PIO_CTRL);
>> +
>> +     /*
>> +      * we'll program one outbound window for config reads and
>> +      * another default inbound window for all the upstream traffic
>> +      * rest of the outbound windows will be configured according to
>> +      * the "ranges" field defined in device tree
>> +      */
>> +
>> +     /* config outbound translation window */
>> +     program_ob_windows(pcie, pcie->ob_wins_configured,
>> +                     pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
>> +                     resource_size(pcie->ob_io_res));
>> +
>> +     /* memory inbound  translation window */
>> +     program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>> +
>> +     /* Get the I/O and memory ranges from DT */
>> +     resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
>> +             type = 0;
>> +             if (resource_type(win->res) == IORESOURCE_MEM)
>> +                     type = MEM_WINDOW_TYPE;
>> +             if (resource_type(win->res) == IORESOURCE_IO)
>> +                     type = IO_WINDOW_TYPE;
>> +             if (type) {
>> +                     /* configure outbound translation window */
>> +                     program_ob_windows(pcie, pcie->ob_wins_configured,
>> +                             win->res->start, 0, type,
>> +                             resource_size(win->res));
>> +             }
>> +     }
>> +
>> +     return err;
>> +}
>> +
>> +static void mobiveil_mask_intx_irq(struct irq_data *data)
>> +{
>> +     struct irq_desc *desc = irq_to_desc(data->irq);
>> +     struct mobiveil_pcie *pcie;
>> +     unsigned long flags;
>> +     u32 mask;
>> +     u32 shifted_val;
>
> All u32 variables in one line please.
>
>> +     pcie = irq_desc_get_chip_data(desc);
>> +     mask = 1 << ((data->hwirq + PAB_INTA_POS) - 1);
>> +     raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
>> +     shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
>> +     csr_writel(pcie, (shifted_val & (~mask)), PAB_INTP_AMBA_MISC_ENB);
>> +     raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
>> +}
>> +
>> +static void mobiveil_unmask_intx_irq(struct irq_data *data)
>> +{
>> +     struct irq_desc *desc = irq_to_desc(data->irq);
>> +     struct mobiveil_pcie *pcie;
>> +     unsigned long flags;
>> +     u32 shifted_val;
>> +     u32 mask;
>
> All u32 in one line.
>
>> +
>> +     pcie = irq_desc_get_chip_data(desc);
>> +     mask = 1 << ((data->hwirq + PAB_INTA_POS) - 1);
>> +     raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
>> +     shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
>> +     csr_writel(pcie, (shifted_val | mask), PAB_INTP_AMBA_MISC_ENB);
>> +     raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
>> +}
>> +
>> +static struct irq_chip intx_irq_chip = {
>> +     .name = "mobiveil_pcie:intx",
>> +     .irq_enable = mobiveil_unmask_intx_irq,
>> +     .irq_disable = mobiveil_mask_intx_irq,
>> +     .irq_mask = mobiveil_mask_intx_irq,
>> +     .irq_unmask = mobiveil_unmask_intx_irq,
>> +};
>> +
>> +/* routine to setup the INTx related data */
>> +static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>> +             irq_hw_number_t hwirq)
>> +{
>> +     irq_set_chip_and_handler(irq, &intx_irq_chip, handle_simple_irq);
>> +     irq_set_chip_data(irq, domain->host_data);
>> +     return 0;
>> +}
>> +
>> +/* INTx domain operations structure */
>> +static const struct irq_domain_ops intx_domain_ops = {
>> +     .map = mobiveil_pcie_intx_map,
>> +     .xlate = pci_irqd_intx_xlate,
>
> I do not think you need this xlate if you follow what's discussed in DT
> bindings.
>
>> +};
>> +
>> +static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>> +{
>> +     struct device *dev = &pcie->pdev->dev;
>> +     struct device_node *node = dev->of_node;
>> +     int ret;
>> +
>> +     /* setup INTx */
>> +     pcie->intx_domain = irq_domain_add_linear(node,
>> +                             PCI_NUM_INTX + 1, &intx_domain_ops, pcie);
>
> Remove (+1).
>
>> +     if (!pcie->intx_domain) {
>> +             dev_err(dev, "Failed to get a INTx IRQ domain\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     raw_spin_lock_init(&pcie->intx_mask_lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static int mobiveil_pcie_probe(struct platform_device *pdev)
>> +{
>> +     struct mobiveil_pcie *pcie;
>> +     struct pci_bus *bus;
>> +     struct pci_bus *child;
>> +     struct pci_host_bridge *bridge;
>> +     struct device *dev = &pdev->dev;
>> +     struct device_node *node = dev->of_node;
>> +     resource_size_t iobase;
>> +     int ret;
>> +
>> +     /* allocate the PCIe port */
>> +     bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>> +     if (!bridge)
>> +             return -ENODEV;
>> +
>> +     pcie = pci_host_bridge_priv(bridge);
>> +     if (!pcie)
>> +             return -ENOMEM;
>> +
>> +     pcie->pdev = pdev;
>> +
>> +     ret = mobiveil_pcie_parse_dt(pcie);
>> +     if (ret) {
>> +             dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     INIT_LIST_HEAD(&pcie->resources);
>> +
>> +     /* parse the host bridge base addresses from the device tree file */
>> +     ret = of_pci_get_host_bridge_resources(node,
>> +                     0, 0xff, &pcie->resources, &iobase);
>> +     if (ret) {
>> +             dev_err(dev, "Getting bridge resources failed\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     /*
>> +      * configure all inbound and outbound windows and prepare the RC for
>> +      * config access
>> +      */
>> +     ret = mobiveil_host_init(pcie);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to initialize host\n");
>> +             goto error;
>> +     }
>> +
>> +     /* fixup for PCIe class register */
>> +     csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
>> +
>> +     /* initialize the IRQ domains */
>> +     ret = mobiveil_pcie_init_irq_domain(pcie);
>> +     if (ret) {
>> +             dev_err(dev, "Failed creating IRQ Domain\n");
>> +             goto error;
>> +     }
>> +
>> +     ret = devm_request_pci_bus_resources(dev, &pcie->resources);
>> +     if (ret)
>> +             goto error;
>> +
>> +     /* Initialize bridge */
>> +     list_splice_init(&pcie->resources, &bridge->windows);
>> +     bridge->dev.parent = dev;
>> +     bridge->sysdata = pcie;
>> +     bridge->busnr = pcie->root_bus_nr;
>> +     bridge->ops = &mobiveil_pcie_ops;
>> +     bridge->map_irq = of_irq_parse_and_map_pci;
>> +     bridge->swizzle_irq = pci_common_swizzle;
>> +
>> +     /* setup the kernel resources for the newly added PCIe root bus */
>> +     ret = pci_scan_root_bus_bridge(bridge);
>> +     if (ret)
>> +             goto error;
>> +
>> +     bus = bridge->bus;
>> +
>> +     pci_assign_unassigned_bus_resources(bus);
>> +     list_for_each_entry(child, &bus->children, node)
>> +             pcie_bus_configure_settings(child);
>> +     pci_bus_add_devices(bus);
>> +
>> +     platform_set_drvdata(pdev, pcie);
>
> What's this needed for ?
>
>> +     return 0;
>> +error:
>> +     pci_free_resource_list(&pcie->resources);
>> +     return ret;
>> +}
>> +
>> +static const struct of_device_id mobiveil_pcie_of_match[] = {
>> +     {.compatible = "mbvl,gpex40-pcie",},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
>> +
>> +static struct platform_driver mobiveil_pcie_driver = {
>> +     .probe = mobiveil_pcie_probe,
>> +     .driver = {
>> +                     .name = "mobiveil-pcie",
>> +                     .of_match_table = mobiveil_pcie_of_match,
>> +                     .suppress_bind_attrs = true,
>> +             },
>> +};
>> +
>> +builtin_platform_driver(mobiveil_pcie_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
>> +MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
>
> Thanks,
> Lorenzo
Thanks.
