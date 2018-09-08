Return-Path: <SRS0=Zo3Z=LW=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=Zo3Z=LW=wunner.de=lukas@kernel.org>
Message-Id: <a617aee639ddab671ae378390146279bf205f5a7.1536341821.git.lukas@wunner.de>
In-Reply-To: <cover.1536341821.git.lukas@wunner.de>
References: <cover.1536341821.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 8 Sep 2018 09:59:01 +0200
Subject: [PATCH v2 3/8] PCI: pciehp: Rename controller struct members for
 clarity
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Keith Busch <keith.busch@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Of the members which were just moved from pciehp's slot struct to the
controller struct, rename "lock" to "state_lock" and rename "work" to
"button_work" for clarity.  Perform the rename separately to the
unification of the two structs per Sinan's request.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/hotplug/pciehp.h      | 10 +++---
 drivers/pci/hotplug/pciehp_core.c |  4 +--
 drivers/pci/hotplug/pciehp_ctrl.c | 58 +++++++++++++++----------------
 drivers/pci/hotplug/pciehp_hpc.c  |  6 ++--
 4 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index df9308f6dafa..39b97e2384c3 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -87,9 +87,9 @@ do {									\
  * @pending_events: used by the IRQ handler to save events retrieved from the
  *	Slot Status register for later consumption by the IRQ thread
  * @state: current state machine position
- * @lock: protects reads and writes of @state;
- *	protects scheduling, execution and cancellation of @work
- * @work: work item to turn the slot on or off after 5 seconds
+ * @state_lock: protects reads and writes of @state;
+ *	protects scheduling, execution and cancellation of @button_work
+ * @button_work: work item to turn the slot on or off after 5 seconds
  *	in response to an Attention Button press
  * @hotplug_slot: pointer to the structure registered with the PCI hotplug core
  * @request_result: result of last user request submitted to the IRQ thread
@@ -114,8 +114,8 @@ struct controller {
 	unsigned int power_fault_detected;
 	atomic_t pending_events;
 	u8 state;
-	struct mutex lock;
-	struct delayed_work work;
+	struct mutex state_lock;
+	struct delayed_work button_work;
 	struct hotplug_slot *hotplug_slot;
 	int request_result;
 	wait_queue_head_t requester;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 4a371ef80842..80cc7ba534bf 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -177,7 +177,7 @@ static void pciehp_check_presence(struct controller *ctrl)
 	bool occupied;
 
 	down_read(&ctrl->reset_lock);
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 
 	occupied = pciehp_card_present_or_link_active(ctrl);
 	if ((occupied && (ctrl->state == OFF_STATE ||
@@ -186,7 +186,7 @@ static void pciehp_check_presence(struct controller *ctrl)
 			   ctrl->state == BLINKINGOFF_STATE)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
 
-	mutex_unlock(&ctrl->lock);
+	mutex_unlock(&ctrl->state_lock);
 	up_read(&ctrl->reset_lock);
 }
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index cd0541d80946..04f7ad9fffe1 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -134,9 +134,9 @@ void pciehp_request(struct controller *ctrl, int action)
 void pciehp_queue_pushbutton_work(struct work_struct *work)
 {
 	struct controller *ctrl = container_of(work, struct controller,
-					       work.work);
+					       button_work.work);
 
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
 	case BLINKINGOFF_STATE:
 		pciehp_request(ctrl, DISABLE_SLOT);
@@ -147,12 +147,12 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 	default:
 		break;
 	}
-	mutex_unlock(&ctrl->lock);
+	mutex_unlock(&ctrl->state_lock);
 }
 
 void pciehp_handle_button_press(struct controller *ctrl)
 {
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
 	case OFF_STATE:
 	case ON_STATE:
@@ -168,7 +168,7 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		/* blink green LED and turn off amber */
 		pciehp_green_led_blink(ctrl);
 		pciehp_set_attention_status(ctrl, 0);
-		schedule_delayed_work(&ctrl->work, 5 * HZ);
+		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
@@ -178,7 +178,7 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		 * expires to cancel hot-add or hot-remove
 		 */
 		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(ctrl));
-		cancel_delayed_work(&ctrl->work);
+		cancel_delayed_work(&ctrl->button_work);
 		if (ctrl->state == BLINKINGOFF_STATE) {
 			ctrl->state = ON_STATE;
 			pciehp_green_led_on(ctrl);
@@ -195,20 +195,20 @@ void pciehp_handle_button_press(struct controller *ctrl)
 			 slot_name(ctrl), ctrl->state);
 		break;
 	}
-	mutex_unlock(&ctrl->lock);
+	mutex_unlock(&ctrl->state_lock);
 }
 
 void pciehp_handle_disable_request(struct controller *ctrl)
 {
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
 	case BLINKINGON_STATE:
 	case BLINKINGOFF_STATE:
-		cancel_delayed_work(&ctrl->work);
+		cancel_delayed_work(&ctrl->button_work);
 		break;
 	}
 	ctrl->state = POWEROFF_STATE;
