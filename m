Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v4 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX termination driver
Date: Fri, 17 Apr 2015 02:50:07 -0700
Message-Id: <5160bc222361ff36cc6e72ca14358c5dee8c7548.1429263201.git.dhdang@apm.com>
In-Reply-To: <cover.1429263201.git.dhdang@apm.com>
References: <cover.1429263201.git.dhdang@apm.com>
In-Reply-To: <cover.1429263201.git.dhdang@apm.com>
References: <20150415091655.02361cdc@arm.com> <cover.1429263201.git.dhdang@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

X-Gene v1 SoC supports total 2048 MSI/MSIX vectors coalesced into
16 HW IRQ lines.

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/Kconfig         |   6 +
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-xgene-msi.c | 410 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pci-xgene.c     |  21 ++
 4 files changed, 438 insertions(+)
 create mode 100644 drivers/pci/host/pci-xgene-msi.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7b892a9..c9b61fa 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -89,11 +89,17 @@ config PCI_XGENE
 	depends on ARCH_XGENE
 	depends on OF
 	select PCIEPORTBUS
+	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
+	select PCI_XGENE_MSI if PCI_MSI
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
 	  There are 5 internal PCIe ports available. Each port is GEN3 capable
 	  and have varied lanes from x1 to x8.
 
+config PCI_XGENE_MSI
+	bool "X-Gene v1 PCIe MSI feature"
+	depends on PCI_XGENE && PCI_MSI
+
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
 	depends on OF && ARM
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index e61d91c..f39bde3 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -11,5 +11,6 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
+obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
new file mode 100644
index 0000000..f53b581e
--- /dev/null
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -0,0 +1,410 @@
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
+#include <linux/irqchip/chained_irq.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/of_pci.h>
+
+#define MSI_IR0			0x000000
+#define MSI_INT0		0x800000
+
+#define IDX_PER_GROUP		8
+#define IRQS_PER_IDX		16
+#define NR_HW_IRQS		16
+#define NR_MSI_VEC		(IDX_PER_GROUP * IRQS_PER_IDX * NR_HW_IRQS)
+
+struct xgene_msi {
+	struct device_node		*node;
+	struct msi_controller		mchip;
+	struct irq_domain		*domain;
+	u64				msi_addr;
+	void __iomem			*msi_regs;
+	unsigned long			*bitmap;
+	struct mutex			bitmap_lock;
+	int				*msi_virqs;
+};
+
+static struct irq_chip xgene_msi_top_irq_chip = {
+	.name		= "X-Gene1 MSI",
+	.irq_enable	= pci_msi_unmask_irq,
+	.irq_disable	= pci_msi_mask_irq,
+	.irq_mask	= pci_msi_mask_irq,
+	.irq_unmask	= pci_msi_unmask_irq,
+};
+
+static struct  msi_domain_info xgene_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_PCI_MSIX),
+	.chip	= &xgene_msi_top_irq_chip,
+};
+
+/*
+ * X-Gene v1 has 16 groups of MSI termination registers MSInIRx, where
+ * n is group number (0..F), x is index of registers in each group (0..7)
+ * The registers layout is like following:
+ * MSI0IR0			base_addr
+ * MSI0IR1			base_addr +  0x10000
+ * ...				...
+ * MSI0IR6			base_addr +  0x60000
+ * MSI0IR7			base_addr +  0x70000
+ * MSI1IR0			base_addr +  0x80000
+ * MSI1IR1			base_addr +  0x90000
+ * ...				...
+ * MSI1IR7			base_addr +  0xF0000
+ * MSI2IR0			base_addr + 0x100000
+ * ...				...
+ * MSIFIR0			base_addr + 0x780000
+ * MSIFIR1			base_addr + 0x790000
+ * ...				...
+ * MSIFIR7			base_addr + 0x7F0000
+ *
+ * Each index register support 16 MSI vectors (0..15) to generate interrupt.
+ * There are total 16 GIC IRQs assigned for these 16 groups of MSI termination
+ * registers.
+ *
+ * With 2048 MSI vectors supported, the MSI message can be construct using
+ * following scheme:
+ * - Divide into 8 256-vector groups
+ *		Group 0: 0-255
+ *		Group 1: 256-511
+ *		Group 2: 512-767
+ *		...
+ *		Group 7: 1792-2047
+ * - Each 256-vector group is divided into 16 16-vector groups
+ *	As an example: 16 16-vector groups for 256-vector group 0-255 is
+ *		Group 0: 0-15
+ *		Group 1: 16-32
+ *		...
+ *		Group 15: 240-255
+ * - The termination address of MSI vector in 256-vector group n and 16-vector
+ * group x is the address of MSIxIRn
+ * - The data for MSI vector in 16-vector group x is x
+ */
+static void xgene_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct xgene_msi *msi = irq_data_get_irq_chip_data(data);
+	u32 reg_set = data->hwirq / (NR_HW_IRQS * IRQS_PER_IDX);
+	u32 group = data->hwirq % NR_HW_IRQS;
+
+	msg->address_hi = upper_32_bits(msi->msi_addr);
+	msg->address_lo = lower_32_bits(msi->msi_addr) +
+			  (((8 * group) + reg_set) << 16);
+	msg->data = (data->hwirq / NR_HW_IRQS) % IRQS_PER_IDX;
+}
+
+static int xgene_msi_set_affinity(struct irq_data *irq_data,
+				  const struct cpumask *mask, bool force)
+{
+	return IRQ_SET_MASK_OK_DONE;
+}
+
+static struct irq_chip xgene_msi_bottom_irq_chip = {
+	.name			= "MSI",
+	.irq_set_affinity       = xgene_msi_set_affinity,
+	.irq_compose_msi_msg	= xgene_compose_msi_msg,
+};
+
+static int xgene_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
+{
+
+	struct xgene_msi *msi = domain->host_data;
+	int msi_irq;
+
+	mutex_lock(&msi->bitmap_lock);
+
+	msi_irq = find_first_zero_bit(msi->bitmap, NR_MSI_VEC);
+	if (msi_irq < NR_MSI_VEC)
+		set_bit(msi_irq, msi->bitmap);
+	else
+		msi_irq = -ENOSPC;
+
+	mutex_unlock(&msi->bitmap_lock);
+
+	if (msi_irq < 0)
+		return msi_irq;
+
+	irq_domain_set_info(domain, virq, msi_irq, &xgene_msi_bottom_irq_chip,
+			    domain->host_data, handle_simple_irq, NULL, NULL);
+	set_irq_flags(virq, IRQF_VALID);
+
+	return 0;
+}
+
+static void xgene_irq_domain_free(struct irq_domain *domain,
+				  unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct xgene_msi *msi = irq_data_get_irq_chip_data(d);
+
+	mutex_lock(&msi->bitmap_lock);
+
+	if (test_bit(d->hwirq, msi->bitmap))
+		clear_bit(d->hwirq, msi->bitmap);
+
+	mutex_unlock(&msi->bitmap_lock);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc  = xgene_irq_domain_alloc,
+	.free   = xgene_irq_domain_free,
+};
+
+static int xgene_allocate_domains(struct xgene_msi *msi)
+{
+	msi->domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
+					    &msi_domain_ops, msi);
+	if (!msi->domain)
+		return -ENOMEM;
+
+	msi->mchip.of_node = msi->node;
+	msi->mchip.domain = pci_msi_create_irq_domain(msi->mchip.of_node,
+						      &xgene_msi_domain_info,
+						      msi->domain);
+
+	if (!msi->mchip.domain) {
+		irq_domain_remove(msi->domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void xgene_free_domains(struct xgene_msi *msi)
+{
+	if (msi->mchip.domain)
+		irq_domain_remove(msi->mchip.domain);
+	if (msi->domain)
+		irq_domain_remove(msi->domain);
+}
+
+static int xgene_msi_init_allocator(struct xgene_msi *xgene_msi)
+{
+	int size = BITS_TO_LONGS(NR_MSI_VEC) * sizeof(long);
+
+	xgene_msi->bitmap = kzalloc(size, GFP_KERNEL);
+	if (!xgene_msi->bitmap)
+		return -ENOMEM;
+
+	mutex_init(&xgene_msi->bitmap_lock);
+
+	xgene_msi->msi_virqs = kcalloc(NR_HW_IRQS, sizeof(int), GFP_KERNEL);
+	if (!xgene_msi->msi_virqs)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void xgene_msi_isr(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct xgene_msi *xgene_msi;
+	unsigned int virq;
+	int msir_index, msir_reg, msir_val, hw_irq;
+	u32 intr_index, grp_select, msi_grp, processed = 0;
+
+	chained_irq_enter(chip, desc);
+
+	xgene_msi = irq_desc_get_handler_data(desc);
+
+	msi_grp = irq - xgene_msi->msi_virqs[0];
+	if (msi_grp >= NR_HW_IRQS) {
+		chained_irq_exit(chip, desc);
+		return;
+	}
+
+	/*
+	 * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
+	 * If bit x of this register is set (x is 0..7), one or more interupts
+	 * corresponding to MSInIRx is set.
+	 */
+	grp_select = readl(xgene_msi->msi_regs + MSI_INT0 + (msi_grp << 16));
+	while (grp_select) {
+		msir_index = ffs(grp_select) - 1;
+		/*
+		 * Calculate MSInIRx address to read to check for interrupts
+		 * (refer to termination address and data assignment
+		 * described in xgene_compose_msi_msg function)
+		 */
+		msir_reg = (msi_grp << 19) + (msir_index << 16);
+		msir_val = readl(xgene_msi->msi_regs + MSI_IR0 + msir_reg);
+		while (msir_val) {
+			intr_index = ffs(msir_val) - 1;
+			/*
+			 * Calculate MSI vector number (refer to the termination
+			 * address and data assignment described in
+			 * xgene_compose_msi_msg function)
+			 */
+			hw_irq = (((msir_index * IRQS_PER_IDX) + intr_index) *
+				 NR_HW_IRQS) + msi_grp;
+			virq = irq_find_mapping(xgene_msi->domain, hw_irq);
+			if (virq != 0)
+				generic_handle_irq(virq);
+			msir_val &= ~(1 << intr_index);
+			processed++;
+		}
+		grp_select &= ~(1 << msir_index);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int xgene_msi_remove(struct platform_device *pdev)
+{
+	int virq, i;
+	struct xgene_msi *msi = platform_get_drvdata(pdev);
+
+	for (i = 0; i < NR_HW_IRQS; i++) {
+		virq = msi->msi_virqs[i];
+		if (virq != 0)
+			free_irq(virq, msi);
+	}
+
+	kfree(msi->bitmap);
+	msi->bitmap = NULL;
+
+	xgene_free_domains(msi);
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
+	irq_set_chained_handler(virt_msir, xgene_msi_isr);
+	err = irq_set_handler_data(virt_msir, msi);
+	if (err) {
+		dev_err(&pdev->dev, "request irq failed\n");
+		return err;
+	}
+
+	if (alloc_cpumask_var(&mask, GFP_KERNEL)) {
+		cpumask_clear(mask);
+		cpumask_set_cpu(irq_index % num_online_cpus(), mask);
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
+	{.compatible = "apm,xgene1-msi"},
+	{},
+};
+
+static int xgene_msi_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int rc, irq_index;
+	struct device_node *np;
+	const struct of_device_id *matched_np;
+	struct xgene_msi *xgene_msi;
+
+	np = of_find_matching_node_and_match(NULL,
+			     xgene_msi_match_table, &matched_np);
+	if (!np)
+		return -ENODEV;
+
+	xgene_msi = kzalloc(sizeof(struct xgene_msi), GFP_KERNEL);
+	if (!xgene_msi) {
+		dev_err(&pdev->dev, "failed to allocate X-Gene MSI data\n");
+		return -ENOMEM;
+	}
+
+	xgene_msi->node = np;
+
+	platform_set_drvdata(pdev, xgene_msi);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xgene_msi->msi_regs)) {
+		dev_err(&pdev->dev, "no reg space\n");
+		rc = -EINVAL;
+		goto error;
+	}
+	xgene_msi->msi_addr = res->start;
+
+	rc = xgene_msi_init_allocator(xgene_msi);
+	if (rc) {
+		dev_err(&pdev->dev, "Error allocating MSI bitmap\n");
+		goto error;
+	}
+
+	rc = xgene_allocate_domains(xgene_msi);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to allocate MSI domain\n");
+		goto error;
+	}
+
+	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
+		rc = xgene_msi_setup_hwirq(xgene_msi, pdev, irq_index);
+		if (rc)
+			goto error;
+	}
+
+	rc = of_pci_msi_chip_add(&xgene_msi->mchip);
+	if (rc) {
+		dev_err(&pdev->dev, "failed to add MSI controller chip\n");
+		goto error;
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
+
+static int __init xgene_pcie_msi_init(void)
+{
+	return platform_driver_register(&xgene_msi_driver);
+}
+subsys_initcall(xgene_pcie_msi_init);
+
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 22751ed..3e6faa1 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -468,6 +468,23 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
 	return 0;
 }
 
+static int xgene_pcie_msi_enable(struct pci_bus *bus)
+{
+	struct device_node *msi_node;
+
+	msi_node = of_parse_phandle(bus->dev.of_node,
+					"msi-parent", 0);
+	if (!msi_node)
+		return -ENODEV;
+
+	bus->msi = of_pci_find_msi_chip_by_node(msi_node);
+	if (bus->msi)
+		bus->msi->dev = &bus->dev;
+	else
+		return -ENODEV;
+	return 0;
+}
+
 static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
@@ -504,6 +521,10 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (!bus)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		if (xgene_pcie_msi_enable(bus))
+			dev_info(port->dev, "failed to enable MSI\n");
+
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
-- 
1.9.1

