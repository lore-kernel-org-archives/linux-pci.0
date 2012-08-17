Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab2HQXgG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:06 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:06 -0700 (PDT)
Subject: [PATCH v2 04/16] PCI: Don't export stop_bus_device and
	remove_bus_device interfaces
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:05 -0600
Message-ID: <20120817233605.10973.85918.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The acpiphp hotplug driver was the only user of pci_stop_bus_device() and
__pci_remove_bus_device(), and it now uses pci_stop_and_remove_bus_device()
instead, so stop exposing these interfaces.

This removes these exported symbols:

    __pci_remove_bus_device
    pci_stop_bus_device

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c |    8 ++++----
 include/linux/pci.h  |    2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 04a4861..534377f 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -79,6 +79,8 @@ void pci_remove_bus(struct pci_bus *pci_bus)
 EXPORT_SYMBOL(pci_remove_bus);
 
 static void __pci_remove_behind_bridge(struct pci_dev *dev);
+static void pci_stop_bus_device(struct pci_dev *dev);
+
 /**
  * pci_stop_and_remove_bus_device - remove a PCI device and any children
  * @dev: the device to remove
@@ -91,7 +93,7 @@ static void __pci_remove_behind_bridge(struct pci_dev *dev);
  * device lists, remove the /proc entry, and notify userspace
  * (/sbin/hotplug).
  */
-void __pci_remove_bus_device(struct pci_dev *dev)
+static void __pci_remove_bus_device(struct pci_dev *dev)
 {
 	if (dev->subordinate) {
 		struct pci_bus *b = dev->subordinate;
@@ -103,7 +105,6 @@ void __pci_remove_bus_device(struct pci_dev *dev)
 
 	pci_destroy_dev(dev);
 }
-EXPORT_SYMBOL(__pci_remove_bus_device);
 
 void pci_stop_and_remove_bus_device(struct pci_dev *dev)
 {
@@ -170,7 +171,7 @@ static void pci_stop_bus_devices(struct pci_bus *bus)
  * and so on). This also stop any subordinate buses and children in a
  * depth-first manner.
  */
-void pci_stop_bus_device(struct pci_dev *dev)
+static void pci_stop_bus_device(struct pci_dev *dev)
 {
 	if (dev->subordinate)
 		pci_stop_bus_devices(dev->subordinate);
@@ -180,4 +181,3 @@ void pci_stop_bus_device(struct pci_dev *dev)
 
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
 EXPORT_SYMBOL(pci_stop_and_remove_behind_bridge);
-EXPORT_SYMBOL_GPL(pci_stop_bus_device);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5faa831..54b5b2b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -734,9 +734,7 @@ u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
 extern void pci_dev_put(struct pci_dev *dev);
 extern void pci_remove_bus(struct pci_bus *b);
-extern void __pci_remove_bus_device(struct pci_dev *dev);
 extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
-extern void pci_stop_bus_device(struct pci_dev *dev);
 void pci_setup_cardbus(struct pci_bus *bus);
 extern void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)

