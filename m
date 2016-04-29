Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:60924 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbcD2XCU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2016 19:02:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: catalin.marinas@arm.com, linux-pci@vger.kernel.org,
	will.deacon@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com,
	robert.richter@caviumnetworks.com, msalter@redhat.com,
	Liviu.Dudau@arm.com, jchandra@broadcom.com,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	Suravee.Suthikulpanit@amd.com,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] [RFC] pci: tegra: use new pci_register_host interface
Date: Sat, 30 Apr 2016 01:01:39 +0200
Message-Id: <1461970899-4150603-4-git-send-email-arnd@arndb.de>
In-Reply-To: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra is one of the remaining platforms that still use the
traditional pci_common_init_dev() interface for probing PCI
host bridges.

This demonstrates how to convert it to the pci_register_host
interface I just added in a previous patch. This leads to
a more linear probe sequence that can handle errors better
because we avoid callbacks into the driver, and it makes
the driver architecture independent.

As a side note, I should mention that I noticed this driver
does not register any IORESOURCE_IO resource with the bus,
but instead registers the I/O port window as a memory
resource, which is surely a bug.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-tegra.c | 67 ++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index c388468c202a..ece4f5d0180b 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -265,6 +265,7 @@ static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
 }
 
 struct tegra_pcie {
+	struct pci_host_bridge bridge;
 	struct device *dev;
 
 	void __iomem *pads;
@@ -615,14 +616,10 @@ static void tegra_pcie_relax_enable(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
 
-static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
+static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
 {
-	struct tegra_pcie *pcie = sys_to_pcie(sys);
 	int err;
 
-	sys->mem_offset = pcie->offset.mem;
-	sys->io_offset = pcie->offset.io;
-
 	err = devm_request_resource(pcie->dev, &pcie->all, &pcie->io);
 	if (err < 0)
 		return err;
@@ -639,15 +636,15 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (err)
 		return err;
 
-	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
-	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
-	pci_add_resource_offset(&sys->resources, &pcie->prefetch,
-				sys->mem_offset);
-	pci_add_resource(&sys->resources, &pcie->busn);
+	pci_add_resource_offset(&pcie->bridge.windows, &pcie->pio, pcie->offset.io);
+	pci_add_resource_offset(&pcie->bridge.windows, &pcie->mem, pcie->offset.mem);
+	pci_add_resource_offset(&pcie->bridge.windows, &pcie->prefetch,
+				pcie->offset.mem);
+	pci_add_resource(&pcie->bridge.windows, &pcie->busn);
 
 	pci_ioremap_io(pcie->pio.start, pcie->io.start);
 
-	return 1;
+	return 0;
 }
 
 static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
@@ -1535,6 +1532,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	}
 
 	/* setup AFI/FPCI range */
+	pcie->bridge.msi = &msi->chip;
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
 	base = virt_to_phys((void *)msi->pages);
 
@@ -2036,10 +2034,9 @@ retry:
 	return false;
 }
 
-static int tegra_pcie_enable(struct tegra_pcie *pcie)
+static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 {
 	struct tegra_pcie_port *port, *tmp;
-	struct hw_pci hw;
 
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
 		dev_info(pcie->dev, "probing port %u, using %u lanes\n",
@@ -2055,22 +2052,6 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
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
@@ -2230,6 +2211,8 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct tegra_pcie *pcie;
+	struct pci_host_bridge *bridge;
+	struct pci_bus *child;
 	int err;
 
 	match = of_match_device(tegra_pcie_of_match, &pdev->dev);
@@ -2244,6 +2227,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&pcie->ports);
 	pcie->soc_data = match->data;
 	pcie->dev = &pdev->dev;
+	bridge = &pcie->bridge;
 
 	err = tegra_pcie_parse_dt(pcie);
 	if (err < 0)
@@ -2261,6 +2245,10 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto put_resources;
 
+	err = tegra_pcie_request_resources(pcie);
+	if (err)
+		goto put_resources;
+
 	/* setup the AFI address translations */
 	tegra_pcie_setup_translations(pcie);
 
@@ -2274,12 +2262,29 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = tegra_pcie_enable(pcie);
+	tegra_pcie_enable_ports(pcie);
+
+	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
+	bridge->busnr = pcie->busn.start;
+	bridge->dev.parent = &pdev->dev;
+	bridge->sysdata = pcie;
+	bridge->ops = &tegra_pcie_ops;
+	err = pci_register_host(bridge);
+
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable PCIe ports: %d\n", err);
+		dev_err(&pdev->dev, "failed to register host: %d\n", err);
 		goto disable_msi;
 	}
 
+        pci_fixup_irqs(pci_common_swizzle, tegra_pcie_map_irq);
+	pci_bus_size_bridges(bridge->bus);
+	pci_bus_assign_resources(bridge->bus);
+
+	list_for_each_entry(child, &bridge->bus->children, node)
+		pcie_bus_configure_settings(child);
+
+        pci_bus_add_devices(bridge->bus);
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err = tegra_pcie_debugfs_init(pcie);
 		if (err < 0)
-- 
2.7.0

