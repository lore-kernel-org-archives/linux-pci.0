Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:58373 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeFPTi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:38:26 -0400
Message-Id: <c4de2b63f4405991d5556062da514f43fee81d56.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 18/32] PCI: pciehp: Drop enable/disable lock
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously slot enablement and disablement could happen concurrently.
But now it's under the exclusive control of the IRQ thread, rendering
the locking obsolete.  Drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  3 ---
 drivers/pci/hotplug/pciehp_ctrl.c | 11 -----------
 drivers/pci/hotplug/pciehp_hpc.c  |  1 -
 3 files changed, 15 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index ed42dde5f9ac..5417180c3aff 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -67,8 +67,6 @@ do {									\
  *	an Attention Button press
  * @lock: protects reads and writes of @state;
  *	protects scheduling, execution and cancellation of @work
- * @hotplug_lock: serializes calls to pciehp_enable_slot() and
- *	pciehp_disable_slot()
  */
 struct slot {
 	u8 state;
@@ -76,7 +74,6 @@ struct slot {
 	struct hotplug_slot *hotplug_slot;
 	struct delayed_work work;
 	struct mutex lock;
-	struct mutex hotplug_lock;
 };
 
 /**
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 70bad847a450..8ba937599fb3 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -277,9 +277,6 @@ void pciehp_handle_presence_change(struct slot *slot)
 	}
 }
 
-/*
- * Note: This function must be called with slot->hotplug_lock held
- */
 static int __pciehp_enable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
@@ -316,10 +313,7 @@ int pciehp_enable_slot(struct slot *slot)
 	struct controller *ctrl = slot->ctrl;
 	int ret;
 
-	mutex_lock(&slot->hotplug_lock);
 	ret = __pciehp_enable_slot(slot);
-	mutex_unlock(&slot->hotplug_lock);
-
 	if (ret && ATTN_BUTTN(ctrl))
 		pciehp_green_led_off(slot); /* may be blinking */
 
@@ -330,9 +324,6 @@ int pciehp_enable_slot(struct slot *slot)
 	return ret;
 }
 
-/*
- * Note: This function must be called with slot->hotplug_lock held
- */
 static int __pciehp_disable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
@@ -355,9 +346,7 @@ int pciehp_disable_slot(struct slot *slot)
 {
 	int ret;
 
-	mutex_lock(&slot->hotplug_lock);
 	ret = __pciehp_disable_slot(slot);
-	mutex_unlock(&slot->hotplug_lock);
 
 	mutex_lock(&slot->lock);
 	slot->state = OFF_STATE;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 9aea0bdbb019..c795d32dbb73 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -781,7 +781,6 @@ static int pcie_init_slot(struct controller *ctrl)
 
 	slot->ctrl = ctrl;
 	mutex_init(&slot->lock);
-	mutex_init(&slot->hotplug_lock);
 	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
 	ctrl->slot = slot;
 	return 0;
-- 
2.17.1
