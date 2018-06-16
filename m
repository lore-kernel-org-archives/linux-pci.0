Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:53795 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPT2t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:28:49 -0400
Message-Id: <c78d667de7024f4ad8bcd688b93a1ebb9053f444.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 11/32] PCI: pciehp: Stop blinking on slot enable failure
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the attention button is pressed to power on the slot AND the user
powers on the slot via sysfs before 5 seconds have elapsed AND powering
on the slot fails because either the slot is unoccupied OR the latch is
open, we neglect turning off the green led so it keeps on blinking.

That's because the error path of pciehp_sysfs_enable_slot() doesn't call
pciehp_green_led_off(), unlike pciehp_power_thread() which does.
The bug has been present since 2004 when the driver was introduced.

Fix by deduplicating common code in pciehp_sysfs_enable_slot() and
pciehp_power_thread() into a wrapper function pciehp_enable_slot() and
renaming the existing function to __pciehp_enable_slot().  Same for
pciehp_disable_slot().  This will also simplify the upcoming rework of
pciehp's event handling.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_core.c |  7 +--
 drivers/pci/hotplug/pciehp_ctrl.c | 73 +++++++++++++++++--------------
 2 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 2ba59fc94827..8a2133856dfd 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -248,11 +248,8 @@ static int pciehp_probe(struct pcie_device *dev)
 	slot = ctrl->slot;
 	pciehp_get_adapter_status(slot, &occupied);
 	pciehp_get_power_status(slot, &poweron);
-	if (occupied && pciehp_force) {
-		mutex_lock(&slot->hotplug_lock);
+	if (occupied && pciehp_force)
 		pciehp_enable_slot(slot);
-		mutex_unlock(&slot->hotplug_lock);
-	}
 	/* If empty slot's power status is on, turn power off */
 	if (!occupied && poweron && POWER_CTRL(ctrl))
 		pciehp_power_off_slot(slot);
@@ -296,12 +293,10 @@ static int pciehp_resume(struct pcie_device *dev)
 
 	/* Check if slot is occupied */
 	pciehp_get_adapter_status(slot, &status);
-	mutex_lock(&slot->hotplug_lock);
 	if (status)
 		pciehp_enable_slot(slot);
 	else
 		pciehp_disable_slot(slot);
-	mutex_unlock(&slot->hotplug_lock);
 	return 0;
 }
 #endif /* PM */
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 76a9b8c26d2b..9d6343a35db1 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -160,26 +160,13 @@ static void pciehp_power_thread(struct work_struct *work)
 	struct power_work_info *info =
 		container_of(work, struct power_work_info, work);
 	struct slot *p_slot = info->p_slot;
-	int ret;
 
 	switch (info->req) {
 	case DISABLE_REQ:
-		mutex_lock(&p_slot->hotplug_lock);
 		pciehp_disable_slot(p_slot);
-		mutex_unlock(&p_slot->hotplug_lock);
-		mutex_lock(&p_slot->lock);
-		p_slot->state = STATIC_STATE;
-		mutex_unlock(&p_slot->lock);
 		break;
 	case ENABLE_REQ:
-		mutex_lock(&p_slot->hotplug_lock);
-		ret = pciehp_enable_slot(p_slot);
-		mutex_unlock(&p_slot->hotplug_lock);
-		if (ret)
-			pciehp_green_led_off(p_slot);
-		mutex_lock(&p_slot->lock);
-		p_slot->state = STATIC_STATE;
-		mutex_unlock(&p_slot->lock);
+		pciehp_enable_slot(p_slot);
 		break;
 	default:
 		break;
@@ -369,7 +356,7 @@ static void interrupt_event_handler(struct work_struct *work)
 /*
  * Note: This function must be called with slot->hotplug_lock held
  */
-int pciehp_enable_slot(struct slot *p_slot)
+static int __pciehp_enable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
 	struct controller *ctrl = p_slot->ctrl;
@@ -400,10 +387,29 @@ int pciehp_enable_slot(struct slot *p_slot)
 	return board_added(p_slot);
 }
 
+int pciehp_enable_slot(struct slot *slot)
+{
+	struct controller *ctrl = slot->ctrl;
+	int ret;
+
+	mutex_lock(&slot->hotplug_lock);
+	ret = __pciehp_enable_slot(slot);
+	mutex_unlock(&slot->hotplug_lock);
+
+	if (ret && ATTN_BUTTN(ctrl))
+		pciehp_green_led_off(slot); /* may be blinking */
+
+	mutex_lock(&slot->lock);
+	slot->state = STATIC_STATE;
+	mutex_unlock(&slot->lock);
+
+	return ret;
+}
+
 /*
  * Note: This function must be called with slot->hotplug_lock held
  */
-int pciehp_disable_slot(struct slot *p_slot)
+static int __pciehp_disable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
 	struct controller *ctrl = p_slot->ctrl;
@@ -421,9 +427,23 @@ int pciehp_disable_slot(struct slot *p_slot)
 	return 0;
 }
 
+int pciehp_disable_slot(struct slot *slot)
+{
+	int ret;
+
+	mutex_lock(&slot->hotplug_lock);
+	ret = __pciehp_disable_slot(slot);
+	mutex_unlock(&slot->hotplug_lock);
+
+	mutex_lock(&slot->lock);
+	slot->state = STATIC_STATE;
+	mutex_unlock(&slot->lock);
+
+	return ret;
+}
+
 int pciehp_sysfs_enable_slot(struct slot *p_slot)
 {
-	int retval = -ENODEV;
 	struct controller *ctrl = p_slot->ctrl;
 
 	mutex_lock(&p_slot->lock);
@@ -433,12 +453,7 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
-		mutex_lock(&p_slot->hotplug_lock);
-		retval = pciehp_enable_slot(p_slot);
-		mutex_unlock(&p_slot->hotplug_lock);
-		mutex_lock(&p_slot->lock);
-		p_slot->state = STATIC_STATE;
-		break;
+		return pciehp_enable_slot(p_slot);
 	case POWERON_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
 			  slot_name(p_slot));
@@ -455,12 +470,11 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 	}
 	mutex_unlock(&p_slot->lock);
 
-	return retval;
+	return -ENODEV;
 }
 
 int pciehp_sysfs_disable_slot(struct slot *p_slot)
 {
-	int retval = -ENODEV;
 	struct controller *ctrl = p_slot->ctrl;
 
 	mutex_lock(&p_slot->lock);
@@ -470,12 +484,7 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 	case STATIC_STATE:
 		p_slot->state = POWEROFF_STATE;
 		mutex_unlock(&p_slot->lock);
-		mutex_lock(&p_slot->hotplug_lock);
-		retval = pciehp_disable_slot(p_slot);
-		mutex_unlock(&p_slot->hotplug_lock);
-		mutex_lock(&p_slot->lock);
-		p_slot->state = STATIC_STATE;
-		break;
+		return pciehp_disable_slot(p_slot);
 	case POWEROFF_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
 			  slot_name(p_slot));
@@ -492,5 +501,5 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 	}
 	mutex_unlock(&p_slot->lock);
 
-	return retval;
+	return -ENODEV;
 }
-- 
2.17.1
