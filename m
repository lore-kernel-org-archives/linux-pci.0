Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f202.google.com ([74.125.82.202]:45478 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab2HQXg2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:28 -0400
Received: by weyr1 with SMTP id r1so207182wey.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:27 -0700 (PDT)
Subject: [PATCH v2 08/16] PCI: Stop and remove devices in one pass
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:26 -0600
Message-ID: <20120817233626.10973.57304.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously, when we removed a PCI device, we made two passes over the
hierarchy rooted at the device.  In the first pass, we stopped all
the devices, and in the second, we removed them.

This patch combines the two passes into one so that we remove a device as
soon as it and all its children have been stopped.

Note that we previously stopped devices in reverse order and removed them
in forward order.  Now we stop and remove them in reverse order.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c |   42 +++++++-----------------------------------
 1 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 30d002e..3828104 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -78,8 +78,6 @@ void pci_remove_bus(struct pci_bus *pci_bus)
 }
 EXPORT_SYMBOL(pci_remove_bus);
 
-static void pci_stop_bus_device(struct pci_dev *dev);
-
 /**
  * pci_stop_and_remove_bus_device - remove a PCI device and any children
  * @dev: the device to remove
@@ -92,38 +90,8 @@ static void pci_stop_bus_device(struct pci_dev *dev);
  * device lists, remove the /proc entry, and notify userspace
  * (/sbin/hotplug).
  */
-static void __pci_remove_bus_device(struct pci_dev *dev)
-{
-	struct pci_bus *bus = dev->subordinate;
-	struct pci_dev *child, *tmp;
-
-	if (bus) {
-		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
-			__pci_remove_bus_device(child);
-
-		pci_remove_bus(bus);
-		dev->subordinate = NULL;
-	}
-
-	pci_destroy_dev(dev);
-}
-
 void pci_stop_and_remove_bus_device(struct pci_dev *dev)
 {
-	pci_stop_bus_device(dev);
-	__pci_remove_bus_device(dev);
-}
-
-/**
- * pci_stop_bus_device - stop a PCI device and any children
- * @dev: the device to stop
- *
- * Stop a PCI device (detach the driver, remove from the global list
- * and so on). This also stop any subordinate buses and children in a
- * depth-first manner.
- */
-static void pci_stop_bus_device(struct pci_dev *dev)
-{
 	struct pci_bus *bus = dev->subordinate;
 	struct pci_dev *child, *tmp;
 
@@ -133,12 +101,16 @@ static void pci_stop_bus_device(struct pci_dev *dev)
 	 * iterator.  Therefore, iterate in reverse so we remove the VFs
 	 * first, then the PF.
 	 */
-	if (bus)
+	if (bus) {
 		list_for_each_entry_safe_reverse(child, tmp,
 						 &bus->devices, bus_list)
-			pci_stop_bus_device(child);
+			pci_stop_and_remove_bus_device(child);
+
+		pci_remove_bus(bus);
+		dev->subordinate = NULL;
+	}
 
 	pci_stop_dev(dev);
+	pci_destroy_dev(dev);
 }
-
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);

