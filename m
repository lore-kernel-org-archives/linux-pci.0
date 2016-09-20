Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/Hotplug: Schedule device add retries
Date: Tue, 20 Sep 2016 11:50:03 -0600
Message-Id: <1474393803-10921-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

If a device fails to be added after being hot inserted, it could be due
to a power fault seen during the insertion or a failure to configure the
new device. The devices are then removed from the tree and the slot
disabled. Many times the devices are working as expected, but the slot
could not tolerate the add without a power fault. A user then has to
issue a sysfs rescan to re-add the slot and pick up the new devices.

This patch detects the failure during slot enabling and attempts to
re-enable the slot a few more times before failing the slot. This fixes
an issue where a power fault is seen during hot insertion, but the slot
itself just needed some time for the power faults to quiesce before the
device was ready to be used.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
Applies against helgaas/pci/hotplug

 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_ctrl.c | 45 ++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e764918..b7927c5 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -93,6 +93,7 @@ struct controller {
 	wait_queue_head_t queue;	/* sleep & wake process */
 	u32 slot_cap;
 	u16 slot_ctrl;
+	u8 slot_retries;
 	struct timer_list poll_timer;
 	unsigned long cmd_started;	/* jiffies */
 	unsigned int cmd_busy:1;
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index efe69e8..b413c3c 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -35,7 +35,19 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+#define DEVICE_ADD_RETRIES 5
+
 static void interrupt_event_handler(struct work_struct *work);
+static void pciehp_queue_power_work(struct slot *p_slot, int req);
+
+struct power_work_info {
+       struct slot *p_slot;
+       struct work_struct work;
+       unsigned int req;
+#define DISABLE_REQ 0
+#define ENABLE_REQ 1
+#define ENABLE_RETRY_REQ 2
+};
 
 void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
 {
@@ -121,9 +133,24 @@ static int board_added(struct slot *p_slot)
 
 	pciehp_green_led_on(p_slot);
 	pciehp_set_attention_status(p_slot, 0);
+	if (ctrl->slot_retries)
+		ctrl_dbg(ctrl, "Device added at %04x:%02x:00 after retry %d/%d\n",
+			 pci_domain_nr(parent), parent->number,
+			 ctrl->slot_retries, DEVICE_ADD_RETRIES);
+
 	return 0;
 
 err_exit:
+	if (ctrl->slot_retries++ < DEVICE_ADD_RETRIES) {
+		ctrl_dbg(ctrl, "Retrying (%d/%d) device add at %04x:%02x:00\n",
+			ctrl->slot_retries, DEVICE_ADD_RETRIES,
+			pci_domain_nr(parent), parent->number);
+		pciehp_queue_power_work(p_slot, ENABLE_RETRY_REQ);
+		return retval;
+	}
+
+	ctrl_err(ctrl, "Failed to add device at %04x:%02x:00\n",
+		 pci_domain_nr(parent), parent->number);
 	set_slot_off(ctrl, p_slot);
 	return retval;
 }
@@ -157,14 +184,6 @@ static int remove_board(struct slot *p_slot)
 	return 0;
 }
 
-struct power_work_info {
-	struct slot *p_slot;
-	struct work_struct work;
-	unsigned int req;
-#define DISABLE_REQ 0
-#define ENABLE_REQ  1
-};
-
 /**
  * pciehp_power_thread - handle pushbutton events
  * @work: &struct work_struct describing work to be done
@@ -183,13 +202,18 @@ static void pciehp_power_thread(struct work_struct *work)
 	case DISABLE_REQ:
 		mutex_lock(&p_slot->hotplug_lock);
 		pciehp_disable_slot(p_slot);
+		p_slot->ctrl->slot_retries = 0;
 		mutex_unlock(&p_slot->hotplug_lock);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
 		mutex_unlock(&p_slot->lock);
 		break;
 	case ENABLE_REQ:
+		/* fall through */
+	case ENABLE_RETRY_REQ:
 		mutex_lock(&p_slot->hotplug_lock);
+		if (info->req == ENABLE_REQ)
+			p_slot->ctrl->slot_retries = 0;
 		ret = pciehp_enable_slot(p_slot);
 		mutex_unlock(&p_slot->hotplug_lock);
 		if (ret)
@@ -208,13 +232,14 @@ static void pciehp_power_thread(struct work_struct *work)
 static void pciehp_queue_power_work(struct slot *p_slot, int req)
 {
 	struct power_work_info *info;
+	bool enabling = (req == ENABLE_REQ || req == ENABLE_RETRY_REQ);
 
-	p_slot->state = (req == ENABLE_REQ) ? POWERON_STATE : POWEROFF_STATE;
+	p_slot->state = enabling ? POWERON_STATE : POWEROFF_STATE;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		ctrl_err(p_slot->ctrl, "no memory to queue %s request\n",
-			 (req == ENABLE_REQ) ? "poweron" : "poweroff");
+			 enabling ? "poweron" : "poweroff");
 		return;
 	}
 	info->p_slot = p_slot;
-- 
1.8.3.1
