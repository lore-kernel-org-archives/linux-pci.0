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
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 12/36] genirq: Move field 'handler_data' from struct irq_data into struct irq_common_data
Date: Mon,  1 Jun 2015 16:05:21 +0800
Message-Id: <1433145945-789-13-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Handler data (handler_data) is per-irq instead of per irqchip, so move
it into struct irq_common_data.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h     |    8 ++++----
 include/linux/irqdesc.h |    2 +-
 kernel/irq/chip.c       |    2 +-
 kernel/irq/irqdesc.c    |    3 ++-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index bcedf9f952d4..68874efe19d3 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -130,12 +130,14 @@ struct irq_domain;
  * @state_use_accessors: status information for irq chip functions.
  *			Use accessor functions to deal with it
  * @node:		node index useful for balancing
+ * @handler_data:	per-IRQ data for the irq_chip methods
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
 #ifdef CONFIG_NUMA
 	unsigned int		node;
 #endif
+	void			*handler_data;
 };
 
 /**
@@ -149,7 +151,6 @@ struct irq_common_data {
  *			between hwirq number and linux irq number.
  * @parent_data:	pointer to parent struct irq_data to support hierarchy
  *			irq_domain
- * @handler_data:	per-IRQ data for the irq_chip methods
  * @chip_data:		platform-specific per-chip private data for the chip
  *			methods, to allow shared chip implementations
  * @msi_desc:		MSI descriptor
@@ -169,7 +170,6 @@ struct irq_data {
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_data		*parent_data;
 #endif
-	void			*handler_data;
 	void			*chip_data;
 	struct msi_desc		*msi_desc;
 	cpumask_var_t		affinity;
@@ -617,12 +617,12 @@ static inline void *irq_data_get_irq_chip_data(struct irq_data *d)
 static inline void *irq_get_handler_data(unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
-	return d ? d->handler_data : NULL;
+	return d ? d->common->handler_data : NULL;
 }
 
 static inline void *irq_data_get_irq_handler_data(struct irq_data *d)
 {
-	return d->handler_data;
+	return d->common->handler_data;
 }
 
 static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index c52d1480f272..d46fd7eb7959 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -120,7 +120,7 @@ static inline void *irq_desc_get_chip_data(struct irq_desc *desc)
 
 static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
 {
-	return desc->irq_data.handler_data;
+	return desc->irq_common_data.handler_data;
 }
 
 static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 55016b2151f3..895de2ea4e32 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -83,7 +83,7 @@ int irq_set_handler_data(unsigned int irq, void *data)
 
 	if (!desc)
 		return -EINVAL;
-	desc->irq_data.handler_data = data;
+	desc->irq_common_data.handler_data = data;
 	irq_put_desc_unlock(desc, flags);
 	return 0;
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 0c3057e42906..7f881792ad5f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -72,11 +72,12 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 {
 	int cpu;
 
+	desc->irq_common_data.handler_data = NULL;
+
 	desc->irq_data.common = &desc->irq_common_data;
 	desc->irq_data.irq = irq;
 	desc->irq_data.chip = &no_irq_chip;
 	desc->irq_data.chip_data = NULL;
-	desc->irq_data.handler_data = NULL;
 	desc->irq_data.msi_desc = NULL;
 	irq_settings_clr_and_set(desc, ~0, _IRQ_DEFAULT_INIT_FLAGS);
 	irqd_set(&desc->irq_data, IRQD_IRQ_DISABLED);
-- 
1.7.10.4

