Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:39355 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeFXIfz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jun 2018 04:35:55 -0400
Message-Id: <d72b41309f077c8d3bee6cc08ad3662d50b5d22a.1529828292.git.lukas@wunner.de>
In-Reply-To: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
References: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 24 Jun 2018 10:35:30 +0200
Subject: [PATCH v2 2/2] genirq: Synchronize only with single thread on
 free_irq()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When pciehp is converted to threaded IRQ handling, removal of unplugged
devices below a PCIe hotplug port happens synchronously in the IRQ
thread.  Removal of devices typically entails a call to free_irq() by
their drivers.

If those devices share their IRQ with the hotplug port, __free_irq()
deadlocks because it calls synchronize_irq() to wait for all hard IRQ
handlers as well as all threads sharing the IRQ to finish.

Actually it's sufficient to wait only for the IRQ thread of the removed
device, so call synchronize_hardirq() to wait for all hard IRQ handlers
to finish, but no longer for any threads.  Compensate by rearranging the
control flow in irq_wait_for_interrupt() such that the device's thread
is allowed to run one last time after kthread_stop() has been called.

kthread_stop() blocks until the IRQ thread has completed.  On completion
the IRQ thread clears its oneshot thread_mask bit.  This is safe because
__free_irq() holds the request_mutex, thereby preventing __setup_irq()
from handing out the same oneshot thread_mask bit to a newly requested
action.

Stack trace for posterity:
    INFO: task irq/17-pciehp:94 blocked for more than 120 seconds.
    schedule+0x28/0x80
    synchronize_irq+0x6e/0xa0
    __free_irq+0x15a/0x2b0
    free_irq+0x33/0x70
    pciehp_release_ctrl+0x98/0xb0
    pcie_port_remove_service+0x2f/0x40
    device_release_driver_internal+0x157/0x220
    bus_remove_device+0xe2/0x150
    device_del+0x124/0x340
    device_unregister+0x16/0x60
    remove_iter+0x1a/0x20
    device_for_each_child+0x4b/0x90
    pcie_port_device_remove+0x1e/0x30
    pci_device_remove+0x36/0xb0
    device_release_driver_internal+0x157/0x220
    pci_stop_bus_device+0x7d/0xa0
    pci_stop_bus_device+0x3d/0xa0
    pci_stop_and_remove_bus_device+0xe/0x20
    pciehp_unconfigure_device+0xb8/0x160
    pciehp_disable_slot+0x84/0x130
    pciehp_ist+0x158/0x190
    irq_thread_fn+0x1b/0x50
    irq_thread+0x143/0x1a0
    kthread+0x111/0x130

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:

* Add code comment explaining the significance of holding the
  request_mutex in __free_irq() until after kthread_stop(),
  add explanation to commit message as well. (Thomas Gleixner)

* Update several code comments to refer to synchronize_hardirq()
  or kthread_stop() instead of synchronize_irq().

 kernel/irq/manage.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 123a227d3357..9390f1595c50 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -790,9 +790,19 @@ static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
 
 static int irq_wait_for_interrupt(struct irqaction *action)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
 
-	while (!kthread_should_stop()) {
+		if (kthread_should_stop()) {
+			/* may need to run one last time */
+			if (test_and_clear_bit(IRQTF_RUNTHREAD,
+					       &action->thread_flags)) {
+				__set_current_state(TASK_RUNNING);
+				return 0;
+			}
+			__set_current_state(TASK_RUNNING);
+			return -1;
+		}
 
 		if (test_and_clear_bit(IRQTF_RUNTHREAD,
 				       &action->thread_flags)) {
@@ -800,10 +810,7 @@ static int irq_wait_for_interrupt(struct irqaction *action)
 			return 0;
 		}
 		schedule();
-		set_current_state(TASK_INTERRUPTIBLE);
 	}
-	__set_current_state(TASK_RUNNING);
-	return -1;
 }
 
 /*
@@ -1024,7 +1031,7 @@ static int irq_thread(void *data)
 	/*
 	 * This is the regular exit path. __free_irq() is stopping the
 	 * thread via kthread_stop() after calling
-	 * synchronize_irq(). So neither IRQTF_RUNTHREAD nor the
+	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel(current, irq_thread_dtor);
@@ -1241,7 +1248,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 	/*
 	 * Protects against a concurrent __free_irq() call which might wait
-	 * for synchronize_irq() to complete without holding the optional
+	 * for synchronize_hardirq() to complete without holding the optional
 	 * chip bus lock and desc->lock. Also protects against handing out
 	 * a recycled oneshot thread_mask bit while it's still in use by
 	 * its previous owner.
@@ -1612,11 +1619,11 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/*
 	 * Drop bus_lock here so the changes which were done in the chip
 	 * callbacks above are synced out to the irq chips which hang
-	 * behind a slow bus (I2C, SPI) before calling synchronize_irq().
+	 * behind a slow bus (I2C, SPI) before calling synchronize_hardirq().
 	 *
 	 * Aside of that the bus_lock can also be taken from the threaded
 	 * handler in irq_finalize_oneshot() which results in a deadlock
-	 * because synchronize_irq() would wait forever for the thread to
+	 * because kthread_stop() would wait forever for the thread to
 	 * complete, which is blocked on the bus lock.
 	 *
 	 * The still held desc->request_mutex() protects against a
@@ -1628,7 +1635,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	unregister_handler_proc(irq, action);
 
 	/* Make sure it's not being used on another CPU: */
-	synchronize_irq(irq);
+	synchronize_hardirq(irq);
 
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*
@@ -1646,6 +1653,12 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	}
 #endif
 
+	/*
+	 * The action has already been removed above, but the thread writes
+	 * its oneshot mask bit when it completes. Hold the request_mutex
+	 * to prevent __setup_irq() from handing out the same bit to a
+	 * newly requested action.
+	 */
 	if (action->thread) {
 		kthread_stop(action->thread);
 		put_task_struct(action->thread);
-- 
2.17.1
