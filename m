Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:58343 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeG1GoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jul 2018 02:44:19 -0400
Message-Id: <9c58b565d0c1bac1fd6e16742caae7097348268e.1532752826.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 28 Jul 2018 07:18:00 +0200
Subject: [REPLACEMENT PATCH] PCI: pciehp: Avoid slot access during reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ->reset_slot callback introduced by commits:

  2e35afaefe64 ("PCI: pciehp: Add reset_slot() method") and
  06a8d89af551 ("PCI: pciehp: Disable link notification across slot reset")

disables notification of Presence Detect Changed and Data Link Layer
State Changed events for the duration of a secondary bus reset.

However a bus reset not only triggers these events, but may also clear
the Presence Detect State bit in the Slot Status register and the Data
Link Layer Link Active bit in the Link Status register momentarily.
According to Sinan Kaya:

 "I know for a fact that bus reset clears the Data Link Layer Active bit
  as soon as link goes down.  It gets set again following link up.
  Presence detect depends on the HW implementation.  QDT root ports
  don't change presence detect for instance since nobody actually
  removed the card.  If an implementation supports in-band presence
  detect, the answer is yes.  As soon as the link goes down, presence
  detect bit will get cleared until recovery."
  https://lkml.kernel.org/r/42e72f83-3b24-f7ef-e5bc-290fae99259a@codeaurora.org

pciehp should therefore ensure that any parts of the driver that access
those bits do not run concurrently to a bus reset.  The only precaution
the commits took to that effect was to halt interrupt polling.  They
made no effort to drain the slot workqueue, cancel an outstanding
Attention Button work, or block slot enable/disable requests via sysfs
and in the ->probe hook.

Now that pciehp is converted to enable/disable the slot exclusively from
the IRQ thread, the only places accessing the two above-mentioned bits
are the IRQ thread and the ->probe hook.  Add locking to serialize them
with a bus reset.  This obviates the need to halt interrupt polling.
Do not add locking to the ->get_adapter_status sysfs callback to afford
users unfettered access to that bit.  Use an rw_semaphore in lieu of a
regular mutex to allow parallel execution of the non-reset code paths
accessing the critical bits, i.e. the IRQ thread and the ->probe hook.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Sinan Kaya <okaya@kernel.org>
---
Replacement for commit "PCI: pciehp: Avoid slot access during reset"
on Bjorn's pci/hotplug branch.  No code changes, only the commit
message has been updated:

* Add Sinan's in-depth description how a bus reset affects presence
  and link status.

* Justify usage of rw_semaphore as requested by Mika.

 drivers/pci/hotplug/pciehp.h      |  5 +++++
 drivers/pci/hotplug/pciehp_core.c |  2 ++
 drivers/pci/hotplug/pciehp_hpc.c  | 14 +++++++-------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 47cd9af5caf3..bb015be34894 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/sched/signal.h>		/* signal_pending() */
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/workqueue.h>
 
 #include "../pcie/portdrv.h"
@@ -80,6 +81,9 @@ struct slot {
  * struct controller - PCIe hotplug controller
  * @ctrl_lock: serializes writes to the Slot Control register
  * @pcie: pointer to the controller's PCIe port service device
+ * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
+ *	Link Status register and to the Presence Detect State bit in the Slot
+ *	Status register during a slot reset which may cause them to flap
  * @slot: pointer to the controller's slot structure
  * @queue: wait queue to wake up on reception of a Command Completed event,
  *	used for synchronous writes to the Slot Control register
@@ -109,6 +113,7 @@ struct slot {
 struct controller {
 	struct mutex ctrl_lock;
 	struct pcie_device *pcie;
+	struct rw_semaphore reset_lock;
 	struct slot *slot;
 	wait_queue_head_t queue;
 	u32 slot_cap;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index f4eaa9944699..1be8871e7439 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -237,6 +237,7 @@ static int pciehp_probe(struct pcie_device *dev)
 	}
 
 	/* Check if slot is occupied */
+	down_read(&ctrl->reset_lock);
 	mutex_lock(&slot->lock);
 	pciehp_get_adapter_status(slot, &occupied);
 	pciehp_get_power_status(slot, &poweron);
@@ -249,6 +250,7 @@ static int pciehp_probe(struct pcie_device *dev)
 	if (!occupied && poweron && POWER_CTRL(ctrl))
 		pciehp_power_off_slot(slot);
 	mutex_unlock(&slot->lock);
+	up_read(&ctrl->reset_lock);
 
 	return 0;
 
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 712f3de78b09..41398b15d306 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -603,10 +603,12 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
 	 */
+	down_read(&ctrl->reset_lock);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(slot);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
 		pciehp_handle_presence_or_link_change(slot, events);
+	up_read(&ctrl->reset_lock);
 
 	/* Check Power Fault Detected */
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
@@ -627,9 +629,6 @@ static int pciehp_poll(void *data)
 	schedule_timeout_idle(10 * HZ); /* start with 10 sec delay */
 
 	while (!kthread_should_stop()) {
-		if (kthread_should_park())
-			kthread_parkme();
-
 		/* poll for interrupt events or user requests */
 		while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
 		       atomic_read(&ctrl->pending_events))
@@ -723,6 +722,8 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	if (probe)
 		return 0;
 
+	down_write(&ctrl->reset_lock);
+
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
 		stat_mask |= PCI_EXP_SLTSTA_PDC;
@@ -733,8 +734,6 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	pcie_write_cmd(ctrl, 0, ctrl_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
-	if (pciehp_poll_mode)
-		kthread_park(ctrl->poll_thread);
 
 	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
 
@@ -742,8 +741,8 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
-	if (pciehp_poll_mode)
-		kthread_unpark(ctrl->poll_thread);
+
+	up_write(&ctrl->reset_lock);
 	return 0;
 }
 
@@ -835,6 +834,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
+	init_rwsem(&ctrl->reset_lock);
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	dbg_ctrl(ctrl);
-- 
2.18.0
