Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:48739 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPT3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:29:09 -0400
Message-Id: <df1171fb7f79ad1f80273671e43367f09739df80.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 12/32] PCI: pciehp: Handle events synchronously
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Up until now, pciehp's IRQ handler schedules a work item for each event,
which in turn schedules a work item to enable or disable the slot.  This
double indirection was necessary because sleeping wasn't allowed in the
IRQ handler.

However it is now that pciehp has been converted to threaded IRQ handling
and polling, so handle events synchronously in pciehp_ist() and remove
the work item infrastructure (with the exception of work items to handle
a button press after the 5 second delay).

For link or presence change events, move the register read to determine
the current link or presence state behind acquisition of the slot lock
to prevent if from becoming stale while the lock is contended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  20 +---
 drivers/pci/hotplug/pciehp_ctrl.c | 178 +++++++++---------------------
 drivers/pci/hotplug/pciehp_hpc.c  |  27 ++---
 3 files changed, 67 insertions(+), 158 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 9f11360e3318..82ff77cc92f5 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -69,8 +69,7 @@ do {									\
  *	protects scheduling, execution and cancellation of @work
  * @hotplug_lock: serializes calls to pciehp_enable_slot() and
  *	pciehp_disable_slot()
- * @wq: work queue on which @work is scheduled;
- *	also used to queue interrupt events and slot enablement and disablement
+ * @wq: work queue on which @work is scheduled
  */
 struct slot {
 	u8 state;
@@ -82,12 +81,6 @@ struct slot {
 	struct workqueue_struct *wq;
 };
 
-struct event_info {
-	u32 event_type;
-	struct slot *p_slot;
-	struct work_struct work;
-};
-
 /**
  * struct controller - PCIe hotplug controller
  * @ctrl_lock: serializes writes to the Slot Control register
@@ -131,13 +124,6 @@ struct controller {
 	atomic_t pending_events;
 };
 
-#define INT_PRESENCE_ON			1
-#define INT_PRESENCE_OFF		2
-#define INT_POWER_FAULT			3
-#define INT_BUTTON_PRESS		4
-#define INT_LINK_UP			5
-#define INT_LINK_DOWN			6
-
 #define STATIC_STATE			0
 #define BLINKINGON_STATE		1
 #define BLINKINGOFF_STATE		2
@@ -156,7 +142,9 @@ struct controller {
 
 int pciehp_sysfs_enable_slot(struct slot *slot);
 int pciehp_sysfs_disable_slot(struct slot *slot);
-void pciehp_queue_interrupt_event(struct slot *slot, u32 event_type);
+void pciehp_handle_button_press(struct slot *slot);
+void pciehp_handle_link_change(struct slot *slot);
+void pciehp_handle_presence_change(struct slot *slot);
 int pciehp_configure_device(struct slot *p_slot);
 void pciehp_unconfigure_device(struct slot *p_slot);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 9d6343a35db1..5763e81be2ed 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -21,24 +21,6 @@
 #include "../pci.h"
 #include "pciehp.h"
 
-static void interrupt_event_handler(struct work_struct *work);
-
-void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
-{
-	struct event_info *info;
-
-	info = kmalloc(sizeof(*info), GFP_ATOMIC);
-	if (!info) {
-		ctrl_err(p_slot->ctrl, "dropped event %d (ENOMEM)\n", event_type);
-		return;
-	}
-
-	INIT_WORK(&info->work, interrupt_event_handler);
-	info->event_type = event_type;
-	info->p_slot = p_slot;
-	queue_work(p_slot->wq, &info->work);
-}
-
 /* The following routines constitute the bulk of the
    hotplug controller logic
  */
@@ -140,59 +122,6 @@ static void remove_board(struct slot *p_slot)
 	pciehp_green_led_off(p_slot);
 }
 
-struct power_work_info {
-	struct slot *p_slot;
-	struct work_struct work;
-	unsigned int req;
-#define DISABLE_REQ 0
-#define ENABLE_REQ  1
-};
-
-/**
- * pciehp_power_thread - handle pushbutton events
- * @work: &struct work_struct describing work to be done
- *
- * Scheduled procedure to handle blocking stuff for the pushbuttons.
- * Handles all pending events and exits.
- */
-static void pciehp_power_thread(struct work_struct *work)
-{
-	struct power_work_info *info =
-		container_of(work, struct power_work_info, work);
-	struct slot *p_slot = info->p_slot;
-
-	switch (info->req) {
-	case DISABLE_REQ:
-		pciehp_disable_slot(p_slot);
-		break;
-	case ENABLE_REQ:
-		pciehp_enable_slot(p_slot);
-		break;
-	default:
-		break;
-	}
-
-	kfree(info);
-}
-
-static void pciehp_queue_power_work(struct slot *p_slot, int req)
-{
-	struct power_work_info *info;
-
-	p_slot->state = (req == ENABLE_REQ) ? POWERON_STATE : POWEROFF_STATE;
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		ctrl_err(p_slot->ctrl, "no memory to queue %s request\n",
-			 (req == ENABLE_REQ) ? "poweron" : "poweroff");
-		return;
-	}
-	info->p_slot = p_slot;
-	INIT_WORK(&info->work, pciehp_power_thread);
-	info->req = req;
-	queue_work(p_slot->wq, &info->work);
-}
-
 void pciehp_queue_pushbutton_work(struct work_struct *work)
 {
 	struct slot *p_slot = container_of(work, struct slot, work.work);
@@ -200,25 +129,27 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 	mutex_lock(&p_slot->lock);
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
-		pciehp_queue_power_work(p_slot, DISABLE_REQ);
-		break;
+		p_slot->state = POWEROFF_STATE;
+		mutex_unlock(&p_slot->lock);
+		pciehp_disable_slot(p_slot);
+		return;
 	case BLINKINGON_STATE:
-		pciehp_queue_power_work(p_slot, ENABLE_REQ);
-		break;
+		p_slot->state = POWERON_STATE;
+		mutex_unlock(&p_slot->lock);
+		pciehp_enable_slot(p_slot);
+		return;
 	default:
 		break;
 	}
 	mutex_unlock(&p_slot->lock);
 }
 
