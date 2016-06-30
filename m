Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34365 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261AbcF3PdP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 11:33:15 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
	Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: tegra: Use new pci_register_host() interface
Date: Thu, 30 Jun 2016 17:19:31 +0200
Message-Id: <20160630151931.29216-2-thierry.reding@gmail.com>
In-Reply-To: <20160630151931.29216-1-thierry.reding@gmail.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

Tegra is one of the remaining platforms that still use the traditional
pci_common_init_dev() interface for probing PCI host bridges.

This demonstrates how to convert it to the pci_register_host interface
I just added in a previous patch. This leads to a more linear probe
sequence that can handle errors better because we avoid callbacks into
the driver, and it makes the driver architecture independent.

As a side note, I should mention that I noticed this driver does not
register any IORESOURCE_IO resource with the bus, but instead registers
the I/O port window as a memory resource, which is surely a bug.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 94 +++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index c1c7653264f8..121e04f21282 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -258,6 +258,7 @@ static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
 }
 
 struct tegra_pcie {
+	struct pci_host_bridge bridge;
 	struct device *dev;
 
 	void __iomem *pads;
@@ -302,6 +303,11 @@ struct tegra_pcie {
 	struct dentry *debugfs;
 };
 
+static inline struct tegra_pcie *to_tegra_pcie(struct pci_host_bridge *host)
+{
+	return container_of(host, struct tegra_pcie, bridge);
+}
+
 struct tegra_pcie_port {
 	struct tegra_pcie *pcie;
 	struct device_node *np;
@@ -320,11 +326,6 @@ struct tegra_pcie_bus {
 	unsigned int nr;
 };
 
-static inline struct tegra_pcie *sys_to_pcie(struct pci_sys_data *sys)
-{
-	return sys->private_data;
-}
-
 static inline void afi_writel(struct tegra_pcie *pcie, u32 value,
 			      unsigned long offset)
 {
@@ -428,7 +429,8 @@ free:
 
 static int tegra_pcie_add_bus(struct pci_bus *bus)
 {
-	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct pci_host_bridge *host = pci_find_host_bridge(bus);
+	struct tegra_pcie *pcie = to_tegra_pcie(host);
 	struct tegra_pcie_bus *b;
 
 	b = tegra_pcie_bus_alloc(pcie, bus->number);
@@ -442,7 +444,8 @@ static int tegra_pcie_add_bus(struct pci_bus *bus)
 
 static void tegra_pcie_remove_bus(struct pci_bus *child)
 {
-	struct tegra_pcie *pcie = sys_to_pcie(child->sysdata);
+	struct pci_host_bridge *host = pci_find_host_bridge(child);
+	struct tegra_pcie *pcie = to_tegra_pcie(host);
 	struct tegra_pcie_bus *bus, *tmp;
 
 	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
@@ -459,7 +462,8 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 					unsigned int devfn,
 					int where)
 {
-	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct pci_host_bridge *host = pci_find_host_bridge(bus);
+	struct tegra_pcie *pcie = to_tegra_pcie(host);
 	void __iomem *addr = NULL;
 
 	if (bus->number == 0) {
@@ -607,36 +611,33 @@ static void tegra_pcie_relax_enable(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
 
-static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
+static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
 {
-	struct tegra_pcie *pcie = sys_to_pcie(sys);
+	struct list_head *windows = &pcie->bridge.windows;
 	int err;
 
-	sys->mem_offset = pcie->offset.mem;
-	sys->io_offset = pcie->offset.io;
-
 	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->io);
 	if (err < 0)
 		return err;
 
 	pci_ioremap_io(pcie->pio.start, pcie->io.start);
 
-	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
-	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
-	pci_add_resource_offset(&sys->resources, &pcie->prefetch,
-				sys->mem_offset);
-	pci_add_resource(&sys->resources, &pcie->busn);
+	pci_add_resource_offset(windows, &pcie->pio, pcie->offset.io);
+	pci_add_resource_offset(windows, &pcie->mem, pcie->offset.mem);
+	pci_add_resource_offset(windows, &pcie->prefetch, pcie->offset.mem);
+	pci_add_resource(windows, &pcie->busn);
 
-	err = devm_request_pci_bus_resources(pcie->dev, &sys->resources);
+	err = devm_request_pci_bus_resources(pcie->dev, windows);
 	if (err < 0)
 		return err;
 
-	return 1;
+	return 0;
 }
 
 static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
-	struct tegra_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+	struct tegra_pcie *pcie = to_tegra_pcie(host);
 	int irq;
 
 	tegra_cpuidle_pcie_irqs_in_use();
@@ -1521,6 +1522,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	}
 
 	/* setup AFI/FPCI range */
+	pcie->bridge.msi = &msi->chip;
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
 	base = virt_to_phys((void *)msi->pages);
 
@@ -2006,10 +2008,9 @@ retry:
 	return false;
 }
 
-static int tegra_pcie_enable(struct tegra_pcie *pcie)
+static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 {
 	struct tegra_pcie_port *port, *tmp;
-	struct hw_pci hw;
 
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
 		dev_info(pcie->dev, "probing port %u, using %u lanes\n",
@@ -2025,22 +2026,6 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
 		tegra_pcie_port_disable(port);
 		tegra_pcie_port_free(port);
 	}
-
-	memset(&hw, 0, sizeof(hw));
-
-#ifdef CONFIG_PCI_MSI
-	hw.msi_ctrl = &pcie->msi.chip;
-#endif
-
-	hw.nr_controllers = 1;
-	hw.private_data = (void **)&pcie;
-	hw.setup = tegra_pcie_setup;
-	hw.map_irq = tegra_pcie_map_irq;
-	hw.ops = &tegra_pcie_ops;
-
-	pci_common_init_dev(pcie->dev, &hw);
-
-	return 0;
 }
 
 static const struct tegra_pcie_soc_data tegra20_pcie_data = {
@@ -2203,7 +2188,9 @@ remove:
 static int tegra_pcie_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
+	struct pci_host_bridge *bridge;
 	struct tegra_pcie *pcie;
+	struct pci_bus *child;
 	int err;
 
 	match = of_match_device(tegra_pcie_of_match, &pdev->dev);
@@ -2219,6 +2206,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	pcie->soc_data = match->data;
 	pcie->dev = &pdev->dev;
 
+	pci_host_bridge_init(&pcie->bridge);
+	bridge = &pcie->bridge;
+
 	err = tegra_pcie_parse_dt(pcie);
 	if (err < 0)
 		return err;
@@ -2235,6 +2225,10 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto put_resources;
 
+	err = tegra_pcie_request_resources(pcie);
+	if (err)
+		goto put_resources;
+
 	/* setup the AFI address translations */
 	tegra_pcie_setup_translations(pcie);
 
@@ -2248,12 +2242,30 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = tegra_pcie_enable(pcie);
+	tegra_pcie_enable_ports(pcie);
+
+	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
+	bridge->busnr = pcie->busn.start;
+	bridge->dev.parent = &pdev->dev;
+	bridge->ops = &tegra_pcie_ops;
+
+	err = pci_host_bridge_register(bridge);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable PCIe ports: %d\n", err);
+		dev_err(&pdev->dev, "failed to register host: %d\n", err);
 		goto disable_msi;
 	}
 
+	pci_scan_child_bus(bridge->bus);
+
+	pci_fixup_irqs(pci_common_swizzle, tegra_pcie_map_irq);
+	pci_bus_size_bridges(bridge->bus);
+	pci_bus_assign_resources(bridge->bus);
+
+	list_for_each_entry(child, &bridge->bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	pci_bus_add_devices(bridge->bus);
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err = tegra_pcie_debugfs_init(pcie);
 		if (err < 0)
-- 
2.8.3

