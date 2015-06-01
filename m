Return-Path: <linux-acpi-owner@vger.kernel.org>
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
	Marc Zyngier <marc.zyngier@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 01/36] genirq: Enhance irq_data_to_desc() to support hierarchy irqdomain
Date: Mon,  1 Jun 2015 16:05:10 +0800
Message-Id: <1433145945-789-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For irq associated with hierarchy irqdomains, there will be multiple
irq_datas for one irq_desc. So enhance irq_data_to_desc() to support
hierarchy irqdomain. Also export irq_data_to_desc() as an inline
function for later reuse.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irqdesc.h |    9 +++++++++
 kernel/irq/internals.h  |    2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd1109fb241e..a113a8dc7438 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -93,6 +93,15 @@ struct irq_desc {
 extern struct irq_desc irq_desc[NR_IRQS];
 #endif
 
+static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
+{
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irq_to_desc(data->irq);
+#else
+	return container_of(data, struct irq_desc, irq_data);
+#endif
+}
+
 static inline struct irq_data *irq_desc_get_irq_data(struct irq_desc *desc)
 {
 	return &desc->irq_data;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index df553b0af936..b93d434e70bd 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -59,8 +59,6 @@ enum {
 #include "debug.h"
 #include "settings.h"
 
-#define irq_data_to_desc(data)	container_of(data, struct irq_desc, irq_data)
-
 extern int __irq_set_trigger(struct irq_desc *desc, unsigned int irq,
 		unsigned long flags);
 extern void __disable_irq(struct irq_desc *desc, unsigned int irq);
-- 
1.7.10.4

