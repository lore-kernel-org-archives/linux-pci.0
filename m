Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [RFT v2 15/48] genirq: Kill the parameter 'irq' of kstat_incr_irqs_this_cpu()
Date: Thu,  4 Jun 2015 12:13:25 +0800
Message-Id: <1433391238-19471-16-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The first parameter 'irq' is never used by kstat_incr_irqs_this_cpu(),
so kill it. So one step further to kill the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 kernel/irq/chip.c      |   16 ++++++++--------
 kernel/irq/handle.c    |    2 +-
 kernel/irq/internals.h |    2 +-
 kernel/irq/irqdesc.c   |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index da14c388b579..fc7545ca6bf7 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -315,7 +315,7 @@ void handle_nested_irq(unsigned int irq)
 	raw_spin_lock_irq(&desc->lock);
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 
 	action = desc->action;
 	if (unlikely(!action || irqd_irq_disabled(&desc->irq_data))) {
@@ -391,7 +391,7 @@ handle_simple_irq(unsigned int irq, struct irq_desc *desc)
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 
 	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
 		desc->istate |= IRQS_PENDING;
@@ -443,7 +443,7 @@ handle_level_irq(unsigned int irq, struct irq_desc *desc)
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 
 	/*
 	 * If its disabled or no action available
@@ -515,7 +515,7 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 		goto out;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 
 	/*
 	 * If its disabled or no action available
@@ -583,7 +583,7 @@ handle_edge_irq(unsigned int irq, struct irq_desc *desc)
 		goto out_unlock;
 	}
 
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 
 	/* Start handling the irq */
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
@@ -646,7 +646,7 @@ void handle_edge_eoi_irq(unsigned int irq, struct irq_desc *desc)
 		goto out_eoi;
 	}
 
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 
 	do {
 		if (unlikely(!desc->action))
@@ -675,7 +675,7 @@ handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
@@ -705,7 +705,7 @@ void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc)
 	void *dev_id = raw_cpu_ptr(action->percpu_dev_id);
 	irqreturn_t res;
 
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 635480270858..4d37b96343e9 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -30,7 +30,7 @@
 void handle_bad_irq(unsigned int irq, struct irq_desc *desc)
 {
 	print_irq_desc(irq, desc);
-	kstat_incr_irqs_this_cpu(irq, desc);
+	kstat_incr_irqs_this_cpu(desc);
 	ack_bad_irq(irq);
 }
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index b117e4c243d8..d6f65336650c 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -191,7 +191,7 @@ static inline bool irqd_has_set(struct irq_data *d, unsigned int mask)
 	return __irqd_to_state(d) & mask;
 }
 
-static inline void kstat_incr_irqs_this_cpu(unsigned int irq, struct irq_desc *desc)
+static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
 	__this_cpu_inc(*desc->kstat_irqs);
 	__this_cpu_inc(kstat.irqs_sum);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 358f620c035a..500e6fd11d78 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -586,7 +586,7 @@ int irq_set_percpu_devid(unsigned int irq)
 
 void kstat_incr_irq_this_cpu(unsigned int irq)
 {
-	kstat_incr_irqs_this_cpu(irq, irq_to_desc(irq));
+	kstat_incr_irqs_this_cpu(irq_to_desc(irq));
 }
 
 /**
-- 
1.7.10.4

