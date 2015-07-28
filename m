Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59197 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755578AbbG1NrK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 09:47:10 -0400
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
	Duc Dang <dhdang@apm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v6 16/19] irqchip: GICv2m: Get rid of struct msi_controller
Date: Tue, 28 Jul 2015 14:46:23 +0100
Message-Id: <1438091186-10244-17-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
References: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

GICv2m only uses the msi_controller structure as a way to match
the host bridge with its MSI HW, and thus the msi_domain.

But now that we can directly associate an msi_domain with a device,
there is no use keeping this msi_controller around.

Just remove all traces of msi_controller from the driver. Also
tag the inner (non-PCI) domain with DOMAIN_BUS_NEXUS.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v2m.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index fdf7065..ec9c376 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -45,7 +45,6 @@
 
 struct v2m_data {
 	spinlock_t msi_cnt_lock;
-	struct msi_controller mchip;
 	struct resource res;	/* GICv2m resource */
 	void __iomem *base;	/* GICv2m virt address */
 	u32 spi_start;		/* The SPI number that MSIs start */
@@ -218,6 +217,7 @@ static int __init gicv2m_init_one(struct device_node *node,
 {
 	int ret;
 	struct v2m_data *v2m;
+	struct irq_domain *inner_domain;
 
 	v2m = kzalloc(sizeof(struct v2m_data), GFP_KERNEL);
 	if (!v2m) {
@@ -261,19 +261,18 @@ static int __init gicv2m_init_one(struct device_node *node,
 		goto err_iounmap;
 	}
 
-	v2m->domain = irq_domain_add_tree(NULL, &gicv2m_domain_ops, v2m);
-	if (!v2m->domain) {
+	inner_domain = irq_domain_add_tree(node, &gicv2m_domain_ops, v2m);
+	if (!inner_domain) {
 		pr_err("Failed to create GICv2m domain\n");
 		ret = -ENOMEM;
 		goto err_free_bm;
 	}
 
-	v2m->domain->parent = parent;
-	v2m->mchip.of_node = node;
-	v2m->mchip.domain = pci_msi_create_irq_domain(node,
-						      &gicv2m_msi_domain_info,
-						      v2m->domain);
-	if (!v2m->mchip.domain) {
+	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
+	inner_domain->parent = parent;
+	v2m->domain = pci_msi_create_irq_domain(node, &gicv2m_msi_domain_info,
+						inner_domain);
+	if (!v2m->domain) {
 		pr_err("Failed to create MSI domain\n");
 		ret = -ENOMEM;
 		goto err_free_domains;
@@ -281,12 +280,6 @@ static int __init gicv2m_init_one(struct device_node *node,
 
 	spin_lock_init(&v2m->msi_cnt_lock);
 
-	ret = of_pci_msi_chip_add(&v2m->mchip);
-	if (ret) {
-		pr_err("Failed to add msi_chip.\n");
-		goto err_free_domains;
-	}
-
 	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
 		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
 		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
@@ -294,10 +287,10 @@ static int __init gicv2m_init_one(struct device_node *node,
 	return 0;
 
 err_free_domains:
-	if (v2m->mchip.domain)
-		irq_domain_remove(v2m->mchip.domain);
 	if (v2m->domain)
 		irq_domain_remove(v2m->domain);
+	if (inner_domain)
+		irq_domain_remove(inner_domain);
 err_free_bm:
 	kfree(v2m->bm);
 err_iounmap:
-- 
2.1.4

