Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:52986 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab2HQXgW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:22 -0400
Received: by mail-ee0-f74.google.com with SMTP id d4so192260eek.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:22 -0700 (PDT)
Subject: [PATCH v2 07/16] PCI: Fold stop and remove helpers into their callers
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:21 -0600
Message-ID: <20120817233621.10973.48755.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_stop_bus_devices() is only two lines of code and is only called by
pci_stop_bus_device(), so I think it's easier to read if we just fold it
into the caller.  Similarly for __pci_remove_behind_bridge().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c |   53 +++++++++++++++++++-------------------------------
 1 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index f17a027..30d002e 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -78,7 +78,6 @@ void pci_remove_bus(struct pci_bus *pci_bus)
 }
 EXPORT_SYMBOL(pci_remove_bus);
 
-static void __pci_remove_behind_bridge(struct pci_dev *dev);
 static void pci_stop_bus_device(struct pci_dev *dev);
 
 /**
@@ -95,11 +94,14 @@ static void pci_stop_bus_device(struct pci_dev *dev);
  */
 static void __pci_remove_bus_device(struct pci_dev *dev)
 {
-	if (dev->subordinate) {
-		struct pci_bus *b = dev->subordinate;
+	struct pci_bus *bus = dev->subordinate;
+	struct pci_dev *child, *tmp;
+
+	if (bus) {
+		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+			__pci_remove_bus_device(child);
 
-		__pci_remove_behind_bridge(dev);
-		pci_remove_bus(b);
+		pci_remove_bus(bus);
 		dev->subordinate = NULL;
 	}
 
@@ -112,32 +114,6 @@ void pci_stop_and_remove_bus_device(struct pci_dev *dev)
 	__pci_remove_bus_device(dev);
 }
 
-static void __pci_remove_behind_bridge(struct pci_dev *dev)
-{
-	struct pci_dev *child, *tmp;
-
-	if (dev->subordinate)
-		list_for_each_entry_safe(child, tmp,
-					 &dev->subordinate->devices, bus_list)
-			__pci_remove_bus_device(child);
-}
-
-static void pci_stop_bus_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev, *tmp;
-
-	/*
-	 * VFs could be removed by pci_stop_and_remove_bus_device() in the
-	 *  pci_stop_bus_devices() code path for PF.
-	 *  aka, bus->devices get updated in the process.
-	 * but VFs are inserted after PFs when SRIOV is enabled for PF,
-	 * We can iterate the list backwards to get prev valid PF instead
-	 *  of removed VF.
-	 */
-	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list)
-		pci_stop_bus_device(dev);
-}
-
 /**
  * pci_stop_bus_device - stop a PCI device and any children
  * @dev: the device to stop
@@ -148,8 +124,19 @@ static void pci_stop_bus_devices(struct pci_bus *bus)
  */
 static void pci_stop_bus_device(struct pci_dev *dev)
 {
-	if (dev->subordinate)
-		pci_stop_bus_devices(dev->subordinate);
+	struct pci_bus *bus = dev->subordinate;
+	struct pci_dev *child, *tmp;
+
+	/*
+	 * Removing an SR-IOV PF device removes all the associated VFs,
+	 * which will update the bus->devices list and confuse the
+	 * iterator.  Therefore, iterate in reverse so we remove the VFs
+	 * first, then the PF.
+	 */
+	if (bus)
+		list_for_each_entry_safe_reverse(child, tmp,
+						 &bus->devices, bus_list)
+			pci_stop_bus_device(child);
 
 	pci_stop_dev(dev);
 }

