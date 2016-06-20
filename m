Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
 rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
 robert.richter@caviumnetworks.com, shijie.huang@arm.com,
 Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Subject: [PATCH V7 4/8] irqchip/gicv3-its: Cleanup for ITS domain
 initialization
Date: Mon, 20 Jun 2016 13:02:17 +0200
Message-Id: <1466420541-20101-5-git-send-email-tn@semihalf.com>
In-Reply-To: <1466420541-20101-1-git-send-email-tn@semihalf.com>
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, Catalin.Marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, okaya@codeaurora.org,
 linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, linux-pci@vger.kernel.org,
 Tomasz Nowicki <tn@semihalf.com>, mw@semihalf.com, andrea.gallo@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

There is no point to initialize ITS without having msi-controller
property in corresponding DT node. However, its_probe is checking
msi-controller presence at the end, so we can save our time and do that
check prior to its_probe call. Also, for the code clarity purpose,
we put domain initialization to separate function.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 57 ++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7ceaba8..bd43de1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1609,13 +1609,37 @@ static void its_enable_quirks(struct its_node *its)
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
@@ -1707,28 +1731,9 @@ static int __init its_probe(struct device_node *node,
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
@@ -1779,6 +1784,12 @@ int __init its_init(struct device_node *node, struct rdists *rdists,
 
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
