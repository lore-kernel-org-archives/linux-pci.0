Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:49826 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1KWFH3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2011 00:07:29 -0500
Message-ID: <4ECC7F6D.6090802@oracle.com>
Date: Tue, 22 Nov 2011 21:06:53 -0800
From: Yinghai Lu <yinghai.lu@oracle.com>
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: Only call pci_stop_bus_device() one time for children
 devices during removing
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


During debugging pcie hotplug with SRIOV with pcie switch, found
pci_stop_bus_device() are called several times for some children devices.

Current pci_remove_bus_device() will call pci_stop_bus_device() at first.
and then use remove_behind_bridge() to call pci_stop_bus_device() for children
devices. But pci_stop_bus_device() already include depth first to stop children.
So We can remove unnecessary calling in pci_remove_behind_bridge() for children.

The patch change original pci_remove_bus_device() to __pci_remove_bus_device(), and
it only do remove work, and new pci_remove_bus_device will call
pci_stop_bus_device() one time, and then call __pci_remove_bus_device().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/remove.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/pci/remove.c
===================================================================
--- linux-2.6.orig/drivers/pci/remove.c
+++ linux-2.6/drivers/pci/remove.c
@@ -89,9 +89,8 @@ EXPORT_SYMBOL(pci_remove_bus);
  * device lists, remove the /proc entry, and notify userspace
  * (/sbin/hotplug).
  */
-void pci_remove_bus_device(struct pci_dev *dev)
+static void __pci_remove_bus_device(struct pci_dev *dev)
 {
-	pci_stop_bus_device(dev);
 	if (dev->subordinate) {
 		struct pci_bus *b = dev->subordinate;
 
@@ -102,6 +101,11 @@ void pci_remove_bus_device(struct pci_de
 
 	pci_destroy_dev(dev);
 }
+void pci_remove_bus_device(struct pci_dev *dev)
+{
+	pci_stop_bus_device(dev);
+	__pci_remove_bus_device(dev);
+}
 
 /**
  * pci_remove_behind_bridge - remove all devices behind a PCI bridge
@@ -117,7 +121,7 @@ void pci_remove_behind_bridge(struct pci
 
 	if (dev->subordinate)
 		list_for_each_safe(l, n, &dev->subordinate->devices)
-			pci_remove_bus_device(pci_dev_b(l));
+			__pci_remove_bus_device(pci_dev_b(l));
 }
 
 static void pci_stop_bus_devices(struct pci_bus *bus)
