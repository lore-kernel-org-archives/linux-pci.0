Return-Path: <linux-acpi-owner@vger.kernel.org>
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
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v2 01/14] genirq: Introduce struct irq_common_data to host shared irq data
Date: Wed, 20 May 2015 17:40:32 +0800
Message-Id: <1432114845-24304-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With introduction of hierarchy irqdomain, struct irq_data becomes
per-chip instead of per-irq and there may be multiple irq_datas
associated with the same irq. Some per-irq data stored in
struct irq_data now may get duplicated into multiple irq_datas,
and causes inconsistent view.

So introduce struct irq_common_data to host per-irq common data and to
achieve consistent view among irq_chips.

Other patches in this patch set will move common fields from
struct irq_data into struct irq_common_data one by one.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h     |   54 ++++++++++++++++++++++++++++-------------------
 include/linux/irqdesc.h |    3 ++-
 kernel/irq/internals.h  |   10 ++++-----
 kernel/irq/irqdesc.c    |    1 +
 kernel/irq/irqdomain.c  |    1 +
 5 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 62c6901cab55..3b6e0def7f5c 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -126,13 +126,21 @@ struct msi_desc;
 struct irq_domain;
 
 /**
- * struct irq_data - per irq and irq chip data passed down to chip functions
+ * struct irq_common_data - per irq data shared by all irqchips
+ * @state_use_accessors: status information for irq chip functions.
+ *			Use accessor functions to deal with it
+ */
+struct irq_common_data {
+	unsigned int		state_use_accessors;
+};
+
+/**
+ * struct irq_data - per irq chip data passed down to chip functions
  * @mask:		precomputed bitmask for accessing the chip registers
  * @irq:		interrupt number
  * @hwirq:		hardware interrupt number, local to the interrupt domain
  * @node:		node index useful for balancing
- * @state_use_accessors: status information for irq chip functions.
- *			Use accessor functions to deal with it
+ * @common:		point to data shared by all irqchips
  * @chip:		low level interrupt hardware access
  * @domain:		Interrupt translation domain; responsible for mapping
  *			between hwirq number and linux irq number.
@@ -153,7 +161,7 @@ struct irq_data {
 	unsigned int		irq;
 	unsigned long		hwirq;
 	unsigned int		node;
-	unsigned int		state_use_accessors;
+	struct irq_common_data	*common;
 	struct irq_chip		*chip;
 	struct irq_domain	*domain;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -166,7 +174,7 @@ struct irq_data {
 };
 
 /*
- * Bit masks for irq_data.state
+ * Bit masks for irq_common_data.state_use_accessors
  *
  * IRQD_TRIGGER_MASK		- Mask for the trigger type bits
  * IRQD_SETAFFINITY_PENDING	- Affinity setting is pending
@@ -198,34 +206,36 @@ enum {
 	IRQD_WAKEUP_ARMED		= (1 << 19),
 };
 
+#define __irqd_to_state(d)		((d)->common->state_use_accessors)
+
 static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_SETAFFINITY_PENDING;
+	return __irqd_to_state(d) & IRQD_SETAFFINITY_PENDING;
 }
 
 static inline bool irqd_is_per_cpu(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_PER_CPU;
+	return __irqd_to_state(d) & IRQD_PER_CPU;
 }
 
 static inline bool irqd_can_balance(struct irq_data *d)
 {
-	return !(d->state_use_accessors & (IRQD_PER_CPU | IRQD_NO_BALANCING));
+	return !(__irqd_to_state(d) & (IRQD_PER_CPU | IRQD_NO_BALANCING));
 }
 
 static inline bool irqd_affinity_was_set(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_AFFINITY_SET;
+	return __irqd_to_state(d) & IRQD_AFFINITY_SET;
 }
 
 static inline void irqd_mark_affinity_was_set(struct irq_data *d)
 {
-	d->state_use_accessors |= IRQD_AFFINITY_SET;
+	__irqd_to_state(d) |= IRQD_AFFINITY_SET;
 }
 
 static inline u32 irqd_get_trigger_type(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_TRIGGER_MASK;
+	return __irqd_to_state(d) & IRQD_TRIGGER_MASK;
 }
 
 /*
@@ -233,43 +243,43 @@ static inline u32 irqd_get_trigger_type(struct irq_data *d)
  */
 static inline void irqd_set_trigger_type(struct irq_data *d, u32 type)
 {
-	d->state_use_accessors &= ~IRQD_TRIGGER_MASK;
-	d->state_use_accessors |= type & IRQD_TRIGGER_MASK;
+	__irqd_to_state(d) &= ~IRQD_TRIGGER_MASK;
+	__irqd_to_state(d) |= type & IRQD_TRIGGER_MASK;
 }
 
 static inline bool irqd_is_level_type(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_LEVEL;
+	return __irqd_to_state(d) & IRQD_LEVEL;
 }
 
 static inline bool irqd_is_wakeup_set(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_WAKEUP_STATE;
+	return __irqd_to_state(d) & IRQD_WAKEUP_STATE;
 }
 
 static inline bool irqd_can_move_in_process_context(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_MOVE_PCNTXT;
+	return __irqd_to_state(d) & IRQD_MOVE_PCNTXT;
 }
 
 static inline bool irqd_irq_disabled(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_IRQ_DISABLED;
+	return __irqd_to_state(d) & IRQD_IRQ_DISABLED;
 }
 
 static inline bool irqd_irq_masked(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_IRQ_MASKED;
+	return __irqd_to_state(d) & IRQD_IRQ_MASKED;
 }
 
 static inline bool irqd_irq_inprogress(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_IRQ_INPROGRESS;
+	return __irqd_to_state(d) & IRQD_IRQ_INPROGRESS;
 }
 
 static inline bool irqd_is_wakeup_armed(struct irq_data *d)
 {
-	return d->state_use_accessors & IRQD_WAKEUP_ARMED;
+	return __irqd_to_state(d) & IRQD_WAKEUP_ARMED;
 }
 
 
