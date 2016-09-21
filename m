Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCHv2] PCI/Hotplug: Schedule device add retries
Date: Wed, 21 Sep 2016 13:12:35 -0600
Message-Id: <1474485155-10822-1-git-send-email-jonathan.derrick@intel.com>
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

v1->v2: Consolidated the clearing of the retry count into the slot's
disable and enable functions.

 drivers/pci/hotplug/pciehp.h      |  2 ++
 drivers/pci/hotplug/pciehp_ctrl.c | 61 +++++++++++++++++++++++++++++++--------
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e764918..55abbc5 100644
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
@@ -133,6 +134,7 @@ void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
 int pciehp_enable_slot(struct slot *p_slot);
+int pciehp_enable_slot_retry(struct slot *p_slot);
 int pciehp_disable_slot(struct slot *p_slot);
 void pcie_enable_notification(struct controller *ctrl);
 int pciehp_power_on_slot(struct slot *slot);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index efe69e8..6470627 100644
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
@@ -189,8 +208,13 @@ static void pciehp_power_thread(struct work_struct *work)
 		mutex_unlock(&p_slot->lock);
 		break;
 	case ENABLE_REQ:
+		/* fall through */
+	case ENABLE_RETRY_REQ:
 		mutex_lock(&p_slot->hotplug_lock);
-		ret = pciehp_enable_slot(p_slot);
+		if (info->req == ENABLE_RETRY_REQ)
+			ret = pciehp_enable_slot_retry(p_slot);
+		else
+			ret = pciehp_enable_slot(p_slot);
 		mutex_unlock(&p_slot->hotplug_lock);
 		if (ret)
 			pciehp_green_led_off(p_slot);
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
@@ -386,7 +411,7 @@ static void interrupt_event_handler(struct work_struct *work)
 /*
  * Note: This function must be called with slot->hotplug_lock held
  */
-int pciehp_enable_slot(struct slot *p_slot)
+static int __pciehp_enable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
 	struct controller *ctrl = p_slot->ctrl;
@@ -417,6 +442,17 @@ int pciehp_enable_slot(struct slot *p_slot)
 	return board_added(p_slot);
 }
 
+int pciehp_enable_slot(struct slot *p_slot)
+{
+	p_slot->ctrl->slot_retries = 0;
+	return __pciehp_enable_slot(p_slot);
+}
+
+int pciehp_enable_slot_retry(struct slot *p_slot)
+{
+	return __pciehp_enable_slot(p_slot);
+}
+
 /*
  * Note: This function must be called with slot->hotplug_lock held
  */
@@ -428,6 +464,7 @@ int pciehp_disable_slot(struct slot *p_slot)
 	if (!p_slot->ctrl)
 		return 1;
 
+	ctrl->slot_retries = 0;
 	if (POWER_CTRL(p_slot->ctrl)) {
 		pciehp_get_power_status(p_slot, &getstatus);
 		if (!getstatus) {
-- 
1.8.3.1
