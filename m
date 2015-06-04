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
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFT v2 18/48] genirq: Kill the parameter 'irq' of note_interrupt()
Date: Thu,  4 Jun 2015 12:13:28 +0800
Message-Id: <1433391238-19471-19-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simplify interrupt management interfaces by killing the parameter 'irq'
of note_interrupt().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h    |    3 +--
 kernel/irq/chip.c      |    4 ++--
 kernel/irq/handle.c    |    2 +-
 kernel/irq/internals.h |    7 +++----
 kernel/irq/manage.c    |   25 +++++++++++++------------
 kernel/irq/pm.c        |   12 ++++++------
 kernel/irq/spurious.c  |   33 ++++++++++++++++-----------------
 7 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 2de650d61a4e..ab6dca4ad968 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -487,8 +487,7 @@ extern int irq_chip_set_vcpu_affinity_parent(struct irq_data *data,
 #endif
 
 /* Handling of unhandled and spurious interrupts: */
-extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
-			   irqreturn_t action_ret);
+extern void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret);
 
 
 /* Enable/disable irq debugging output: */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7fe80d2fcc6c..048698045dad 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -63,7 +63,7 @@ int irq_set_irq_type(unsigned int irq, unsigned int type)
 		return -EINVAL;
 
 	type &= IRQ_TYPE_SENSE_MASK;
-	ret = __irq_set_trigger(desc, irq, type);
+	ret = __irq_set_trigger(desc, type);
 	irq_put_desc_busunlock(desc, flags);
 	return ret;
 }
@@ -328,7 +328,7 @@ void handle_nested_irq(unsigned int irq)
 
 	action_ret = action->thread_fn(action->irq, action->dev_id);
 	if (!noirqdebug)
-		note_interrupt(irq, desc, action_ret);
+		note_interrupt(desc, action_ret);
 
 	raw_spin_lock_irq(&desc->lock);
 	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 4d37b96343e9..b6eeea8a80c5 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -176,7 +176,7 @@ handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
 	add_interrupt_randomness(irq, flags);
 
 	if (!noirqdebug)
-		note_interrupt(irq, desc, retval);
+		note_interrupt(desc, retval);
 	return retval;
 }
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ca2ca5531be6..3d274e2fe605 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -59,10 +59,9 @@ enum {
 #include "debug.h"
 #include "settings.h"
 
-extern int __irq_set_trigger(struct irq_desc *desc, unsigned int irq,
-		unsigned long flags);
-extern void __disable_irq(struct irq_desc *desc, unsigned int irq);
-extern void __enable_irq(struct irq_desc *desc, unsigned int irq);
+extern int __irq_set_trigger(struct irq_desc *desc, unsigned long flags);
+extern void __disable_irq(struct irq_desc *desc);
+extern void __enable_irq(struct irq_desc *desc);
 
 extern int irq_startup(struct irq_desc *desc, bool resend);
 extern void irq_shutdown(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 379a1d60c4f4..32567d4d7031 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -423,7 +423,7 @@ setup_affinity(unsigned int irq, struct irq_desc *desc, struct cpumask *mask)
 }
 #endif
 
-void __disable_irq(struct irq_desc *desc, unsigned int irq)
+void __disable_irq(struct irq_desc *desc)
 {
 	if (!desc->depth++)
 		irq_disable(desc);
@@ -436,7 +436,7 @@ static int __disable_irq_nosync(unsigned int irq)
 
 	if (!desc)
 		return -EINVAL;
-	__disable_irq(desc, irq);
+	__disable_irq(desc);
 	irq_put_desc_busunlock(desc, flags);
 	return 0;
 }
@@ -503,12 +503,13 @@ bool disable_hardirq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(disable_hardirq);
 
-void __enable_irq(struct irq_desc *desc, unsigned int irq)
+void __enable_irq(struct irq_desc *desc)
 {
 	switch (desc->depth) {
 	case 0:
  err_out:
-		WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n", irq);
+		WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n",
+		     irq_desc_get_irq(desc));
 		break;
 	case 1: {
 		if (desc->istate & IRQS_SUSPENDED)
@@ -546,7 +547,7 @@ void enable_irq(unsigned int irq)
 		 KERN_ERR "enable_irq before setup/request_irq: irq %u\n", irq))
 		goto out;
 
-	__enable_irq(desc, irq);
+	__enable_irq(desc);
 out:
 	irq_put_desc_busunlock(desc, flags);
 }
