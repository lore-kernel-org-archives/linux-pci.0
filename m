Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFT v2 20/48] genirq: Kill the parameter 'irq' of setup_affinity()
Date: Thu,  4 Jun 2015 12:13:30 +0800
Message-Id: <1433391238-19471-21-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simplify interrupt management interfaces by killing the parameter 'irq'
of setup_affinity().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 kernel/irq/manage.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e478a0f25bd6..cce2b52c865d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -115,6 +115,15 @@ EXPORT_SYMBOL(synchronize_irq);
 #ifdef CONFIG_SMP
 cpumask_var_t irq_default_affinity;
 
+static int __irq_can_set_affinity(struct irq_desc *desc)
+{
+	if (!desc || !irqd_can_balance(&desc->irq_data) ||
+	    !desc->irq_data.chip || !desc->irq_data.chip->irq_set_affinity)
+		return 0;
+
+	return 1;
+}
+
 /**
  *	irq_can_set_affinity - Check if the affinity of a given irq can be set
  *	@irq:		Interrupt to check
@@ -122,13 +131,7 @@ cpumask_var_t irq_default_affinity;
  */
 int irq_can_set_affinity(unsigned int irq)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (!desc || !irqd_can_balance(&desc->irq_data) ||
-	    !desc->irq_data.chip || !desc->irq_data.chip->irq_set_affinity)
-		return 0;
-
-	return 1;
+	return __irq_can_set_affinity(irq_to_desc(irq));
 }
 
 /**
@@ -360,13 +363,13 @@ EXPORT_SYMBOL_GPL(irq_set_affinity_notifier);
  * Generic version of the affinity autoselector.
  */
 static int
-setup_affinity(unsigned int irq, struct irq_desc *desc, struct cpumask *mask)
+setup_affinity(struct irq_desc *desc, struct cpumask *mask)
 {
 	struct cpumask *set = irq_default_affinity;
 	int node = irq_desc_get_node(desc);
 
 	/* Excludes PER_CPU and NO_BALANCE interrupts */
-	if (!irq_can_set_affinity(irq))
+	if (!__irq_can_set_affinity(desc))
 		return 0;
 
 	/*
@@ -394,9 +397,9 @@ setup_affinity(unsigned int irq, struct irq_desc *desc, struct cpumask *mask)
 }
 #else
 static inline int
-setup_affinity(unsigned int irq, struct irq_desc *d, struct cpumask *mask)
+setup_affinity(struct irq_desc *d, struct cpumask *mask)
 {
-	return irq_select_affinity(irq);
+	return irq_select_affinity(irq_desc_get_irq(d));
 }
 #endif
 
@@ -410,14 +413,14 @@ int irq_select_affinity_usr(unsigned int irq, struct cpumask *mask)
 	int ret;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
-	ret = setup_affinity(irq, desc, mask);
+	ret = setup_affinity(desc, mask);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	return ret;
 }
 
 #else
 static inline int
-setup_affinity(unsigned int irq, struct irq_desc *desc, struct cpumask *mask)
+setup_affinity(struct irq_desc *desc, struct cpumask *mask)
 {
 	return 0;
 }
@@ -1254,7 +1257,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		}
 
 		/* Set default affinity mask once everything is setup */
-		setup_affinity(irq, desc, mask);
+		setup_affinity(desc, mask);
 
 	} else if (new->flags & IRQF_TRIGGER_MASK) {
 		unsigned int nmsk = new->flags & IRQF_TRIGGER_MASK;
-- 
1.7.10.4

