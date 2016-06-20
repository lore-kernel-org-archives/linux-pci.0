Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
 rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
 robert.richter@caviumnetworks.com, shijie.huang@arm.com,
 Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Subject: [PATCH V7 5/8] irqchip/gicv3-its: Refactor ITS DT init code to
 prepare for ACPI
Date: Mon, 20 Jun 2016 13:02:18 +0200
Message-Id: <1466420541-20101-6-git-send-email-tn@semihalf.com>
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

In order to add ACPI support we need to isolate ACPI&DT common code and
move DT logic to corresponding functions. To achieve this we are using
firmware agnostic handle which can be unpacked to either DT or ACPI node.

No functional changes other than a very minor one:
1. Terminate its_init call with -ENODEV for non-DT case which allows
to remove hack from its-gic-v3.c.
2. Fix ITS base register address type (from 'unsigned long' to 'phys_addr_t'),
as a bonus we get nice string formatting.
3. Since there is only one of ITS parent domain convert it to static global
variable and drop the parameter from its_probe_one. Users can refer to it
in more convenient way then.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 65 ++++++++++++++++++++++----------------
 drivers/irqchip/irq-gic-v3.c       |  7 ++--
 include/linux/irqchip/arm-gic-v3.h |  4 +--
 3 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index bd43de1..1e0888d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -75,7 +75,7 @@ struct its_node {
 	raw_spinlock_t		lock;
 	struct list_head	entry;
 	void __iomem		*base;
-	unsigned long		phys_base;
+	phys_addr_t		phys_base;
 	struct its_cmd_block	*cmd_base;
 	struct its_cmd_block	*cmd_write;
 	struct its_baser	tables[GITS_BASER_NR_REGS];
@@ -115,6 +115,7 @@ struct its_device {
 static LIST_HEAD(its_nodes);
 static DEFINE_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
+static struct irq_domain *its_parent;
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
@@ -1609,8 +1610,7 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
-static int its_init_domain(struct device_node *node, struct its_node *its,
-			   struct irq_domain *parent)
+static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 {
 	struct irq_domain *inner_domain;
 	struct msi_domain_info *info;
@@ -1619,13 +1619,13 @@ static int its_init_domain(struct device_node *node, struct its_node *its,
 	if (!info)
 		return -ENOMEM;
 
-	inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
+	inner_domain = irq_domain_create_tree(handle, &its_domain_ops, its);
 	if (!inner_domain) {
 		kfree(info);
 		return -ENOMEM;
 	}
 
-	inner_domain->parent = parent;
+	inner_domain->parent = its_parent;
 	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
 	info->ops = &its_msi_domain_ops;
 	info->data = its;
@@ -1634,43 +1634,35 @@ static int its_init_domain(struct device_node *node, struct its_node *its,
 	return 0;
 }
 
-static int __init its_probe(struct device_node *node,
-			    struct irq_domain *parent)
+static int __init its_probe_one(struct resource *res,
+				struct fwnode_handle *handle, int numa_node)
 {
-	struct resource res;
 	struct its_node *its;
 	void __iomem *its_base;
 	u32 val;
 	u64 baser, tmp;
 	int err;
 
-	err = of_address_to_resource(node, 0, &res);
-	if (err) {
-		pr_warn("%s: no regs?\n", node->full_name);
-		return -ENXIO;
-	}
-
-	its_base = ioremap(res.start, resource_size(&res));
+	its_base = ioremap(res->start, resource_size(res));
 	if (!its_base) {
-		pr_warn("%s: unable to map registers\n", node->full_name);
+		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
 		return -ENOMEM;
 	}
 
 	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
 	if (val != 0x30 && val != 0x40) {
-		pr_warn("%s: no ITS detected, giving up\n", node->full_name);
+		pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
 		err = -ENODEV;
 		goto out_unmap;
 	}
 
 	err = its_force_quiescent(its_base);
 	if (err) {
-		pr_warn("%s: failed to quiesce, giving up\n",
-			node->full_name);
+		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
 		goto out_unmap;
 	}
 
-	pr_info("ITS: %s\n", node->full_name);
+	pr_info("ITS@%pa\n", &res->start);
 
 	its = kzalloc(sizeof(*its), GFP_KERNEL);
 	if (!its) {
@@ -1682,9 +1674,9 @@ static int __init its_probe(struct device_node *node,
 	INIT_LIST_HEAD(&its->entry);
 	INIT_LIST_HEAD(&its->its_device_list);
 	its->base = its_base;
-	its->phys_base = res.start;
+	its->phys_base = res->start;
 	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
-	its->numa_node = of_node_to_nid(node);
+	its->numa_node = numa_node;
 
 	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
 	if (!its->cmd_base) {
@@ -1731,7 +1723,7 @@ static int __init its_probe(struct device_node *node,
 	writeq_relaxed(0, its->base + GITS_CWRITER);
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
-	err = its_init_domain(node, its, parent);
+	err = its_init_domain(handle, its);
 	if (err)
 		goto out_free_tables;
 
@@ -1749,7 +1741,7 @@ out_free_its:
 	kfree(its);
 out_unmap:
 	iounmap(its_base);
-	pr_err("ITS: failed probing %s (%d)\n", node->full_name, err);
+	pr_err("ITS@%pa: failed probing (%d)\n", &res->start, err);
 	return err;
 }
 
@@ -1777,10 +1769,10 @@ static struct of_device_id its_device_id[] = {
 	{},
 };
 
-int __init its_init(struct device_node *node, struct rdists *rdists,
-	     struct irq_domain *parent_domain)
+static int __init its_of_probe(struct device_node *node)
 {
 	struct device_node *np;
+	struct resource res;
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
@@ -1790,8 +1782,27 @@ int __init its_init(struct device_node *node, struct rdists *rdists,
 			continue;
 		}
 
-		its_probe(np, parent_domain);
+		if (of_address_to_resource(np, 0, &res)) {
+			pr_warn("%s: no regs?\n", np->full_name);
+			continue;
+		}
+
+		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
 	}
+	return 0;
+}
+
+int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
+		    struct irq_domain *parent_domain)
+{
+	struct device_node *of_node;
+
+	its_parent = parent_domain;
+	of_node = to_of_node(handle);
+	if (of_node)
+		its_of_probe(of_node);
+	else
+		return -ENODEV;
 
 	if (list_empty(&its_nodes)) {
 		pr_warn("ITS: No ITS available, not enabling LPIs\n");
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2c5ba0e..2a8b2e1 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -911,7 +911,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 				 u64 redist_stride,
 				 struct fwnode_handle *handle)
 {
-	struct device_node *node;
 	u32 typer;
 	int gic_irqs;
 	int err;
@@ -952,10 +951,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	node = to_of_node(handle);
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
-	    node) /* Temp hack to prevent ITS init for ACPI */
-		its_init(node, &gic_data.rdists, gic_data.domain);
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
+		its_init(handle, &gic_data.rdists, gic_data.domain);
 
 	gic_smp_init();
 	gic_dist_init();
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 107eed4..a1ea4e2 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -338,9 +338,9 @@ struct rdists {
 };
 
 struct irq_domain;
-struct device_node;
+struct fwnode_handle;
 int its_cpu_init(void);
-int its_init(struct device_node *node, struct rdists *rdists,
+int its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	     struct irq_domain *domain);
 
 static inline bool gic_enable_sre(void)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
