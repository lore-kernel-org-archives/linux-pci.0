Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36274 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbdHXSnv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2017 14:43:51 -0400
Received: by mail-wm0-f41.google.com with SMTP id z132so2102711wmg.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2017 11:43:50 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Cc: mw@semihalf.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 2/3] pci: designware: add separate driver for the MSI part of the RC
Date: Thu, 24 Aug 2017 19:43:20 +0100
Message-Id: <20170824184321.19432-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20170824184321.19432-1-ard.biesheuvel@linaro.org>
References: <20170824184321.19432-1-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most drivers that currently exist for the Synopsys Designware PCIe
controller in RC mode hardcode the relation with the embedded MSI
controller. This makes it more difficult than necessary to use a
generic driver to drive the RC, which is especially unfortunate
in cases where the firmware already configures the RC to the extent
that it can be driven by the generic ECAM driver. It also makes it
impossible to use an existing driver but use another IP block for
MSI support, i.e., a GICv2m or GICv3-ITS.

So add a separate driver for the MSI part, which can be referenced
from the DT node describing the RC via its msi-parent property.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/dwc/Makefile              |   3 +-
 drivers/pci/dwc/pcie-designware-msi.c | 255 ++++++++++++++++++++
 2 files changed, 257 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
index 7d5a23e5b767..7607a2b686a0 100644
--- a/drivers/pci/dwc/Makefile
+++ b/drivers/pci/dwc/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
-obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
+msi-obj-$(CONFIG_PCI_MSI_IRQ_DOMAIN) += pcie-designware-msi.o
+obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o $(msi-obj-y)
 obj-$(CONFIG_PCIE_DW_HOST_ECAM) += pcie-designware-ecam.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
