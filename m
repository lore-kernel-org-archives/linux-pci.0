Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab2HQXgL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:11 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:11 -0700 (PDT)
Subject: [PATCH v2 05/16] PCI: Remove pci_stop_and_remove_behind_bridge()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:10 -0600
Message-ID: <20120817233610.10973.25669.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCMCIA CardBus driver was the only user of
pci_stop_and_remove_behind_bridge(), and it now uses
pci_stop_and_remove_bus_device() instead, so remove this interface.

This removes exported symbol pci_stop_and_remove_behind_bridge.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c |   25 -------------------------
 include/linux/pci.h  |    1 -
 2 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 534377f..b18dc2e 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -121,30 +121,6 @@ static void __pci_remove_behind_bridge(struct pci_dev *dev)
 			__pci_remove_bus_device(pci_dev_b(l));
 }
 
-static void pci_stop_behind_bridge(struct pci_dev *dev)
-{
-	struct list_head *l, *n;
-
-	if (dev->subordinate)
-		list_for_each_safe(l, n, &dev->subordinate->devices)
-			pci_stop_bus_device(pci_dev_b(l));
-}
-
-/**
- * pci_stop_and_remove_behind_bridge - stop and remove all devices behind
- *					 a PCI bridge
- * @dev: PCI bridge device
- *
- * Remove all devices on the bus, except for the parent bridge.
- * This also removes any child buses, and any devices they may
- * contain in a depth-first manner.
- */
-void pci_stop_and_remove_behind_bridge(struct pci_dev *dev)
-{
-	pci_stop_behind_bridge(dev);
-	__pci_remove_behind_bridge(dev);
-}
-
 static void pci_stop_bus_devices(struct pci_bus *bus)
 {
 	struct list_head *l, *n;
@@ -180,4 +156,3 @@ static void pci_stop_bus_device(struct pci_dev *dev)
 }
 
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
-EXPORT_SYMBOL(pci_stop_and_remove_behind_bridge);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 54b5b2b..1dce47c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1011,7 +1011,6 @@ void pci_unregister_driver(struct pci_driver *dev);
 	module_driver(__pci_driver, pci_register_driver, \
 		       pci_unregister_driver)
 
-void pci_stop_and_remove_behind_bridge(struct pci_dev *dev);
 struct pci_driver *pci_dev_driver(const struct pci_dev *dev);
 int pci_add_dynid(struct pci_driver *drv,
 		  unsigned int vendor, unsigned int device,

