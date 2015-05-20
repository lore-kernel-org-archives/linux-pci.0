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
Subject: [Patch v2 05/14] genirq: Move field 'node' from struct irq_data into struct irq_common_data
Date: Wed, 20 May 2015 17:40:36 +0800
Message-Id: <1432114845-24304-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

NUMA node information is per-irq instead of per-irqchip, so move it into
struct irq_common_data. Also use CONFIG_NUMA to guard irq_common_data.node.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h    |   17 ++++++++++++++---
 kernel/irq/internals.h |    2 +-
 kernel/irq/irqdesc.c   |    4 +++-
 kernel/irq/irqdomain.c |    1 -
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0de75a22b827..0138f046642c 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -129,9 +129,13 @@ struct irq_domain;
  * struct irq_common_data - per irq data shared by all irqchips
  * @state_use_accessors: status information for irq chip functions.
  *			Use accessor functions to deal with it
+ * @node:		node index useful for balancing
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
+#ifdef CONFIG_NUMA
+	unsigned int		node;
+#endif
 };
 
 /**
@@ -139,7 +143,6 @@ struct irq_common_data {
  * @mask:		precomputed bitmask for accessing the chip registers
  * @irq:		interrupt number
  * @hwirq:		hardware interrupt number, local to the interrupt domain
- * @node:		node index useful for balancing
  * @common:		point to data shared by all irqchips
  * @chip:		low level interrupt hardware access
  * @domain:		Interrupt translation domain; responsible for mapping
@@ -160,7 +163,6 @@ struct irq_data {
 	u32			mask;
 	unsigned int		irq;
 	unsigned long		hwirq;
-	unsigned int		node;
 	struct irq_common_data	*common;
 	struct irq_chip		*chip;
 	struct irq_domain	*domain;
@@ -634,9 +636,18 @@ static inline u32 irq_get_trigger_type(unsigned int irq)
 	return d ? irqd_get_trigger_type(d) : 0;
 }
 
-static inline int irq_data_get_node(struct irq_data *d)
+static inline int irq_common_data_get_node(struct irq_common_data *d)
 {
+#ifdef CONFIG_NUMA
 	return d->node;
+#else
+	return 0;
+#endif
+}
+
+static inline int irq_data_get_node(struct irq_data *d)
+{
+	return irq_common_data_get_node(d->common);
 }
 
 unsigned int arch_dynirq_lower_bound(unsigned int from);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index d1f583543d40..d82a77d39aeb 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -201,7 +201,7 @@ static inline void kstat_incr_irqs_this_cpu(unsigned int irq, struct irq_desc *d
 
 static inline int irq_desc_get_node(struct irq_desc *desc)
 {
-	return irq_data_get_node(&desc->irq_data);
+	return irq_common_data_get_node(&desc->irq_common_data);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b18d3f1d73d9..0c3057e42906 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -52,11 +52,13 @@ static int alloc_masks(struct irq_desc *desc, gfp_t gfp, int node)
 
 static void desc_smp_init(struct irq_desc *desc, int node)
 {
-	desc->irq_data.node = node;
 	cpumask_copy(desc->irq_data.affinity, irq_default_affinity);
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	cpumask_clear(desc->pending_mask);
 #endif
+#ifdef CONFIG_NUMA
+	desc->irq_common_data.node = node;
+#endif
 }
 
 #else
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 1b06dfed4574..93ef89059022 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -836,7 +836,6 @@ static struct irq_data *irq_domain_insert_irq_data(struct irq_domain *domain,
 		child->parent_data = irq_data;
 		irq_data->irq = child->irq;
 		irq_data->common = child->common;
-		irq_data->node = child->node;
 		irq_data->domain = domain;
 	}
 
-- 
1.7.10.4

