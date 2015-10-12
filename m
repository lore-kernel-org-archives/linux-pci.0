Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] PCI: pciehp: Queue power work requests in dedicated function
Date: Mon, 12 Oct 2015 12:10:12 -0700
Message-Id: <1444677013-3836-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Up to now, work items to be queued to be handled by pciehp_power_thread()
are allocated using kmalloc() in three different locations. If not needed,
kfree() is called to free the allocated data.

Introduce a separate function to allocate the work item and queue it,
and call it only if needed. This reduces code ducplication and avoids
having to free memory if the work item does not need to get executed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 66 +++++++++++----------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index f3796124ad7c..ef96a1d51fac 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -204,11 +204,12 @@ static void pciehp_power_thread(struct work_struct *work)
 	kfree(info);
 }
 
-void pciehp_queue_pushbutton_work(struct work_struct *work)
+void pciehp_queue_power_work(struct slot *p_slot, int req)
 {
-	struct slot *p_slot = container_of(work, struct slot, work.work);
 	struct power_work_info *info;
 
+	p_slot->state = req == ENABLE_REQ ? POWERON_STATE : POWEROFF_STATE;
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		ctrl_err(p_slot->ctrl, "%s: Cannot allocate memory\n",
@@ -217,23 +218,25 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 	}
 	info->p_slot = p_slot;
 	INIT_WORK(&info->work, pciehp_power_thread);
+	info->req = req;
+	queue_work(p_slot->wq, &info->work);
+}
+
+void pciehp_queue_pushbutton_work(struct work_struct *work)
+{
+	struct slot *p_slot = container_of(work, struct slot, work.work);
 
 	mutex_lock(&p_slot->lock);
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
-		p_slot->state = POWEROFF_STATE;
-		info->req = DISABLE_REQ;
+		pciehp_queue_power_work(p_slot, DISABLE_REQ);
 		break;
 	case BLINKINGON_STATE:
-		p_slot->state = POWERON_STATE;
-		info->req = ENABLE_REQ;
+		pciehp_queue_power_work(p_slot, ENABLE_REQ);
 		break;
 	default:
-		kfree(info);
-		goto out;
+		break;
 	}
-	queue_work(p_slot->wq, &info->work);
- out:
 	mutex_unlock(&p_slot->lock);
 }
 
@@ -301,27 +304,13 @@ static void handle_button_press_event(struct slot *p_slot)
 static void handle_surprise_event(struct slot *p_slot)
 {
 	u8 getstatus;
-	struct power_work_info *info;
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		ctrl_err(p_slot->ctrl, "%s: Cannot allocate memory\n",
-			 __func__);
-		return;
-	}
-	info->p_slot = p_slot;
-	INIT_WORK(&info->work, pciehp_power_thread);
 
 	pciehp_get_adapter_status(p_slot, &getstatus);
 	if (!getstatus) {
-		p_slot->state = POWEROFF_STATE;
-		info->req = DISABLE_REQ;
+		pciehp_queue_power_work(p_slot, DISABLE_REQ);
 	} else {
-		p_slot->state = POWERON_STATE;
-		info->req = ENABLE_REQ;
+		pciehp_queue_power_work(p_slot, ENABLE_REQ);
 	}
-
-	queue_work(p_slot->wq, &info->work);
 }
 
 /*
@@ -330,17 +319,6 @@ static void handle_surprise_event(struct slot *p_slot)
 static void handle_link_event(struct slot *p_slot, u32 event)
 {
 	struct controller *ctrl = p_slot->ctrl;
-	struct power_work_info *info;
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		ctrl_err(p_slot->ctrl, "%s: Cannot allocate memory\n",
-			 __func__);
-		return;
-	}
-	info->p_slot = p_slot;
-	info->req = event == INT_LINK_UP ? ENABLE_REQ : DISABLE_REQ;
-	INIT_WORK(&info->work, pciehp_power_thread);
 
 	switch (p_slot->state) {
 	case BLINKINGON_STATE:
@@ -348,22 +326,19 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 		cancel_delayed_work(&p_slot->work);
 		/* Fall through */
 	case STATIC_STATE:
-		p_slot->state = event == INT_LINK_UP ?
-		    POWERON_STATE : POWEROFF_STATE;
-		queue_work(p_slot->wq, &info->work);
+		pciehp_queue_power_work(p_slot, event == INT_LINK_UP ?
+					ENABLE_REQ : DISABLE_REQ);
 		break;
 	case POWERON_STATE:
 		if (event == INT_LINK_UP) {
 			ctrl_info(ctrl,
 				  "Link Up event ignored on slot(%s): already powering on\n",
 				  slot_name(p_slot));
-			kfree(info);
 		} else {
 			ctrl_info(ctrl,
 				  "Link Down event queued on slot(%s): currently getting powered on\n",
 				  slot_name(p_slot));
-			p_slot->state = POWEROFF_STATE;
-			queue_work(p_slot->wq, &info->work);
+			pciehp_queue_power_work(p_slot, DISABLE_REQ);
 		}
 		break;
 	case POWEROFF_STATE:
@@ -371,19 +346,16 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 			ctrl_info(ctrl,
 				  "Link Up event queued on slot(%s): currently getting powered off\n",
 				  slot_name(p_slot));
-			p_slot->state = POWERON_STATE;
-			queue_work(p_slot->wq, &info->work);
+			pciehp_queue_power_work(p_slot, ENABLE_REQ);
 		} else {
 			ctrl_info(ctrl,
 				  "Link Down event ignored on slot(%s): already powering off\n",
 				  slot_name(p_slot));
-			kfree(info);
 		}
 		break;
 	default:
 		ctrl_err(ctrl, "ignoring invalid state %#x on slot(%s)\n",
 			 p_slot->state, slot_name(p_slot));
-		kfree(info);
 		break;
 	}
 }
-- 
2.1.4

