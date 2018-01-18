Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v4 4/7] PCI: Add generic function to probe PCI host controllers
Date: Thu, 18 Jan 2018 23:52:49 +0100
Message-Id: <e3b3e853bee77366a2f66d03a9809ca24274141d.1516314953.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
References: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
References: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchs moves generic source code from
drivers/pci/host/pci-host-common.c into drivers/pci/probe.c.

Indeed the extracted lines of code were duplicated by many host
controller drivers. Regrouping them into a generic function gives a
change to properly share this code without introducing a useless
dependency to PCI_HOST_COMMON, which selects PCI_ECAM when not needed by
most host controller drivers.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/pci/host/pci-host-common.c | 22 +---------------------
 drivers/pci/probe.c                | 33 +++++++++++++++++++++++++++++++++
 include/linux/pci.h                |  1 +
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 9f27e90f578c..756702d8dd10 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -72,7 +72,6 @@ int pci_host_common_probe(struct platform_device *pdev,
 	const char *type;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
 	struct list_head resources;
@@ -107,30 +106,11 @@ int pci_host_common_probe(struct platform_device *pdev,
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_scan_root_bus_bridge(bridge);
+	ret = pci_host_probe(bridge);
 	if (ret < 0) {
-		dev_err(dev, "Scanning root bridge failed");
 		pci_free_resource_list(&resources);
 		return ret;
 	}
 
-	bus = bridge->bus;
-
-	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
-	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
-
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
-
-	pci_bus_add_devices(bus);
 	return 0;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1360db508035..178328d06a32 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2685,6 +2685,39 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
+int pci_host_probe(struct pci_host_bridge *bridge)
+{
+	struct pci_bus *bus, *child;
+	int ret;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0) {
+		dev_err(bridge->dev.parent, "Scanning root bridge failed");
+		return ret;
+	}
+
+	bus = bridge->bus;
+
+	/*
+	 * We insert PCI resources into the iomem_resource and
+	 * ioport_resource trees in either pci_bus_claim_resources()
+	 * or pci_bus_assign_resources().
+	 */
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(bus);
+	} else {
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
+
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
+
+	pci_bus_add_devices(bus);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_host_probe);
+
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 {
 	struct resource *res = &b->busn_res;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4a4cbd444e1e..83514b34742a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -879,6 +879,7 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
+int pci_host_probe(struct pci_host_bridge *bridge);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-- 
2.11.0
