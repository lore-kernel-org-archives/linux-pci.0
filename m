Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:59221 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbeFPTac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:30:32 -0400
Message-Id: <5e94a3157548e18f19edf3b39e85b25bf48d8768.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 16/32] PCI: pciehp: Track enable/disable status
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

handle_button_press_event() currently determines whether the slot has
been turned on or off by looking at the Power Controller Control bit in
the Slot Control register.  This assumes that an attention button
implies presence of a power controller even though that's not mandated
by the spec.  Moreover the Power Controller Control bit is unreliable
when a power fault occurs (PCIe r4.0, sec 6.7.1.8).  This issue has
existed since the driver was introduced in 2004.

Fix by replacing STATIC_STATE with ON_STATE and OFF_STATE and tracking
whether the slot has been turned on or off.  This is also a required
ingredient to make pciehp resilient to missed events, which is the
object of an upcoming commit.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      | 15 ++++++++++++++-
 drivers/pci/hotplug/pciehp_ctrl.c | 28 ++++++++++++++++------------
 drivers/pci/hotplug/pciehp_hpc.c  |  5 +++++
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 0d005c5fabfa..1ba335d6563a 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -122,11 +122,24 @@ struct controller {
 	atomic_t pending_events;
 };
 
-#define STATIC_STATE			0
+/**
+ * DOC: Slot state
+ *
+ * @OFF_STATE: slot is powered off, no subordinate devices are enumerated
+ * @BLINKINGON_STATE: slot will be powered on after the 5 second delay,
+ *	green led is blinking
+ * @BLINKINGOFF_STATE: slot will be powered off after the 5 second delay,
+ *	green led is blinking
+ * @POWERON_STATE: slot is currently powering on
+ * @POWEROFF_STATE: slot is currently powering off
+ * @ON_STATE: slot is powered on, subordinate devices have been enumerated
+ */
+#define OFF_STATE			0
 #define BLINKINGON_STATE		1
 #define BLINKINGOFF_STATE		2
 #define POWERON_STATE			3
 #define POWEROFF_STATE			4
+#define ON_STATE			5
 
 #define ATTN_BUTTN(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_ABP)
 #define POWER_CTRL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_PCP)
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index a4a8a5457aca..627e846df802 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -147,13 +147,12 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 void pciehp_handle_button_press(struct slot *p_slot)
 {
 	struct controller *ctrl = p_slot->ctrl;
-	u8 getstatus;
 
 	mutex_lock(&p_slot->lock);
 	switch (p_slot->state) {
-	case STATIC_STATE:
-		pciehp_get_power_status(p_slot, &getstatus);
-		if (getstatus) {
+	case OFF_STATE:
+	case ON_STATE:
+		if (p_slot->state == ON_STATE) {
 			p_slot->state = BLINKINGOFF_STATE;
 			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
 				  slot_name(p_slot));
@@ -176,14 +175,16 @@ void pciehp_handle_button_press(struct slot *p_slot)
 		 */
 		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(p_slot));
 		cancel_delayed_work(&p_slot->work);
-		if (p_slot->state == BLINKINGOFF_STATE)
+		if (p_slot->state == BLINKINGOFF_STATE) {
+			p_slot->state = ON_STATE;
 			pciehp_green_led_on(p_slot);
-		else
+		} else {
+			p_slot->state = OFF_STATE;
 			pciehp_green_led_off(p_slot);
+		}
 		pciehp_set_attention_status(p_slot, 0);
 		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
 			  slot_name(p_slot));
-		p_slot->state = STATIC_STATE;
 		break;
 	case POWEROFF_STATE:
 	case POWERON_STATE:
@@ -216,7 +217,8 @@ void pciehp_handle_link_change(struct slot *p_slot)
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&p_slot->work);
 		/* Fall through */
-	case STATIC_STATE:
+	case ON_STATE:
+	case OFF_STATE:
 		if (link_active) {
 			p_slot->state = POWERON_STATE;
 			mutex_unlock(&p_slot->lock);
@@ -332,7 +334,7 @@ int pciehp_enable_slot(struct slot *slot)
 		pciehp_green_led_off(slot); /* may be blinking */
 
 	mutex_lock(&slot->lock);
-	slot->state = STATIC_STATE;
+	slot->state = ret ? OFF_STATE : ON_STATE;
 	mutex_unlock(&slot->lock);
 
 	return ret;
@@ -368,7 +370,7 @@ int pciehp_disable_slot(struct slot *slot)
 	mutex_unlock(&slot->hotplug_lock);
 
 	mutex_lock(&slot->lock);
-	slot->state = STATIC_STATE;
+	slot->state = OFF_STATE;
 	mutex_unlock(&slot->lock);
 
 	return ret;
@@ -382,7 +384,7 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&p_slot->work);
-	case STATIC_STATE:
+	case OFF_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
 		return pciehp_enable_slot(p_slot);
@@ -391,6 +393,7 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 			  slot_name(p_slot));
 		break;
 	case BLINKINGOFF_STATE:
+	case ON_STATE:
 	case POWEROFF_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already enabled\n",
 			  slot_name(p_slot));
@@ -413,7 +416,7 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&p_slot->work);
-	case STATIC_STATE:
+	case ON_STATE:
 		p_slot->state = POWEROFF_STATE;
 		mutex_unlock(&p_slot->lock);
 		return pciehp_disable_slot(p_slot);
@@ -422,6 +425,7 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 			  slot_name(p_slot));
 		break;
 	case BLINKINGON_STATE:
+	case OFF_STATE:
 	case POWERON_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already disabled\n",
 			  slot_name(p_slot));
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 0898501eea93..564a904d7fa9 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -761,12 +761,17 @@ void pcie_shutdown_notification(struct controller *ctrl)
 
 static int pcie_init_slot(struct controller *ctrl)
 {
+	struct pci_bus *subordinate = ctrl_dev(ctrl)->subordinate;
 	struct slot *slot;
 
 	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
 	if (!slot)
 		return -ENOMEM;
 
+	down_read(&pci_bus_sem);
+	slot->state = list_empty(&subordinate->devices) ? OFF_STATE : ON_STATE;
+	up_read(&pci_bus_sem);
+
 	slot->ctrl = ctrl;
 	mutex_init(&slot->lock);
 	mutex_init(&slot->hotplug_lock);
-- 
2.17.1
