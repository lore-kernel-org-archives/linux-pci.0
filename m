Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59046 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755287AbbG1Nqf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 09:46:35 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v6 01/19] genirq: irqdomain: Allow irq domain aliasing
Date: Tue, 28 Jul 2015 14:46:08 +0100
Message-Id: <1438091186-10244-2-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
References: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is not uncommon (at least with the ARM stuff) to have a piece
of hardware that implements different flavours of "interrupts".
A typical example of this is the GICv3 ITS, which implements
standard PCI/MSI support, but also some form of "generic MSI".

So far, the PCI/MSI domain is registered using the ITS device_node,
so that irq_find_host can return it. On the contrary, the raw MSI
domain is not registered with an device_node, making it impossible
to be looked up by another subsystem (obviously, using the same
device_node twice would only result in confusion, as it is not
defined which one irq_find_host would return).

A solution to this is to "type" domains that may be aliasing, and
to be able to lookup an device_node that matches a given type.
For this, we introduce irq_find_matching_host() as a superset
of irq_find_host:

struct irq_domain *irq_find_matching_host(struct device_node *node,
                                enum irq_domain_bus_token bus_token);

where bus_token is the "type" we want to match the domain against
(so far, only DOMAIN_BUS_ANY is defined). This result in some
moderately invasive changes on the PPC side (which is the only
user of the .match method).

This has otherwise no functionnal change.

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |  3 ++-
 arch/powerpc/platforms/cell/interrupt.c          |  3 ++-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |  3 ++-
 arch/powerpc/platforms/powermac/pic.c            |  3 ++-
 arch/powerpc/platforms/powernv/opal-irqchip.c    |  3 ++-
 arch/powerpc/platforms/ps3/interrupt.c           |  3 ++-
 arch/powerpc/sysdev/ehv_pic.c                    |  3 ++-
 arch/powerpc/sysdev/i8259.c                      |  3 ++-
 arch/powerpc/sysdev/ipic.c                       |  3 ++-
 arch/powerpc/sysdev/mpic.c                       |  3 ++-
 arch/powerpc/sysdev/qe_lib/qe_ic.c               |  3 ++-
 arch/powerpc/sysdev/xics/xics-common.c           |  3 ++-
 include/linux/irqdomain.h                        | 23 +++++++++++++++++++++--
 kernel/irq/irqdomain.c                           | 18 +++++++++++++-----
 14 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index ca3a062..11090ab 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -123,7 +123,8 @@ cpld_pic_cascade(unsigned int irq, struct irq_desc *desc)
 }
 
 static int
-cpld_pic_host_match(struct irq_domain *h, struct device_node *node)
+cpld_pic_host_match(struct irq_domain *h, struct device_node *node,
+		    enum irq_domain_bus_token bus_token)
 {
 	return cpld_pic_node == node;
 }
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 3af8324..a15f1ef 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -222,7 +222,8 @@ void iic_request_IPIs(void)
 #endif /* CONFIG_SMP */
 
 
