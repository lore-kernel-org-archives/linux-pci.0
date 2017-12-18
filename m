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
Subject: [PATCH v2 3/9] PCI: Add generic function to probe PCI host controllers
Date: Mon, 18 Dec 2017 19:16:03 +0100
Message-Id: <4eb40ebbad84527f57ffea73435a46407d0b1637.1513620412.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
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
 drivers/pci/host/pci-host-common.c | 38 +++--------------------------
 drivers/pci/probe.c                | 50 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h                |  3 +++
 3 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index a613ea310e76..ba5d3dab5d89 100644
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
@@ -95,41 +94,12 @@ int pci_host_common_probe(struct platform_device *pdev,
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
-	list_splice_init(&resources, &bridge->windows);
-	bridge->dev.parent = dev;
-	bridge->sysdata = cfg;
-	bridge->busnr = cfg->busr.start;
-	bridge->ops = &ops->pci_ops;
-	bridge->map_irq = of_irq_parse_and_map_pci;
-	bridge->swizzle_irq = pci_common_swizzle;
-
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0) {
-		dev_err(dev, "Scanning root bridge failed");
+	ret = pci_host_probe(bridge, dev, cfg->busr.start, &ops->pci_ops, cfg,
+			     &resources);
+	if (ret) {
+		pci_free_resource_list(&resources);
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
index 1360db508035..3dfdc579b7de 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2685,6 +2685,56 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
+int pci_host_probe(struct pci_host_bridge *bridge,
+		   struct device *parent,
+		   int busnr,
+		   struct pci_ops *ops,
+		   void *sysdata,
+		   struct list_head *resources)
+{
+	struct pci_bus *bus, *child;
+	int ret;
+
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = busnr;
+	bridge->ops = ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0) {
+		dev_err(parent, "Scanning root bridge failed");
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
index 11823f4f1d83..e76df07dac07 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -879,6 +879,9 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
+int pci_host_probe(struct pci_host_bridge *bridge, struct device *parent,
+		   int busnr, struct pci_ops *ops, void *sysdata,
+		   struct list_head *resources);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-- 
2.11.0