-/*
- * Note: This function must be called with slot->lock held
- */
-static void handle_button_press_event(struct slot *p_slot)
+void pciehp_handle_button_press(struct slot *p_slot)
 {
 	struct controller *ctrl = p_slot->ctrl;
 	u8 getstatus;
 
+	mutex_lock(&p_slot->lock);
 	switch (p_slot->state) {
 	case STATIC_STATE:
 		pciehp_get_power_status(p_slot, &getstatus);
@@ -269,14 +200,16 @@ static void handle_button_press_event(struct slot *p_slot)
 			 slot_name(p_slot), p_slot->state);
 		break;
 	}
+	mutex_unlock(&p_slot->lock);
 }
 
-/*
- * Note: This function must be called with slot->lock held
- */
-static void handle_link_event(struct slot *p_slot, u32 event)
+void pciehp_handle_link_change(struct slot *p_slot)
 {
 	struct controller *ctrl = p_slot->ctrl;
+	bool link_active;
+
+	mutex_lock(&p_slot->lock);
+	link_active = pciehp_check_link_active(ctrl);
 
 	switch (p_slot->state) {
 	case BLINKINGON_STATE:
@@ -284,24 +217,40 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 		cancel_delayed_work(&p_slot->work);
 		/* Fall through */
 	case STATIC_STATE:
-		pciehp_queue_power_work(p_slot, event == INT_LINK_UP ?
-					ENABLE_REQ : DISABLE_REQ);
+		if (link_active) {
+			p_slot->state = POWERON_STATE;
+			mutex_unlock(&p_slot->lock);
+			ctrl_info(ctrl, "Slot(%s): Link Up\n", slot_name(p_slot));
+			pciehp_enable_slot(p_slot);
+		} else {
+			p_slot->state = POWEROFF_STATE;
+			mutex_unlock(&p_slot->lock);
+			ctrl_info(ctrl, "Slot(%s): Link Down\n", slot_name(p_slot));
+			pciehp_disable_slot(p_slot);
+		}
+		return;
 		break;
 	case POWERON_STATE:
-		if (event == INT_LINK_UP) {
+		if (link_active) {
 			ctrl_info(ctrl, "Slot(%s): Link Up event ignored; already powering on\n",
 				  slot_name(p_slot));
 		} else {
+			p_slot->state = POWEROFF_STATE;
+			mutex_unlock(&p_slot->lock);
 			ctrl_info(ctrl, "Slot(%s): Link Down event queued; currently getting powered on\n",
 				  slot_name(p_slot));
-			pciehp_queue_power_work(p_slot, DISABLE_REQ);
+			pciehp_disable_slot(p_slot);
+			return;
 		}
 		break;
 	case POWEROFF_STATE:
-		if (event == INT_LINK_UP) {
+		if (link_active) {
+			p_slot->state = POWERON_STATE;
+			mutex_unlock(&p_slot->lock);
 			ctrl_info(ctrl, "Slot(%s): Link Up event queued; currently getting powered off\n",
 				  slot_name(p_slot));
-			pciehp_queue_power_work(p_slot, ENABLE_REQ);
+			pciehp_enable_slot(p_slot);
+			return;
 		} else {
 			ctrl_info(ctrl, "Slot(%s): Link Down event ignored; already powering off\n",
 				  slot_name(p_slot));
@@ -312,45 +261,28 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 			 slot_name(p_slot), p_slot->state);
 		break;
 	}
+	mutex_unlock(&p_slot->lock);
 }
 
-static void interrupt_event_handler(struct work_struct *work)
+void pciehp_handle_presence_change(struct slot *slot)
 {
-	struct event_info *info = container_of(work, struct event_info, work);
-	struct slot *p_slot = info->p_slot;
-	struct controller *ctrl = p_slot->ctrl;
+	struct controller *ctrl = slot->ctrl;
+	u8 present;
 
-	mutex_lock(&p_slot->lock);
-	switch (info->event_type) {
-	case INT_BUTTON_PRESS:
-		handle_button_press_event(p_slot);
-		break;
-	case INT_POWER_FAULT:
-		if (!POWER_CTRL(ctrl))
-			break;
-		pciehp_set_attention_status(p_slot, 1);
-		pciehp_green_led_off(p_slot);
-		break;
-	case INT_PRESENCE_ON:
-		pciehp_queue_power_work(p_slot, ENABLE_REQ);
-		break;
-	case INT_PRESENCE_OFF:
-		/*
-		 * Regardless of surprise capability, we need to
-		 * definitely remove a card that has been pulled out!
-		 */
-		pciehp_queue_power_work(p_slot, DISABLE_REQ);
-		break;
-	case INT_LINK_UP:
-	case INT_LINK_DOWN:
-		handle_link_event(p_slot, info->event_type);
-		break;
-	default:
-		break;
+	mutex_lock(&slot->lock);
+	pciehp_get_adapter_status(slot, &present);
+	ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
+		  present ? "" : "not ");
+
+	if (present) {
+		slot->state = POWERON_STATE;
+		mutex_unlock(&slot->lock);
+		pciehp_enable_slot(slot);
+	} else {
+		slot->state = POWEROFF_STATE;
+		mutex_unlock(&slot->lock);
+		pciehp_disable_slot(slot);
 	}
-	mutex_unlock(&p_slot->lock);
-
-	kfree(info);
 }
 
 /*
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index be4d9698f254..bc70762cbba1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -581,8 +581,6 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct slot *slot = ctrl->slot;
 	u32 events;
-	u8 present;
-	bool link;
 
 	synchronize_hardirq(irq);
 	events = atomic_xchg(&ctrl->pending_events, 0);
@@ -593,34 +591,25 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
 			  slot_name(slot));
-		pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
+		pciehp_handle_button_press(slot);
 	}
 
 	/*
 	 * Check Link Status Changed at higher precedence than Presence
 	 * Detect Changed.  The PDS value may be set to "card present" from
-	 * out-of-band detection, which may be in conflict with a Link Down
-	 * and cause the wrong event to queue.
+	 * out-of-band detection, which may be in conflict with a Link Down.
 	 */
-	if (events & PCI_EXP_SLTSTA_DLLSC) {
-		link = pciehp_check_link_active(ctrl);
-		ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
-			  link ? "Up" : "Down");
-		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
-					     INT_LINK_DOWN);
-	} else if (events & PCI_EXP_SLTSTA_PDC) {
-		pciehp_get_adapter_status(slot, &present);
-		ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
-			  present ? "" : "not ");
-		pciehp_queue_interrupt_event(slot, present ? INT_PRESENCE_ON :
-					     INT_PRESENCE_OFF);
-	}
+	if (events & PCI_EXP_SLTSTA_DLLSC)
+		pciehp_handle_link_change(slot);
+	else if (events & PCI_EXP_SLTSTA_PDC)
+		pciehp_handle_presence_change(slot);
 
 	/* Check Power Fault Detected */
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
 		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
-		pciehp_queue_interrupt_event(slot, INT_POWER_FAULT);
+		pciehp_set_attention_status(slot, 1);
+		pciehp_green_led_off(slot);
 	}
 
 	return IRQ_HANDLED;
-- 
2.17.1
