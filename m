Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v5 11/19] irqchip: gicv3-its: Split PCI/MSI code from the core ITS driver
Date: Thu, 23 Jul 2015 10:26:30 +0100
Message-Id: <1437643598-19795-12-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is becoming obvious that having the PCI/MSI code in the same
file as the the core ITS code is giving people implementing non-PCI
MSI support the wrong kind of idea.

In order to make things a bit clearer, let's move the PCI/MSI code
out to its own file. Hopefully it will make it clear that whoever
thinks of hooking into the core ITS better have a very strong point.

We use a temporary entry point that will get removed in a subsequent
patch, once the proper infrastructure is added.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/Makefile                 |   2 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 105 +++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c         |  93 ++++-----------------------
 include/linux/irqchip/arm-gic-v3.h       |   6 ++
 4 files changed, 123 insertions(+), 83 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-its-pci-msi.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b8d4e96..0d5f2a9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
new file mode 100644
index 0000000..7614721
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+
+#include <linux/irqchip/arm-gic-v3.h>
+
+static void its_mask_msi_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void its_unmask_msi_irq(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip its_msi_irq_chip = {
+	.name			= "ITS-MSI",
+	.irq_unmask		= its_unmask_msi_irq,
+	.irq_mask		= its_mask_msi_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_write_msi_msg	= pci_msi_domain_write_msg,
+};
+
+struct its_pci_alias {
+	struct pci_dev	*pdev;
+	u32		dev_id;
+	u32		count;
+};
+
+static int its_pci_msi_vec_count(struct pci_dev *pdev)
+{
+	int msi, msix;
+
+	msi = max(pci_msi_vec_count(pdev), 0);
+	msix = max(pci_msix_vec_count(pdev), 0);
+
+	return max(msi, msix);
+}
+
+static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct its_pci_alias *dev_alias = data;
+
+	dev_alias->dev_id = alias;
+	if (pdev != dev_alias->pdev)
+		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
+
+	return 0;
+}
+
+static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *info)
+{
+	struct pci_dev *pdev;
+	struct its_pci_alias dev_alias;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	dev_alias.pdev = pdev;
+	dev_alias.count = nvec;
+
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
+
+	return its_msi_prepare(domain, dev_alias.dev_id, dev_alias.count, info);
+}
+
+static struct msi_domain_ops its_pci_msi_ops = {
+	.msi_prepare	= its_pci_msi_prepare,
+};
+
+static struct msi_domain_info its_pci_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+	.ops	= &its_pci_msi_ops,
+	.chip	= &its_msi_irq_chip,
+};
+
+struct irq_domain *its_pci_msi_alloc_domain(struct device_node *np,
+					    struct irq_domain *parent)
+{
+	return pci_msi_create_irq_domain(np, &its_pci_msi_domain_info, parent);
+}
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b7e155..7c01fe4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -611,26 +611,6 @@ static struct irq_chip its_irq_chip = {
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
 };
 
-static void its_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void its_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip its_msi_irq_chip = {
-	.name			= "ITS-MSI",
-	.irq_unmask		= its_unmask_msi_irq,
-	.irq_mask		= its_mask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_write_msi_msg	= pci_msi_domain_write_msg,
-};
-
 /*
  * How we allocate LPIs:
  *
@@ -1173,85 +1153,34 @@ static int its_alloc_device_irq(struct its_device *dev, irq_hw_number_t *hwirq)
 	return 0;
 }
 
-struct its_pci_alias {
-	struct pci_dev	*pdev;
-	u32		dev_id;
-	u32		count;
-};
-
-static int its_pci_msi_vec_count(struct pci_dev *pdev)
-{
-	int msi, msix;
-
-	msi = max(pci_msi_vec_count(pdev), 0);
-	msix = max(pci_msix_vec_count(pdev), 0);
-
-	return max(msi, msix);
-}
-
-static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
+int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
+		    int nvec, msi_alloc_info_t *info)
 {
-	struct its_pci_alias *dev_alias = data;
-
-	dev_alias->dev_id = alias;
-	if (pdev != dev_alias->pdev)
-		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
-
-	return 0;
-}
-
-static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
-			   int nvec, msi_alloc_info_t *info)
-{
-	struct pci_dev *pdev;
 	struct its_node *its;
 	struct its_device *its_dev;
-	struct its_pci_alias dev_alias;
-
-	if (!dev_is_pci(dev))
-		return -EINVAL;
-
-	pdev = to_pci_dev(dev);
-	dev_alias.pdev = pdev;
-	dev_alias.count = nvec;
 
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
 	its = domain->parent->host_data;
-
-	its_dev = its_find_device(its, dev_alias.dev_id);
+	its_dev = its_find_device(its, dev_id);
 	if (its_dev) {
 		/*
 		 * We already have seen this ID, probably through
 		 * another alias (PCI bridge of some sort). No need to
 		 * create the device.
 		 */
-		dev_dbg(dev, "Reusing ITT for devID %x\n", dev_alias.dev_id);
+		pr_debug("Reusing ITT for devID %x\n", dev_id);
 		goto out;
 	}
 
-	its_dev = its_create_device(its, dev_alias.dev_id, dev_alias.count);
+	its_dev = its_create_device(its, dev_id, nvec);
 	if (!its_dev)
 		return -ENOMEM;
 
-	dev_dbg(&pdev->dev, "ITT %d entries, %d bits\n",
-		dev_alias.count, ilog2(dev_alias.count));
+	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
 	info->scratchpad[0].ptr = its_dev;
-	info->scratchpad[1].ptr = dev;
 	return 0;
 }
 
-static struct msi_domain_ops its_pci_msi_ops = {
-	.msi_prepare	= its_msi_prepare,
-};
-
-static struct msi_domain_info its_pci_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.ops	= &its_pci_msi_ops,
-	.chip	= &its_msi_irq_chip,
-};
-
 static int its_irq_gic_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq,
 				    irq_hw_number_t hwirq)
@@ -1287,8 +1216,9 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i,
 					      hwirq, &its_irq_chip, its_dev);
-		dev_dbg(info->scratchpad[1].ptr, "ID:%d pID:%d vID:%d\n",
-			(int)(hwirq - its_dev->lpi_base), (int)hwirq, virq + i);
+		pr_debug("ID:%d pID:%d vID:%d\n",
+			 (int)(hwirq - its_dev->lpi_base),
+			 (int)hwirq, virq + i);
 	}
 
 	return 0;
@@ -1485,9 +1415,8 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 
 		its->domain->parent = parent;
 
-		its->msi_chip.domain = pci_msi_create_irq_domain(node,
-								 &its_pci_msi_domain_info,
-								 its->domain);
+		its->msi_chip.domain = its_pci_msi_alloc_domain(node,
+								its->domain);
 		if (!its->msi_chip.domain) {
 			err = -ENOMEM;
 			goto out_free_domains;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index ffbc034..d6149ba 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -360,6 +360,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/stringify.h>
+#include <asm/msi.h>
 
 /*
  * We need a value to serve as a irq-type for LPIs. Choose one that will
@@ -388,6 +389,11 @@ struct irq_domain;
 int its_cpu_init(void);
 int its_init(struct device_node *node, struct rdists *rdists,
 	     struct irq_domain *domain);
+int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
+		    int nvec, msi_alloc_info_t *info);
+
+struct irq_domain *its_pci_msi_alloc_domain(struct device_node *node,
+					    struct irq_domain *parent);
 
 #endif
 
-- 
2.1.4

