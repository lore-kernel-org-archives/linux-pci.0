Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:50509 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPT2H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:28:07 -0400
Message-Id: <b65b18957cec018dec5c1f1c3de0e2e47b46b265.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 09/32] PCI: pciehp: Convert to threaded IRQ
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pciehp's IRQ handler queues up a work item for each event signaled by
the hardware.  A more modern alternative is to let a long running
kthread service the events.  The IRQ handler's sole job is then to check
whether the IRQ originated from the device in question, acknowledge its
receipt to the hardware to quiesce the interrupt and wake up the kthread.

One benefit is reduced latency to handle the IRQ, which is a necessity
for realtime environments.  Another benefit is that we can make pciehp
simpler and more robust by handling events synchronously in process
context, rather than asynchronously by queueing up work items.  pciehp's
usage of work items is a historic artifact, it predates the introduction
of threaded IRQ handlers by two years.  (The former was introduced in
2007 with commit 5d386e1ac402 ("pciehp: Event handling rework"), the
latter in 2009 with commit 3aa551c9b4c4 ("genirq: add threaded interrupt
handler support").)

Convert pciehp to threaded IRQ handling by retrieving the pending events
in pciehp_isr(), saving them for later consumption by the thread handler
pciehp_ist() and clearing them in the Slot Status register.

By clearing the Slot Status (and thereby acknowledging the events) in
pciehp_isr(), we can avoid requesting the IRQ with IRQF_ONESHOT, which
would have the unpleasant side effect of starving devices sharing the
IRQ until pciehp_ist() has finished.

pciehp_isr() does not count how many times each event occurred, but
merely records the fact *that* an event occurred.  If the same event
occurs a second time before pciehp_ist() is woken, that second event
will not be recorded separately, which is problematic according to
commit fad214b0aa72 ("PCI: pciehp: Process all hotplug events before
looking for new ones") because we may miss removal of a card in-between
two back-to-back insertions.  We're about to make pciehp_ist() resilient
to missed events.  The present commit regresses the driver's behavior
temporarily in order to separate the changes into reviewable chunks.
This doesn't affect regular slow-motion hotplug, only plug-unplug-plug
operations that happen in a timespan shorter than wakeup of the IRQ
thread.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mayurkumar Patel <mayurkumar.patel@intel.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h     |  3 ++
 drivers/pci/hotplug/pciehp_hpc.c | 70 +++++++++++++++++---------------
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index c3d63e5b650f..ab1d97a1822d 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -112,6 +112,8 @@ struct event_info {
  * @notification_enabled: whether the IRQ was requested successfully
  * @power_fault_detected: whether a power fault was detected by the hardware
  *	that has not yet been cleared by the user
+ * @pending_events: used by the IRQ handler to save events retrieved from the
+ *	Slot Status register for later consumption by the IRQ thread
  */
 struct controller {
 	struct mutex ctrl_lock;
@@ -126,6 +128,7 @@ struct controller {
 	unsigned int link_active_reporting:1;
 	unsigned int notification_enabled:1;
 	unsigned int power_fault_detected;
+	atomic_t pending_events;
 };
 
 #define INT_PRESENCE_ON			1
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 044087e2683d..5f41ba788cb2 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -31,7 +31,8 @@ static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
 	return ctrl->pcie->port;
 }
 
-static irqreturn_t pcie_isr(int irq, void *dev_id);
+static irqreturn_t pciehp_isr(int irq, void *dev_id);
+static irqreturn_t pciehp_ist(int irq, void *dev_id);
 static void start_int_poll_timer(struct controller *ctrl, int sec);
 
 /* This is the interrupt polling timeout function. */
@@ -40,7 +41,8 @@ static void int_poll_timeout(struct timer_list *t)
 	struct controller *ctrl = from_timer(ctrl, t, poll_timer);
 
 	/* Poll for interrupt events.  regs == NULL => polling */
-	pcie_isr(0, ctrl);
+	while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD)
+		pciehp_ist(IRQ_NOTCONNECTED, ctrl);
 
 	if (!pciehp_poll_time)
 		pciehp_poll_time = 2; /* default polling interval is 2 sec */
@@ -71,7 +73,8 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 	}
 
 	/* Installs the interrupt handler */
-	retval = request_irq(irq, pcie_isr, IRQF_SHARED, MY_NAME, ctrl);
+	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
+				      IRQF_SHARED, MY_NAME, ctrl);
 	if (retval)
 		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
 			 irq);
@@ -539,12 +542,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	struct slot *slot = ctrl->slot;
 	u16 status, events;
-	u8 present;
-	bool link;
 
-	/* Interrupts cannot originate from a controller that's asleep */
+	/*
+	 * Interrupts only occur in D3hot or shallower (PCIe r4.0, sec 6.7.3.4).
+	 */
 	if (pdev->current_state == PCI_D3cold)
 		return IRQ_NONE;
 
@@ -572,18 +574,22 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	if (!events)
 		return IRQ_NONE;
 
-	/* Capture link status before clearing interrupts */
-	if (events & PCI_EXP_SLTSTA_DLLSC)
-		link = pciehp_check_link_active(ctrl);
-
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 
-	/* Check Command Complete Interrupt Pending */
+	/*
+	 * Command Completed notifications are not deferred to the
+	 * IRQ thread because it may be waiting for their arrival.
+	 */
 	if (events & PCI_EXP_SLTSTA_CC) {
 		ctrl->cmd_busy = 0;
 		smp_mb();
 		wake_up(&ctrl->queue);
+
+		if (events == PCI_EXP_SLTSTA_CC)
+			return IRQ_HANDLED;
+
+		events &= ~PCI_EXP_SLTSTA_CC;
 	}
 
 	if (pdev->ignore_hotplug) {
@@ -591,6 +597,24 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
+	/* Save pending events for consumption by IRQ thread. */
+	atomic_or(events, &ctrl->pending_events);
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t pciehp_ist(int irq, void *dev_id)
+{
+	struct controller *ctrl = (struct controller *)dev_id;
+	struct slot *slot = ctrl->slot;
+	u32 events;
+	u8 present;
+	bool link;
+
+	synchronize_hardirq(irq);
+	events = atomic_xchg(&ctrl->pending_events, 0);
+	if (!events)
+		return IRQ_NONE;
+
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
@@ -605,12 +629,13 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 * and cause the wrong event to queue.
 	 */
 	if (events & PCI_EXP_SLTSTA_DLLSC) {
+		link = pciehp_check_link_active(ctrl);
 		ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
 			  link ? "Up" : "Down");
 		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
 					     INT_LINK_DOWN);
 	} else if (events & PCI_EXP_SLTSTA_PDC) {
-		present = !!(status & PCI_EXP_SLTSTA_PDS);
+		pciehp_get_adapter_status(slot, &present);
 		ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
 			  present ? "" : "not ");
 		pciehp_queue_interrupt_event(slot, present ? INT_PRESENCE_ON :
@@ -627,25 +652,6 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t pcie_isr(int irq, void *dev_id)
-{
-	irqreturn_t rc, handled = IRQ_NONE;
-
-	/*
-	 * To guarantee that all interrupt events are serviced, we need to
-	 * re-inspect Slot Status register after clearing what is presumed
-	 * to be the last pending interrupt.
-	 */
-	do {
-		rc = pciehp_isr(irq, dev_id);
-		if (rc == IRQ_HANDLED)
-			handled = IRQ_HANDLED;
-	} while (rc == IRQ_HANDLED);
-
-	/* Return IRQ_HANDLED if we handled one or more events */
-	return handled;
-}
-
 static void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;
-- 
2.17.1
