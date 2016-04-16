Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48864 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbcDPBf6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2016 21:35:58 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] genirq: Make use of dev->irq_affinity
Date: Fri, 15 Apr 2016 18:35:46 -0700
Message-Id: <1460770552-31260-3-git-send-email-hch@lst.de>
In-Reply-To: <1460770552-31260-1-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

This allows optimized interrupt allocation and affinity settings for multi
queue devices MSI-X interrupts.

If the device holds a pointer to a cpumask, then this mask is used to:
   - allocate the interrupt descriptor on the proper nodes
   - set the default interrupt affinity for the interrupt

The interrupts are excluded from balancing so the user space balancer cannot
screw with the settings which have been requested by the multiqueue driver.

It's yet not clear how we are going to deal with cpu offlining/onlining. Right
now the affinity will simply break during offline. One option to handle this is:

  If the cpu goes offline, then move the irq to a different cpu on the same
  node. If it's the last cpu on the node or all remaining cpus on that node
  have already a queue we "park" it and reuse it when cpus come online again.

XXX: currently only works properly for MSI-X, not for MSI because MSI
allocates a msi_desc for more than a single vector.

Requested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Fucked-up-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/irq_64.c     |  2 +-
 arch/x86/kernel/apic/io_apic.c |  5 +++--
 include/linux/irq.h            |  4 ++--
 include/linux/irqdomain.h      |  8 ++++---
 kernel/irq/ipi.c               |  4 ++--
 kernel/irq/irqdesc.c           | 48 +++++++++++++++++++++++++++---------------
 kernel/irq/irqdomain.c         | 22 ++++++++++++-------
 kernel/irq/msi.c               | 11 ++++++++--
 8 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index e22416c..437d0f7 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -242,7 +242,7 @@ unsigned int irq_alloc(unsigned int dev_handle, unsigned int dev_ino)
 {
 	int irq;
 
-	irq = __irq_alloc_descs(-1, 1, 1, numa_node_id(), NULL);
+	irq = __irq_alloc_descs(-1, 1, 1, numa_node_id(), NULL, -1);
 	if (irq <= 0)
 		goto out;
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index fdb0fbf..54267ea 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -981,7 +981,7 @@ static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
 
 	return __irq_domain_alloc_irqs(domain, irq, 1,
 				       ioapic_alloc_attr_node(info),
-				       info, legacy);
+				       info, legacy, -1);
 }
 
 /*
@@ -1014,7 +1014,8 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 					  info->ioapic_pin))
 			return -ENOMEM;
 	} else {
-		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true);
+		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true,
+					      -1);
 		if (irq >= 0) {
 			irq_data = irq_domain_get_irq_data(domain, irq);
 			data = irq_data->chip_data;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index c4de623..27779d0 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -697,11 +697,11 @@ static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		struct module *owner);
+		      struct module *owner, int targetcpu);
 
 /* use macros to avoid needing export.h for THIS_MODULE */
 #define irq_alloc_descs(irq, from, cnt, node)	\
-	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE)
+	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE, -1)
 
 #define irq_alloc_desc(node)			\
 	irq_alloc_descs(-1, 0, 1, node)
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2aed043..fa24663 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -215,7 +215,8 @@ extern struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
 						   enum irq_domain_bus_token bus_token);
 extern void irq_set_default_host(struct irq_domain *host);
 extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
-				  irq_hw_number_t hwirq, int node);
+				  irq_hw_number_t hwirq, int node,
+				  int targetcpu);
 
 static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 {
@@ -377,7 +378,7 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
 
 extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 				   unsigned int nr_irqs, int node, void *arg,
-				   bool realloc);
+				   bool realloc, int targetcpu);
 extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 extern void irq_domain_activate_irq(struct irq_data *irq_data);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
@@ -385,7 +386,8 @@ extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
 {
-	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false);
+	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
+				       -1);
 }
 
 extern int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index c37f34b..c635e61 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -76,14 +76,14 @@ unsigned int irq_reserve_ipi(struct irq_domain *domain,
 		}
 	}
 
-	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
+	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE, -1);
 	if (virq <= 0) {
 		pr_warn("Can't reserve IPI, failed to alloc descs\n");
 		return 0;
 	}
 
 	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
