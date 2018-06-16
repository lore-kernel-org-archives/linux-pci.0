Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:36743 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPT1G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:27:06 -0400
Message-Id: <06297ed0e562d09878a5ebdc5eec5e6af8869219.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 06/32] PCI: pciehp: Declare pciehp_unconfigure_device() void
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit 0f4bd8014db5 ("PCI: hotplug: Drop checking of PCI_BRIDGE_
CONTROL in *_unconfigure_device()"), pciehp_unconfigure_device() can no
longer fail, so declare it and its sole caller remove_board() void, in
keeping with the usual kernel pattern that enablement can fail, but
disablement cannot.  No functional change intended.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  2 +-
 drivers/pci/hotplug/pciehp_ctrl.c | 11 ++++-------
 drivers/pci/hotplug/pciehp_pci.c  |  6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index fca87a1a2b22..acdeb08cbcba 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -115,7 +115,7 @@ int pciehp_sysfs_enable_slot(struct slot *slot);
 int pciehp_sysfs_disable_slot(struct slot *slot);
 void pciehp_queue_interrupt_event(struct slot *slot, u32 event_type);
 int pciehp_configure_device(struct slot *p_slot);
-int pciehp_unconfigure_device(struct slot *p_slot);
+void pciehp_unconfigure_device(struct slot *p_slot);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 4a4639b7a479..76a9b8c26d2b 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -119,14 +119,11 @@ static int board_added(struct slot *p_slot)
  * remove_board - Turns off slot and LEDs
  * @p_slot: slot where board is being removed
  */
-static int remove_board(struct slot *p_slot)
+static void remove_board(struct slot *p_slot)
 {
-	int retval;
 	struct controller *ctrl = p_slot->ctrl;
 
-	retval = pciehp_unconfigure_device(p_slot);
-	if (retval)
-		return retval;
+	pciehp_unconfigure_device(p_slot);
 
 	if (POWER_CTRL(ctrl)) {
 		pciehp_power_off_slot(p_slot);
@@ -141,7 +138,6 @@ static int remove_board(struct slot *p_slot)
 
 	/* turn off Green LED */
 	pciehp_green_led_off(p_slot);
-	return 0;
 }
 
 struct power_work_info {
@@ -421,7 +417,8 @@ int pciehp_disable_slot(struct slot *p_slot)
 		}
 	}
 
-	return remove_board(p_slot);
+	remove_board(p_slot);
+	return 0;
 }
 
 int pciehp_sysfs_enable_slot(struct slot *p_slot)
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 242395389293..a3aa575c248a 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -74,9 +74,8 @@ int pciehp_configure_device(struct slot *p_slot)
 	return ret;
 }
 
-int pciehp_unconfigure_device(struct slot *p_slot)
+void pciehp_unconfigure_device(struct slot *p_slot)
 {
-	int rc = 0;
 	u8 presence = 0;
 	struct pci_dev *dev, *temp;
 	struct controller *ctrl = p_slot->ctrl;
@@ -87,7 +86,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 	mutex_lock(&acquire_unless_disconnected);
 	if (pci_dev_is_disconnected(bridge)) {
 		mutex_unlock(&acquire_unless_disconnected);
-		return -ENODEV;
+		return;
 	}
 	pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
 	pci_lock_rescan_remove();
@@ -121,5 +120,4 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 	}
 
 	pci_unlock_rescan_remove();
-	return rc;
 }
-- 
2.17.1
