Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:56845 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932874AbeFPTfb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:35:31 -0400
Message-Id: <1cfd7f5bff9a38023ab1735e91b546240dfa23be.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 10/32] PCI: pciehp: Convert to threaded polling
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We've just converted pciehp to threaded IRQ handling, but still cannot
sleep in pciehp_ist() because the function is also called in poll mode,
which runs in softirq context (from a timer).

Convert poll mode to a kthread so that pciehp_ist() always runs in task
context.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h     |  4 +-
 drivers/pci/hotplug/pciehp_hpc.c | 67 +++++++++++++++-----------------
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index ab1d97a1822d..9f11360e3318 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -97,7 +97,7 @@ struct event_info {
  *	used for synchronous writes to the Slot Control register
  * @slot_cap: cached copy of the Slot Capabilities register
  * @slot_ctrl: cached copy of the Slot Control register
- * @poll_timer: timer to poll for slot events if no IRQ is available,
+ * @poll_thread: thread to poll for slot events if no IRQ is available,
  *	enabled with pciehp_poll_mode module parameter
  * @cmd_started: jiffies when the Slot Control register was last written;
  *	the next write is allowed 1 second later, absent a Command Completed
@@ -122,7 +122,7 @@ struct controller {
 	wait_queue_head_t queue;
 	u32 slot_cap;
 	u16 slot_ctrl;
-	struct timer_list poll_timer;
+	struct task_struct *poll_thread;
 	unsigned long cmd_started;	/* jiffies */
 	unsigned int cmd_busy:1;
 	unsigned int link_active_reporting:1;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5f41ba788cb2..be4d9698f254 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 #include <linux/signal.h>
 #include <linux/jiffies.h>
-#include <linux/timer.h>
+#include <linux/kthread.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/time.h>
@@ -33,43 +33,17 @@ static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
 
 static irqreturn_t pciehp_isr(int irq, void *dev_id);
 static irqreturn_t pciehp_ist(int irq, void *dev_id);
-static void start_int_poll_timer(struct controller *ctrl, int sec);
-
-/* This is the interrupt polling timeout function. */
-static void int_poll_timeout(struct timer_list *t)
-{
-	struct controller *ctrl = from_timer(ctrl, t, poll_timer);
-
-	/* Poll for interrupt events.  regs == NULL => polling */
-	while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD)
-		pciehp_ist(IRQ_NOTCONNECTED, ctrl);
-
-	if (!pciehp_poll_time)
-		pciehp_poll_time = 2; /* default polling interval is 2 sec */
-
-	start_int_poll_timer(ctrl, pciehp_poll_time);
-}
-
-/* This function starts the interrupt polling timer. */
-static void start_int_poll_timer(struct controller *ctrl, int sec)
-{
-	/* Clamp to sane value */
-	if ((sec <= 0) || (sec > 60))
-		sec = 2;
-
-	ctrl->poll_timer.expires = jiffies + sec * HZ;
-	add_timer(&ctrl->poll_timer);
-}
+static int pciehp_poll(void *data);
 
 static inline int pciehp_request_irq(struct controller *ctrl)
 {
 	int retval, irq = ctrl->pcie->irq;
 
-	/* Install interrupt polling timer. Start with 10 sec delay */
 	if (pciehp_poll_mode) {
-		timer_setup(&ctrl->poll_timer, int_poll_timeout, 0);
-		start_int_poll_timer(ctrl, 10);
-		return 0;
+		ctrl->poll_thread = kthread_run(&pciehp_poll, ctrl,
+						"pciehp_poll-%s",
+						slot_name(ctrl->slot));
+		return PTR_ERR_OR_ZERO(ctrl->poll_thread);
 	}
 
 	/* Installs the interrupt handler */
@@ -84,7 +58,7 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 static inline void pciehp_free_irq(struct controller *ctrl)
 {
 	if (pciehp_poll_mode)
-		del_timer_sync(&ctrl->poll_timer);
+		kthread_stop(ctrl->poll_thread);
 	else
 		free_irq(ctrl->pcie->irq, ctrl);
 }
@@ -652,6 +626,29 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int pciehp_poll(void *data)
+{
+	struct controller *ctrl = data;
+
+	schedule_timeout_idle(10 * HZ); /* start with 10 sec delay */
+
+	while (!kthread_should_stop()) {
+		if (kthread_should_park())
+			kthread_parkme();
+
+		/* poll for interrupt events */
+		while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD)
+			pciehp_ist(IRQ_NOTCONNECTED, ctrl);
+
+		if (pciehp_poll_time <= 0 || pciehp_poll_time > 60)
+			pciehp_poll_time = 2; /* clamp to sane value */
+
+		schedule_timeout_idle(pciehp_poll_time * HZ);
+	}
+
+	return 0;
+}
+
 static void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;
@@ -742,7 +739,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
 	if (pciehp_poll_mode)
-		del_timer_sync(&ctrl->poll_timer);
+		kthread_park(ctrl->poll_thread);
 
 	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
 
@@ -751,7 +748,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
 	if (pciehp_poll_mode)
-		int_poll_timeout(&ctrl->poll_timer);
+		kthread_unpark(ctrl->poll_thread);
 	return 0;
 }
 
-- 
2.17.1
