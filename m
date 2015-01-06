Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og122.obsmtp.com ([64.18.0.192]:57642 "HELO
	exprod5og122.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751831AbbAFQWR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 11:22:17 -0500
Received: by mail-pd0-f182.google.com with SMTP id p10so30679514pdj.13
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2015 08:22:16 -0800 (PST)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>, Duc Dang <dhdang@apm.com>
Subject: [PATCH 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX termination driver
Date: Tue,  6 Jan 2015 08:15:41 -0800
Message-Id: <94f9823d9a8c9c7ef819173f0a5ab06fb8fff408.1420499393.git.dhdang@apm.com>
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

X-Gene v1 SOC supports total 2688 MSI/MSIX vectors coalesced into
16 HW IRQ lines.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
---
 drivers/pci/host/Kconfig         |   4 +
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-xgene-msi.c | 370 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 375 insertions(+)
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c4b6568..650fd1d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -84,11 +84,15 @@ config PCIE_XILINX
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
 
+config PCI_XGENE_MSI
+	bool
+
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARCH_XGENE
 	depends on OF
 	select PCIEPORTBUS
+	select PCI_XGENE_MSI if PCI_MSI
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
 	  There are 5 internal PCIe ports available. Each port is GEN3 capable
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 44c2699..c261cf7 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -11,4 +11,5 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
+obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
new file mode 100644
index 0000000..1d1e1aa
--- /dev/null
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -0,0 +1,370 @@
+/*
+ * APM X-Gene MSI Driver
+ *
+ * Copyright (c) 2014, Applied Micro Circuits Corporation
+ * Author: Tanmay Inamdar <tinamdar@apm.com>
+ *	   Duc Dang <dhdang@apm.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#define MSI_INDEX0		0x000000
+#define MSI_INT0		0x800000
+
+struct xgene_msi_settings {
+	u32	index_per_group;
+	u32	irqs_per_index;
+	u32	nr_msi_vec;
+	u32	nr_hw_irqs;
+};
+
+struct xgene_msi {
+	struct irq_domain		*irqhost;
+	struct xgene_msi_settings	*settings;
+	u32				msi_addr_lo;
+	u32				msi_addr_hi;
+	void __iomem			*msi_regs;
+	unsigned long			*bitmap;
+	struct mutex			bitmap_lock;
+	int				*msi_virqs;
+};
+
+struct xgene_msi_settings storm_msi_settings = {
+	.index_per_group	= 8,
+	.irqs_per_index		= 21,
+	.nr_msi_vec		= 2688,
+	.nr_hw_irqs		= 16,
+};
+
+typedef int (*xgene_msi_initcall_t)(struct xgene_msi *);
+struct xgene_msi xgene_msi_data;
+
+static inline irq_hw_number_t virq_to_hw(unsigned int virq)
+{
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+
+	return WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
+}
+
+static int xgene_msi_init_storm_settings(struct xgene_msi *xgene_msi)
+{
+	xgene_msi->settings = &storm_msi_settings;
+	return 0;
+}
+
+static struct irq_chip xgene_msi_chip = {
+	.name		= "xgene-msi",
+	.irq_enable	= unmask_msi_irq,
+	.irq_disable	= mask_msi_irq,
+	.irq_mask	= mask_msi_irq,
+	.irq_unmask	= unmask_msi_irq,
+};
+
+static int xgene_msi_host_map(struct irq_domain *h, unsigned int virq,
+			      irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &xgene_msi_chip, handle_simple_irq);
+	irq_set_chip_data(virq, h->host_data);
+	set_irq_flags(irq, IRQF_VALID);
+
+	return 0;
+}
+
+static const struct irq_domain_ops xgene_msi_host_ops = {
+	.map = xgene_msi_host_map,
+};
+
+static int xgene_msi_alloc(struct xgene_msi *xgene_msi)
+{
+	u32 msi_irq_count = xgene_msi->settings->nr_msi_vec;
+	int msi;
+
+	mutex_lock(&xgene_msi->bitmap_lock);
+
+	msi = find_first_zero_bit(xgene_msi->bitmap, msi_irq_count);
+	if (msi < msi_irq_count)
+		set_bit(msi, xgene_msi->bitmap);
+	else
+		msi = -ENOSPC;
+
+	mutex_unlock(&xgene_msi->bitmap_lock);
+
+	return msi;
+}
+
+static void xgene_msi_free(struct xgene_msi *xgene_msi, unsigned long irq)
+{
+	mutex_lock(&xgene_msi->bitmap_lock);
+
+	if (!test_bit(irq, xgene_msi->bitmap))
+		pr_err("trying to free unused MSI#%lu\n", irq);
+	else
+		clear_bit(irq, xgene_msi->bitmap);
+
+	mutex_unlock(&xgene_msi->bitmap_lock);
+}
+
+static int xgene_msi_init_allocator(struct xgene_msi *xgene_msi)
+{
+	u32 msi_irq_count = xgene_msi->settings->nr_msi_vec;
+	u32 hw_irq_count = xgene_msi->settings->nr_hw_irqs;
+	int size = BITS_TO_LONGS(msi_irq_count) * sizeof(long);
+
+	xgene_msi->bitmap = kzalloc(size, GFP_KERNEL);
+	if (!xgene_msi->bitmap)
+		return -ENOMEM;
+	mutex_init(&xgene_msi->bitmap_lock);
+
+	xgene_msi->msi_virqs = kcalloc(hw_irq_count, sizeof(int), GFP_KERNEL);
+	if (!xgene_msi->msi_virqs)
+		return -ENOMEM;
+	return 0;
+}
+
+void arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *entry;
+	struct xgene_msi *xgene_msi;
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		if (entry->irq == 0)
+			continue;
+		xgene_msi = irq_get_chip_data(entry->irq);
+		irq_set_msi_desc(entry->irq, NULL);
+		xgene_msi_free(xgene_msi, virq_to_hw(entry->irq));
+	}
+}
+
+static void xgene_compose_msi_msg(struct pci_dev *dev, int hwirq,
+				  struct msi_msg *msg,
+				  struct xgene_msi *xgene_msi)
+{
+	u32 nr_hw_irqs = xgene_msi->settings->nr_hw_irqs;
+	u32 irqs_per_index = xgene_msi->settings->irqs_per_index;
+	u32 reg_set = hwirq / (nr_hw_irqs * irqs_per_index);
+	u32 group = hwirq % nr_hw_irqs;
+
+	msg->address_hi = xgene_msi->msi_addr_hi;
+	msg->address_lo = xgene_msi->msi_addr_lo +
+			  (((8 * group) + reg_set) << 16);
+	msg->data = (hwirq / nr_hw_irqs) % irqs_per_index;
+}
+
+int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	struct xgene_msi *xgene_msi = &xgene_msi_data;
+	struct msi_desc *entry;
+	struct msi_msg msg;
+	unsigned long virq, gic_irq;
+	int hwirq;
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		hwirq = xgene_msi_alloc(xgene_msi);
+		if (hwirq < 0) {
+			dev_err(&pdev->dev, "failed to allocate MSI\n");
+			return -ENOSPC;
+		}
+
+		virq = irq_create_mapping(xgene_msi->irqhost, hwirq);
+		if (virq == 0) {
+			dev_err(&pdev->dev, "failed to map hwirq %i\n", hwirq);
+			return -ENOSPC;
+		}
+
+		gic_irq = xgene_msi->msi_virqs[hwirq %
+				xgene_msi->settings->nr_hw_irqs];
+		pr_debug("Mapp HWIRQ %d on GIC IRQ %lu TO VIRQ %lu\n",
+			 hwirq, gic_irq, virq);
+		irq_set_msi_desc(virq, entry);
+		xgene_compose_msi_msg(pdev, hwirq, &msg, xgene_msi);
+		irq_set_handler_data(virq, (void *)gic_irq);
+		write_msi_msg(virq, &msg);
+	}
+
+	return 0;
+}
+
+static irqreturn_t xgene_msi_isr(int irq, void *data)
+{
+	struct xgene_msi *xgene_msi = (struct xgene_msi *) data;
+	unsigned int virq;
+	int msir_index, msir_reg, msir_val, hw_irq;
+	u32 intr_index, grp_select, msi_grp, processed = 0;
+	u32 nr_hw_irqs, irqs_per_index, index_per_group;
+
+	msi_grp = irq - xgene_msi->msi_virqs[0];
+	if (msi_grp >= xgene_msi->settings->nr_hw_irqs) {
+		pr_err("invalid msi received\n");
+		return IRQ_NONE;
+	}
+
+	nr_hw_irqs = xgene_msi->settings->nr_hw_irqs;
+	irqs_per_index = xgene_msi->settings->irqs_per_index;
+	index_per_group = xgene_msi->settings->index_per_group;
+
+	grp_select = readl(xgene_msi->msi_regs + MSI_INT0 + (msi_grp << 16));
+	while (grp_select) {
+		msir_index = ffs(grp_select) - 1;
+		msir_reg = (msi_grp << 19) + (msir_index << 16);
+		msir_val = readl(xgene_msi->msi_regs + MSI_INDEX0 + msir_reg);
+		while (msir_val) {
+			intr_index = ffs(msir_val) - 1;
+			hw_irq = (((msir_index * irqs_per_index) + intr_index) *
+				 nr_hw_irqs) + msi_grp;
+			virq = irq_find_mapping(xgene_msi->irqhost, hw_irq);
+			if (virq != 0)
+				generic_handle_irq(virq);
+			msir_val &= ~(1 << intr_index);
+			processed++;
+		}
+		grp_select &= ~(1 << msir_index);
+	}
+
+	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int xgene_msi_remove(struct platform_device *pdev)
+{
+	int virq, i;
+	struct xgene_msi *msi = platform_get_drvdata(pdev);
+	u32 nr_hw_irqs = msi->settings->nr_hw_irqs;
+
+	for (i = 0; i < nr_hw_irqs; i++) {
+		virq = msi->msi_virqs[i];
+		if (virq != 0)
+			free_irq(virq, msi);
+	}
+
+	kfree(msi->bitmap);
+	msi->bitmap = NULL;
+
+	return 0;
+}
+
+static int xgene_msi_setup_hwirq(struct xgene_msi *msi,
+				 struct platform_device *pdev,
+				 int irq_index)
+{
+	int virt_msir;
+	cpumask_var_t mask;
+	int err;
+
+	virt_msir = platform_get_irq(pdev, irq_index);
+	if (virt_msir < 0) {
+		dev_err(&pdev->dev, "Cannot translate IRQ index %d\n",
+			irq_index);
+		return -EINVAL;
+	}
+
+	err = request_irq(virt_msir, xgene_msi_isr, 0, "xgene-msi", msi);
+	if (err) {
+		dev_err(&pdev->dev, "request irq failed\n");
+		return err;
+	}
+
+	if (alloc_cpumask_var(&mask, GFP_KERNEL)) {
+		cpumask_setall(mask);
+		irq_set_affinity(virt_msir, mask);
+		free_cpumask_var(mask);
+	}
+
+	msi->msi_virqs[irq_index] = virt_msir;
+
+	return 0;
+}
+
+static const struct of_device_id xgene_msi_match_table[] = {
+	{.compatible = "apm,xgene-storm-pcie-msi",
+	 .data = xgene_msi_init_storm_settings},
+	{},
+};
+
+static int xgene_msi_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int rc, irq_index;
+	struct device_node *np;
+	const struct of_device_id *matched_np;
+	struct xgene_msi *xgene_msi = &xgene_msi_data;
+	xgene_msi_initcall_t init_fn;
+	u32 nr_hw_irqs, nr_msi_vecs;
+
+	np = of_find_matching_node_and_match(NULL,
+			     xgene_msi_match_table, &matched_np);
+	if (!np)
+		return -ENODEV;
+
+	init_fn = (xgene_msi_initcall_t) matched_np->data;
+	rc = init_fn(xgene_msi);
+	if (rc)
+		return rc;
+
+	nr_msi_vecs = xgene_msi->settings->nr_msi_vec;
+	xgene_msi->irqhost = irq_domain_add_linear(pdev->dev.of_node,
+			     nr_msi_vecs, &xgene_msi_host_ops, xgene_msi);
+	if (!xgene_msi->irqhost) {
+		dev_err(&pdev->dev, "No memory for MSI irqhost\n");
+		rc = -ENOMEM;
+		goto error;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xgene_msi->msi_regs)) {
+		dev_err(&pdev->dev, "no reg space\n");
+		rc = -EINVAL;
+		goto error;
+	}
+
+	xgene_msi->msi_addr_hi = upper_32_bits(res->start);
+	xgene_msi->msi_addr_lo = lower_32_bits(res->start);
+
+	rc = xgene_msi_init_allocator(xgene_msi);
+	if (rc) {
+		dev_err(&pdev->dev, "Error allocating MSI bitmap\n");
+		goto error;
+	}
+
+	nr_hw_irqs = xgene_msi->settings->nr_hw_irqs;
+	for (irq_index = 0; irq_index < nr_hw_irqs; irq_index++) {
+		rc = xgene_msi_setup_hwirq(xgene_msi, pdev, irq_index);
+		if (rc)
+			goto error;
+	}
+
+	dev_info(&pdev->dev, "APM X-Gene PCIe MSI driver loaded\n");
+
+	return 0;
+error:
+	xgene_msi_remove(pdev);
+	return rc;
+}
+
+static struct platform_driver xgene_msi_driver = {
+	.driver = {
+		.name = "xgene-msi",
+		.owner = THIS_MODULE,
+		.of_match_table = xgene_msi_match_table,
+	},
+	.probe = xgene_msi_probe,
+	.remove = xgene_msi_remove,
+};
+module_platform_driver(xgene_msi_driver);
+
+MODULE_AUTHOR("Duc Dang <dhdang@apm.com>");
+MODULE_DESCRIPTION("APM X-Gene PCIe MSI driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