-				       (void *) dest, true);
+				       (void *) dest, true, -1);
 
 	if (virq <= 0) {
 		pr_warn("Can't reserve IPI, failed to alloc hw irqs\n");
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 0ccd028..26d92fa 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -68,9 +68,17 @@ static int alloc_masks(struct irq_desc *desc, gfp_t gfp, int node)
 	return 0;
 }
 
-static void desc_smp_init(struct irq_desc *desc, int node)
+static void desc_smp_init(struct irq_desc *desc, int node, int targetcpu)
 {
-	cpumask_copy(desc->irq_common_data.affinity, irq_default_affinity);
+	if (targetcpu < 0) {
+		cpumask_copy(desc->irq_common_data.affinity,
+			     irq_default_affinity);
+	} else {
+		cpumask_copy(desc->irq_common_data.affinity,
+			     cpumask_of(targetcpu));
+		irq_settings_set_no_balancing(desc);
+		irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
+	}
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	cpumask_clear(desc->pending_mask);
 #endif
@@ -82,11 +90,11 @@ static void desc_smp_init(struct irq_desc *desc, int node)
 #else
 static inline int
 alloc_masks(struct irq_desc *desc, gfp_t gfp, int node) { return 0; }
-static inline void desc_smp_init(struct irq_desc *desc, int node) { }
+static inline void desc_smp_init(struct irq_desc *desc, int cpu, int node) { }
 #endif
 
-static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
-		struct module *owner)
+static void desc_set_defaults(unsigned int irq, struct irq_desc *desc,
+			      int node, struct module *owner, int targetcpu)
 {
 	int cpu;
 
@@ -107,7 +115,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = 0;
-	desc_smp_init(desc, node);
+	desc_smp_init(desc, node, targetcpu);
 }
 
 int nr_irqs = NR_IRQS;
@@ -158,7 +166,8 @@ void irq_unlock_sparse(void)
 	mutex_unlock(&sparse_irq_lock);
 }
 
-static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
+static struct irq_desc *alloc_desc(int irq, int node, struct module *owner,
+		int targetcpu)
 {
 	struct irq_desc *desc;
 	gfp_t gfp = GFP_KERNEL;
@@ -178,7 +187,7 @@ static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
 	init_rcu_head(&desc->rcu);
 
-	desc_set_defaults(irq, desc, node, owner);
+	desc_set_defaults(irq, desc, node, owner, targetcpu);
 
 	return desc;
 
@@ -223,13 +232,16 @@ static void free_desc(unsigned int irq)
 }
 
 static int alloc_descs(unsigned int start, unsigned int cnt, int node,
-		       struct module *owner)
+		       struct module *owner, int targetcpu)
 {
 	struct irq_desc *desc;
 	int i;
 
+	if (targetcpu != -1)
+		node = cpu_to_node(targetcpu);
+
 	for (i = 0; i < cnt; i++) {
-		desc = alloc_desc(start + i, node, owner);
+		desc = alloc_desc(start + i, node, owner, targetcpu);
 		if (!desc)
 			goto err;
 		mutex_lock(&sparse_irq_lock);
@@ -277,7 +289,7 @@ int __init early_irq_init(void)
 		nr_irqs = initcnt;
 
 	for (i = 0; i < initcnt; i++) {
-		desc = alloc_desc(i, node, NULL);
+		desc = alloc_desc(i, node, NULL, -1);
 		set_bit(i, allocated_irqs);
 		irq_insert_desc(i, desc);
 	}
@@ -311,7 +323,7 @@ int __init early_irq_init(void)
 		alloc_masks(&desc[i], GFP_KERNEL, node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
-		desc_set_defaults(i, &desc[i], node, NULL);
+		desc_set_defaults(i, &desc[i], node, NULL, -1);
 	}
 	return arch_early_irq_init();
 }
@@ -328,12 +340,12 @@ static void free_desc(unsigned int irq)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
-	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL);
+	desc_set_defaults(irq, desc, -1, irq_desc_get_node(desc), NULL, -1);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
 
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
-			      struct module *owner)
+			      struct module *owner, int targetcpu)
 {
 	u32 i;
 
@@ -453,12 +465,14 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  * @cnt:	Number of consecutive irqs to allocate.
  * @node:	Preferred node on which the irq descriptor should be allocated
  * @owner:	Owning module (can be NULL)
+ * @targetcpu:	CPU number where the irq descriptors should be allocated and
+ *		which should be used for the default affinity.  -1 if not used.
  *
  * Returns the first irq number or error code
  */
 int __ref
 __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner)
