Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38763 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbbGOMRb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 08:17:31 -0400
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
Subject: [PATCH v4 14/19] irqchip: gicv3-its: Make the PCI/MSI code standalone
Date: Wed, 15 Jul 2015 13:16:48 +0100
Message-Id: <1436962613-17359-15-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can now lookup the base ITS domain, making it possible to
initialize the PCI/MSI code independently from the main ITS
subsystem.

This allows us to remove all the previously add hooks.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 47 ++++++++++++++++++++++++++----
 drivers/irqchip/irq-gic-v3-its.c         | 50 +++++++++++++++++++++-----------
 include/linux/irqchip/arm-gic-v3.h       |  5 ----
 3 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 7614721..cf351c6 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -20,8 +20,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 
-#include <linux/irqchip/arm-gic-v3.h>
-
 static void its_mask_msi_irq(struct irq_data *d)
 {
 	pci_msi_mask_irq(d);
@@ -74,17 +72,24 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 {
 	struct pci_dev *pdev;
 	struct its_pci_alias dev_alias;
+	struct msi_domain_info *msi_info;
 
 	if (!dev_is_pci(dev))
 		return -EINVAL;
 
+	msi_info = msi_get_domain_info(domain->parent);
+
 	pdev = to_pci_dev(dev);
 	dev_alias.pdev = pdev;
 	dev_alias.count = nvec;
 
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
 
-	return its_msi_prepare(domain, dev_alias.dev_id, dev_alias.count, info);
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul = dev_alias.dev_id;
+
+	return msi_info->ops->msi_prepare(domain->parent,
+					  dev, dev_alias.count, info);
 }
 
 static struct msi_domain_ops its_pci_msi_ops = {
@@ -98,8 +103,38 @@ static struct msi_domain_info its_pci_msi_domain_info = {
 	.chip	= &its_msi_irq_chip,
 };
 
-struct irq_domain *its_pci_msi_alloc_domain(struct device_node *np,
-					    struct irq_domain *parent)
+static struct of_device_id its_device_id[] = {
+	{	.compatible	= "arm,gic-v3-its",	},
+	{},
+};
+
+static int __init its_pci_msi_init(void)
 {
-	return pci_msi_create_irq_domain(np, &its_pci_msi_domain_info, parent);
+	struct device_node *np;
+	struct irq_domain *parent;
+
+	for (np = of_find_matching_node(NULL, its_device_id); np;
+	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_property_read_bool(np, "msi-controller"))
+			continue;
+
+		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
+		if (!parent || !msi_get_domain_info(parent)) {
+			pr_err("%s: unable to locate ITS domain\n",
+			       np->full_name);
+			continue;
+		}
+
+		if (!pci_msi_create_irq_domain(np, &its_pci_msi_domain_info,
+					       parent)) {
+			pr_err("%s: unable to create PCI domain\n",
+			       np->full_name);
+			continue;
+		}
+
+		pr_info("PCI/MSI: %s domain created\n", np->full_name);
+	}
+
+	return 0;
 }
+early_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 20fe0dc..21b002f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -60,7 +60,6 @@ struct its_collection {
 struct its_node {
 	raw_spinlock_t		lock;
 	struct list_head	entry;
-	struct irq_domain	*domain;
 	void __iomem		*base;
 	unsigned long		phys_base;
 	struct its_cmd_block	*cmd_base;
@@ -1152,13 +1151,25 @@ static int its_alloc_device_irq(struct its_device *dev, irq_hw_number_t *hwirq)
 	return 0;
 }
 
-int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
-		    int nvec, msi_alloc_info_t *info)
+static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
+			   int nvec, msi_alloc_info_t *info)
 {
 	struct its_node *its;
 	struct its_device *its_dev;
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+
+	/*
+	 * We ignore "dev" entierely, and rely on the dev_id that has
+	 * been passed via the scratchpad. This limits this domain's
+	 * usefulness to upper layers that definitely know that they
+	 * are built on top of the ITS.
+	 */
+	dev_id = info->scratchpad[0].ul;
+
+	msi_info = msi_get_domain_info(domain);
+	its = msi_info->data;
 
-	its = domain->parent->host_data;
 	its_dev = its_find_device(its, dev_id);
 	if (its_dev) {
 		/*
@@ -1180,6 +1191,10 @@ out:
 	return 0;
 }
 
+static struct msi_domain_ops its_msi_domain_ops = {
+	.msi_prepare	= its_msi_prepare,
+};
+
 static int its_irq_gic_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq,
 				    irq_hw_number_t hwirq)
@@ -1316,7 +1331,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	struct resource res;
 	struct its_node *its;
 	void __iomem *its_base;
-	struct irq_domain *inner_domain = NULL;
+	struct irq_domain *inner_domain;
 	u32 val;
 	u64 baser, tmp;
 	int err;
@@ -1406,20 +1421,26 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
 	if (of_property_read_bool(node, "msi-controller")) {
+		struct msi_domain_info *info;
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			err = -ENOMEM;
+			goto out_free_tables;
+		}
+
 		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
 		if (!inner_domain) {
 			err = -ENOMEM;
+			kfree(info);
 			goto out_free_tables;
 		}
 
 		inner_domain->parent = parent;
-		inner_domain->bus_token = DOMAIN_BUS_NEXUS_MSI;
-
-		its->domain = its_pci_msi_alloc_domain(node, inner_domain);
-		if (!its->domain) {
-			err = -ENOMEM;
-			goto out_free_domains;
-		}
+		inner_domain->bus_token = DOMAIN_BUS_NEXUS;
+		info->ops = &its_msi_domain_ops;
+		info->data = its;
+		inner_domain->host_data = info;
 	}
 
 	spin_lock(&its_lock);
@@ -1428,11 +1449,6 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 
 	return 0;
 
-out_free_domains:
-	if (its->domain)
-		irq_domain_remove(its->domain);
-	if (inner_domain)
-		irq_domain_remove(inner_domain);
 out_free_tables:
 	its_free_tables(its);
 out_free_cmd:
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index d6149ba..bf982e0 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -389,11 +389,6 @@ struct irq_domain;
 int its_cpu_init(void);
 int its_init(struct device_node *node, struct rdists *rdists,
 	     struct irq_domain *domain);
-int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
-		    int nvec, msi_alloc_info_t *info);
-
-struct irq_domain *its_pci_msi_alloc_domain(struct device_node *node,
-					    struct irq_domain *parent);
 
 #endif
 
-- 
2.1.4

