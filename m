Return-Path: <SRS0=dBQP=LC=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=dBQP=LC=wunner.de=lukas@kernel.org>
Message-Id: <2d4b1ed51a1c90fb6e1ef6282ab0c28f6c62cab1.1534686485.git.lukas@wunner.de>
In-Reply-To: <cover.1534686484.git.lukas@wunner.de>
References: <cover.1534686484.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 19 Aug 2018 16:29:00 +0200
Subject: [PATCH 4/9] PCI: pciehp: Unify controller and slot structs
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

pciehp was originally introduced together with shpchp in a single
commit, c16b4b14d980 ("PCI Hotplug: Add SHPC and PCI Express hot-plug
drivers"):
https://git.kernel.org/tglx/history/c/c16b4b14d980

shpchp supports up to 31 slots per controller, hence uses separate slot
and controller structs.  pciehp has a 1:1 relationship between slot and
controller and therefore never required this separation.  Nevertheless,
because much of the code had been copy-pasted between the two drivers,
pciehp likewise uses separate structs to this very day.

The artificial separation of data structures adds unnecessary complexity
and bloat to pciehp and requires constantly chasing pointers at runtime.

Simplify the driver by merging struct slot into struct controller.
Merge the slot constructor pcie_init_slot() and the destructor
pcie_cleanup_slot() into the controller counterparts.  Rename the slot
struct's "lock" member to "state_lock" and rename "work" to "button_work"
for clarity.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  69 ++++-----
 drivers/pci/hotplug/pciehp_core.c |  55 +++----
 drivers/pci/hotplug/pciehp_ctrl.c | 250 ++++++++++++++----------------
 drivers/pci/hotplug/pciehp_hpc.c  | 120 +++++---------
 drivers/pci/hotplug/pciehp_pci.c  |  14 +-
 5 files changed, 218 insertions(+), 290 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8131c08b21e5..32f2701fb8dc 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -58,24 +58,6 @@ do {									\
 
 #define SLOT_NAME_SIZE 10
 
-/**
- * struct slot - PCIe hotplug slot
- * @state: current state machine position
- * @ctrl: pointer to the slot's controller structure
- * @hotplug_slot: pointer to the structure registered with the PCI hotplug core
- * @work: work item to turn the slot on or off after 5 seconds in response to
- *	an Attention Button press
- * @lock: protects reads and writes of @state;
- *	protects scheduling, execution and cancellation of @work
- */
-struct slot {
-	u8 state;
-	struct controller *ctrl;
-	struct hotplug_slot *hotplug_slot;
-	struct delayed_work work;
-	struct mutex lock;
-};
-
 /**
  * struct controller - PCIe hotplug controller
  * @ctrl_lock: serializes writes to the Slot Control register
@@ -83,7 +65,6 @@ struct slot {
  * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
  *	Link Status register and to the Presence Detect State bit in the Slot
  *	Status register during a slot reset which may cause them to flap
- * @slot: pointer to the controller's slot structure
  * @queue: wait queue to wake up on reception of a Command Completed event,
  *	used for synchronous writes to the Slot Control register
  * @slot_cap: cached copy of the Slot Capabilities register
@@ -105,15 +86,23 @@ struct slot {
  *	that has not yet been cleared by the user
  * @pending_events: used by the IRQ handler to save events retrieved from the
  *	Slot Status register for later consumption by the IRQ thread
+ * @state: current state machine position
+ * @state_lock: protects reads and writes of @state;
+ *	protects scheduling, execution and cancellation of @button_work
+ * @button_work: work item to turn the slot on or off after 5 seconds
+ *	in response to an Attention Button press
+ * @hotplug_slot: pointer to the structure registered with the PCI hotplug core
  * @request_result: result of last user request submitted to the IRQ thread
  * @requester: wait queue to wake up on completion of user request,
  *	used for synchronous slot enable/disable request via sysfs
+ *
+ * PCIe hotplug has a 1:1 relationship between controller and slot, hence
+ * unlike other drivers, the two aren't represented by separate structures.
  */
 struct controller {
 	struct mutex ctrl_lock;
 	struct pcie_device *pcie;
 	struct rw_semaphore reset_lock;
-	struct slot *slot;
 	wait_queue_head_t queue;
 	u32 slot_cap;
 	u16 slot_ctrl;
@@ -124,6 +113,10 @@ struct controller {
 	unsigned int notification_enabled:1;
 	unsigned int power_fault_detected;
 	atomic_t pending_events;
+	u8 state;
+	struct mutex state_lock;
+	struct delayed_work button_work;
+	struct hotplug_slot *hotplug_slot;
 	int request_result;
 	wait_queue_head_t requester;
 };
@@ -174,27 +167,27 @@ struct controller {
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
 void pciehp_request(struct controller *ctrl, int action);
-void pciehp_handle_button_press(struct slot *slot);
-void pciehp_handle_disable_request(struct slot *slot);
-void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events);
-int pciehp_configure_device(struct slot *p_slot);
-void pciehp_unconfigure_device(struct slot *p_slot, bool presence);
+void pciehp_handle_button_press(struct controller *ctrl);
+void pciehp_handle_disable_request(struct controller *ctrl);
+void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events);
+int pciehp_configure_device(struct controller *ctrl);
+void pciehp_unconfigure_device(struct controller *ctrl, bool presence);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
 void pcie_shutdown_notification(struct controller *ctrl);
 void pcie_clear_hotplug_events(struct controller *ctrl);
-int pciehp_power_on_slot(struct slot *slot);
-void pciehp_power_off_slot(struct slot *slot);
-void pciehp_get_power_status(struct slot *slot, u8 *status);
-
-void pciehp_set_attention_status(struct slot *slot, u8 status);
-void pciehp_get_latch_status(struct slot *slot, u8 *status);
-void pciehp_get_adapter_status(struct slot *slot, u8 *status);
-int pciehp_query_power_fault(struct slot *slot);
-void pciehp_green_led_on(struct slot *slot);
-void pciehp_green_led_off(struct slot *slot);
-void pciehp_green_led_blink(struct slot *slot);
+int pciehp_power_on_slot(struct controller *ctrl);
+void pciehp_power_off_slot(struct controller *ctrl);
+void pciehp_get_power_status(struct controller *ctrl, u8 *status);
+
+void pciehp_set_attention_status(struct controller *ctrl, u8 status);
+void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
+void pciehp_get_adapter_status(struct controller *ctrl, u8 *status);
+int pciehp_query_power_fault(struct controller *ctrl);
+void pciehp_green_led_on(struct controller *ctrl);
+void pciehp_green_led_off(struct controller *ctrl);
+void pciehp_green_led_blink(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
 bool pciehp_check_link_active(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
@@ -206,9 +199,9 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
-static inline const char *slot_name(struct slot *slot)
+static inline const char *slot_name(struct controller *ctrl)
 {
-	return hotplug_slot_name(slot->hotplug_slot);
+	return hotplug_slot_name(ctrl->hotplug_slot);
 }
 
 #endif				/* _PCIEHP_H */
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ccaf01e6eced..2c9fa5263634 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -51,7 +51,6 @@ static int get_adapter_status(struct hotplug_slot *slot, u8 *value);
 
 static int init_slot(struct controller *ctrl)
 {
-	struct slot *slot = ctrl->slot;
 	struct hotplug_slot *hotplug = NULL;
 	struct hotplug_slot_info *info = NULL;
 	struct hotplug_slot_ops *ops = NULL;
@@ -88,9 +87,9 @@ static int init_slot(struct controller *ctrl)
 
 	/* register this slot with the hotplug pci core */
 	hotplug->info = info;
-	hotplug->private = slot;
+	hotplug->private = ctrl;
 	hotplug->ops = ops;
-	slot->hotplug_slot = hotplug;
+	ctrl->hotplug_slot = hotplug;
 	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
 
 	retval = pci_hp_initialize(hotplug,
@@ -108,7 +107,7 @@ static int init_slot(struct controller *ctrl)
 
 static void cleanup_slot(struct controller *ctrl)
 {
-	struct hotplug_slot *hotplug_slot = ctrl->slot->hotplug_slot;
+	struct hotplug_slot *hotplug_slot = ctrl->hotplug_slot;
 
 	pci_hp_destroy(hotplug_slot);
 	kfree(hotplug_slot->ops);
@@ -121,44 +120,44 @@ static void cleanup_slot(struct controller *ctrl)
  */
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 {
-	struct slot *slot = hotplug_slot->private;
-	struct pci_dev *pdev = slot->ctrl->pcie->port;
+	struct controller *ctrl = hotplug_slot->private;
+	struct pci_dev *pdev = ctrl->pcie->port;
 
 	pci_config_pm_runtime_get(pdev);
-	pciehp_set_attention_status(slot, status);
+	pciehp_set_attention_status(ctrl, status);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
 
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
-	struct pci_dev *pdev = slot->ctrl->pcie->port;
+	struct controller *ctrl = hotplug_slot->private;
+	struct pci_dev *pdev = ctrl->pcie->port;
 
 	pci_config_pm_runtime_get(pdev);
-	pciehp_get_power_status(slot, value);
+	pciehp_get_power_status(ctrl, value);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
 
 static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
-	struct pci_dev *pdev = slot->ctrl->pcie->port;
+	struct controller *ctrl = hotplug_slot->private;
+	struct pci_dev *pdev = ctrl->pcie->port;
 
 	pci_config_pm_runtime_get(pdev);
-	pciehp_get_latch_status(slot, value);
+	pciehp_get_latch_status(ctrl, value);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
 
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = hotplug_slot->private;
-	struct pci_dev *pdev = slot->ctrl->pcie->port;
+	struct controller *ctrl = hotplug_slot->private;
+	struct pci_dev *pdev = ctrl->pcie->port;
 
 	pci_config_pm_runtime_get(pdev);
-	pciehp_get_adapter_status(slot, value);
+	pciehp_get_adapter_status(ctrl, value);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
@@ -175,20 +174,19 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
  */
 static void pciehp_check_presence(struct controller *ctrl)
 {
-	struct slot *slot = ctrl->slot;
 	u8 occupied;
 
 	down_read(&ctrl->reset_lock);
-	mutex_lock(&slot->lock);
+	mutex_lock(&ctrl->state_lock);
 
-	pciehp_get_adapter_status(slot, &occupied);
-	if ((occupied && (slot->state == OFF_STATE ||
-			  slot->state == BLINKINGON_STATE)) ||
-	    (!occupied && (slot->state == ON_STATE ||
-			   slot->state == BLINKINGOFF_STATE)))
+	pciehp_get_adapter_status(ctrl, &occupied);
+	if ((occupied && (ctrl->state == OFF_STATE ||
+			  ctrl->state == BLINKINGON_STATE)) ||
+	    (!occupied && (ctrl->state == ON_STATE ||
+			   ctrl->state == BLINKINGOFF_STATE)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
 
-	mutex_unlock(&slot->lock);
+	mutex_unlock(&ctrl->state_lock);
 	up_read(&ctrl->reset_lock);
 }
 
@@ -196,7 +194,6 @@ static int pciehp_probe(struct pcie_device *dev)
 {
 	int rc;
 	struct controller *ctrl;
-	struct slot *slot;
 
 	/* If this is not a "hotplug" service, we have no business here. */
 	if (dev->service != PCIE_PORT_SERVICE_HP)
@@ -234,8 +231,7 @@ static int pciehp_probe(struct pcie_device *dev)
 	}
 
 	/* Publish to user space */
-	slot = ctrl->slot;
-	rc = pci_hp_add(slot->hotplug_slot);
+	rc = pci_hp_add(ctrl->hotplug_slot);
 	if (rc) {
 		ctrl_err(ctrl, "Publication to user space failed (%d)\n", rc);
 		goto err_out_shutdown_notification;
@@ -258,7 +254,7 @@ static void pciehp_remove(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
 
-	pci_hp_del(ctrl->slot->hotplug_slot);
+	pci_hp_del(ctrl->hotplug_slot);
 	pcie_shutdown_notification(ctrl);
 	cleanup_slot(ctrl);
 	pciehp_release_ctrl(ctrl);
@@ -273,14 +269,13 @@ static int pciehp_suspend(struct pcie_device *dev)
 static int pciehp_resume_noirq(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
-	struct slot *slot = ctrl->slot;
 
 	/* pci_restore_state() just wrote to the Slot Control register */
 	ctrl->cmd_started = jiffies;
 	ctrl->cmd_busy = true;
 
 	/* clear spurious events from rediscovery of inserted card */
-	if (slot->state == ON_STATE || slot->state == BLINKINGOFF_STATE)
+	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE)
 		pcie_clear_hotplug_events(ctrl);
 
 	return 0;
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index c4d0f902f1d2..005d88ccbcaa 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -26,11 +26,11 @@
 #define SAFE_REMOVAL	 true
 #define SURPRISE_REMOVAL false
 
-static void set_slot_off(struct controller *ctrl, struct slot *pslot)
+static void set_slot_off(struct controller *ctrl)
 {
 	/* turn off slot, turn on Amber LED, turn off Green LED if supported*/
 	if (POWER_CTRL(ctrl)) {
-		pciehp_power_off_slot(pslot);
+		pciehp_power_off_slot(ctrl);
 
 		/*
 		 * After turning power off, we must wait for at least 1 second
@@ -40,31 +40,30 @@ static void set_slot_off(struct controller *ctrl, struct slot *pslot)
 		msleep(1000);
 	}
 
-	pciehp_green_led_off(pslot);
-	pciehp_set_attention_status(pslot, 1);
+	pciehp_green_led_off(ctrl);
+	pciehp_set_attention_status(ctrl, 1);
 }
 
 /**
  * board_added - Called after a board has been added to the system.
- * @p_slot: &slot where board is added
+ * @ctrl: PCIe hotplug controller where board is added
  *
  * Turns power on for the board.
  * Configures board.
  */
-static int board_added(struct slot *p_slot)
+static int board_added(struct controller *ctrl)
 {
 	int retval = 0;
-	struct controller *ctrl = p_slot->ctrl;
 	struct pci_bus *parent = ctrl->pcie->port->subordinate;
 
 	if (POWER_CTRL(ctrl)) {
 		/* Power on slot */
-		retval = pciehp_power_on_slot(p_slot);
+		retval = pciehp_power_on_slot(ctrl);
 		if (retval)
 			return retval;
 	}
 
-	pciehp_green_led_blink(p_slot);
+	pciehp_green_led_blink(ctrl);
 
 	/* Check link training status */
 	retval = pciehp_check_link_status(ctrl);
@@ -74,13 +73,13 @@ static int board_added(struct slot *p_slot)
 	}
 
 	/* Check for a power fault */
-	if (ctrl->power_fault_detected || pciehp_query_power_fault(p_slot)) {
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(p_slot));
+	if (ctrl->power_fault_detected || pciehp_query_power_fault(ctrl)) {
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
 		retval = -EIO;
 		goto err_exit;
 	}
 
-	retval = pciehp_configure_device(p_slot);
+	retval = pciehp_configure_device(ctrl);
 	if (retval) {
 		if (retval != -EEXIST) {
 			ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
@@ -89,28 +88,26 @@ static int board_added(struct slot *p_slot)
 		}
 	}
 
-	pciehp_green_led_on(p_slot);
-	pciehp_set_attention_status(p_slot, 0);
+	pciehp_green_led_on(ctrl);
+	pciehp_set_attention_status(ctrl, 0);
 	return 0;
 
 err_exit:
-	set_slot_off(ctrl, p_slot);
+	set_slot_off(ctrl);
 	return retval;
 }
 
 /**
  * remove_board - Turns off slot and LEDs
- * @p_slot: slot where board is being removed
+ * @ctrl: PCIe hotplug controller where board is being removed
  * @safe_removal: whether the board is safely removed (versus surprise removed)
  */
-static void remove_board(struct slot *p_slot, bool safe_removal)
+static void remove_board(struct controller *ctrl, bool safe_removal)
 {
-	struct controller *ctrl = p_slot->ctrl;
-
-	pciehp_unconfigure_device(p_slot, safe_removal);
+	pciehp_unconfigure_device(ctrl, safe_removal);
 
 	if (POWER_CTRL(ctrl)) {
-		pciehp_power_off_slot(p_slot);
+		pciehp_power_off_slot(ctrl);
 
 		/*
 		 * After turning power off, we must wait for at least 1 second
@@ -121,11 +118,11 @@ static void remove_board(struct slot *p_slot, bool safe_removal)
 	}
 
 	/* turn off Green LED */
-	pciehp_green_led_off(p_slot);
+	pciehp_green_led_off(ctrl);
 }
 
-static int pciehp_enable_slot(struct slot *slot);
-static int pciehp_disable_slot(struct slot *slot, bool safe_removal);
+static int pciehp_enable_slot(struct controller *ctrl);
+static int pciehp_disable_slot(struct controller *ctrl, bool safe_removal);
 
 void pciehp_request(struct controller *ctrl, int action)
 {
@@ -136,11 +133,11 @@ void pciehp_request(struct controller *ctrl, int action)
 
 void pciehp_queue_pushbutton_work(struct work_struct *work)
 {
-	struct slot *p_slot = container_of(work, struct slot, work.work);
-	struct controller *ctrl = p_slot->ctrl;
+	struct controller *ctrl = container_of(work, struct controller,
+					       button_work.work);
 
-	mutex_lock(&p_slot->lock);
-	switch (p_slot->state) {
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
 	case BLINKINGOFF_STATE:
 		pciehp_request(ctrl, DISABLE_SLOT);
 		break;
@@ -150,30 +147,28 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 	default:
 		break;
 	}
-	mutex_unlock(&p_slot->lock);
+	mutex_unlock(&ctrl->state_lock);
 }
 
-void pciehp_handle_button_press(struct slot *p_slot)
+void pciehp_handle_button_press(struct controller *ctrl)
 {
-	struct controller *ctrl = p_slot->ctrl;
-
-	mutex_lock(&p_slot->lock);
-	switch (p_slot->state) {
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
 	case OFF_STATE:
 	case ON_STATE:
-		if (p_slot->state == ON_STATE) {
-			p_slot->state = BLINKINGOFF_STATE;
+		if (ctrl->state == ON_STATE) {
+			ctrl->state = BLINKINGOFF_STATE;
 			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
-				  slot_name(p_slot));
+				  slot_name(ctrl));
 		} else {
-			p_slot->state = BLINKINGON_STATE;
+			ctrl->state = BLINKINGON_STATE;
 			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
-				  slot_name(p_slot));
+				  slot_name(ctrl));
 		}
 		/* blink green LED and turn off amber */
-		pciehp_green_led_blink(p_slot);
-		pciehp_set_attention_status(p_slot, 0);
-		schedule_delayed_work(&p_slot->work, 5 * HZ);
+		pciehp_green_led_blink(ctrl);
+		pciehp_set_attention_status(ctrl, 0);
+		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
@@ -182,47 +177,44 @@ void pciehp_handle_button_press(struct slot *p_slot)
 		 * press the attention again before the 5 sec. limit
 		 * expires to cancel hot-add or hot-remove
 		 */
-		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(p_slot));
-		cancel_delayed_work(&p_slot->work);
-		if (p_slot->state == BLINKINGOFF_STATE) {
-			p_slot->state = ON_STATE;
-			pciehp_green_led_on(p_slot);
+		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(ctrl));
+		cancel_delayed_work(&ctrl->button_work);
+		if (ctrl->state == BLINKINGOFF_STATE) {
+			ctrl->state = ON_STATE;
+			pciehp_green_led_on(ctrl);
 		} else {
-			p_slot->state = OFF_STATE;
-			pciehp_green_led_off(p_slot);
+			ctrl->state = OFF_STATE;
+			pciehp_green_led_off(ctrl);
 		}
-		pciehp_set_attention_status(p_slot, 0);
+		pciehp_set_attention_status(ctrl, 0);
 		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
-			  slot_name(p_slot));
+			  slot_name(ctrl));
 		break;
 	default:
 		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
-			 slot_name(p_slot), p_slot->state);
+			 slot_name(ctrl), ctrl->state);
 		break;
 	}
-	mutex_unlock(&p_slot->lock);
+	mutex_unlock(&ctrl->state_lock);
 }
 
-void pciehp_handle_disable_request(struct slot *slot)
+void pciehp_handle_disable_request(struct controller *ctrl)
 {
-	struct controller *ctrl = slot->ctrl;
-
-	mutex_lock(&slot->lock);
-	switch (slot->state) {
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
 	case BLINKINGON_STATE:
 	case BLINKINGOFF_STATE:
-		cancel_delayed_work(&slot->work);
+		cancel_delayed_work(&ctrl->button_work);
 		break;
 	}
-	slot->state = POWEROFF_STATE;
-	mutex_unlock(&slot->lock);
+	ctrl->state = POWEROFF_STATE;
+	mutex_unlock(&ctrl->state_lock);
 
-	ctrl->request_result = pciehp_disable_slot(slot, SAFE_REMOVAL);
+	ctrl->request_result = pciehp_disable_slot(ctrl, SAFE_REMOVAL);
 }
 
-void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
+void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
-	struct controller *ctrl = slot->ctrl;
 	bool link_active;
 	u8 present;
 
@@ -230,150 +222,145 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 	 * If the slot is on and presence or link has changed, turn it off.
 	 * Even if it's occupied again, we cannot assume the card is the same.
 	 */
-	mutex_lock(&slot->lock);
-	switch (slot->state) {
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
 	case BLINKINGOFF_STATE:
-		cancel_delayed_work(&slot->work);
+		cancel_delayed_work(&ctrl->button_work);
 		/* fall through */
 	case ON_STATE:
-		slot->state = POWEROFF_STATE;
-		mutex_unlock(&slot->lock);
+		ctrl->state = POWEROFF_STATE;
+		mutex_unlock(&ctrl->state_lock);
 		if (events & PCI_EXP_SLTSTA_DLLSC)
 			ctrl_info(ctrl, "Slot(%s): Link Down\n",
-				  slot_name(slot));
+				  slot_name(ctrl));
 		if (events & PCI_EXP_SLTSTA_PDC)
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
-				  slot_name(slot));
-		pciehp_disable_slot(slot, SURPRISE_REMOVAL);
+				  slot_name(ctrl));
+		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
-		mutex_unlock(&slot->lock);
+		mutex_unlock(&ctrl->state_lock);
 		break;
 	}
 
 	/* Turn the slot on if it's occupied or link is up */
-	mutex_lock(&slot->lock);
-	pciehp_get_adapter_status(slot, &present);
+	mutex_lock(&ctrl->state_lock);
+	pciehp_get_adapter_status(ctrl, &present);
 	link_active = pciehp_check_link_active(ctrl);
 	if (!present && !link_active) {
-		mutex_unlock(&slot->lock);
+		mutex_unlock(&ctrl->state_lock);
 		return;
 	}
 
-	switch (slot->state) {
+	switch (ctrl->state) {
 	case BLINKINGON_STATE:
-		cancel_delayed_work(&slot->work);
+		cancel_delayed_work(&ctrl->button_work);
 		/* fall through */
 	case OFF_STATE:
-		slot->state = POWERON_STATE;
-		mutex_unlock(&slot->lock);
+		ctrl->state = POWERON_STATE;
+		mutex_unlock(&ctrl->state_lock);
 		if (present)
 			ctrl_info(ctrl, "Slot(%s): Card present\n",
-				  slot_name(slot));
+				  slot_name(ctrl));
 		if (link_active)
 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
-				  slot_name(slot));
-		ctrl->request_result = pciehp_enable_slot(slot);
+				  slot_name(ctrl));
+		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
-		mutex_unlock(&slot->lock);
+		mutex_unlock(&ctrl->state_lock);
 		break;
 	}
 }
 
-static int __pciehp_enable_slot(struct slot *p_slot)
+static int __pciehp_enable_slot(struct controller *ctrl)
 {
 	u8 getstatus = 0;
-	struct controller *ctrl = p_slot->ctrl;
 
-	pciehp_get_adapter_status(p_slot, &getstatus);
+	pciehp_get_adapter_status(ctrl, &getstatus);
 	if (!getstatus) {
-		ctrl_info(ctrl, "Slot(%s): No adapter\n", slot_name(p_slot));
+		ctrl_info(ctrl, "Slot(%s): No adapter\n", slot_name(ctrl));
 		return -ENODEV;
 	}
-	if (MRL_SENS(p_slot->ctrl)) {
-		pciehp_get_latch_status(p_slot, &getstatus);
+	if (MRL_SENS(ctrl)) {
+		pciehp_get_latch_status(ctrl, &getstatus);
 		if (getstatus) {
 			ctrl_info(ctrl, "Slot(%s): Latch open\n",
-				  slot_name(p_slot));
+				  slot_name(ctrl));
 			return -ENODEV;
 		}
 	}
 
-	if (POWER_CTRL(p_slot->ctrl)) {
-		pciehp_get_power_status(p_slot, &getstatus);
+	if (POWER_CTRL(ctrl)) {
+		pciehp_get_power_status(ctrl, &getstatus);
 		if (getstatus) {
 			ctrl_info(ctrl, "Slot(%s): Already enabled\n",
-				  slot_name(p_slot));
+				  slot_name(ctrl));
 			return 0;
 		}
 	}
 
-	return board_added(p_slot);
+	return board_added(ctrl);
 }
 
-static int pciehp_enable_slot(struct slot *slot)
+static int pciehp_enable_slot(struct controller *ctrl)
 {
-	struct controller *ctrl = slot->ctrl;
 	int ret;
 
 	pm_runtime_get_sync(&ctrl->pcie->port->dev);
-	ret = __pciehp_enable_slot(slot);
+	ret = __pciehp_enable_slot(ctrl);
 	if (ret && ATTN_BUTTN(ctrl))
-		pciehp_green_led_off(slot); /* may be blinking */
+		pciehp_green_led_off(ctrl); /* may be blinking */
 	pm_runtime_put(&ctrl->pcie->port->dev);
 
-	mutex_lock(&slot->lock);
-	slot->state = ret ? OFF_STATE : ON_STATE;
-	mutex_unlock(&slot->lock);
+	mutex_lock(&ctrl->state_lock);
+	ctrl->state = ret ? OFF_STATE : ON_STATE;
+	mutex_unlock(&ctrl->state_lock);
 
 	return ret;
 }
 
-static int __pciehp_disable_slot(struct slot *p_slot, bool safe_removal)
+static int __pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
 {
 	u8 getstatus = 0;
-	struct controller *ctrl = p_slot->ctrl;
 
-	if (POWER_CTRL(p_slot->ctrl)) {
-		pciehp_get_power_status(p_slot, &getstatus);
+	if (POWER_CTRL(ctrl)) {
+		pciehp_get_power_status(ctrl, &getstatus);
 		if (!getstatus) {
 			ctrl_info(ctrl, "Slot(%s): Already disabled\n",
-				  slot_name(p_slot));
+				  slot_name(ctrl));
 			return -EINVAL;
 		}
 	}
 
-	remove_board(p_slot, safe_removal);
+	remove_board(ctrl, safe_removal);
 	return 0;
 }
 
-static int pciehp_disable_slot(struct slot *slot, bool safe_removal)
+static int pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
 {
-	struct controller *ctrl = slot->ctrl;
 	int ret;
 
 	pm_runtime_get_sync(&ctrl->pcie->port->dev);
-	ret = __pciehp_disable_slot(slot, safe_removal);
+	ret = __pciehp_disable_slot(ctrl, safe_removal);
 	pm_runtime_put(&ctrl->pcie->port->dev);
 
-	mutex_lock(&slot->lock);
-	slot->state = OFF_STATE;
-	mutex_unlock(&slot->lock);
+	mutex_lock(&ctrl->state_lock);
+	ctrl->state = OFF_STATE;
+	mutex_unlock(&ctrl->state_lock);
 
 	return ret;
 }
 
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *p_slot = hotplug_slot->private;
-	struct controller *ctrl = p_slot->ctrl;
+	struct controller *ctrl = hotplug_slot->private;
 
-	mutex_lock(&p_slot->lock);
-	switch (p_slot->state) {
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
 	case BLINKINGON_STATE:
 	case OFF_STATE:
-		mutex_unlock(&p_slot->lock);
+		mutex_unlock(&ctrl->state_lock);
 		/*
 		 * The IRQ thread becomes a no-op if the user pulls out the
 		 * card before the thread wakes up, so initialize to -ENODEV.
@@ -385,54 +372,53 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 		return ctrl->request_result;
 	case POWERON_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
-			  slot_name(p_slot));
+			  slot_name(ctrl));
 		break;
 	case BLINKINGOFF_STATE:
 	case ON_STATE:
 	case POWEROFF_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already enabled\n",
-			  slot_name(p_slot));
+			  slot_name(ctrl));
 		break;
 	default:
 		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
-			 slot_name(p_slot), p_slot->state);
+			 slot_name(ctrl), ctrl->state);
 		break;
 	}
-	mutex_unlock(&p_slot->lock);
+	mutex_unlock(&ctrl->state_lock);
 
 	return -ENODEV;
 }
 
 int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *p_slot = hotplug_slot->private;
-	struct controller *ctrl = p_slot->ctrl;
+	struct controller *ctrl = hotplug_slot->private;
 
-	mutex_lock(&p_slot->lock);
-	switch (p_slot->state) {
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
 	case BLINKINGOFF_STATE:
 	case ON_STATE:
-		mutex_unlock(&p_slot->lock);
+		mutex_unlock(&ctrl->state_lock);
 		pciehp_request(ctrl, DISABLE_SLOT);
 		wait_event(ctrl->requester,
 			   !atomic_read(&ctrl->pending_events));
 		return ctrl->request_result;
 	case POWEROFF_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
-			  slot_name(p_slot));
+			  slot_name(ctrl));
 		break;
 	case BLINKINGON_STATE:
 	case OFF_STATE:
 	case POWERON_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already disabled\n",
-			  slot_name(p_slot));
+			  slot_name(ctrl));
 		break;
 	default:
 		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
-			 slot_name(p_slot), p_slot->state);
+			 slot_name(ctrl), ctrl->state);
 		break;
 	}
-	mutex_unlock(&p_slot->lock);
+	mutex_unlock(&ctrl->state_lock);
 
 	return -ENODEV;
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 017161c03a4d..71ae78732145 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -40,7 +40,7 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 	if (pciehp_poll_mode) {
 		ctrl->poll_thread = kthread_run(&pciehp_poll, ctrl,
 						"pciehp_poll-%s",
-						slot_name(ctrl->slot));
+						slot_name(ctrl));
 		return PTR_ERR_OR_ZERO(ctrl->poll_thread);
 	}
 
@@ -315,8 +315,8 @@ static int pciehp_link_enable(struct controller *ctrl)
 int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 *status)
 {
-	struct slot *slot = hotplug_slot->private;
-	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
+	struct controller *ctrl = hotplug_slot->private;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
 	pci_config_pm_runtime_get(pdev);
@@ -328,8 +328,7 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 
 int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
 {
-	struct slot *slot = hotplug_slot->private;
-	struct controller *ctrl = slot->ctrl;
+	struct controller *ctrl = hotplug_slot->private;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
@@ -357,9 +356,8 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
 	return 0;
 }
 
-void pciehp_get_power_status(struct slot *slot, u8 *status)
+void pciehp_get_power_status(struct controller *ctrl, u8 *status)
 {
-	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
@@ -380,27 +378,27 @@ void pciehp_get_power_status(struct slot *slot, u8 *status)
 	}
 }
 
-void pciehp_get_latch_status(struct slot *slot, u8 *status)
+void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
 {
-	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
 }
 
-void pciehp_get_adapter_status(struct slot *slot, u8 *status)
+void pciehp_get_adapter_status(struct controller *ctrl, u8 *status)
 {
-	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_PDS);
 }
 
-int pciehp_query_power_fault(struct slot *slot)
+int pciehp_query_power_fault(struct controller *ctrl)
 {
-	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
@@ -410,8 +408,7 @@ int pciehp_query_power_fault(struct slot *slot)
 int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 status)
 {
-	struct slot *slot = hotplug_slot->private;
-	struct controller *ctrl = slot->ctrl;
+	struct controller *ctrl = hotplug_slot->private;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 
 	pci_config_pm_runtime_get(pdev);
@@ -421,9 +418,8 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	return 0;
 }
 
-void pciehp_set_attention_status(struct slot *slot, u8 value)
+void pciehp_set_attention_status(struct controller *ctrl, u8 value)
 {
-	struct controller *ctrl = slot->ctrl;
 	u16 slot_cmd;
 
 	if (!ATTN_LED(ctrl))
@@ -447,10 +443,8 @@ void pciehp_set_attention_status(struct slot *slot, u8 value)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
 }
 
-void pciehp_green_led_on(struct slot *slot)
+void pciehp_green_led_on(struct controller *ctrl)
 {
-	struct controller *ctrl = slot->ctrl;
-
 	if (!PWR_LED(ctrl))
 		return;
 
@@ -461,10 +455,8 @@ void pciehp_green_led_on(struct slot *slot)
 		 PCI_EXP_SLTCTL_PWR_IND_ON);
 }
 
-void pciehp_green_led_off(struct slot *slot)
+void pciehp_green_led_off(struct controller *ctrl)
 {
-	struct controller *ctrl = slot->ctrl;
-
 	if (!PWR_LED(ctrl))
 		return;
 
@@ -475,10 +467,8 @@ void pciehp_green_led_off(struct slot *slot)
 		 PCI_EXP_SLTCTL_PWR_IND_OFF);
 }
 
-void pciehp_green_led_blink(struct slot *slot)
+void pciehp_green_led_blink(struct controller *ctrl)
 {
-	struct controller *ctrl = slot->ctrl;
-
 	if (!PWR_LED(ctrl))
 		return;
 
@@ -489,9 +479,8 @@ void pciehp_green_led_blink(struct slot *slot)
 		 PCI_EXP_SLTCTL_PWR_IND_BLINK);
 }
 
-int pciehp_power_on_slot(struct slot *slot)
+int pciehp_power_on_slot(struct controller *ctrl)
 {
-	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 	int retval;
@@ -515,10 +504,8 @@ int pciehp_power_on_slot(struct slot *slot)
 	return retval;
 }
 
-void pciehp_power_off_slot(struct slot *slot)
+void pciehp_power_off_slot(struct controller *ctrl)
 {
-	struct controller *ctrl = slot->ctrl;
-
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
@@ -616,7 +603,6 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	struct slot *slot = ctrl->slot;
 	irqreturn_t ret;
 	u32 events;
 
@@ -642,8 +628,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
-			  slot_name(slot));
-		pciehp_handle_button_press(slot);
+			  slot_name(ctrl));
+		pciehp_handle_button_press(ctrl);
 	}
 
 	/*
@@ -652,17 +638,17 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	 */
 	down_read(&ctrl->reset_lock);
 	if (events & DISABLE_SLOT)
-		pciehp_handle_disable_request(slot);
+		pciehp_handle_disable_request(ctrl);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
-		pciehp_handle_presence_or_link_change(slot, events);
+		pciehp_handle_presence_or_link_change(ctrl, events);
 	up_read(&ctrl->reset_lock);
 
 	/* Check Power Fault Detected */
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
-		pciehp_set_attention_status(slot, 1);
-		pciehp_green_led_off(slot);
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
+		pciehp_set_attention_status(ctrl, 1);
+		pciehp_green_led_off(ctrl);
 	}
 
 	pci_config_pm_runtime_put(pdev);
@@ -758,8 +744,7 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
  */
 int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 {
-	struct slot *slot = hotplug_slot->private;
-	struct controller *ctrl = slot->ctrl;
+	struct controller *ctrl = hotplug_slot->private;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
@@ -809,34 +794,6 @@ void pcie_shutdown_notification(struct controller *ctrl)
 	}
 }
 