-static int iic_host_match(struct irq_domain *h, struct device_node *node)
+static int iic_host_match(struct irq_domain *h, struct device_node *node,
+			  enum irq_domain_bus_token bus_token)
 {
 	return of_device_is_compatible(node,
 				    "IBM,CBEA-Internal-Interrupt-Controller");
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 4cde8e7..b7866e0 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -108,7 +108,8 @@ static int flipper_pic_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static int flipper_pic_match(struct irq_domain *h, struct device_node *np)
+static int flipper_pic_match(struct irq_domain *h, struct device_node *np,
+			     enum irq_domain_bus_token bus_token)
 {
 	return 1;
 }
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 59cfc9d..6f4f8b0 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -268,7 +268,8 @@ static struct irqaction gatwick_cascade_action = {
 	.name		= "cascade",
 };
 
-static int pmac_pic_host_match(struct irq_domain *h, struct device_node *node)
+static int pmac_pic_host_match(struct irq_domain *h, struct device_node *node,
+			       enum irq_domain_bus_token bus_token)
 {
 	/* We match all, we don't always have a node anyway */
 	return 1;
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index e2e7d75..2c91ee7 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -134,7 +134,8 @@ static void opal_handle_irq_work(struct irq_work *work)
 	opal_handle_events(be64_to_cpu(last_outstanding_events));
 }
 
-static int opal_event_match(struct irq_domain *h, struct device_node *node)
+static int opal_event_match(struct irq_domain *h, struct device_node *node,
+			    enum irq_domain_bus_token bus_token)
 {
 	return h->of_node == node;
 }
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index a6c42f3..638c406 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -678,7 +678,8 @@ static int ps3_host_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static int ps3_host_match(struct irq_domain *h, struct device_node *np)
+static int ps3_host_match(struct irq_domain *h, struct device_node *np,
+			  enum irq_domain_bus_token bus_token)
 {
 	/* Match all */
 	return 1;
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index 2d20f10..eca0b00 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -177,7 +177,8 @@ unsigned int ehv_pic_get_irq(void)
 	return irq_linear_revmap(global_ehv_pic->irqhost, irq);
 }
 
-static int ehv_pic_host_match(struct irq_domain *h, struct device_node *node)
+static int ehv_pic_host_match(struct irq_domain *h, struct device_node *node,
+			      enum irq_domain_bus_token bus_token)
 {
 	/* Exact match, unless ehv_pic node is NULL */
 	return h->of_node == NULL || h->of_node == node;
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 31c3347..e1a9c2c 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -162,7 +162,8 @@ static struct resource pic_edgectrl_iores = {
 	.flags = IORESOURCE_BUSY,
 };
 
-static int i8259_host_match(struct irq_domain *h, struct device_node *node)
+static int i8259_host_match(struct irq_domain *h, struct device_node *node,
+			    enum irq_domain_bus_token bus_token)
 {
 	return h->of_node == NULL || h->of_node == node;
 }
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index d78f136..6b2b689 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -671,7 +671,8 @@ static struct irq_chip ipic_edge_irq_chip = {
 	.irq_set_type	= ipic_set_irq_type,
 };
 
-static int ipic_host_match(struct irq_domain *h, struct device_node *node)
+static int ipic_host_match(struct irq_domain *h, struct device_node *node,
+			   enum irq_domain_bus_token bus_token)
 {
 	/* Exact match, unless ipic node is NULL */
 	return h->of_node == NULL || h->of_node == node;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index c8e7333..97a8ae8 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1007,7 +1007,8 @@ static struct irq_chip mpic_irq_ht_chip = {
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 
-static int mpic_host_match(struct irq_domain *h, struct device_node *node)
+static int mpic_host_match(struct irq_domain *h, struct device_node *node,
+			   enum irq_domain_bus_token bus_token)
 {
 	/* Exact match, unless mpic node is NULL */
 	return h->of_node == NULL || h->of_node == node;
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 6512cd8..47b352e 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -244,7 +244,8 @@ static struct irq_chip qe_ic_irq_chip = {
 	.irq_mask_ack = qe_ic_mask_irq,
 };
 
-static int qe_ic_host_match(struct irq_domain *h, struct device_node *node)
+static int qe_ic_host_match(struct irq_domain *h, struct device_node *node,
+			    enum irq_domain_bus_token bus_token)
 {
 	/* Exact match, unless qe_ic node is NULL */
 	return h->of_node == NULL || h->of_node == node;
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 08c248e..47e43b7 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -298,7 +298,8 @@ int xics_get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 }
 #endif /* CONFIG_SMP */
 
-static int xics_host_match(struct irq_domain *h, struct device_node *node)
+static int xics_host_match(struct irq_domain *h, struct device_node *node,
+			   enum irq_domain_bus_token bus_token)
 {
 	struct ics *ics;
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 744ac0e..91a83ad 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -45,6 +45,17 @@ struct irq_data;
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
 
+/*
+ * Should several domains have the same device node, but serve
+ * different purposes (for example one domain is for PCI/MSI, and the
+ * other for wired IRQs), they can be distinguished using a
+ * bus-specific token. Most domains are expected to only carry
+ * DOMAIN_BUS_ANY.
+ */
+enum irq_domain_bus_token {
+	DOMAIN_BUS_ANY		= 0,
+};
+
 /**
  * struct irq_domain_ops - Methods for irq_domain objects
  * @match: Match an interrupt controller device node to a host, returns
@@ -61,7 +72,8 @@ struct irq_data;
  * to setup the irq_desc when returning from map().
  */
 struct irq_domain_ops {
-	int (*match)(struct irq_domain *d, struct device_node *node);
+	int (*match)(struct irq_domain *d, struct device_node *node,
+		     enum irq_domain_bus_token bus_token);
 	int (*map)(struct irq_domain *d, unsigned int virq, irq_hw_number_t hw);
 	void (*unmap)(struct irq_domain *d, unsigned int virq);
 	int (*xlate)(struct irq_domain *d, struct device_node *node,
@@ -116,6 +128,7 @@ struct irq_domain {
 
 	/* Optional data */
 	struct device_node *of_node;
+	enum irq_domain_bus_token bus_token;
 	struct irq_domain_chip_generic *gc;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain *parent;
@@ -161,9 +174,15 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
-extern struct irq_domain *irq_find_host(struct device_node *node);
+extern struct irq_domain *irq_find_matching_host(struct device_node *node,
+						 enum irq_domain_bus_token bus_token);
 extern void irq_set_default_host(struct irq_domain *host);
 
+static inline struct irq_domain *irq_find_host(struct device_node *node)
+{
+	return irq_find_matching_host(node, DOMAIN_BUS_ANY);
+}
+
 /**
  * irq_domain_add_linear() - Allocate and register a linear revmap irq_domain.
  * @of_node: pointer to interrupt controller's device tree node.
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8c3577f..79baaf8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -187,10 +187,12 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
 
 /**
- * irq_find_host() - Locates a domain for a given device node
+ * irq_find_matching_host() - Locates a domain for a given device node
  * @node: device-tree node of the interrupt controller
+ * @bus_token: domain-specific data
  */
-struct irq_domain *irq_find_host(struct device_node *node)
+struct irq_domain *irq_find_matching_host(struct device_node *node,
+					  enum irq_domain_bus_token bus_token)
 {
 	struct irq_domain *h, *found = NULL;
 	int rc;
@@ -199,13 +201,19 @@ struct irq_domain *irq_find_host(struct device_node *node)
 	 * it might potentially be set to match all interrupts in
 	 * the absence of a device node. This isn't a problem so far
 	 * yet though...
+	 *
+	 * bus_token == DOMAIN_BUS_ANY matches any domain, any other
+	 * values must generate an exact match for the domain to be
+	 * selected.
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
 		if (h->ops->match)
-			rc = h->ops->match(h, node);
+			rc = h->ops->match(h, node, bus_token);
 		else
-			rc = (h->of_node != NULL) && (h->of_node == node);
+			rc = ((h->of_node != NULL) && (h->of_node == node) &&
+			      ((bus_token == DOMAIN_BUS_ANY) ||
+			       (h->bus_token == bus_token)));
 
 		if (rc) {
 			found = h;
@@ -215,7 +223,7 @@ struct irq_domain *irq_find_host(struct device_node *node)
 	mutex_unlock(&irq_domain_mutex);
 	return found;
 }
-EXPORT_SYMBOL_GPL(irq_find_host);
+EXPORT_SYMBOL_GPL(irq_find_matching_host);
 
 /**
  * irq_set_default_host() - Set a "default" irq domain
-- 
2.1.4

