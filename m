Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755346AbcJLNCt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:02:49 -0400
Subject: [PATCH v2 2/3] PCI: tegra: Add local struct device pointers
To: Alexandre Courbot <gnurou@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:02:33 -0500
Message-ID: <20161012130233.24960.70172.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012125946.24960.54201.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012125946.24960.54201.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-tegra.c |  234 ++++++++++++++++++++++--------------------
 1 file changed, 122 insertions(+), 112 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 6df5ed0..e2ec0f6 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -384,6 +384,7 @@ static unsigned long tegra_pcie_conf_offset(unsigned int devfn, int where)
 static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
 						   unsigned int busnr)
 {
+	struct device *dev = pcie->dev;
 	pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
 				 L_PTE_XN | L_PTE_MT_DEV_SHARED | L_PTE_SHARED);
 	phys_addr_t cs = pcie->cs->start;
@@ -413,8 +414,7 @@ static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
 
 		err = ioremap_page_range(virt, virt + SZ_64K, phys, prot);
 		if (err < 0) {
-			dev_err(pcie->dev, "ioremap_page_range() failed: %d\n",
-				err);
+			dev_err(dev, "ioremap_page_range() failed: %d\n", err);
 			goto unmap;
 		}
 	}
@@ -462,6 +462,7 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 					int where)
 {
 	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct device *dev = pcie->dev;
 	void __iomem *addr = NULL;
 
 	if (bus->number == 0) {
@@ -482,8 +483,7 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 				addr = (void __iomem *)b->area->addr;
 
 		if (!addr) {
-			dev_err(pcie->dev,
-				"failed to map cfg. space for bus %u\n",
+			dev_err(dev, "failed to map cfg. space for bus %u\n",
 				bus->number);
 			return NULL;
 		}
@@ -584,12 +584,13 @@ static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
 static void tegra_pcie_port_free(struct tegra_pcie_port *port)
 {
 	struct tegra_pcie *pcie = port->pcie;
+	struct device *dev = pcie->dev;
 
-	devm_iounmap(pcie->dev, port->base);
-	devm_release_mem_region(pcie->dev, port->regs.start,
+	devm_iounmap(dev, port->base);
+	devm_release_mem_region(dev, port->regs.start,
 				resource_size(&port->regs));
 	list_del(&port->list);
-	devm_kfree(pcie->dev, port);
+	devm_kfree(dev, port);
 }
 
 /* Tegra PCIE root complex wrongly reports device class */
@@ -612,12 +613,13 @@ DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
 static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct tegra_pcie *pcie = sys_to_pcie(sys);
+	struct device *dev = pcie->dev;
 	int err;
 
 	sys->mem_offset = pcie->offset.mem;
 	sys->io_offset = pcie->offset.io;
 
-	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->io);
+	err = devm_request_resource(dev, &iomem_resource, &pcie->io);
 	if (err < 0)
 		return err;
 
@@ -631,7 +633,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 				sys->mem_offset);
 	pci_add_resource(&sys->resources, &pcie->busn);
 
-	err = devm_request_pci_bus_resources(pcie->dev, &sys->resources);
+	err = devm_request_pci_bus_resources(dev, &sys->resources);
 	if (err < 0)
 		return err;
 
@@ -672,6 +674,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 		"Peer2Peer error",
 	};
 	struct tegra_pcie *pcie = arg;
+	struct device *dev = pcie->dev;
 	u32 code, signature;
 
 	code = afi_readl(pcie, AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
@@ -689,11 +692,9 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 	 * happen a lot during enumeration
 	 */
 	if (code == AFI_INTR_MASTER_ABORT)
-		dev_dbg(pcie->dev, "%s, signature: %08x\n", err_msg[code],
-			signature);
+		dev_dbg(dev, "%s, signature: %08x\n", err_msg[code], signature);
 	else
-		dev_err(pcie->dev, "%s, signature: %08x\n", err_msg[code],
-			signature);
+		dev_err(dev, "%s, signature: %08x\n", err_msg[code], signature);
 
 	if (code == AFI_INTR_TARGET_ABORT || code == AFI_INTR_MASTER_ABORT ||
 	    code == AFI_INTR_FPCI_DECODE_ERROR) {
@@ -701,9 +702,9 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 		u64 address = (u64)fpci << 32 | (signature & 0xfffffffc);
 
 		if (code == AFI_INTR_MASTER_ABORT)
-			dev_dbg(pcie->dev, "  FPCI address: %10llx\n", address);
+			dev_dbg(dev, "  FPCI address: %10llx\n", address);
 		else
-			dev_err(pcie->dev, "  FPCI address: %10llx\n", address);
+			dev_err(dev, "  FPCI address: %10llx\n", address);
 	}
 
 	return IRQ_HANDLED;
@@ -793,6 +794,7 @@ static int tegra_pcie_pll_wait(struct tegra_pcie *pcie, unsigned long timeout)
 
 static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	u32 value;
 	int err;
@@ -829,7 +831,7 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 	/* wait for the PLL to lock */
 	err = tegra_pcie_pll_wait(pcie, 500);
 	if (err < 0) {
-		dev_err(pcie->dev, "PLL failed to lock: %d\n", err);
+		dev_err(dev, "PLL failed to lock: %d\n", err);
 		return err;
 	}
 
@@ -880,8 +882,7 @@ static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
 	for (i = 0; i < port->lanes; i++) {
 		err = phy_power_on(port->phys[i]);
 		if (err < 0) {
-			dev_err(dev, "failed to power on PHY#%u: %d\n", i,
-				err);
+			dev_err(dev, "failed to power on PHY#%u: %d\n", i, err);
 			return err;
 		}
 	}
@@ -909,6 +910,7 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
 
 static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct tegra_pcie_port *port;
 	int err;
@@ -920,7 +922,7 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 			err = tegra_pcie_phy_enable(pcie);
 
 		if (err < 0)
-			dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
+			dev_err(dev, "failed to power on PHY: %d\n", err);
 
 		return err;
 	}
@@ -928,7 +930,7 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 	list_for_each_entry(port, &pcie->ports, list) {
 		err = tegra_pcie_port_phy_power_on(port);
 		if (err < 0) {
-			dev_err(pcie->dev,
+			dev_err(dev,
 				"failed to power on PCIe port %u PHY: %d\n",
 				port->index, err);
 			return err;
@@ -946,6 +948,7 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 
 static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	struct tegra_pcie_port *port;
 	int err;
 
@@ -956,8 +959,7 @@ static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
 			err = tegra_pcie_phy_disable(pcie);
 
 		if (err < 0)
-			dev_err(pcie->dev, "failed to power off PHY: %d\n",
-				err);
+			dev_err(dev, "failed to power off PHY: %d\n", err);
 
 		return err;
 	}
@@ -965,7 +967,7 @@ static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
 	list_for_each_entry(port, &pcie->ports, list) {
 		err = tegra_pcie_port_phy_power_off(port);
 		if (err < 0) {
-			dev_err(pcie->dev,
+			dev_err(dev,
 				"failed to power off PCIe port %u PHY: %d\n",
 				port->index, err);
 			return err;
@@ -977,6 +979,7 @@ static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
 
 static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct tegra_pcie_port *port;
 	unsigned long value;
@@ -1016,7 +1019,7 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 
 	err = tegra_pcie_phy_power_on(pcie);
 	if (err < 0) {
-		dev_err(pcie->dev, "failed to power on PHY(s): %d\n", err);
+		dev_err(dev, "failed to power on PHY(s): %d\n", err);
 		return err;
 	}
 
@@ -1049,13 +1052,14 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 
 static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	int err;
 
 	/* TODO: disable and unprepare clocks? */
 
 	err = tegra_pcie_phy_power_off(pcie);
 	if (err < 0)
-		dev_err(pcie->dev, "failed to power off PHY(s): %d\n", err);
+		dev_err(dev, "failed to power off PHY(s): %d\n", err);
 
 	reset_control_assert(pcie->pcie_xrst);
 	reset_control_assert(pcie->afi_rst);
@@ -1065,11 +1069,12 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 
 	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
-		dev_warn(pcie->dev, "failed to disable regulators: %d\n", err);
+		dev_warn(dev, "failed to disable regulators: %d\n", err);
 }
 
 static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
@@ -1082,13 +1087,13 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	/* enable regulators */
 	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
-		dev_err(pcie->dev, "failed to enable regulators: %d\n", err);
+		dev_err(dev, "failed to enable regulators: %d\n", err);
 
 	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
 						pcie->pex_clk,
 						pcie->pex_rst);
 	if (err) {
-		dev_err(pcie->dev, "powerup sequence failed: %d\n", err);
+		dev_err(dev, "powerup sequence failed: %d\n", err);
 		return err;
 	}
 
@@ -1096,22 +1101,21 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 
 	err = clk_prepare_enable(pcie->afi_clk);
 	if (err < 0) {
-		dev_err(pcie->dev, "failed to enable AFI clock: %d\n", err);
+		dev_err(dev, "failed to enable AFI clock: %d\n", err);
 		return err;
 	}
 
 	if (soc->has_cml_clk) {
 		err = clk_prepare_enable(pcie->cml_clk);
 		if (err < 0) {
-			dev_err(pcie->dev, "failed to enable CML clock: %d\n",
-				err);
+			dev_err(dev, "failed to enable CML clock: %d\n", err);
 			return err;
 		}
 	}
 
 	err = clk_prepare_enable(pcie->pll_e);
 	if (err < 0) {
-		dev_err(pcie->dev, "failed to enable PLLE clock: %d\n", err);
+		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
 		return err;
 	}
 
@@ -1120,22 +1124,23 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 
-	pcie->pex_clk = devm_clk_get(pcie->dev, "pex");
+	pcie->pex_clk = devm_clk_get(dev, "pex");
 	if (IS_ERR(pcie->pex_clk))
 		return PTR_ERR(pcie->pex_clk);
 
-	pcie->afi_clk = devm_clk_get(pcie->dev, "afi");
+	pcie->afi_clk = devm_clk_get(dev, "afi");
 	if (IS_ERR(pcie->afi_clk))
 		return PTR_ERR(pcie->afi_clk);
 
-	pcie->pll_e = devm_clk_get(pcie->dev, "pll_e");
+	pcie->pll_e = devm_clk_get(dev, "pll_e");
 	if (IS_ERR(pcie->pll_e))
 		return PTR_ERR(pcie->pll_e);
 
 	if (soc->has_cml_clk) {
-		pcie->cml_clk = devm_clk_get(pcie->dev, "cml");
+		pcie->cml_clk = devm_clk_get(dev, "cml");
 		if (IS_ERR(pcie->cml_clk))
 			return PTR_ERR(pcie->cml_clk);
 	}
@@ -1145,15 +1150,17 @@ static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 
 static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
 {
-	pcie->pex_rst = devm_reset_control_get(pcie->dev, "pex");
+	struct device *dev = pcie->dev;
+
+	pcie->pex_rst = devm_reset_control_get(dev, "pex");
 	if (IS_ERR(pcie->pex_rst))
 		return PTR_ERR(pcie->pex_rst);
 
-	pcie->afi_rst = devm_reset_control_get(pcie->dev, "afi");
+	pcie->afi_rst = devm_reset_control_get(dev, "afi");
 	if (IS_ERR(pcie->afi_rst))
 		return PTR_ERR(pcie->afi_rst);
 
-	pcie->pcie_xrst = devm_reset_control_get(pcie->dev, "pcie_x");
+	pcie->pcie_xrst = devm_reset_control_get(dev, "pcie_x");
 	if (IS_ERR(pcie->pcie_xrst))
 		return PTR_ERR(pcie->pcie_xrst);
 
@@ -1162,18 +1169,19 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
 
 static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	int err;
 
-	pcie->phy = devm_phy_optional_get(pcie->dev, "pcie");
+	pcie->phy = devm_phy_optional_get(dev, "pcie");
 	if (IS_ERR(pcie->phy)) {
 		err = PTR_ERR(pcie->phy);
-		dev_err(pcie->dev, "failed to get PHY: %d\n", err);
+		dev_err(dev, "failed to get PHY: %d\n", err);
 		return err;
 	}
 
 	err = phy_init(pcie->phy);
 	if (err < 0) {
-		dev_err(pcie->dev, "failed to initialize PHY: %d\n", err);
+		dev_err(dev, "failed to initialize PHY: %d\n", err);
 		return err;
 	}
 
@@ -1256,43 +1264,44 @@ static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
 
 static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
+	struct device *dev = pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *pads, *afi, *res;
 	int err;
 
 	err = tegra_pcie_clocks_get(pcie);
 	if (err) {
-		dev_err(&pdev->dev, "failed to get clocks: %d\n", err);
+		dev_err(dev, "failed to get clocks: %d\n", err);
 		return err;
 	}
 
 	err = tegra_pcie_resets_get(pcie);
 	if (err) {
-		dev_err(&pdev->dev, "failed to get resets: %d\n", err);
+		dev_err(dev, "failed to get resets: %d\n", err);
 		return err;
 	}
 
 	err = tegra_pcie_phys_get(pcie);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get PHYs: %d\n", err);
+		dev_err(dev, "failed to get PHYs: %d\n", err);
 		return err;
 	}
 
 	err = tegra_pcie_power_on(pcie);
 	if (err) {
-		dev_err(&pdev->dev, "failed to power up: %d\n", err);
+		dev_err(dev, "failed to power up: %d\n", err);
 		return err;
 	}
 
 	pads = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pads");
-	pcie->pads = devm_ioremap_resource(&pdev->dev, pads);
+	pcie->pads = devm_ioremap_resource(dev, pads);
 	if (IS_ERR(pcie->pads)) {
 		err = PTR_ERR(pcie->pads);
 		goto poweroff;
 	}
 
 	afi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "afi");
-	pcie->afi = devm_ioremap_resource(&pdev->dev, afi);
+	pcie->afi = devm_ioremap_resource(dev, afi);
 	if (IS_ERR(pcie->afi)) {
 		err = PTR_ERR(pcie->afi);
 		goto poweroff;
@@ -1305,7 +1314,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 		goto poweroff;
 	}
 
-	pcie->cs = devm_request_mem_region(pcie->dev, res->start,
+	pcie->cs = devm_request_mem_region(dev, res->start,
 					   resource_size(res), res->name);
 	if (!pcie->cs) {
 		err = -EADDRNOTAVAIL;
@@ -1315,7 +1324,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	/* request interrupt */
 	err = platform_get_irq_byname(pdev, "intr");
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+		dev_err(dev, "failed to get IRQ: %d\n", err);
 		goto poweroff;
 	}
 
@@ -1323,7 +1332,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 
 	err = request_irq(pcie->irq, tegra_pcie_isr, IRQF_SHARED, "PCIE", pcie);
 	if (err) {
-		dev_err(&pdev->dev, "failed to register IRQ: %d\n", err);
+		dev_err(dev, "failed to register IRQ: %d\n", err);
 		goto poweroff;
 	}
 
@@ -1336,6 +1345,7 @@ poweroff:
 
 static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	int err;
 
 	if (pcie->irq > 0)
@@ -1345,7 +1355,7 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 
 	err = phy_exit(pcie->phy);
 	if (err < 0)
-		dev_err(pcie->dev, "failed to teardown PHY: %d\n", err);
+		dev_err(dev, "failed to teardown PHY: %d\n", err);
 
 	return 0;
 }
@@ -1384,6 +1394,7 @@ static void tegra_msi_free(struct tegra_msi *chip, unsigned long irq)
 static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
 {
 	struct tegra_pcie *pcie = data;
+	struct device *dev = pcie->dev;
 	struct tegra_msi *msi = &pcie->msi;
 	unsigned int i, processed = 0;
 
@@ -1403,13 +1414,13 @@ static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
 				if (test_bit(index, msi->used))
 					generic_handle_irq(irq);
 				else
-					dev_info(pcie->dev, "unhandled MSI\n");
+					dev_info(dev, "unhandled MSI\n");
 			} else {
 				/*
 				 * that's weird who triggered this?
 				 * just clear it
 				 */
-				dev_info(pcie->dev, "unexpected MSI\n");
+				dev_info(dev, "unexpected MSI\n");
 			}
 
 			/* see if there's any more pending in this vector */
@@ -1488,7 +1499,8 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
+	struct device *dev = pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct tegra_msi *msi = &pcie->msi;
 	unsigned long base;
@@ -1497,20 +1509,20 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 
 	mutex_init(&msi->lock);
 
-	msi->chip.dev = pcie->dev;
+	msi->chip.dev = dev;
 	msi->chip.setup_irq = tegra_msi_setup_irq;
 	msi->chip.teardown_irq = tegra_msi_teardown_irq;
 
-	msi->domain = irq_domain_add_linear(pcie->dev->of_node, INT_PCI_MSI_NR,
+	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
 					    &msi_domain_ops, &msi->chip);
 	if (!msi->domain) {
-		dev_err(&pdev->dev, "failed to create IRQ domain\n");
+		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
 	err = platform_get_irq_byname(pdev, "msi");
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+		dev_err(dev, "failed to get IRQ: %d\n", err);
 		goto err;
 	}
 
@@ -1519,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	err = request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
 			  tegra_msi_irq_chip.name, pcie);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
+		dev_err(dev, "failed to request IRQ: %d\n", err);
 		goto err;
 	}
 
@@ -1594,46 +1606,47 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
 static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
 				      u32 *xbar)
 {
-	struct device_node *np = pcie->dev->of_node;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
 
 	if (of_device_is_compatible(np, "nvidia,tegra124-pcie")) {
 		switch (lanes) {
 		case 0x0000104:
-			dev_info(pcie->dev, "4x1, 1x1 configuration\n");
+			dev_info(dev, "4x1, 1x1 configuration\n");
 			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_X4_X1;
 			return 0;
 
 		case 0x0000102:
-			dev_info(pcie->dev, "2x1, 1x1 configuration\n");
+			dev_info(dev, "2x1, 1x1 configuration\n");
 			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_X2_X1;
 			return 0;
 		}
 	} else if (of_device_is_compatible(np, "nvidia,tegra30-pcie")) {
 		switch (lanes) {
 		case 0x00000204:
-			dev_info(pcie->dev, "4x1, 2x1 configuration\n");
+			dev_info(dev, "4x1, 2x1 configuration\n");
 			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_420;
 			return 0;
 
 		case 0x00020202:
-			dev_info(pcie->dev, "2x3 configuration\n");
+			dev_info(dev, "2x3 configuration\n");
 			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_222;
 			return 0;
 
 		case 0x00010104:
-			dev_info(pcie->dev, "4x1, 1x2 configuration\n");
+			dev_info(dev, "4x1, 1x2 configuration\n");
 			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_411;
 			return 0;
 		}
 	} else if (of_device_is_compatible(np, "nvidia,tegra20-pcie")) {
 		switch (lanes) {
 		case 0x00000004:
-			dev_info(pcie->dev, "single-mode configuration\n");
+			dev_info(dev, "single-mode configuration\n");
 			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_SINGLE;
 			return 0;
 
 		case 0x00000202:
-			dev_info(pcie->dev, "dual-mode configuration\n");
+			dev_info(dev, "dual-mode configuration\n");
 			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_DUAL;
 			return 0;
 		}
@@ -1673,7 +1686,8 @@ static bool of_regulator_bulk_available(struct device_node *np,
  */
 static int tegra_pcie_get_legacy_regulators(struct tegra_pcie *pcie)
 {
-	struct device_node *np = pcie->dev->of_node;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
 
 	if (of_device_is_compatible(np, "nvidia,tegra30-pcie"))
 		pcie->num_supplies = 3;
@@ -1681,12 +1695,12 @@ static int tegra_pcie_get_legacy_regulators(struct tegra_pcie *pcie)
 		pcie->num_supplies = 2;
 
 	if (pcie->num_supplies == 0) {
-		dev_err(pcie->dev, "device %s not supported in legacy mode\n",
+		dev_err(dev, "device %s not supported in legacy mode\n",
 			np->full_name);
 		return -ENODEV;
 	}
 
-	pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+	pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
 				      sizeof(*pcie->supplies),
 				      GFP_KERNEL);
 	if (!pcie->supplies)
@@ -1698,8 +1712,7 @@ static int tegra_pcie_get_legacy_regulators(struct tegra_pcie *pcie)
 	if (pcie->num_supplies > 2)
 		pcie->supplies[2].supply = "avdd";
 
-	return devm_regulator_bulk_get(pcie->dev, pcie->num_supplies,
-				       pcie->supplies);
+	return devm_regulator_bulk_get(dev, pcie->num_supplies, pcie->supplies);
 }
 
 /*
@@ -1713,13 +1726,14 @@ static int tegra_pcie_get_legacy_regulators(struct tegra_pcie *pcie)
  */
 static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 {
-	struct device_node *np = pcie->dev->of_node;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
 	unsigned int i = 0;
 
 	if (of_device_is_compatible(np, "nvidia,tegra124-pcie")) {
 		pcie->num_supplies = 7;
 
-		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+		pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
 					      sizeof(*pcie->supplies),
 					      GFP_KERNEL);
 		if (!pcie->supplies)
@@ -1746,7 +1760,7 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 		pcie->num_supplies = 4 + (need_pexa ? 2 : 0) +
 					 (need_pexb ? 2 : 0);
 
-		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+		pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
 					      sizeof(*pcie->supplies),
 					      GFP_KERNEL);
 		if (!pcie->supplies)
@@ -1769,7 +1783,7 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 	} else if (of_device_is_compatible(np, "nvidia,tegra20-pcie")) {
 		pcie->num_supplies = 5;
 
-		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+		pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
 					      sizeof(*pcie->supplies),
 					      GFP_KERNEL);
 		if (!pcie->supplies)
@@ -1782,9 +1796,9 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 		pcie->supplies[4].supply = "vddio-pex-clk";
 	}
 
-	if (of_regulator_bulk_available(pcie->dev->of_node, pcie->supplies,
+	if (of_regulator_bulk_available(dev->of_node, pcie->supplies,
 					pcie->num_supplies))
-		return devm_regulator_bulk_get(pcie->dev, pcie->num_supplies,
+		return devm_regulator_bulk_get(dev, pcie->num_supplies,
 					       pcie->supplies);
 
 	/*
@@ -1792,9 +1806,9 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 	 * that the device tree complies with an older version of the device
 	 * tree binding.
 	 */
-	dev_info(pcie->dev, "using legacy DT binding for power supplies\n");
+	dev_info(dev, "using legacy DT binding for power supplies\n");
 
-	devm_kfree(pcie->dev, pcie->supplies);
+	devm_kfree(dev, pcie->supplies);
 	pcie->num_supplies = 0;
 
 	return tegra_pcie_get_legacy_regulators(pcie);
@@ -1802,7 +1816,8 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 
 static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 {
-	struct device_node *np = pcie->dev->of_node, *port;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node, *port;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct of_pci_range_parser parser;
 	struct of_pci_range range;
@@ -1812,7 +1827,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 	int err;
 
 	if (of_pci_range_parser_init(&parser, np)) {
-		dev_err(pcie->dev, "missing \"ranges\" property\n");
+		dev_err(dev, "missing \"ranges\" property\n");
 		return -EINVAL;
 	}
 
@@ -1867,8 +1882,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 	err = of_pci_parse_bus_range(np, &pcie->busn);
 	if (err < 0) {
-		dev_err(pcie->dev, "failed to parse ranges property: %d\n",
-			err);
+		dev_err(dev, "failed to parse ranges property: %d\n", err);
 		pcie->busn.name = np->name;
 		pcie->busn.start = 0;
 		pcie->busn.end = 0xff;
@@ -1883,15 +1897,14 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
-			dev_err(pcie->dev, "failed to parse address: %d\n",
-				err);
+			dev_err(dev, "failed to parse address: %d\n", err);
 			return err;
 		}
 
 		index = PCI_SLOT(err);
 
 		if (index < 1 || index > soc->num_ports) {
-			dev_err(pcie->dev, "invalid port number: %d\n", index);
+			dev_err(dev, "invalid port number: %d\n", index);
 			return -EINVAL;
 		}
 
@@ -1899,13 +1912,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 		err = of_property_read_u32(port, "nvidia,num-lanes", &value);
 		if (err < 0) {
-			dev_err(pcie->dev, "failed to parse # of lanes: %d\n",
+			dev_err(dev, "failed to parse # of lanes: %d\n",
 				err);
 			return err;
 		}
 
 		if (value > 16) {
-			dev_err(pcie->dev, "invalid # of lanes: %u\n", value);
+			dev_err(dev, "invalid # of lanes: %u\n", value);
 			return -EINVAL;
 		}
 
@@ -1919,14 +1932,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		mask |= ((1 << value) - 1) << lane;
 		lane += value;
 
-		rp = devm_kzalloc(pcie->dev, sizeof(*rp), GFP_KERNEL);
+		rp = devm_kzalloc(dev, sizeof(*rp), GFP_KERNEL);
 		if (!rp)
 			return -ENOMEM;
 
 		err = of_address_to_resource(port, 0, &rp->regs);
 		if (err < 0) {
-			dev_err(pcie->dev, "failed to parse address: %d\n",
-				err);
+			dev_err(dev, "failed to parse address: %d\n", err);
 			return err;
 		}
 
@@ -1936,7 +1948,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		rp->pcie = pcie;
 		rp->np = port;
 
-		rp->base = devm_ioremap_resource(pcie->dev, &rp->regs);
+		rp->base = devm_ioremap_resource(dev, &rp->regs);
 		if (IS_ERR(rp->base))
 			return PTR_ERR(rp->base);
 
@@ -1945,7 +1957,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 	err = tegra_pcie_get_xbar_config(pcie, lanes, &pcie->xbar_config);
 	if (err < 0) {
-		dev_err(pcie->dev, "invalid lane configuration\n");
+		dev_err(dev, "invalid lane configuration\n");
 		return err;
 	}
 
@@ -1964,6 +1976,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 #define TEGRA_PCIE_LINKUP_TIMEOUT	200	/* up to 1.2 seconds */
 static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 {
+	struct device *dev = port->pcie->dev;
 	unsigned int retries = 3;
 	unsigned long value;
 
@@ -1986,8 +1999,7 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 		} while (--timeout);
 
 		if (!timeout) {
-			dev_err(port->pcie->dev, "link %u down, retrying\n",
-				port->index);
+			dev_err(dev, "link %u down, retrying\n", port->index);
 			goto retry;
 		}
 
@@ -2011,11 +2023,12 @@ retry:
 
 static int tegra_pcie_enable(struct tegra_pcie *pcie)
 {
+	struct device *dev = pcie->dev;
 	struct tegra_pcie_port *port, *tmp;
 	struct hw_pci hw;
 
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		dev_info(pcie->dev, "probing port %u, using %u lanes\n",
+		dev_info(dev, "probing port %u, using %u lanes\n",
 			 port->index, port->lanes);
 
 		tegra_pcie_port_enable(port);
@@ -2023,7 +2036,7 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
 		if (tegra_pcie_port_check_link(port))
 			continue;
 
-		dev_info(pcie->dev, "link %u down, ignoring\n", port->index);
+		dev_info(dev, "link %u down, ignoring\n", port->index);
 
 		tegra_pcie_port_disable(port);
 		tegra_pcie_port_free(port);
@@ -2041,8 +2054,7 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
 	hw.map_irq = tegra_pcie_map_irq;
 	hw.ops = &tegra_pcie_ops;
 
-	pci_common_init_dev(pcie->dev, &hw);
-
+	pci_common_init_dev(dev, &hw);
 	return 0;
 }
 
@@ -2204,17 +2216,18 @@ remove:
 
 static int tegra_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct tegra_pcie *pcie;
 	int err;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
-	pcie->soc = of_device_get_match_data(&pdev->dev);
+	pcie->soc = of_device_get_match_data(dev);
 	INIT_LIST_HEAD(&pcie->buses);
 	INIT_LIST_HEAD(&pcie->ports);
-	pcie->dev = &pdev->dev;
+	pcie->dev = dev;
 
 	err = tegra_pcie_parse_dt(pcie);
 	if (err < 0)
@@ -2222,7 +2235,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	err = tegra_pcie_get_resources(pcie);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
+		dev_err(dev, "failed to request resources: %d\n", err);
 		return err;
 	}
 
@@ -2236,24 +2249,21 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = tegra_pcie_enable_msi(pcie);
 		if (err < 0) {
-			dev_err(&pdev->dev,
-				"failed to enable MSI support: %d\n",
-				err);
+			dev_err(dev, "failed to enable MSI support: %d\n", err);
 			goto put_resources;
 		}
 	}
 
 	err = tegra_pcie_enable(pcie);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable PCIe ports: %d\n", err);
+		dev_err(dev, "failed to enable PCIe ports: %d\n", err);
 		goto disable_msi;
 	}
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err = tegra_pcie_debugfs_init(pcie);
 		if (err < 0)
-			dev_err(&pdev->dev, "failed to setup debugfs: %d\n",
-				err);
+			dev_err(dev, "failed to setup debugfs: %d\n", err);
 	}
 
 	platform_set_drvdata(pdev, pcie);

