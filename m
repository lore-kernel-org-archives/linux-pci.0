Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37838 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932205AbcFNT73 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2016 15:59:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] irq: Use affinity hint in irqdesc allocation
Date: Tue, 14 Jun 2016 21:58:57 +0200
Message-Id: <1465934346-20648-5-git-send-email-hch@lst.de>
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the affinity hint in the irqdesc allocator. The hint is used to determine
the node for the allocation and to set the affinity of the interrupt.

If multiple interrupts are allocated (multi-MSI) then the allocator iterates
over the cpumask and for each set cpu it allocates on their node and sets the
initial affinity to that cpu.

If a single interrupt is allocated (MSI-X) then the allocator uses the first
cpu in the mask to compute the allocation node and uses the mask for the
initial affinity setting.

Interrupts set up this way are marked with the AFFINITY_MANAGED flag to
prevent userspace from messing with their affinity settings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdesc.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b8df4fc..a623b44 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -68,9 +68,13 @@ static int alloc_masks(struct irq_desc *desc, gfp_t gfp, int node)
 	return 0;
 }
 
-static void desc_smp_init(struct irq_desc *desc, int node)
+static void desc_smp_init(struct irq_desc *desc, int node,
+			  const struct cpumask *affinity)
 {
-	cpumask_copy(desc->irq_common_data.affinity, irq_default_affinity);
+	if (!affinity)
+		affinity = irq_default_affinity;
+	cpumask_copy(desc->irq_common_data.affinity, affinity);
+
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	cpumask_clear(desc->pending_mask);
 #endif
@@ -82,11 +86,12 @@ static void desc_smp_init(struct irq_desc *desc, int node)
 #else
 static inline int
 alloc_masks(struct irq_desc *desc, gfp_t gfp, int node) { return 0; }
-static inline void desc_smp_init(struct irq_desc *desc, int node) { }
+static inline void
+desc_smp_init(struct irq_desc *desc, int node, const struct cpumask *affinity) { }
 #endif
 
 static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
-		struct module *owner)
+			      const struct cpumask *affinity, struct module *owner)
 {
 	int cpu;
 
@@ -107,7 +112,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = 0;
-	desc_smp_init(desc, node);
+	desc_smp_init(desc, node, affinity);
 }
 
 int nr_irqs = NR_IRQS;
@@ -158,7 +163,9 @@ void irq_unlock_sparse(void)
 	mutex_unlock(&sparse_irq_lock);
 }
 
-static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
+static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
+				   const struct cpumask *affinity,
+				   struct module *owner)
 {
 	struct irq_desc *desc;
 	gfp_t gfp = GFP_KERNEL;
@@ -178,7 +185,8 @@ static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
 	init_rcu_head(&desc->rcu);
 
-	desc_set_defaults(irq, desc, node, owner);
+	desc_set_defaults(irq, desc, node, affinity, owner);
+	irqd_set(&desc->irq_data, flags);
 
 	return desc;
 
@@ -225,11 +233,30 @@ static void free_desc(unsigned int irq)
 static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		       const struct cpumask *affinity, struct module *owner)
 {
+	const struct cpumask *mask = NULL;
 	struct irq_desc *desc;
-	int i;
+	unsigned int flags;
+	int i, cpu = -1;
+
+	if (affinity && cpumask_empty(affinity))
+		return -EINVAL;
+
+	flags = affinity ? IRQD_AFFINITY_MANAGED : 0;
 
 	for (i = 0; i < cnt; i++) {
-		desc = alloc_desc(start + i, node, owner);
+		if (affinity) {
+			cpu = cpumask_next(cpu, affinity);
+			if (cpu >= nr_cpu_ids)
+				cpu = cpumask_first(affinity);
+			node = cpu_to_node(cpu);
+
+			/*
+			 * For single allocations we use the caller provided
+			 * mask otherwise we use the mask of the target cpu
+			 */
+			mask = cnt == 1 ? affinity : cpumask_of(cpu);
+		}
+		desc = alloc_desc(start + i, node, flags, mask, owner);
 		if (!desc)
 			goto err;
 		mutex_lock(&sparse_irq_lock);
@@ -277,7 +304,7 @@ int __init early_irq_init(void)
 		nr_irqs = initcnt;
 
 	for (i = 0; i < initcnt; i++) {
-		desc = alloc_desc(i, node, NULL);
+		desc = alloc_desc(i, node, 0, NULL, NULL);
 		set_bit(i, allocated_irqs);
 		irq_insert_desc(i, desc);
 	}
@@ -311,7 +338,7 @@ int __init early_irq_init(void)
 		alloc_masks(&desc[i], GFP_KERNEL, node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
-		desc_set_defaults(i, &desc[i], node, NULL);
+		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
 	return arch_early_irq_init();
 }
@@ -328,7 +355,7 @@ static void free_desc(unsigned int irq)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
-	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL);
+	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-- 
2.1.4

