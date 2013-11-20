Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31701 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3KTBwl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 20:52:41 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/6] PCI: pcibus address to resource converting take bus directly
Date: Tue, 19 Nov 2013 17:51:55 -0800
Message-Id: <1384912317-3721-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
References: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For allocating resource under bus path, we do have dev pass along, and we
could just use bus instead.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/host-bridge.c | 34 +++++++++++++++++++++-------------
 include/linux/pci.h       |  3 +++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index a68dc61..2e7288b 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -9,22 +9,19 @@
 
 #include "pci.h"
 
-static struct pci_bus *find_pci_root_bus(struct pci_dev *dev)
+static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 {
-	struct pci_bus *bus;
-
-	bus = dev->bus;
 	while (bus->parent)
 		bus = bus->parent;
 
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
+static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 {
-	struct pci_bus *bus = find_pci_root_bus(dev);
+	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
-	return to_pci_host_bridge(bus->bridge);
+	return to_pci_host_bridge(root_bus->bridge);
 }
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
@@ -40,10 +37,11 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
 	return res1->start <= res2->start && res1->end >= res2->end;
 }
 
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
+void __pcibios_resource_to_bus(struct pci_bus *bus,
+				      struct pci_bus_region *region,
+				      struct resource *res)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
@@ -60,6 +58,11 @@ void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 	region->start = res->start - offset;
 	region->end = res->end - offset;
 }
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			     struct resource *res)
+{
+	__pcibios_resource_to_bus(dev->bus, region, res);
+}
 EXPORT_SYMBOL(pcibios_resource_to_bus);
 
 static bool region_contains(struct pci_bus_region *region1,
@@ -68,10 +71,10 @@ static bool region_contains(struct pci_bus_region *region1,
 	return region1->start <= region2->start && region1->end >= region2->end;
 }
 
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
+static void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
+				      struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
@@ -93,4 +96,9 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 	res->start = region->start + offset;
 	res->end = region->end + offset;
 }
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	__pcibios_bus_to_resource(dev->bus, res, region);
+}
 EXPORT_SYMBOL(pcibios_bus_to_resource);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ccb316d..55ee90f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -738,6 +738,9 @@ void pci_fixup_cardbus(struct pci_bus *);
 
 /* Generic PCI functions used internally */
 
+void __pcibios_resource_to_bus(struct pci_bus *bus,
+			       struct pci_bus_region *region,
+			       struct resource *res);
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			     struct resource *res);
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-- 
1.8.1.4

