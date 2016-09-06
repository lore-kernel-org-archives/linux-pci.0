Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:40375 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbcIFE2k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2016 00:28:40 -0400
Message-Id: <9bc855a01d0f29cc8425cf50dce9812062309cfb.1473135221.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 6 Sep 2016 06:20:46 +0200
Subject: [PATCH] PCI: Fix bridge_d3 update on device removal
To: linux-pci@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Starting with v4.8, we allow a PCIe port to runtime suspend to D3hot if
the port itself and its children satisfy a number of conditions.  Once a
child is removed, we recheck those conditions in case the removed device
was blocking the port from suspending.

The rechecking needs to happen *after* the device has been removed from
the bus it resides on.  Otherwise when walking the port's subordinate
bus in pci_bridge_d3_update(), the device being removed would
erroneously still be taken into account.

However the device is removed from the bus_list in pci_destroy_dev() and
we currently recheck *before* that.  Fix it.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/remove.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d1ef7ac..f9357e0 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -40,6 +40,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+	pci_bridge_d3_device_removed(dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
@@ -96,8 +97,6 @@ static void pci_remove_bus_device(struct pci_dev *dev)
 		dev->subordinate = NULL;
 	}
 
-	pci_bridge_d3_device_removed(dev);
-
 	pci_destroy_dev(dev);
 }
 
-- 
2.9.3