+		  struct module *owner, int targetcpu)
 {
 	int start, ret;
 
@@ -494,7 +508,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 
 	bitmap_set(allocated_irqs, start, cnt);
 	mutex_unlock(&sparse_irq_lock);
-	return alloc_descs(start, cnt, node, owner);
+	return alloc_descs(start, cnt, node, owner, targetcpu);
 
 err:
 	mutex_unlock(&sparse_irq_lock);
@@ -512,7 +526,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 unsigned int irq_alloc_hwirqs(int cnt, int node)
 {
-	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL);
+	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL, -1);
 
 	if (irq < 0)
 		return 0;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3a519a0..af7a39f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -483,7 +483,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	}
 
 	/* Allocate a virtual interrupt number */
-	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node));
+	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node), -1);
 	if (virq <= 0) {
 		pr_debug("-> virq allocation failed\n");
 		return 0;
@@ -839,19 +839,23 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 
 int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
-			   int node)
+			   int node, int targetcpu)
 {
 	unsigned int hint;
 
 	if (virq >= 0) {
-		virq = irq_alloc_descs(virq, virq, cnt, node);
+		virq = __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
+					 targetcpu);
 	} else {
 		hint = hwirq % nr_irqs;
 		if (hint == 0)
 			hint++;
-		virq = irq_alloc_descs_from(hint, cnt, node);
-		if (virq <= 0 && hint > 1)
-			virq = irq_alloc_descs_from(1, cnt, node);
+		virq = __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
+					 targetcpu);
+		if (virq <= 0 && hint > 1) {
+			virq = __irq_alloc_descs(-1, 1, cnt, node, THIS_MODULE,
+						 targetcpu);
+		}
 	}
 
 	return virq;
@@ -1163,6 +1167,7 @@ int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
  * @node:	NUMA node id for memory allocation
  * @arg:	domain specific argument
  * @realloc:	IRQ descriptors have already been allocated if true
+ * @targetcpu:	Optional target cpu multiqueue devices (otherwise -1)
  *
  * Allocate IRQ numbers and initialized all data structures to support
  * hierarchy IRQ domains.
@@ -1178,7 +1183,7 @@ int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
  */
 int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			    unsigned int nr_irqs, int node, void *arg,
-			    bool realloc)
+			    bool realloc, int targetcpu)
 {
 	int i, ret, virq;
 
@@ -1196,7 +1201,8 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 	if (realloc && irq_base >= 0) {
 		virq = irq_base;
 	} else {
-		virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node);
+		virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node,
+					      targetcpu);
 		if (virq < 0) {
 			pr_debug("cannot allocate IRQ(base %d, count %d)\n",
 				 irq_base, nr_irqs);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 38e89ce..3385729 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -324,7 +324,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	struct msi_domain_ops *ops = info->ops;
 	msi_alloc_info_t arg;
 	struct msi_desc *desc;
-	int i, ret, virq = -1;
+	int i, ret, virq = -1, cpu = -1;
 
 	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
 	if (ret)
@@ -337,8 +337,15 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 		else
 			virq = -1;
 
+		if (dev->irq_affinity) {
+			cpu = cpumask_next(cpu, dev->irq_affinity);
+			if (cpu > nr_cpu_ids)
+				cpu = cpumask_first(dev->irq_affinity);
+		}
+
 		virq = __irq_domain_alloc_irqs(domain, virq, desc->nvec_used,
-					       dev_to_node(dev), &arg, false);
+					       dev_to_node(dev), &arg, false,
+					       cpu);
 		if (virq < 0) {
 			ret = -ENOSPC;
 			if (ops->handle_error)
-- 
2.1.4

