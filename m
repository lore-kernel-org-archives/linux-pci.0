Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 04/36] genirq: Introduce helper function irq_data_get_node()
Date: Mon,  1 Jun 2015 16:05:13 +0800
Message-Id: <1433145945-789-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce helper function irq_data_get_node() and friends to hide
struct irq_data implementation details.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h    |    5 +++++
 kernel/irq/internals.h |    5 +++++
 kernel/irq/irqdesc.c   |    8 +-------
 kernel/irq/irqdomain.c |    3 ++-
 kernel/irq/manage.c    |    2 +-
 kernel/irq/proc.c      |    2 +-
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c7fbe44edae..b3b82a5344c8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -640,6 +640,11 @@ static inline u32 irq_get_trigger_type(unsigned int irq)
 	return d ? irqd_get_trigger_type(d) : 0;
 }
 
+static inline int irq_data_get_node(struct irq_data *d)
+{
+	return d->node;
+}
+
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index a1ed80d11800..4834ee828c41 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -197,6 +197,11 @@ static inline void kstat_incr_irqs_this_cpu(unsigned int irq, struct irq_desc *d
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
+static inline int irq_desc_get_node(struct irq_desc *desc)
+{
+	return irq_data_get_node(&desc->irq_data);
+}
+
 #ifdef CONFIG_PM_SLEEP
 bool irq_pm_check_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index eac1aac906ea..b18d3f1d73d9 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -59,16 +59,10 @@ static void desc_smp_init(struct irq_desc *desc, int node)
 #endif
 }
 
-static inline int desc_node(struct irq_desc *desc)
-{
-	return desc->irq_data.node;
-}
-
 #else
 static inline int
 alloc_masks(struct irq_desc *desc, gfp_t gfp, int node) { return 0; }
 static inline void desc_smp_init(struct irq_desc *desc, int node) { }
-static inline int desc_node(struct irq_desc *desc) { return 0; }
 #endif
 
 static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
@@ -300,7 +294,7 @@ static void free_desc(unsigned int irq)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
-	desc_set_defaults(irq, desc, desc_node(desc), NULL);
+	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3552b8750efd..1b06dfed4574 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -830,7 +830,8 @@ static struct irq_data *irq_domain_insert_irq_data(struct irq_domain *domain,
 {
 	struct irq_data *irq_data;
 
-	irq_data = kzalloc_node(sizeof(*irq_data), GFP_KERNEL, child->node);
+	irq_data = kzalloc_node(sizeof(*irq_data), GFP_KERNEL,
+				irq_data_get_node(child));
 	if (irq_data) {
 		child->parent_data = irq_data;
 		irq_data->irq = child->irq;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b1c7e8f46bfb..f9744853b656 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -363,7 +363,7 @@ static int
 setup_affinity(unsigned int irq, struct irq_desc *desc, struct cpumask *mask)
 {
 	struct cpumask *set = irq_default_affinity;
-	int node = desc->irq_data.node;
+	int node = irq_desc_get_node(desc);
 
 	/* Excludes PER_CPU and NO_BALANCE interrupts */
 	if (!irq_can_set_affinity(irq))
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index df2f4642d1e7..0e97c142ce40 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -241,7 +241,7 @@ static int irq_node_proc_show(struct seq_file *m, void *v)
 {
 	struct irq_desc *desc = irq_to_desc((long) m->private);
 
-	seq_printf(m, "%d\n", desc->irq_data.node);
+	seq_printf(m, "%d\n", irq_desc_get_node(desc));
 	return 0;
 }
 
-- 
1.7.10.4

