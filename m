Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Subject: [Patch v2 10/14] genirq: Move field 'affinity' from struct irq_data into struct irq_common_data
Date: Wed, 20 May 2015 17:40:41 +0800
Message-Id: <1432114845-24304-11-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Irq affinity mask is per-irq instead of per irqchip, so move it into
struct irq_common_data.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h  |   12 ++++++------
 kernel/irq/irqdesc.c |    9 +++++----
 kernel/irq/manage.c  |   12 ++++++------
 kernel/irq/proc.c    |    2 +-
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 2eb82257aaee..e33cc0b040f2 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -110,8 +110,8 @@ enum {
 /*
  * Return value for chip->irq_set_affinity()
  *
- * IRQ_SET_MASK_OK	- OK, core updates irq_data.affinity
- * IRQ_SET_MASK_NOCPY	- OK, chip did update irq_data.affinity
+ * IRQ_SET_MASK_OK	- OK, core updates irq_common_data.affinity
+ * IRQ_SET_MASK_NOCPY	- OK, chip did update irq_common_data.affinity
  * IRQ_SET_MASK_OK_DONE	- Same as IRQ_SET_MASK_OK for core. Special code to
  *			  support stacked irqchips, which indicates skipping
  *			  all descendent irqchips.
@@ -131,6 +131,7 @@ struct irq_domain;
  *			Use accessor functions to deal with it
  * @node:		node index useful for balancing
  * @handler_data:	per-IRQ data for the irq_chip methods
+ * @affinity:		IRQ affinity on SMP
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
@@ -138,6 +139,7 @@ struct irq_common_data {
 	unsigned int		node;
 #endif
 	void			*handler_data;
+	cpumask_var_t		affinity;
 };
 
 /**
@@ -154,7 +156,6 @@ struct irq_common_data {
  * @chip_data:		platform-specific per-chip private data for the chip
  *			methods, to allow shared chip implementations
  * @msi_desc:		MSI descriptor
- * @affinity:		IRQ affinity on SMP
  *
  * The fields here need to overlay the ones in irq_desc until we
  * cleaned up the direct references and switched everything over to
@@ -172,7 +173,6 @@ struct irq_data {
 #endif
 	void			*chip_data;
 	struct msi_desc		*msi_desc;
-	cpumask_var_t		affinity;
 };
 
 /*
@@ -654,12 +654,12 @@ static inline struct cpumask *irq_get_affinity_mask(int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
 
-	return d ? d->affinity : NULL;
+	return d ? d->common->affinity : NULL;
 }
 
 static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 {
-	return d->affinity;
+	return d->common->affinity;
 }
 
 unsigned int arch_dynirq_lower_bound(unsigned int from);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 7f881792ad5f..2c39a203f78b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -38,12 +38,13 @@ static void __init init_irq_default_affinity(void)
 #ifdef CONFIG_SMP
 static int alloc_masks(struct irq_desc *desc, gfp_t gfp, int node)
 {
-	if (!zalloc_cpumask_var_node(&desc->irq_data.affinity, gfp, node))
+	if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity,
+				     gfp, node))
 		return -ENOMEM;
 
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	if (!zalloc_cpumask_var_node(&desc->pending_mask, gfp, node)) {
-		free_cpumask_var(desc->irq_data.affinity);
+		free_cpumask_var(desc->irq_common_data.affinity);
 		return -ENOMEM;
 	}
 #endif
@@ -52,7 +53,7 @@ static int alloc_masks(struct irq_desc *desc, gfp_t gfp, int node)
 
 static void desc_smp_init(struct irq_desc *desc, int node)
 {
-	cpumask_copy(desc->irq_data.affinity, irq_default_affinity);
+	cpumask_copy(desc->irq_common_data.affinity, irq_default_affinity);
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	cpumask_clear(desc->pending_mask);
 #endif
@@ -124,7 +125,7 @@ static void free_masks(struct irq_desc *desc)
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	free_cpumask_var(desc->pending_mask);
 #endif
-	free_cpumask_var(desc->irq_data.affinity);
+	free_cpumask_var(desc->irq_common_data.affinity);
 }
 #else
 static inline void free_masks(struct irq_desc *desc) { }
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d206aa2c3378..7588bf87e8f3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -190,7 +190,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
-		cpumask_copy(data->affinity, mask);
+		cpumask_copy(desc->irq_common_data.affinity, mask);
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_set_thread_affinity(desc);
 		ret = 0;
@@ -271,7 +271,7 @@ static void irq_affinity_notify(struct work_struct *work)
 	if (irq_move_pending(&desc->irq_data))
 		irq_get_pending(cpumask, desc);
 	else
-		cpumask_copy(cpumask, desc->irq_data.affinity);
+		cpumask_copy(cpumask, desc->irq_common_data.affinity);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	notify->notify(notify, cpumask);
@@ -343,9 +343,9 @@ setup_affinity(unsigned int irq, struct irq_desc *desc, struct cpumask *mask)
 	 * one of the targets is online.
 	 */
 	if (irqd_has_set(&desc->irq_data, IRQD_AFFINITY_SET)) {
-		if (cpumask_intersects(desc->irq_data.affinity,
+		if (cpumask_intersects(desc->irq_common_data.affinity,
 				       cpu_online_mask))
-			set = desc->irq_data.affinity;
+			set = desc->irq_common_data.affinity;
 		else
 			irqd_clear(&desc->irq_data, IRQD_AFFINITY_SET);
 	}
@@ -796,8 +796,8 @@ irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
 	 * This code is triggered unconditionally. Check the affinity
 	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
 	 */
-	if (desc->irq_data.affinity)
-		cpumask_copy(mask, desc->irq_data.affinity);
+	if (desc->irq_common_data.affinity)
+		cpumask_copy(mask, desc->irq_common_data.affinity);
 	else
 		valid = false;
 	raw_spin_unlock_irq(&desc->lock);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 0e97c142ce40..e3a8c9577ba6 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -39,7 +39,7 @@ static struct proc_dir_entry *root_irq_dir;
 static int show_irq_affinity(int type, struct seq_file *m, void *v)
 {
 	struct irq_desc *desc = irq_to_desc((long)m->private);
-	const struct cpumask *mask = desc->irq_data.affinity;
+	const struct cpumask *mask = desc->irq_common_data.affinity;
 
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	if (irqd_is_setaffinity_pending(&desc->irq_data))
-- 
1.7.10.4