@@ -637,8 +638,7 @@ int can_request_irq(unsigned int irq, unsigned long irqflags)
 	return canrequest;
 }
 
-int __irq_set_trigger(struct irq_desc *desc, unsigned int irq,
-		      unsigned long flags)
+int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
 	int ret, unmask = 0;
@@ -648,7 +648,8 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned int irq,
 		 * IRQF_TRIGGER_* but the PIC does not support multiple
 		 * flow-types?
 		 */
-		pr_debug("No set_type function for IRQ %d (%s)\n", irq,
+		pr_debug("No set_type function for IRQ %d (%s)\n",
+			 irq_desc_get_irq(desc),
 			 chip ? (chip->name ? : "unknown") : "unknown");
 		return 0;
 	}
@@ -685,7 +686,7 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned int irq,
 		break;
 	default:
 		pr_err("Setting trigger mode %lu for irq %u failed (%pF)\n",
-		       flags, irq, chip->irq_set_type);
+		       flags, irq_desc_get_irq(desc), chip->irq_set_type);
 	}
 	if (unmask)
 		unmask_irq(desc);
@@ -1221,7 +1222,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
-			ret = __irq_set_trigger(desc, irq,
+			ret = __irq_set_trigger(desc,
 					new->flags & IRQF_TRIGGER_MASK);
 
 			if (ret)
@@ -1280,7 +1281,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 */
 	if (shared && (desc->istate & IRQS_SPURIOUS_DISABLED)) {
 		desc->istate &= ~IRQS_SPURIOUS_DISABLED;
-		__enable_irq(desc, irq);
+		__enable_irq(desc);
 	}
 
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
@@ -1650,7 +1651,7 @@ void enable_percpu_irq(unsigned int irq, unsigned int type)
 	if (type != IRQ_TYPE_NONE) {
 		int ret;
 
-		ret = __irq_set_trigger(desc, irq, type);
+		ret = __irq_set_trigger(desc, type);
 
 		if (ret) {
 			WARN(1, "failed to set type for IRQ%d\n", irq);
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 5204a6d1b985..50d1a594da7e 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -68,7 +68,7 @@ void irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action)
 		desc->cond_suspend_depth--;
 }
 
-static bool suspend_device_irq(struct irq_desc *desc, int irq)
+static bool suspend_device_irq(struct irq_desc *desc)
 {
 	if (!desc->action || desc->no_suspend_depth)
 		return false;
@@ -85,7 +85,7 @@ static bool suspend_device_irq(struct irq_desc *desc, int irq)
 	}
 
 	desc->istate |= IRQS_SUSPENDED;
-	__disable_irq(desc, irq);
+	__disable_irq(desc);
 
 	/*
 	 * Hardware which has no wakeup source configuration facility
@@ -124,7 +124,7 @@ void suspend_device_irqs(void)
 		bool sync;
 
 		raw_spin_lock_irqsave(&desc->lock, flags);
-		sync = suspend_device_irq(desc, irq);
+		sync = suspend_device_irq(desc);
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 		if (sync)
@@ -133,7 +133,7 @@ void suspend_device_irqs(void)
 }
 EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
-static void resume_irq(struct irq_desc *desc, int irq)
+static void resume_irq(struct irq_desc *desc)
 {
 	irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
 
@@ -148,7 +148,7 @@ static void resume_irq(struct irq_desc *desc, int irq)
 	desc->depth++;
 resume:
 	desc->istate &= ~IRQS_SUSPENDED;
-	__enable_irq(desc, irq);
+	__enable_irq(desc);
 }
 
 static void resume_irqs(bool want_early)
@@ -165,7 +165,7 @@ static void resume_irqs(bool want_early)
 			continue;
 
 		raw_spin_lock_irqsave(&desc->lock, flags);
-		resume_irq(desc, irq);
+		resume_irq(desc);
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index e2514b0e439e..db9e06169adb 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -60,7 +60,7 @@ bool irq_wait_for_poll(struct irq_desc *desc)
 /*
  * Recovery handler for misrouted interrupts.
  */
-static int try_one_irq(int irq, struct irq_desc *desc, bool force)
+static int try_one_irq(struct irq_desc *desc, bool force)
 {
 	irqreturn_t ret = IRQ_NONE;
 	struct irqaction *action;
@@ -133,7 +133,7 @@ static int misrouted_irq(int irq)
 		if (i == irq)	/* Already tried */
 			continue;
 
-		if (try_one_irq(i, desc, false))
+		if (try_one_irq(desc, false))
 			ok = 1;
 	}
 out:
@@ -164,7 +164,7 @@ static void poll_spurious_irqs(unsigned long dummy)
 			continue;
 
 		local_irq_disable();
-		try_one_irq(i, desc, true);
+		try_one_irq(desc, true);
 		local_irq_enable();
 	}
 out:
@@ -189,9 +189,9 @@ static inline int bad_action_ret(irqreturn_t action_ret)
  *  functioning device sharing an IRQ with the failing one)
  */
 static void
-__report_bad_irq(unsigned int irq, struct irq_desc *desc,
-		 irqreturn_t action_ret)
+__report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irqaction *action;
 	unsigned long flags;
 
@@ -225,19 +225,18 @@ __report_bad_irq(unsigned int irq, struct irq_desc *desc,
 }
 
 static void
-report_bad_irq(unsigned int irq, struct irq_desc *desc, irqreturn_t action_ret)
+report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	static int count = 100;
 
 	if (count > 0) {
 		count--;
-		__report_bad_irq(irq, desc, action_ret);
+		__report_bad_irq(desc, action_ret);
 	}
 }
 
 static inline int
-try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
-		  irqreturn_t action_ret)
+try_misrouted_irq(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	struct irqaction *action;
 
@@ -256,7 +255,7 @@ try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
 	if (irqfixup < 2)
 		return 0;
 
-	if (!irq)
+	if (!irq_desc_get_irq(desc))
 		return 1;
 
 	/*
@@ -272,15 +271,14 @@ try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
 
 #define SPURIOUS_DEFERRED	0x80000000
 
-void note_interrupt(unsigned int irq, struct irq_desc *desc,
-		    irqreturn_t action_ret)
+void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	if (desc->istate & IRQS_POLL_INPROGRESS ||
 	    irq_settings_is_polled(desc))
 		return;
 
 	if (bad_action_ret(action_ret)) {
-		report_bad_irq(irq, desc, action_ret);
+		report_bad_irq(desc, action_ret);
 		return;
 	}
 
@@ -398,8 +396,8 @@ void note_interrupt(unsigned int irq, struct irq_desc *desc,
 		desc->last_unhandled = jiffies;
 	}
 
-	if (unlikely(try_misrouted_irq(irq, desc, action_ret))) {
-		int ok = misrouted_irq(irq);
+	if (unlikely(try_misrouted_irq(desc, action_ret))) {
+		int ok = misrouted_irq(irq_desc_get_irq(desc));
 		if (action_ret == IRQ_NONE)
 			desc->irqs_unhandled -= ok;
 	}
@@ -413,11 +411,12 @@ void note_interrupt(unsigned int irq, struct irq_desc *desc,
 		/*
 		 * The interrupt is stuck
 		 */
-		__report_bad_irq(irq, desc, action_ret);
+		__report_bad_irq(desc, action_ret);
 		/*
 		 * Now kill the IRQ
 		 */
-		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
+		printk(KERN_EMERG "Disabling IRQ #%d\n",
+		       irq_desc_get_irq(desc));
 		desc->istate |= IRQS_SPURIOUS_DISABLED;
 		desc->depth++;
 		irq_disable(desc);
-- 
1.7.10.4