@@ -280,12 +290,12 @@ static inline bool irqd_is_wakeup_armed(struct irq_data *d)
  */
 static inline void irqd_set_chained_irq_inprogress(struct irq_data *d)
 {
-	d->state_use_accessors |= IRQD_IRQ_INPROGRESS;
+	__irqd_to_state(d) |= IRQD_IRQ_INPROGRESS;
 }
 
 static inline void irqd_clr_chained_irq_inprogress(struct irq_data *d)
 {
-	d->state_use_accessors &= ~IRQD_IRQ_INPROGRESS;
+	__irqd_to_state(d) &= ~IRQD_IRQ_INPROGRESS;
 }
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd1109fb241e..1fcbaadab02e 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -17,7 +17,7 @@ struct pt_regs;
 
 /**
  * struct irq_desc - interrupt descriptor
- * @irq_data:		per irq and chip data passed down to chip functions
+ * @irq_common_data:	per irq and chip data passed down to chip functions
  * @kstat_irqs:		irq stats per cpu
  * @handle_irq:		highlevel irq-events handler
  * @preflow_handler:	handler called before the flow handler (currently used by sparc)
@@ -47,6 +47,7 @@ struct pt_regs;
  * @name:		flow handler name for /proc/interrupts output
  */
 struct irq_desc {
+	struct irq_common_data	irq_common_data;
 	struct irq_data		irq_data;
 	unsigned int __percpu	*kstat_irqs;
 	irq_flow_handler_t	handle_irq;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index df553b0af936..ed84299788b3 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -170,27 +170,27 @@ irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags)
  */
 static inline void irqd_set_move_pending(struct irq_data *d)
 {
-	d->state_use_accessors |= IRQD_SETAFFINITY_PENDING;
+	__irqd_to_state(d) |= IRQD_SETAFFINITY_PENDING;
 }
 
 static inline void irqd_clr_move_pending(struct irq_data *d)
 {
-	d->state_use_accessors &= ~IRQD_SETAFFINITY_PENDING;
+	__irqd_to_state(d) &= ~IRQD_SETAFFINITY_PENDING;
 }
 
 static inline void irqd_clear(struct irq_data *d, unsigned int mask)
 {
-	d->state_use_accessors &= ~mask;
+	__irqd_to_state(d) &= ~mask;
 }
 
 static inline void irqd_set(struct irq_data *d, unsigned int mask)
 {
-	d->state_use_accessors |= mask;
+	__irqd_to_state(d) |= mask;
 }
 
 static inline bool irqd_has_set(struct irq_data *d, unsigned int mask)
 {
-	return d->state_use_accessors & mask;
+	return __irqd_to_state(d) & mask;
 }
 
 static inline void kstat_incr_irqs_this_cpu(unsigned int irq, struct irq_desc *desc)
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 99793b9b6d23..eac1aac906ea 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -76,6 +76,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 {
 	int cpu;
 
+	desc->irq_data.common = &desc->irq_common_data;
 	desc->irq_data.irq = irq;
 	desc->irq_data.chip = &no_irq_chip;
 	desc->irq_data.chip_data = NULL;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7fac311057b8..3552b8750efd 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -834,6 +834,7 @@ static struct irq_data *irq_domain_insert_irq_data(struct irq_domain *domain,
 	if (irq_data) {
 		child->parent_data = irq_data;
 		irq_data->irq = child->irq;
+		irq_data->common = child->common;
 		irq_data->node = child->node;
 		irq_data->domain = domain;
 	}
-- 
1.7.10.4

