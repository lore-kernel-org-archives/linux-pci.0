Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56054 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbbDJRUm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Apr 2015 13:20:42 -0400
Message-ID: <55280665.9020603@arm.com>
Date: Fri, 10 Apr 2015 18:20:37 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>
Subject: Re: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org> <cover.1428564115.git.dhdang@apm.com> <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
In-Reply-To: <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/04/15 18:05, Duc Dang wrote:
> X-Gene v1 SoC supports total 2688 MSI/MSIX vectors coalesced into
> 16 HW IRQ lines.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  drivers/pci/host/Kconfig         |   6 +
>  drivers/pci/host/Makefile        |   1 +
>  drivers/pci/host/pci-xgene-msi.c | 407 +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pci-xgene.c     |  21 ++
>  4 files changed, 435 insertions(+)
>  create mode 100644 drivers/pci/host/pci-xgene-msi.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 7b892a9..c9b61fa 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -89,11 +89,17 @@ config PCI_XGENE
>         depends on ARCH_XGENE
>         depends on OF
>         select PCIEPORTBUS
> +       select PCI_MSI_IRQ_DOMAIN if PCI_MSI
> +       select PCI_XGENE_MSI if PCI_MSI
>         help
>           Say Y here if you want internal PCI support on APM X-Gene SoC.
>           There are 5 internal PCIe ports available. Each port is GEN3 capable
>           and have varied lanes from x1 to x8.
> 
> +config PCI_XGENE_MSI
> +       bool "X-Gene v1 PCIe MSI feature"
> +       depends on PCI_XGENE && PCI_MSI
> +
>  config PCI_LAYERSCAPE
>         bool "Freescale Layerscape PCIe controller"
>         depends on OF && ARM
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index e61d91c..f39bde3 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -11,5 +11,6 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>  obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
> +obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
> new file mode 100644
> index 0000000..4f0ff42
> --- /dev/null
> +++ b/drivers/pci/host/pci-xgene-msi.c
> @@ -0,0 +1,407 @@
> +/*
> + * APM X-Gene MSI Driver
> + *
> + * Copyright (c) 2014, Applied Micro Circuits Corporation
> + * Author: Tanmay Inamdar <tinamdar@apm.com>
> + *        Duc Dang <dhdang@apm.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_pci.h>
> +
> +#define MSI_INDEX0             0x000000
> +#define MSI_INT0               0x800000
> +
> +struct xgene_msi_settings {
> +       u32     index_per_group;
> +       u32     irqs_per_index;
> +       u32     nr_msi_vec;
> +       u32     nr_hw_irqs;
> +};
> +
> +struct xgene_msi {
> +       struct device_node              *node;
> +       struct msi_controller           mchip;
> +       struct irq_domain               *domain;
> +       struct xgene_msi_settings       *settings;
> +       u32                             msi_addr_lo;
> +       u32                             msi_addr_hi;

I'd rather see the mailbox address directly, and only do the split when
assigning it to the message (you seem to play all kind of tricks on the
address anyway).

> +       void __iomem                    *msi_regs;
> +       unsigned long                   *bitmap;
> +       struct mutex                    bitmap_lock;
> +       int                             *msi_virqs;
> +};
> +
> +struct xgene_msi_settings storm_msi_settings = {
> +       .index_per_group        = 8,
> +       .irqs_per_index         = 21,
> +       .nr_msi_vec             = 2688,
> +       .nr_hw_irqs             = 16,
> +};

It would really help understanding how index, group and hw irq lines are
structured. nr_msi_vec is obviously the product of these three numbers,
so maybe you can loose it (we have computers, remember... ;-).

Do you expect more than this single "storm" implementation? If so, maybe
they should be described in the DT. If not, why do we need a separate
structure with an indirection if we know these are constants?

> +
> +typedef int (*xgene_msi_initcall_t)(struct xgene_msi *);
> +
> +static int xgene_msi_init_storm_settings(struct xgene_msi *xgene_msi)
> +{
> +       xgene_msi->settings = &storm_msi_settings;
> +       return 0;
> +}
> +
> +static struct irq_chip xgene_msi_top_irq_chip = {
> +       .name           = "X-Gene1 MSI",
> +       .irq_enable     = pci_msi_unmask_irq,
> +       .irq_disable    = pci_msi_mask_irq,
> +       .irq_mask       = pci_msi_mask_irq,
> +       .irq_unmask     = pci_msi_unmask_irq,
> +};
> +
> +static struct  msi_domain_info xgene_msi_domain_info = {
> +       .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +                 MSI_FLAG_PCI_MSIX),
> +       .chip   = &xgene_msi_top_irq_chip,
> +};
> +
> +static void xgene_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +       struct xgene_msi *msi = irq_data_get_irq_chip_data(data);
> +       u32 nr_hw_irqs = msi->settings->nr_hw_irqs;
> +       u32 irqs_per_index = msi->settings->irqs_per_index;
> +       u32 reg_set = data->hwirq / (nr_hw_irqs * irqs_per_index);
> +       u32 group = data->hwirq % nr_hw_irqs;
> +
> +       msg->address_hi = msi->msi_addr_hi;
> +       msg->address_lo = msi->msi_addr_lo +
> +                         (((8 * group) + reg_set) << 16);
> +       msg->data = (data->hwirq / nr_hw_irqs) % irqs_per_index;

... (sound of head exploding...). I hate it when I have to reverse
engineer the hardware by looking at the code...

Please give us some clue on how interrupts are spread across the various
pages, how the various indexes are combined to give an actual address.

> +}
> +
> +static int xgene_msi_set_affinity(struct irq_data *irq_data,
> +                                 const struct cpumask *mask, bool force)
> +{
> +       struct xgene_msi *msi = irq_data_get_irq_chip_data(irq_data);
> +       unsigned int gic_irq;
> +       int ret;
> +
> +       gic_irq = msi->msi_virqs[irq_data->hwirq % msi->settings->nr_hw_irqs];
> +       ret = irq_set_affinity(gic_irq, mask);

Erm... This as the effect of moving *all* the MSIs hanging off this
interrupt to another CPU. I'm not sure that's an acceptable effect...
What if another MSI requires a different affinity?

> +       if (ret == IRQ_SET_MASK_OK)
> +               ret = IRQ_SET_MASK_OK_DONE;
> +
> +       return ret;
> +}
> +
> +static struct irq_chip xgene_msi_bottom_irq_chip = {
> +       .name                   = "MSI",
> +       .irq_set_affinity       = xgene_msi_set_affinity,
> +       .irq_compose_msi_msg    = xgene_compose_msi_msg,
> +};
> +
> +static int xgene_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +                                 unsigned int nr_irqs, void *args)
> +{
> +
> +       struct xgene_msi *msi = domain->host_data;
> +       u32 msi_irq_count = msi->settings->nr_msi_vec;
> +       int msi_irq;
> +
> +       mutex_lock(&msi->bitmap_lock);
> +
> +       msi_irq = find_first_zero_bit(msi->bitmap, msi_irq_count);
> +       if (msi_irq < msi_irq_count)
> +               set_bit(msi_irq, msi->bitmap);
> +       else
> +               msi_irq = -ENOSPC;
> +
> +       mutex_unlock(&msi->bitmap_lock);
> +
> +       if (msi_irq < 0)
> +               return msi_irq;
> +
> +       irq_domain_set_info(domain, virq, msi_irq, &xgene_msi_bottom_irq_chip,
> +                           domain->host_data, handle_simple_irq, NULL, NULL);
> +       set_irq_flags(virq, IRQF_VALID);
> +
> +       return 0;
> +}
> +
> +static void xgene_irq_domain_free(struct irq_domain *domain,
> +                                 unsigned int virq, unsigned int nr_irqs)
> +{
> +       struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +       struct xgene_msi *msi = irq_data_get_irq_chip_data(d);
> +
> +       mutex_lock(&msi->bitmap_lock);
> +
> +       if (!test_bit(d->hwirq, msi->bitmap))
> +               pr_err("trying to free unused MSI#%lu\n", d->hwirq);
> +       else
> +               clear_bit(d->hwirq, msi->bitmap);
> +
> +       mutex_unlock(&msi->bitmap_lock);
> +
> +       irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +       .alloc  = xgene_irq_domain_alloc,
> +       .free   = xgene_irq_domain_free,
> +};
> +
> +static int xgene_allocate_domains(struct xgene_msi *msi)
> +{
> +       msi->domain = irq_domain_add_linear(NULL, msi->settings->nr_msi_vec,
> +                                           &msi_domain_ops, msi);
> +
> +       if (!msi->domain) {
> +               pr_err("failed to create parent MSI domain\n");
> +               return -ENOMEM;
> +       }
> +
> +       msi->mchip.of_node = msi->node;
> +       msi->mchip.domain = pci_msi_create_irq_domain(msi->mchip.of_node,
> +                                                     &xgene_msi_domain_info,
> +                                                     msi->domain);
> +
> +       if (!msi->mchip.domain) {
> +               pr_err("failed to create MSI domain\n");
> +               irq_domain_remove(msi->domain);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void xgene_free_domains(struct xgene_msi *msi)
> +{
> +       if (msi->mchip.domain)
> +               irq_domain_remove(msi->mchip.domain);
> +       if (msi->domain)
> +               irq_domain_remove(msi->domain);
> +}
> +
> +static int xgene_msi_init_allocator(struct xgene_msi *xgene_msi)
> +{
> +       u32 msi_irq_count = xgene_msi->settings->nr_msi_vec;
> +       u32 hw_irq_count = xgene_msi->settings->nr_hw_irqs;
> +       int size = BITS_TO_LONGS(msi_irq_count) * sizeof(long);
> +
> +       xgene_msi->bitmap = kzalloc(size, GFP_KERNEL);
> +       if (!xgene_msi->bitmap)
> +               return -ENOMEM;
> +
> +       mutex_init(&xgene_msi->bitmap_lock);
> +
> +       xgene_msi->msi_virqs = kcalloc(hw_irq_count, sizeof(int), GFP_KERNEL);
> +       if (!xgene_msi->msi_virqs)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static irqreturn_t xgene_msi_isr(int irq, void *data)

This is not a "normal" interrupt handler. This is really a chained
interrupt controller. Please use the proper infrastructure for this
(irq_set_chained_handler, chained_irq_enter, chained_irq_exit).
Otherwise, your usage of irq_find_mapping is illegal wrt RCU.

> +{
> +       struct xgene_msi *xgene_msi = (struct xgene_msi *) data;
> +       unsigned int virq;
> +       int msir_index, msir_reg, msir_val, hw_irq;
> +       u32 intr_index, grp_select, msi_grp, processed = 0;
> +       u32 nr_hw_irqs, irqs_per_index, index_per_group;
> +
> +       msi_grp = irq - xgene_msi->msi_virqs[0];
> +       if (msi_grp >= xgene_msi->settings->nr_hw_irqs) {
> +               pr_err("invalid msi received\n");
> +               return IRQ_NONE;
> +       }
> +
> +       nr_hw_irqs = xgene_msi->settings->nr_hw_irqs;
> +       irqs_per_index = xgene_msi->settings->irqs_per_index;
> +       index_per_group = xgene_msi->settings->index_per_group;
> +
> +       grp_select = readl(xgene_msi->msi_regs + MSI_INT0 + (msi_grp << 16));
> +       while (grp_select) {
> +               msir_index = ffs(grp_select) - 1;
> +               msir_reg = (msi_grp << 19) + (msir_index << 16);
> +               msir_val = readl(xgene_msi->msi_regs + MSI_INDEX0 + msir_reg);
> +               while (msir_val) {
> +                       intr_index = ffs(msir_val) - 1;
> +                       hw_irq = (((msir_index * irqs_per_index) + intr_index) *
> +                                nr_hw_irqs) + msi_grp;

Same thing here. This requires some explaination on how the HW is organised.

> +                       virq = irq_find_mapping(xgene_msi->domain, hw_irq);
> +                       if (virq != 0)
> +                               generic_handle_irq(virq);
> +                       msir_val &= ~(1 << intr_index);
> +                       processed++;
> +               }
> +               grp_select &= ~(1 << msir_index);
> +       }
> +
> +       return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int xgene_msi_remove(struct platform_device *pdev)
> +{
> +       int virq, i;
> +       struct xgene_msi *msi = platform_get_drvdata(pdev);
> +       u32 nr_hw_irqs = msi->settings->nr_hw_irqs;
> +
> +       for (i = 0; i < nr_hw_irqs; i++) {
> +               virq = msi->msi_virqs[i];
> +               if (virq != 0)
> +                       free_irq(virq, msi);
> +       }
> +
> +       kfree(msi->bitmap);
> +       msi->bitmap = NULL;
> +
> +       xgene_free_domains(msi);
> +
> +       return 0;
> +}
> +
> +static int xgene_msi_setup_hwirq(struct xgene_msi *msi,
> +                                struct platform_device *pdev,
> +                                int irq_index)
> +{
> +       int virt_msir;
> +       cpumask_var_t mask;
> +       int err;
> +
> +       virt_msir = platform_get_irq(pdev, irq_index);
> +       if (virt_msir < 0) {
> +               dev_err(&pdev->dev, "Cannot translate IRQ index %d\n",
> +                       irq_index);
> +               return -EINVAL;
> +       }
> +
> +       err = request_irq(virt_msir, xgene_msi_isr, 0,
> +                         xgene_msi_top_irq_chip.name, msi);

This is where you should use irq_set_chained_handler.

> +       if (err) {
> +               dev_err(&pdev->dev, "request irq failed\n");
> +               return err;
> +       }
> +
> +       if (alloc_cpumask_var(&mask, GFP_KERNEL)) {
> +               cpumask_setall(mask);
> +               irq_set_affinity(virt_msir, mask);
> +               free_cpumask_var(mask);
> +       }
> +
> +       msi->msi_virqs[irq_index] = virt_msir;
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id xgene_msi_match_table[] = {
> +       {.compatible = "apm,xgene1-msi",
> +        .data = xgene_msi_init_storm_settings},
> +       {},
> +};
> +
> +static int xgene_msi_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       int rc, irq_index;
> +       struct device_node *np;
> +       const struct of_device_id *matched_np;
> +       struct xgene_msi *xgene_msi;
> +       xgene_msi_initcall_t init_fn;
> +       u32 nr_hw_irqs, nr_msi_vecs;
> +
> +       np = of_find_matching_node_and_match(NULL,
> +                            xgene_msi_match_table, &matched_np);
> +       if (!np)
> +               return -ENODEV;
> +
> +       xgene_msi = kzalloc(sizeof(struct xgene_msi), GFP_KERNEL);
> +       if (!xgene_msi) {
> +               dev_err(&pdev->dev, "failed to allocate X-Gene MSI data\n");
> +               return -ENOMEM;
> +       }
> +
> +       xgene_msi->node = np;
> +
> +       init_fn = (xgene_msi_initcall_t) matched_np->data;
> +       rc = init_fn(xgene_msi);
> +       if (rc)
> +               return rc;
> +
> +       platform_set_drvdata(pdev, xgene_msi);
> +
> +       nr_msi_vecs = xgene_msi->settings->nr_msi_vec;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(xgene_msi->msi_regs)) {
> +               dev_err(&pdev->dev, "no reg space\n");
> +               rc = -EINVAL;
> +               goto error;
> +       }
> +
> +       xgene_msi->msi_addr_hi = upper_32_bits(res->start);
> +       xgene_msi->msi_addr_lo = lower_32_bits(res->start);
> +
> +       rc = xgene_msi_init_allocator(xgene_msi);
> +       if (rc) {
> +               dev_err(&pdev->dev, "Error allocating MSI bitmap\n");
> +               goto error;
> +       }
> +
> +       rc = xgene_allocate_domains(xgene_msi);
> +       if (rc) {
> +               dev_err(&pdev->dev, "Failed to allocate MSI domain\n");
> +               goto error;
> +       }
> +
> +       nr_hw_irqs = xgene_msi->settings->nr_hw_irqs;
> +       for (irq_index = 0; irq_index < nr_hw_irqs; irq_index++) {
> +               rc = xgene_msi_setup_hwirq(xgene_msi, pdev, irq_index);
> +               if (rc)
> +                       goto error;
> +       }
> +
> +       rc = of_pci_msi_chip_add(&xgene_msi->mchip);
> +       if (rc) {
> +               dev_err(&pdev->dev, "failed to add MSI controller chip\n");
> +               goto error;
> +       }
> +
> +       dev_info(&pdev->dev, "APM X-Gene PCIe MSI driver loaded\n");
> +
> +       return 0;
> +error:
> +       xgene_msi_remove(pdev);
> +       return rc;
> +}
> +
> +static struct platform_driver xgene_msi_driver = {
> +       .driver = {
> +               .name = "xgene-msi",
> +               .owner = THIS_MODULE,
> +               .of_match_table = xgene_msi_match_table,
> +       },
> +       .probe = xgene_msi_probe,
> +       .remove = xgene_msi_remove,
> +};
> +
> +static int __init xgene_pcie_msi_init(void)
> +{
> +       return platform_driver_register(&xgene_msi_driver);
> +}
> +subsys_initcall(xgene_pcie_msi_init);
> +
> +MODULE_AUTHOR("Duc Dang <dhdang@apm.com>");
> +MODULE_DESCRIPTION("APM X-Gene PCIe MSI driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 22751ed..3e6faa1 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -468,6 +468,23 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
>         return 0;
>  }
> 
> +static int xgene_pcie_msi_enable(struct pci_bus *bus)
> +{
> +       struct device_node *msi_node;
> +
> +       msi_node = of_parse_phandle(bus->dev.of_node,
> +                                       "msi-parent", 0);
> +       if (!msi_node)
> +               return -ENODEV;
> +
> +       bus->msi = of_pci_find_msi_chip_by_node(msi_node);
> +       if (bus->msi)
> +               bus->msi->dev = &bus->dev;
> +       else
> +               return -ENODEV;
> +       return 0;
> +}
> +
>  static int xgene_pcie_probe_bridge(struct platform_device *pdev)
>  {
>         struct device_node *dn = pdev->dev.of_node;
> @@ -504,6 +521,10 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
>         if (!bus)
>                 return -ENOMEM;
> 
> +       if (IS_ENABLED(CONFIG_PCI_MSI))
> +               if (xgene_pcie_msi_enable(bus))
> +                       dev_info(port->dev, "failed to enable MSI\n");
> +
>         pci_scan_child_bus(bus);
>         pci_assign_unassigned_bus_resources(bus);
>         pci_bus_add_devices(bus);
> --
> 1.9.1
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
