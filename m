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
	Grant Likely <grant.likely@linaro.org>,
	Kevin Cernekee <cernekee@gmail.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC v1 03/11] genirq: Use CONFIG_NUMA instead of CONFIG_SMP to guard irq_common_data.node
Date: Mon,  4 May 2015 11:15:31 +0800
Message-Id: <1430709339-29083-4-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

NUMA is enabled by CONFIG_NUMA instead of CONFIG_SMP, so use CONFIG_NUMA
to guard irq_common_data.node.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h  |    4 ++--
 kernel/irq/irqdesc.c |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3f999a0af713..0138f046642c 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -133,7 +133,7 @@ struct irq_domain;
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
-#ifdef CONFIG_SMP
+#ifdef CONFIG_NUMA
 	unsigned int		node;
 #endif
 };
@@ -638,7 +638,7 @@ static inline u32 irq_get_trigger_type(unsigned int irq)
 
 static inline int irq_common_data_get_node(struct irq_common_data *d)
 {
-#ifdef CONFIG_SMP
+#ifdef CONFIG_NUMA
 	return d->node;
 #else
 	return 0;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 20773f073e24..0c3057e42906 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -52,11 +52,13 @@ static int alloc_masks(struct irq_desc *desc, gfp_t gfp, int node)
 
 static void desc_smp_init(struct irq_desc *desc, int node)
 {
-	desc->irq_common_data.node = node;
 	cpumask_copy(desc->irq_data.affinity, irq_default_affinity);
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	cpumask_clear(desc->pending_mask);
 #endif
+#ifdef CONFIG_NUMA
+	desc->irq_common_data.node = node;
+#endif
 }
 
 #else
-- 
1.7.10.4

