Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:33613 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeFPTi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:38:26 -0400
Message-Id: <034a190ba172c91adb0a9cc5225716d4aa69d78e.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 13/32] PCI: pciehp: Drop slot workqueue
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously the slot workqueue was used to handle events and enable or
disable the slot.  That's no longer the case as those tasks are done
synchronously in the IRQ thread.  The slot workqueue is thus merely used
to handle a button press after the 5 second delay and only one such work
item may be in flight at any given time.  A separate workqueue isn't
necessary for this simple task, so use the system workqueue instead.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      | 2 --
 drivers/pci/hotplug/pciehp_core.c | 6 ------
 drivers/pci/hotplug/pciehp_ctrl.c | 2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 9 +--------
 4 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 82ff77cc92f5..0d005c5fabfa 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -69,7 +69,6 @@ do {									\
  *	protects scheduling, execution and cancellation of @work
  * @hotplug_lock: serializes calls to pciehp_enable_slot() and
  *	pciehp_disable_slot()
- * @wq: work queue on which @work is scheduled
  */
 struct slot {
 	u8 state;
@@ -78,7 +77,6 @@ struct slot {
 	struct delayed_work work;
 	struct mutex lock;
 	struct mutex hotplug_lock;
-	struct workqueue_struct *wq;
 };
 
 /**
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 8a2133856dfd..b360645377c2 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -62,12 +62,6 @@ static int reset_slot(struct hotplug_slot *slot, int probe);
  */
 static void release_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
-
-	/* queued work needs hotplug_slot name */
-	cancel_delayed_work(&slot->work);
-	drain_workqueue(slot->wq);
-
 	kfree(hotplug_slot->ops);
 	kfree(hotplug_slot->info);
 	kfree(hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 5763e81be2ed..a4a8a5457aca 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -165,7 +165,7 @@ void pciehp_handle_button_press(struct slot *p_slot)
 		/* blink green LED and turn off amber */
 		pciehp_green_led_blink(p_slot);
 		pciehp_set_attention_status(p_slot, 0);
-		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
+		schedule_delayed_work(&p_slot->work, 5 * HZ);
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bc70762cbba1..0898501eea93 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -767,25 +767,18 @@ static int pcie_init_slot(struct controller *ctrl)
 	if (!slot)
 		return -ENOMEM;
 
-	slot->wq = alloc_ordered_workqueue("pciehp-%u", 0, PSN(ctrl));
-	if (!slot->wq)
-		goto abort;
-
 	slot->ctrl = ctrl;
 	mutex_init(&slot->lock);
 	mutex_init(&slot->hotplug_lock);
 	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
 	ctrl->slot = slot;
 	return 0;
-abort:
-	kfree(slot);
-	return -ENOMEM;
 }
 
 static void pcie_cleanup_slot(struct controller *ctrl)
 {
 	struct slot *slot = ctrl->slot;
-	destroy_workqueue(slot->wq);
+	cancel_delayed_work_sync(&slot->work);
 	kfree(slot);
 }
 
-- 
2.17.1