diff --git a/drivers/pci/dwc/pcie-designware-msi.c b/drivers/pci/dwc/pcie-designware-msi.c
new file mode 100644
index 000000000000..16b02151177d
--- /dev/null
+++ b/drivers/pci/dwc/pcie-designware-msi.c
@@ -0,0 +1,255 @@
+/*
+ * Copyright (C) 2017 Linaro Limited <ard.biesheuvel@linaro.org>
+ *
+ * Based on code posted for the tango platform by
+ *                            Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-designware.h"
+
+struct dw_pcie_msi {
+	void __iomem		*regbase;
+	int			irq;
+	struct irq_domain	*irqd;
+	struct irq_domain	*msid;
+	DECLARE_BITMAP(		used_msi, MAX_MSI_IRQS);
+	spinlock_t		used_msi_lock;
+	u32			doorbell;
+};
+
+static void dw_pcie_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct dw_pcie_msi *dw_msi = irq_desc_get_handler_data(desc);
+	unsigned long status, base, virq, idx, pos;
+
+	chained_irq_enter(chip, desc);
+	spin_lock(&dw_msi->used_msi_lock);
+
+	for (pos = 0; pos < MAX_MSI_IRQS;
+	     pos = find_next_bit(dw_msi->used_msi, MAX_MSI_IRQS, pos)) {
+		base = round_down(pos, 32);
+		status = readl_relaxed(dw_msi->regbase + PCIE_MSI_INTR0_STATUS +
+				       (base / 32) * 12);
+		for_each_set_bit(idx, &status, 32) {
+			virq = irq_find_mapping(dw_msi->irqd, base + idx);
+			generic_handle_irq(virq);
+		}
+		pos = base + 32;
+	}
+
+	spin_unlock(&dw_msi->used_msi_lock);
+	chained_irq_exit(chip, desc);
+}
+
+static void dw_pcie_ack(struct irq_data *d)
+{
+	struct dw_pcie_msi *dw_msi = d->chip_data;
+	u32 offset = (d->hwirq / 32) * 12;
+	u32 bit = BIT(d->hwirq % 32);
+
+	writel_relaxed(bit, dw_msi->regbase + PCIE_MSI_INTR0_STATUS + offset);
+}
+
+static void dw_pcie_update_msi_enable(struct irq_data *d, bool unmask)
+{
+	unsigned long flags;
+	struct dw_pcie_msi *dw_msi = d->chip_data;
+	u32 offset = (d->hwirq / 32) * 12;
+	u32 bit = BIT(d->hwirq % 32);
+	u32 val;
+
+	spin_lock_irqsave(&dw_msi->used_msi_lock, flags);
+	val = readl_relaxed(dw_msi->regbase + PCIE_MSI_INTR0_ENABLE + offset);
+	val = unmask ? (val | bit) : (val & ~bit);
+	writel_relaxed(val, dw_msi->regbase + PCIE_MSI_INTR0_ENABLE + offset);
+	spin_unlock_irqrestore(&dw_msi->used_msi_lock, flags);
+}
+
+static void dw_pcie_mask(struct irq_data *d)
+{
+	dw_pcie_update_msi_enable(d, false);
+}
+
+static void dw_pcie_unmask(struct irq_data *d)
+{
+	dw_pcie_update_msi_enable(d, true);
+}
+
+static int dw_pcie_set_affinity(struct irq_data *d,
+				    const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static void dw_pcie_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct dw_pcie_msi *dw_msi = d->chip_data;
+
+	msg->address_lo = lower_32_bits(virt_to_phys(&dw_msi->doorbell));
+	msg->address_hi = upper_32_bits(virt_to_phys(&dw_msi->doorbell));
+	msg->data = d->hwirq;
+}
+
+static struct irq_chip dw_pcie_chip = {
+	.irq_ack		= dw_pcie_ack,
+	.irq_mask		= dw_pcie_mask,
+	.irq_unmask		= dw_pcie_unmask,
+	.irq_set_affinity	= dw_pcie_set_affinity,
+	.irq_compose_msi_msg	= dw_pcie_compose_msi_msg,
+};
+
+static void dw_pcie_msi_ack(struct irq_data *d)
+{
+	irq_chip_ack_parent(d);
+}
+
+static void dw_pcie_msi_mask(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void dw_pcie_msi_unmask(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip dw_pcie_msi_chip = {
+	.name			= "DW-MSI",
+	.irq_ack		= dw_pcie_msi_ack,
+	.irq_mask		= dw_pcie_msi_mask,
+	.irq_unmask		= dw_pcie_msi_unmask,
+};
+
+static struct msi_domain_info dw_pcie_msi_dom_info = {
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
+	.chip	= &dw_pcie_msi_chip,
+};
+
+static int dw_pcie_msi_irq_domain_alloc(struct irq_domain *dom,
+					unsigned int virq,
+					unsigned int nr_irqs, void *args)
+{
+	struct dw_pcie_msi *dw_msi = dom->host_data;
+	unsigned long flags;
+	int pos;
+
+	spin_lock_irqsave(&dw_msi->used_msi_lock, flags);
+	pos = find_first_zero_bit(dw_msi->used_msi, MAX_MSI_IRQS);
+	if (pos >= MAX_MSI_IRQS) {
+		spin_unlock_irqrestore(&dw_msi->used_msi_lock, flags);
+		return -ENOSPC;
+	}
+	__set_bit(pos, dw_msi->used_msi);
+	spin_unlock_irqrestore(&dw_msi->used_msi_lock, flags);
+	irq_domain_set_info(dom, virq, pos, &dw_pcie_chip, dw_msi,
+			    handle_edge_irq, NULL, NULL);
+
+	return 0;
+}
+
+static void dw_pcie_msi_irq_domain_free(struct irq_domain *dom,
+					unsigned int virq,
+					unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(dom, virq);
+	struct dw_pcie_msi *dw_msi = d->chip_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dw_msi->used_msi_lock, flags);
+	__clear_bit(d->hwirq, dw_msi->used_msi);
+	spin_unlock_irqrestore(&dw_msi->used_msi_lock, flags);
+}
+
+static const struct irq_domain_ops irq_dom_ops = {
+	.alloc	= dw_pcie_msi_irq_domain_alloc,
+	.free	= dw_pcie_msi_irq_domain_free,
+};
+
+static int dw_pcie_msi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_pcie_msi *dw_msi;
+	struct resource *res;
+
+	dw_msi = devm_kzalloc(dev, sizeof(*dw_msi), GFP_KERNEL);
+	if (!dw_msi)
+		return -ENOMEM;
+
+	/* get the control register and map it */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dw_msi->regbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dw_msi->regbase))
+		return PTR_ERR(dw_msi->regbase);
+
+	/* get the wired interrupt that gets raised when we receive an MSI */
+	dw_msi->irq = platform_get_irq(pdev, 0);
+	if (dw_msi->irq <= 0) {
+		dev_err(dev, "No IRQ resource found\n");
+		return -ENXIO;
+	}
+
+	dw_msi->irqd = irq_domain_create_linear(dev->fwnode, MAX_MSI_IRQS,
+						&irq_dom_ops, dw_msi);
+	if (!dw_msi->irqd) {
+		dev_err(dev, "Failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	dw_msi->msid = pci_msi_create_irq_domain(dev->fwnode,
+						 &dw_pcie_msi_dom_info,
+						 dw_msi->irqd);
+	if (!dw_msi->msid) {
+		dev_err(dev, "Failed to create MSI domain\n");
+		irq_domain_remove(dw_msi->irqd);
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(dw_msi->irq, dw_pcie_msi_isr, dw_msi);
+	platform_set_drvdata(pdev, dw_msi);
+
+	/* program the msi_data */
+	writel_relaxed(lower_32_bits(virt_to_phys(&dw_msi->doorbell)),
+		       dw_msi->regbase + PCIE_MSI_ADDR_LO);
+	writel_relaxed(upper_32_bits(virt_to_phys(&dw_msi->doorbell)),
+		       dw_msi->regbase + PCIE_MSI_ADDR_HI);
+
+	return 0;
+}
+
+static int dw_pcie_msi_remove(struct platform_device *pdev)
+{
+	struct dw_pcie_msi *dw_msi = platform_get_drvdata(pdev);
+
+	irq_set_chained_handler_and_data(dw_msi->irq, NULL, NULL);
+	irq_domain_remove(dw_msi->msid);
+	irq_domain_remove(dw_msi->irqd);
+
+	return 0;
+}
+
+static const struct of_device_id dw_pcie_dw_msi_of_match[] = {
+	{ .compatible = "snps,dw-pcie-msi" },
+	{ },
+};
+
+static struct platform_driver pci_dw_msi_driver = {
+	.driver.name			= "pcie-designware-msi",
+	.driver.of_match_table		= dw_pcie_dw_msi_of_match,
+	.probe				= dw_pcie_msi_probe,
+	.remove				= dw_pcie_msi_remove,
+};
+builtin_platform_driver(pci_dw_msi_driver);
-- 
2.11.0
