Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1104 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeAIJUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jan 2018 04:20:42 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <cyndis@kapsi.fi>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 4/7] PCI: tegra: Free resources on probe failure
Date: Tue, 9 Jan 2018 14:49:34 +0530
Message-ID: <1515489577-2197-5-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
References: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tegra_pcie_probe() can fail in multiple instances, this patch takes care
of freeing the resources which are allocated before probe fail.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* no change in this patch
V3:
* change 'if check' to 'legacy_phy is true' for tegra_pcie_phys_put_legacy()
* commit log correction
V4:
* no change in this patch
V5:
* Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
rebased on linux-next

 drivers/pci/host/pci-tegra.c | 99 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index e4b47ebc91fe..e68507f658d8 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -562,14 +562,25 @@ static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
 	pci_add_resource(windows, &pcie->busn);
 
 	err = devm_request_pci_bus_resources(dev, windows);
-	if (err < 0)
+	if (err < 0) {
+		pci_free_resource_list(windows);
 		return err;
+	}
 
 	pci_remap_iospace(&pcie->pio, pcie->io.start);
 
 	return 0;
 }
 
+static void tegra_pcie_free_resources(struct tegra_pcie *pcie)
+{
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct list_head *windows = &host->windows;
+
+	pci_unmap_iospace(&pcie->pio);
+	pci_free_resource_list(windows);
+}
+
 static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	struct tegra_pcie *pcie = pdev->bus->sysdata;
@@ -979,24 +990,35 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 	return 0;
 }
 
-static void tegra_pcie_power_off(struct tegra_pcie *pcie)
+static void tegra_pcie_disable_controller(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
-	/* TODO: disable and unprepare clocks? */
+	reset_control_assert(pcie->pcie_xrst);
 
-	if (soc->program_uphy) {
+	if (pcie->soc->program_uphy) {
 		err = tegra_pcie_phy_power_off(pcie);
 		if (err < 0)
-			dev_err(dev, "failed to power off PHY(s): %d\n", err);
+			dev_err(pcie->dev, "failed to power off PHY(s): %d\n",
+				err);
 	}
+}
+
+static void tegra_pcie_power_off(struct tegra_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	const struct tegra_pcie_soc *soc = pcie->soc;
+	int err;
 
-	reset_control_assert(pcie->pcie_xrst);
 	reset_control_assert(pcie->afi_rst);
 	reset_control_assert(pcie->pex_rst);
 
+	clk_disable_unprepare(pcie->pll_e);
+	if (soc->has_cml_clk)
+		clk_disable_unprepare(pcie->cml_clk);
+	clk_disable_unprepare(pcie->afi_clk);
+	clk_disable_unprepare(pcie->pex_clk);
+
 	if (!dev->pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
 
@@ -1205,6 +1227,30 @@ static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
 	return 0;
 }
 
+static void tegra_pcie_phys_put(struct tegra_pcie *pcie)
+{
+	struct tegra_pcie_port *port;
+	struct device *dev = pcie->dev;
+	int err, i;
+
+	if (pcie->legacy_phy) {
+		err = phy_exit(pcie->phy);
+		if (err < 0)
+			dev_err(dev, "failed to teardown PHY: %d\n", err);
+		return;
+	}
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		for (i = 0; i < port->lanes; i++) {
+			err = phy_exit(port->phys[i]);
+			if (err < 0)
+				dev_err(dev, "failed to teardown PHY#%u: %d\n",
+					i, err);
+		}
+	}
+}
+
+
 static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1236,7 +1282,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	err = tegra_pcie_power_on(pcie);
 	if (err) {
 		dev_err(dev, "failed to power up: %d\n", err);
-		return err;
+		goto phys_put;
 	}
 
 	pads = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pads");
@@ -1288,6 +1334,9 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 
 	return 0;
 
+phys_put:
+	if (soc->program_uphy)
+		tegra_pcie_phys_put(pcie);
 poweroff:
 	tegra_pcie_power_off(pcie);
 	return err;
@@ -1295,20 +1344,15 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 
 static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
-	int err;
 
 	if (pcie->irq > 0)
 		free_irq(pcie->irq, pcie);
 
 	tegra_pcie_power_off(pcie);
 
-	if (soc->program_uphy) {
-		err = phy_exit(pcie->phy);
-		if (err < 0)
-			dev_err(dev, "failed to teardown PHY: %d\n", err);
-	}
+	if (soc->program_uphy)
+		tegra_pcie_phys_put(pcie);
 
 	return 0;
 }
@@ -2048,6 +2092,16 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 	}
 }
 
+static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
+{
+	struct tegra_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		tegra_pcie_port_disable(port);
+		tegra_pcie_port_free(port);
+	}
+}
+
 static const struct tegra_pcie_soc tegra20_pcie = {
 	.num_ports = 2,
 	.msi_base_shift = 0,
@@ -2278,7 +2332,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	err = tegra_pcie_request_resources(pcie);
 	if (err)
-		goto put_resources;
+		goto disable_controller;
 
 	/* setup the AFI address translations */
 	tegra_pcie_setup_translations(pcie);
@@ -2287,7 +2341,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		err = tegra_pcie_enable_msi(pcie);
 		if (err < 0) {
 			dev_err(dev, "failed to enable MSI support: %d\n", err);
-			goto put_resources;
+			goto free_resources;
 		}
 	}
 
@@ -2302,7 +2356,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	err = pci_scan_root_bus_bridge(host);
 	if (err < 0) {
 		dev_err(dev, "failed to register host: %d\n", err);
-		goto disable_msi;
+		goto disable_ports;
 	}
 
 	pci_bus_size_bridges(host->bus);
@@ -2321,9 +2375,14 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
-disable_msi:
+disable_ports:
+	tegra_pcie_disable_ports(pcie);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
+free_resources:
+	tegra_pcie_free_resources(pcie);
+disable_controller:
+	tegra_pcie_disable_controller(pcie);
 put_resources:
 	tegra_pcie_put_resources(pcie);
 	return err;
-- 
2.1.4
