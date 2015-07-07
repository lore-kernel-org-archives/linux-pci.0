Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37008 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932826AbbGGRSs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 13:18:48 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 13/15] irqchip: gicv3-its: Make the PCI/MSI code standalone
Date: Tue,  7 Jul 2015 18:18:03 +0100
Message-Id: <1436289485-28230-14-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can now lookup the base ITS domain, making it possible to
initialize the PCI/MSI code independently from the main ITS
subsystem.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 36 +++++++++++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3-its.c         | 14 +------------
 include/linux/irqchip/arm-gic-v3.h       |  3 ---
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 7614721..4de130ac 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -98,8 +98,38 @@ static struct msi_domain_info its_pci_msi_domain_info = {
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
+		parent = irq_find_matching_host(np, DOMAIN_BUS_PLATFORM_MSI);
+		if (!parent) {
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
+subsys_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c0b574e..49020da 100644
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
@@ -1316,7 +1315,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	struct resource res;
 	struct its_node *its;
 	void __iomem *its_base;
-	struct irq_domain *inner_domain = NULL;
+	struct irq_domain *inner_domain;
 	u32 val;
 	u64 baser, tmp;
 	int err;
@@ -1414,12 +1413,6 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 
 		inner_domain->parent = parent;
 		inner_domain->bus_token = DOMAIN_BUS_PLATFORM_MSI;
-
-		its->domain = its_pci_msi_alloc_domain(node, inner_domain);
-		if (!its->domain) {
-			err = -ENOMEM;
-			goto out_free_domains;
-		}
 	}
 
 	spin_lock(&its_lock);
@@ -1428,11 +1421,6 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 
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
index d6149ba..01caef8 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -392,9 +392,6 @@ int its_init(struct device_node *node, struct rdists *rdists,
 int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
 		    int nvec, msi_alloc_info_t *info);
 
-struct irq_domain *its_pci_msi_alloc_domain(struct device_node *node,
-					    struct irq_domain *parent);
-
 #endif
 
 #endif
-- 
2.1.4

