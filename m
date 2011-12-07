Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:42250 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893Ab1LGIx5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 03:53:57 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 5/5] PCI: Make pci_rescan_bus handle add_list
Date: Wed,  7 Dec 2011 00:53:04 -0800
Message-Id: <1323247984-15281-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So it will allocate resource to hotplug bridge during remove/rescan.

Need to move that function to setup-bus.c so it could use
  __pci_bus_size_bridges and __pci_bus_assign_resources
directly to take add_list.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/probe.c     |   32 --------------------------------
 drivers/pci/setup-bus.c |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 32 deletions(-)

Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -1684,38 +1684,6 @@ unsigned int __ref pci_rescan_bus_bridge
 	return max;
 }
 
-/**
- * pci_rescan_bus - scan a PCI bus for devices.
- * @bus: PCI bus to scan
- *
- * Scan a PCI bus and child buses for new devices, adds them,
- * and enables them.
- *
- * Returns the max number of subordinate bus discovered.
- */
-unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
-{
-	unsigned int max;
-	struct pci_dev *dev;
-
-	max = pci_scan_child_bus(bus);
-
-	down_read(&pci_bus_sem);
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
-			if (dev->subordinate)
-				pci_bus_size_bridges(dev->subordinate);
-	up_read(&pci_bus_sem);
-
-	pci_bus_assign_resources(bus);
-	pci_enable_bridges(bus);
-	pci_bus_add_devices(bus);
-
-	return max;
-}
-EXPORT_SYMBOL_GPL(pci_rescan_bus);
-
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bridge);
Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -1354,3 +1354,42 @@ enable_all:
 	pci_enable_bridges(parent);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
+
+#ifdef CONFIG_HOTPLUG
+/**
+ * pci_rescan_bus - scan a PCI bus for devices.
+ * @bus: PCI bus to scan
+ *
+ * Scan a PCI bus and child buses for new devices, adds them,
+ * and enables them.
+ *
+ * Returns the max number of subordinate bus discovered.
+ */
+unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
+{
+	unsigned int max;
+	struct pci_dev *dev;
+	struct resource_list_x add_list; /* list of resources that
+					want additional resources */
+
+	max = pci_scan_child_bus(bus);
+
+	add_list.next = NULL;
+	down_read(&pci_bus_sem);
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+			if (dev->subordinate)
+				__pci_bus_size_bridges(dev->subordinate,
+							 &add_list);
+	up_read(&pci_bus_sem);
+	__pci_bus_assign_resources(bus, &add_list, NULL);
+	BUG_ON(add_list.next);
+
+	pci_enable_bridges(bus);
+	pci_bus_add_devices(bus);
+
+	return max;
+}
+EXPORT_SYMBOL_GPL(pci_rescan_bus);
+#endif
