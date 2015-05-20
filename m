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
Subject: [Patch v2 13/14] genirq: Move field 'msi_desc' from struct irq_data into struct irq_common_data
Date: Wed, 20 May 2015 17:40:44 +0800
Message-Id: <1432114845-24304-14-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MSI descriptors are per-irq instead of per irqchip, so move it into
struct irq_common_data.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h     |    8 ++++----
 include/linux/irqdesc.h |    2 +-
 kernel/irq/chip.c       |    2 +-
 kernel/irq/irqdesc.c    |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 05b2266572ce..657ccd03f94d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -132,6 +132,7 @@ struct irq_domain;
  * @node:		node index useful for balancing
  * @handler_data:	per-IRQ data for the irq_chip methods
  * @affinity:		IRQ affinity on SMP
+ * @msi_desc:		MSI descriptor
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
@@ -139,6 +140,7 @@ struct irq_common_data {
 	unsigned int		node;
 #endif
 	void			*handler_data;
+	struct msi_desc		*msi_desc;
 	cpumask_var_t		affinity;
 };
 
@@ -155,7 +157,6 @@ struct irq_common_data {
  *			irq_domain
  * @chip_data:		platform-specific per-chip private data for the chip
  *			methods, to allow shared chip implementations
- * @msi_desc:		MSI descriptor
  *
  * The fields here need to overlay the ones in irq_desc until we
  * cleaned up the direct references and switched everything over to
@@ -172,7 +173,6 @@ struct irq_data {
 	struct irq_data		*parent_data;
 #endif
 	void			*chip_data;
-	struct msi_desc		*msi_desc;
 };
 
 /*
@@ -622,12 +622,12 @@ static inline void *irq_data_get_irq_handler_data(struct irq_data *d)
 static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
-	return d ? d->msi_desc : NULL;
+	return d ? d->common->msi_desc : NULL;
 }
 
 static inline struct msi_desc *irq_data_get_msi_desc(struct irq_data *d)
 {
-	return d->msi_desc;
+	return d->common->msi_desc;
 }
 
 static inline u32 irq_get_trigger_type(unsigned int irq)
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index f595fb193c8a..8a4044d6efba 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -116,7 +116,7 @@ static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
 
 static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
 {
-	return desc->irq_data.msi_desc;
+	return desc->irq_common_data.msi_desc;
 }
 
 /*
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 46c487fc71dd..d7a50974b77d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -105,7 +105,7 @@ int irq_set_msi_desc_off(unsigned int irq_base, unsigned int irq_offset,
 
 	if (!desc)
 		return -EINVAL;
-	desc->irq_data.msi_desc = entry;
+	desc->irq_common_data.msi_desc = entry;
 	if (entry && !irq_offset)
 		entry->irq = irq_base;
 	irq_put_desc_unlock(desc, flags);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2c39a203f78b..358f620c035a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -74,12 +74,12 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	int cpu;
 
 	desc->irq_common_data.handler_data = NULL;
+	desc->irq_common_data.msi_desc = NULL;
 
 	desc->irq_data.common = &desc->irq_common_data;
 	desc->irq_data.irq = irq;
 	desc->irq_data.chip = &no_irq_chip;
 	desc->irq_data.chip_data = NULL;
-	desc->irq_data.msi_desc = NULL;
 	irq_settings_clr_and_set(desc, ~0, _IRQ_DEFAULT_INIT_FLAGS);
 	irqd_set(&desc->irq_data, IRQD_IRQ_DISABLED);
 	desc->handle_irq = handle_bad_irq;
-- 
1.7.10.4

