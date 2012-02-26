Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/8] PCI: make pci_host_bridge more robust
Date: Sun, 26 Feb 2012 15:33:18 -0800
Message-Id: <1330299202-3838-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330299202-3838-1-git-send-email-yinghai@kernel.org>
References: <1330299202-3838-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

1. change pci_host_bridge to find_pci_root_bridge.
2. separate find_pci_root_bus().
3. on any possible path return NULL.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/host-bridge.c |   35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/pci/host-bridge.c
===================================================================
--- linux-2.6.orig/drivers/pci/host-bridge.c
+++ linux-2.6/drivers/pci/host-bridge.c
@@ -16,19 +16,31 @@ void add_to_pci_host_bridges(struct pci_
 	list_add_tail(&bridge->list, &pci_host_bridges);
 }
 
-static struct pci_host_bridge *pci_host_bridge(struct pci_dev *dev)
+static struct pci_bus *find_pci_root_bus(struct pci_dev *dev)
 {
 	struct pci_bus *bus;
-	struct pci_host_bridge *bridge;
 
 	bus = dev->bus;
 	while (bus->parent)
 		bus = bus->parent;
 
-	list_for_each_entry(bridge, &pci_host_bridges, list) {
+	if (!pci_is_root_bus(bus))
+		return NULL;
+
+	return bus;
+}
+
+static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
+{
+	struct pci_bus *bus = find_pci_root_bus(dev);
+	struct pci_host_bridge *bridge;
+
+	if (!bus)
+		return NULL;
+
+	list_for_each_entry(bridge, &pci_host_bridges, list)
 		if (bridge->bus == bus)
 			return bridge;
-	}
 
 	return NULL;
 }
@@ -42,10 +54,13 @@ void __weak pcibios_resource_to_bus(stru
 				    struct pci_bus_region *region,
 				    struct resource *res)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge(dev);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
+	if (!bridge)
+		goto no_bridge;
+
 	list_for_each_entry(window, &bridge->windows, list) {
 		if (resource_type(res) != resource_type(window->res))
 			continue;
@@ -56,6 +71,7 @@ void __weak pcibios_resource_to_bus(stru
 		}
 	}
 
+no_bridge:
 	region->start = res->start - offset;
 	region->end = res->end - offset;
 }
@@ -70,12 +86,16 @@ static bool region_contains(struct pci_b
 void __weak pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 				    struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge(dev);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
 	struct pci_host_bridge_window *window;
-	struct pci_bus_region bus_region;
 	resource_size_t offset = 0;
 
+	if (!bridge)
+		goto no_bridge;
+
 	list_for_each_entry(window, &bridge->windows, list) {
+		struct pci_bus_region bus_region;
+
 		if (resource_type(res) != resource_type(window->res))
 			continue;
 
@@ -88,6 +108,7 @@ void __weak pcibios_bus_to_resource(stru
 		}
 	}
 
+no_bridge:
 	res->start = region->start + offset;
 	res->end = region->end + offset;
 }