-static int pcie_init_slot(struct controller *ctrl)
-{
-	struct pci_bus *subordinate = ctrl_dev(ctrl)->subordinate;
-	struct slot *slot;
-
-	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
-	if (!slot)
-		return -ENOMEM;
-
-	down_read(&pci_bus_sem);
-	slot->state = list_empty(&subordinate->devices) ? OFF_STATE : ON_STATE;
-	up_read(&pci_bus_sem);
-
-	slot->ctrl = ctrl;
-	mutex_init(&slot->lock);
-	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
-	ctrl->slot = slot;
-	return 0;
-}
-
-static void pcie_cleanup_slot(struct controller *ctrl)
-{
-	struct slot *slot = ctrl->slot;
-
-	cancel_delayed_work_sync(&slot->work);
-	kfree(slot);
-}
-
 static inline void dbg_ctrl(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl->pcie->port;
@@ -860,10 +817,11 @@ struct controller *pcie_init(struct pcie_device *dev)
 	u32 slot_cap, link_cap;
 	u8 occupied, poweron;
 	struct pci_dev *pdev = dev->port;
+	struct pci_bus *subordinate = pdev->subordinate;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
-		goto abort;
+		return NULL;
 
 	ctrl->pcie = dev;
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
@@ -880,11 +838,17 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
+	mutex_init(&ctrl->state_lock);
 	init_rwsem(&ctrl->reset_lock);
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
+	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
 	dbg_ctrl(ctrl);
 
+	down_read(&pci_bus_sem);
+	ctrl->state = list_empty(&subordinate->devices) ? OFF_STATE : ON_STATE;
+	up_read(&pci_bus_sem);
+
 	/* Check if Data Link Layer Link Active Reporting is implemented */
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
 	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
@@ -910,33 +874,25 @@ struct controller *pcie_init(struct pcie_device *dev)
 		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
 		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
 
-	if (pcie_init_slot(ctrl))
-		goto abort_ctrl;
-
 	/*
 	 * If empty slot's power status is on, turn power off.  The IRQ isn't
 	 * requested yet, so avoid triggering a notification with this command.
 	 */
 	if (POWER_CTRL(ctrl)) {
-		pciehp_get_adapter_status(ctrl->slot, &occupied);
-		pciehp_get_power_status(ctrl->slot, &poweron);
+		pciehp_get_adapter_status(ctrl, &occupied);
+		pciehp_get_power_status(ctrl, &poweron);
 		if (!occupied && poweron) {
 			pcie_disable_notification(ctrl);
-			pciehp_power_off_slot(ctrl->slot);
+			pciehp_power_off_slot(ctrl);
 		}
 	}
 
 	return ctrl;
-
-abort_ctrl:
-	kfree(ctrl);
-abort:
-	return NULL;
 }
 
 void pciehp_release_ctrl(struct controller *ctrl)
 {
-	pcie_cleanup_slot(ctrl);
+	cancel_delayed_work_sync(&ctrl->button_work);
 	kfree(ctrl);
 }
 
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 8da87931bd45..b9c1396db6fe 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -21,19 +21,18 @@
 
 /**
  * pciehp_configure_device() - enumerate PCI devices below a hotplug bridge
- * @p_slot: PCIe hotplug slot
+ * @ctrl: PCIe hotplug controller
  *
  * Enumerate PCI devices below a hotplug bridge and add them to the system.
  * Return 0 on success, %-EEXIST if the devices are already enumerated or
  * %-ENODEV if enumeration failed.
  */
