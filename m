Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36999 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932823AbbGGRSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 13:18:45 -0400
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
Subject: [PATCH v3 12/15] irqchip: gicv3-its: Get rid of struct msi_controller
Date: Tue,  7 Jul 2015 18:18:02 +0100
Message-Id: <1436289485-28230-13-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The GICv3 ITS only uses the msi_controller structure as a way
to match the PHB with its MSI HW, and thus the msi_domain.
But now that we can directly associate an msi_domain with a device,
there is no use keeping this msi_controller around.

Just remove all traces of msi_controller from the driver.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 140224c..c0b574e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -54,13 +54,12 @@ struct its_collection {
 
 /*
  * The ITS structure - contains most of the infrastructure, with the
- * msi_controller, the command queue, the collections, and the list of
- * devices writing to it.
+ * top-level MSI domain, the command queue, the collections, and the
+ * list of devices writing to it.
  */
 struct its_node {
 	raw_spinlock_t		lock;
 	struct list_head	entry;
-	struct msi_controller	msi_chip;
 	struct irq_domain	*domain;
 	void __iomem		*base;
 	unsigned long		phys_base;
@@ -776,7 +775,7 @@ static void its_free_tables(struct its_node *its)
 	}
 }
 
-static int its_alloc_tables(struct its_node *its)
+static int its_alloc_tables(const char *node_name, struct its_node *its)
 {
 	int err;
 	int i;
@@ -819,7 +818,7 @@ static int its_alloc_tables(struct its_node *its)
 			if (order >= MAX_ORDER) {
 				order = MAX_ORDER - 1;
 				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
-					its->msi_chip.of_node->full_name, order);
+					node_name, order);
 			}
 		}
 
@@ -889,7 +888,7 @@ retry_baser:
 
 		if (val != tmp) {
 			pr_err("ITS: %s: GITS_BASER%d doesn't stick: %lx %lx\n",
-			       its->msi_chip.of_node->full_name, i,
+			       node_name, i,
 			       (unsigned long) val, (unsigned long) tmp);
 			err = -ENXIO;
 			goto out_free;
@@ -1317,6 +1316,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	struct resource res;
 	struct its_node *its;
 	void __iomem *its_base;
+	struct irq_domain *inner_domain = NULL;
 	u32 val;
 	u64 baser, tmp;
 	int err;
@@ -1360,7 +1360,6 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	INIT_LIST_HEAD(&its->its_device_list);
 	its->base = its_base;
 	its->phys_base = res.start;
-	its->msi_chip.of_node = node;
 	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
 
 	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
@@ -1370,7 +1369,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	}
 	its->cmd_write = its->cmd_base;
 
-	err = its_alloc_tables(its);
+	err = its_alloc_tables(node->full_name, its);
 	if (err)
 		goto out_free_cmd;
 
@@ -1406,26 +1405,21 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	writeq_relaxed(0, its->base + GITS_CWRITER);
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
-	if (of_property_read_bool(its->msi_chip.of_node, "msi-controller")) {
-		its->domain = irq_domain_add_tree(node, &its_domain_ops, its);
-		if (!its->domain) {
+	if (of_property_read_bool(node, "msi-controller")) {
+		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
+		if (!inner_domain) {
 			err = -ENOMEM;
 			goto out_free_tables;
 		}
 
-		its->domain->parent = parent;
-		its->domain->bus_token = DOMAIN_BUS_PLATFORM_MSI;
+		inner_domain->parent = parent;
+		inner_domain->bus_token = DOMAIN_BUS_PLATFORM_MSI;
 
-		its->msi_chip.domain = its_pci_msi_alloc_domain(node,
-								its->domain);
-		if (!its->msi_chip.domain) {
+		its->domain = its_pci_msi_alloc_domain(node, inner_domain);
+		if (!its->domain) {
 			err = -ENOMEM;
 			goto out_free_domains;
 		}
-
-		err = of_pci_msi_chip_add(&its->msi_chip);
-		if (err)
-			goto out_free_domains;
 	}
 
 	spin_lock(&its_lock);
@@ -1435,10 +1429,10 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	return 0;
 
 out_free_domains:
-	if (its->msi_chip.domain)
-		irq_domain_remove(its->msi_chip.domain);
 	if (its->domain)
 		irq_domain_remove(its->domain);
+	if (inner_domain)
+		irq_domain_remove(inner_domain);
 out_free_tables:
 	its_free_tables(its);
 out_free_cmd:
-- 
2.1.4

