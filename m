Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	rjw@rjwysocki.net,
	helgaas@kernel.org,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: will.deacon@arm.com,
	catalin.marinas@arm.com,
	hanjun.guo@linaro.org,
	shijie.huang@arm.com,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	andrea.gallo@linaro.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	al.stone@linaro.org,
	graeme.gregory@linaro.org,
	ddaney.cavm@gmail.com,
	okaya@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V11 4/8] irqchip/gicv3-its: Cleanup for ITS domain initialization
Date: Mon, 12 Sep 2016 20:32:23 +0200
Message-Id: <1473705147-6588-5-git-send-email-tn@semihalf.com>
In-Reply-To: <1473705147-6588-1-git-send-email-tn@semihalf.com>
References: <1473705147-6588-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

There is no point to initialize ITS without having msi-controller
property in corresponding DT node. However, its_probe is checking
msi-controller presence at the end, so we can save our time and do that
check prior to its_probe call. Also, for the code clarity purpose,
we put domain initialization to separate function.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 57 ++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 36b9c28..943442d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1614,13 +1614,37 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
+static int its_init_domain(struct device_node *node, struct its_node *its,
+			   struct irq_domain *parent)
+{
+	struct irq_domain *inner_domain;
+	struct msi_domain_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
+	if (!inner_domain) {
+		kfree(info);
+		return -ENOMEM;
+	}
+
+	inner_domain->parent = parent;
+	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
+	info->ops = &its_msi_domain_ops;
+	info->data = its;
+	inner_domain->host_data = info;
+
+	return 0;
+}
+
 static int __init its_probe(struct device_node *node,
 			    struct irq_domain *parent)
 {
 	struct resource res;
 	struct its_node *its;
 	void __iomem *its_base;
-	struct irq_domain *inner_domain;
 	u32 val;
 	u64 baser, tmp;
 	int err;
@@ -1712,28 +1736,9 @@ static int __init its_probe(struct device_node *node,
 	writeq_relaxed(0, its->base + GITS_CWRITER);
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
-	if (of_property_read_bool(node, "msi-controller")) {
-		struct msi_domain_info *info;
-
-		info = kzalloc(sizeof(*info), GFP_KERNEL);
-		if (!info) {
-			err = -ENOMEM;
-			goto out_free_tables;
-		}
-
-		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
-		if (!inner_domain) {
-			err = -ENOMEM;
-			kfree(info);
-			goto out_free_tables;
-		}
-
-		inner_domain->parent = parent;
-		inner_domain->bus_token = DOMAIN_BUS_NEXUS;
-		info->ops = &its_msi_domain_ops;
-		info->data = its;
-		inner_domain->host_data = info;
-	}
+	err = its_init_domain(node, its, parent);
+	if (err)
+		goto out_free_tables;
 
 	spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
@@ -1784,6 +1789,12 @@ int __init its_init(struct device_node *node, struct rdists *rdists,
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_property_read_bool(np, "msi-controller")) {
+			pr_warn("%s: no msi-controller property, ITS ignored\n",
+				np->full_name);
+			continue;
+		}
+
 		its_probe(np, parent_domain);
 	}
 
-- 
1.9.1