-int pciehp_configure_device(struct slot *p_slot)
+int pciehp_configure_device(struct controller *ctrl)
 {
 	struct pci_dev *dev;
-	struct pci_dev *bridge = p_slot->ctrl->pcie->port;
+	struct pci_dev *bridge = ctrl->pcie->port;
 	struct pci_bus *parent = bridge->subordinate;
 	int num, ret = 0;
-	struct controller *ctrl = p_slot->ctrl;
 
 	pci_lock_rescan_remove();
 
@@ -71,7 +70,7 @@ int pciehp_configure_device(struct slot *p_slot)
 
 /**
  * pciehp_unconfigure_device() - remove PCI devices below a hotplug bridge
- * @p_slot: PCIe hotplug slot
+ * @ctrl: PCIe hotplug controller
  * @presence: whether the card is still present in the slot;
  *	true for safe removal via sysfs or an Attention Button press,
  *	false for surprise removal
@@ -80,12 +79,11 @@ int pciehp_configure_device(struct slot *p_slot)
  * them from the system.  Safely removed devices are quiesced.  Surprise
  * removed devices are marked as such to prevent further accesses.
  */
-void pciehp_unconfigure_device(struct slot *p_slot, bool presence)
+void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 {
 	struct pci_dev *dev, *temp;
-	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
+	struct pci_bus *parent = ctrl->pcie->port->subordinate;
 	u16 command;
-	struct controller *ctrl = p_slot->ctrl;
 
 	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
-- 
2.18.0