-	mutex_unlock(&ctrl->lock);
+	mutex_unlock(&ctrl->state_lock);
 
 	ctrl->request_result = pciehp_disable_slot(ctrl, SAFE_REMOVAL);
 }
@@ -221,14 +221,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	 * If the slot is on and presence or link has changed, turn it off.
 	 * Even if it's occupied again, we cannot assume the card is the same.
 	 */
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
 	case BLINKINGOFF_STATE:
-		cancel_delayed_work(&ctrl->work);
+		cancel_delayed_work(&ctrl->button_work);
 		/* fall through */
 	case ON_STATE:
 		ctrl->state = POWEROFF_STATE;
-		mutex_unlock(&ctrl->lock);
+		mutex_unlock(&ctrl->state_lock);
 		if (events & PCI_EXP_SLTSTA_DLLSC)
 			ctrl_info(ctrl, "Slot(%s): Link Down\n",
 				  slot_name(ctrl));
@@ -238,26 +238,26 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
-		mutex_unlock(&ctrl->lock);
+		mutex_unlock(&ctrl->state_lock);
 		break;
 	}
 
 	/* Turn the slot on if it's occupied or link is up */
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (!present && !link_active) {
-		mutex_unlock(&ctrl->lock);
+		mutex_unlock(&ctrl->state_lock);
 		return;
 	}
 
 	switch (ctrl->state) {
 	case BLINKINGON_STATE:
-		cancel_delayed_work(&ctrl->work);
+		cancel_delayed_work(&ctrl->button_work);
 		/* fall through */
 	case OFF_STATE:
 		ctrl->state = POWERON_STATE;
-		mutex_unlock(&ctrl->lock);
+		mutex_unlock(&ctrl->state_lock);
 		if (present)
 			ctrl_info(ctrl, "Slot(%s): Card present\n",
 				  slot_name(ctrl));
@@ -267,7 +267,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
-		mutex_unlock(&ctrl->lock);
+		mutex_unlock(&ctrl->state_lock);
 		break;
 	}
 }
@@ -307,9 +307,9 @@ static int pciehp_enable_slot(struct controller *ctrl)
 		pciehp_green_led_off(ctrl); /* may be blinking */
 	pm_runtime_put(&ctrl->pcie->port->dev);
 
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	ctrl->state = ret ? OFF_STATE : ON_STATE;
-	mutex_unlock(&ctrl->lock);
+	mutex_unlock(&ctrl->state_lock);
 
 	return ret;
 }
@@ -339,9 +339,9 @@ static int pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
 	ret = __pciehp_disable_slot(ctrl, safe_removal);
 	pm_runtime_put(&ctrl->pcie->port->dev);
 
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	ctrl->state = OFF_STATE;
-	mutex_unlock(&ctrl->lock);
+	mutex_unlock(&ctrl->state_lock);
 
 	return ret;
 }
@@ -350,11 +350,11 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct controller *ctrl = hotplug_slot->private;
 
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
 	case BLINKINGON_STATE:
 	case OFF_STATE:
-		mutex_unlock(&ctrl->lock);
+		mutex_unlock(&ctrl->state_lock);
 		/*
 		 * The IRQ thread becomes a no-op if the user pulls out the
 		 * card before the thread wakes up, so initialize to -ENODEV.
@@ -379,7 +379,7 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 			 slot_name(ctrl), ctrl->state);
 		break;
 	}
-	mutex_unlock(&ctrl->lock);
+	mutex_unlock(&ctrl->state_lock);
 
 	return -ENODEV;
 }
@@ -388,11 +388,11 @@ int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct controller *ctrl = hotplug_slot->private;
 
-	mutex_lock(&ctrl->lock);
+	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
 	case BLINKINGOFF_STATE:
 	case ON_STATE:
-		mutex_unlock(&ctrl->lock);
+		mutex_unlock(&ctrl->state_lock);
 		pciehp_request(ctrl, DISABLE_SLOT);
 		wait_event(ctrl->requester,
 			   !atomic_read(&ctrl->pending_events));
@@ -412,7 +412,7 @@ int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 			 slot_name(ctrl), ctrl->state);
 		break;
 	}
-	mutex_unlock(&ctrl->lock);
+	mutex_unlock(&ctrl->state_lock);
 
 	return -ENODEV;
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 65e4185b62dc..4d3e6fe06595 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -852,11 +852,11 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
-	mutex_init(&ctrl->lock);
+	mutex_init(&ctrl->state_lock);
 	init_rwsem(&ctrl->reset_lock);
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
-	INIT_DELAYED_WORK(&ctrl->work, pciehp_queue_pushbutton_work);
+	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
 	dbg_ctrl(ctrl);
 
 	down_read(&pci_bus_sem);
@@ -905,7 +905,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 void pciehp_release_ctrl(struct controller *ctrl)
 {
-	cancel_delayed_work_sync(&ctrl->work);
+	cancel_delayed_work_sync(&ctrl->button_work);
 	kfree(ctrl);
 }
 
-- 
2.18.0
