Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:37233 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938725AbcJSOOa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 10:14:30 -0400
Message-Id: <bae5458c8288c0ee1ede1c16b41f47e5cbf6e77b.1476875113.git.lukas@wunner.de>
In-Reply-To: <cover.1476875113.git.lukas@wunner.de>
References: <cover.1476875113.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Oct 2016 16:07:13 +0200
Subject: [PATCH 2/9] PCI: Autosense device removal in pci_bridge_d3_update()
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The algorithm to update the flag indicating whether a bridge may go to
D3 makes a few optimizations based on whether the update was caused by
the removal of a device on the one hand, versus the addition of a device
or the change of its D3cold flags on the other hand.

The information whether the update pertains to a removal is currently
passed in by the caller, but the function may as well determine that
itself by examining the device in question, thereby allowing for a
considerable simplification and reduction of the code.

Out of several options to determine removal, I've chosen the function
device_is_registered() because it's cheap:  It merely returns the
dev->kobj.state_in_sysfs flag.  That flag is set through device_add()
when the root bus is scanned and cleared through device_remove().
The call to pci_bridge_d3_update() happens after each of these calls,
respectively, so the ordering is correct.

No functional change intended.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/bus.c    |  2 +-
 drivers/pci/pci.c    | 35 +++++------------------------------
 drivers/pci/pci.h    |  3 +--
 drivers/pci/remove.c |  2 +-
 4 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index c288e5a..bc56cf1 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -320,7 +320,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_fixup_device(pci_fixup_final, dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
-	pci_bridge_d3_device_changed(dev);
+	pci_bridge_d3_update(dev);
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6e0c399..c12fae7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2277,14 +2277,14 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 /*
  * pci_bridge_d3_update - Update bridge D3 capabilities
  * @dev: PCI device which is changed
- * @remove: Is the device being removed
  *
  * Update upstream bridge PM capabilities accordingly depending on if the
  * device PM configuration was changed or the device is being removed.  The
  * change is also propagated upstream.
  */
-static void pci_bridge_d3_update(struct pci_dev *dev, bool remove)
+void pci_bridge_d3_update(struct pci_dev *dev)
 {
+	bool remove = !device_is_registered(&dev->dev);
 	struct pci_dev *bridge;
 	bool d3cold_ok = true;
 
@@ -2311,36 +2311,11 @@ static void pci_bridge_d3_update(struct pci_dev *dev, bool remove)
 	if (bridge->bridge_d3 != d3cold_ok) {
 		bridge->bridge_d3 = d3cold_ok;
 		/* Propagate change to upstream bridges */
-		pci_bridge_d3_update(bridge, false);
+		pci_bridge_d3_update(bridge);
 	}
 }
 
 /**
- * pci_bridge_d3_device_changed - Update bridge D3 capabilities on change
- * @dev: PCI device that was changed
- *
- * If a device is added or its PM configuration, such as is it allowed to
- * enter D3cold, is changed this function updates upstream bridge PM
- * capabilities accordingly.
- */
-void pci_bridge_d3_device_changed(struct pci_dev *dev)
-{
-	pci_bridge_d3_update(dev, false);
-}
-
-/**
- * pci_bridge_d3_device_removed - Update bridge D3 capabilities on remove
- * @dev: PCI device being removed
- *
- * Function updates upstream bridge PM capabilities based on other devices
- * still left on the bus.
- */
-void pci_bridge_d3_device_removed(struct pci_dev *dev)
-{
-	pci_bridge_d3_update(dev, true);
-}
-
-/**
  * pci_d3cold_enable - Enable D3cold for device
  * @dev: PCI device to handle
  *
@@ -2352,7 +2327,7 @@ void pci_d3cold_enable(struct pci_dev *dev)
 {
 	if (dev->no_d3cold) {
 		dev->no_d3cold = false;
-		pci_bridge_d3_device_changed(dev);
+		pci_bridge_d3_update(dev);
 	}
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_enable);
@@ -2369,7 +2344,7 @@ void pci_d3cold_disable(struct pci_dev *dev)
 {
 	if (!dev->no_d3cold) {
 		dev->no_d3cold = true;
-		pci_bridge_d3_device_changed(dev);
+		pci_bridge_d3_update(dev);
 	}
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_disable);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4518562..27048bb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -85,8 +85,7 @@ void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
-void pci_bridge_d3_device_changed(struct pci_dev *dev);
-void pci_bridge_d3_device_removed(struct pci_dev *dev);
+void pci_bridge_d3_update(struct pci_dev *dev);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index f9357e0..73a03d3 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -40,7 +40,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
-	pci_bridge_d3_device_removed(dev);
+	pci_bridge_d3_update(dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
-- 
2.9.3

