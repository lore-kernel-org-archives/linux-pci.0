Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] irq: Add untracked irq handler
Date: Fri, 17 Jun 2016 16:00:20 -0600
Message-Id: <1466200821-29159-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a software irq handler for controllers that multiplex
interrupts from multiple devices, but don't know which device generated
the interrupt. For these devices, the irq handler that demuxes must
check every action for every software irq using the same h/w irq in order
to find out which device generated the interrupt. This will inevitably
trigger spurious interrupt detection if we are noting the irq.

The new irq handler does not track the handling for spurious interrupt
detection. An irq that uses this also won't get stats tracked since it
didn't generate the interrupt, nor added to randomness since they are
not random.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 include/linux/irq.h    |  1 +
 kernel/irq/chip.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
 kernel/irq/handle.c    | 18 ++++++++++++++----
 kernel/irq/internals.h |  1 +
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4d758a7..cd7b94e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -482,6 +482,7 @@ extern void handle_fasteoi_irq(struct irq_desc *desc);
 extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
+extern void handle_untracked_irq(struct irq_desc *desc);
 extern void handle_percpu_irq(struct irq_desc *desc);
 extern void handle_percpu_devid_irq(struct irq_desc *desc);
 extern void handle_bad_irq(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2f9f2b0..584e5e8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -426,6 +426,49 @@ out_unlock:
 }
 EXPORT_SYMBOL_GPL(handle_simple_irq);
 
+/**
+ *	handle_untracked_irq - Simple and software-decoded IRQs.
+ *	@desc:	the interrupt description structure for this irq
+ *
+ *	Untracked interrupts are sent from a demultiplexing interrupt
+ *	handler when the demultiplexer does not know which device it its
+ *	multiplexed irq domain generated the interrupt. IRQ's handled
+ *	through here are not subjected to stats tracking, randomness, or
+ *	spurious interrupt detection.
+ *
+ *	Note: Like handle_simple_irq, the caller is expected to handle
+ *	the ack, clear, mask and unmask issues if necessary.
+ */
+void handle_untracked_irq(struct irq_desc *desc)
+{
+	unsigned int flags = 0;
+
+	raw_spin_lock(&desc->lock);
+
+	if (!irq_may_run(desc))
+		goto out_unlock;
+
+	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
+		desc->istate |= IRQS_PENDING;
+		goto out_unlock;
+	}
+
+	desc->istate &= ~IRQS_PENDING;
+	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+	raw_spin_unlock(&desc->lock);
+
+	__handle_irq_event_percpu(desc, &flags);
+
+	raw_spin_lock(&desc->lock);
+	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+
+out_unlock:
+	raw_spin_unlock(&desc->lock);
+}
+EXPORT_SYMBOL_GPL(handle_untracked_irq);
+
 /*
  * Called unconditionally from handle_level_irq() and only for oneshot
  * interrupts from handle_fasteoi_irq()
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index a15b548..d3f2490 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -132,10 +132,10 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	wake_up_process(action->thread);
 }
 
-irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
+irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags)
 {
 	irqreturn_t retval = IRQ_NONE;
-	unsigned int flags = 0, irq = desc->irq_data.irq;
+	unsigned int irq = desc->irq_data.irq;
 	struct irqaction *action;
 
 	for_each_action_of_desc(desc, action) {
@@ -164,7 +164,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 
 			/* Fall through to add to randomness */
 		case IRQ_HANDLED:
-			flags |= action->flags;
+			*flags |= action->flags;
 			break;
 
 		default:
@@ -174,7 +174,17 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 		retval |= res;
 	}
 
-	add_interrupt_randomness(irq, flags);
+	return retval;
+}
+
+irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
+{
+	irqreturn_t retval;
+	unsigned int flags = 0;
+
+	retval = __handle_irq_event_percpu(desc, &flags);
+
+	add_interrupt_randomness(desc->irq_data.irq, flags);
 
 	if (!noirqdebug)
 		note_interrupt(desc, retval);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 09be2c9..d788150 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -83,6 +83,7 @@ extern void irq_mark_irq(unsigned int irq);
 
 extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
 
+irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags);
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
 
-- 
2.7.2
