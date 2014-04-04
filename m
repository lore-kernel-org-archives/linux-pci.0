Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14031 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbaDDOuP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 10:50:15 -0400
From: Thierry Reding <treding@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [RFC 3/5] PCI: tegra: Implement accurate power supply scheme
Date: Fri, 4 Apr 2014 16:49:27 +0200
Message-ID: <1396622969-17837-4-git-send-email-treding@nvidia.com>
In-Reply-To: <1396622969-17837-1-git-send-email-treding@nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current description of power supplies doesn't match the hardware.
Instead it's designed to support the needs of current designs, which
will break as soon as a new design appears that cannot be described
using the current assumptions.

In order to fully support all possible future designs, all power supply
inputs to the PCIe block need to be accurately described and separately
configurable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 146 ++++++++++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 59 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 5f334e69e608..2be7b9bce12e 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -234,7 +234,6 @@ struct tegra_pcie_soc_data {
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
-	bool has_avdd_supply;
 	bool has_cml_clk;
 };
 
@@ -275,9 +274,8 @@ struct tegra_pcie {
 	unsigned int num_ports;
 	u32 xbar_config;
 
-	struct regulator *pex_clk_supply;
-	struct regulator *vdd_supply;
-	struct regulator *avdd_supply;
+	struct regulator_bulk_data *supplies;
+	unsigned int num_supplies;
 
 	const struct tegra_pcie_soc_data *soc_data;
 	struct dentry *debugfs;
@@ -919,7 +917,6 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 
 static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 {
-	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
 	int err;
 
 	/* TODO: disable and unprepare clocks? */
@@ -930,23 +927,9 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 
 	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
 
-	if (soc->has_avdd_supply) {
-		err = regulator_disable(pcie->avdd_supply);
-		if (err < 0)
-			dev_warn(pcie->dev,
-				 "failed to disable AVDD regulator: %d\n",
-				 err);
-	}
-
-	err = regulator_disable(pcie->pex_clk_supply);
+	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
-		dev_warn(pcie->dev, "failed to disable pex-clk regulator: %d\n",
-			 err);
-
-	err = regulator_disable(pcie->vdd_supply);
-	if (err < 0)
-		dev_warn(pcie->dev, "failed to disable VDD regulator: %d\n",
-			 err);
+		dev_warn(pcie->dev, "failed to enable regulators: %d\n", err);
 }
 
 static int tegra_pcie_power_on(struct tegra_pcie *pcie)
@@ -961,28 +944,9 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
 
 	/* enable regulators */
-	err = regulator_enable(pcie->vdd_supply);
-	if (err < 0) {
-		dev_err(pcie->dev, "failed to enable VDD regulator: %d\n", err);
-		return err;
-	}
-
-	err = regulator_enable(pcie->pex_clk_supply);
-	if (err < 0) {
-		dev_err(pcie->dev, "failed to enable pex-clk regulator: %d\n",
-			err);
-		return err;
-	}
-
-	if (soc->has_avdd_supply) {
-		err = regulator_enable(pcie->avdd_supply);
-		if (err < 0) {
-			dev_err(pcie->dev,
-				"failed to enable AVDD regulator: %d\n",
-				err);
-			return err;
-		}
-	}
+	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
+	if (err < 0)
+		dev_err(pcie->dev, "failed to enable regulators: %d\n", err);
 
 	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
 						pcie->pex_clk,
@@ -1419,6 +1383,82 @@ static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
 	return -EINVAL;
 }
 
+/*
+ * Obtains the list of regulators required for a particular generation of the
+ * IP block.
+ *
+ * This would've been nice to do simply by providing static tables for use
+ * with the regulator_bulk_*() API, but unfortunately Tegra30 is a bit quirky
+ * in that it has two pairs or AVDD_PEX and VDD_PEX supplies (PEXA and PEXB)
+ * and either seems to be optional depending on which ports are being used.
+ */
+static int tegra_pcie_get_regulators(struct tegra_pcie *pcie)
+{
+	struct device_node *np = pcie->dev->of_node;
+	unsigned int i = 0;
+
+	if (of_device_is_compatible(np, "nvidia,tegra30-pcie")) {
+		bool need_pexa = false, need_pexb = false;
+		struct tegra_pcie_port *port;
+
+		list_for_each_entry(port, &pcie->ports, list) {
+			dev_info(pcie->dev, "port %u enabled\n", port->index);
+
+			switch (port->index) {
+			case 0:
+				need_pexa = true;
+				break;
+
+			case 1:
+			case 2:
+				need_pexb = true;
+				break;
+			}
+		}
+
+		pcie->num_supplies = 4 + (need_pexa ? 2 : 0) +
+					 (need_pexb ? 2 : 0);
+
+		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+					      sizeof(*pcie->supplies),
+					      GFP_KERNEL);
+		if (!pcie->supplies)
+			return -ENOMEM;
+
+		pcie->supplies[i++].supply = "avdd-pex-pll";
+		pcie->supplies[i++].supply = "hvdd-pex";
+		pcie->supplies[i++].supply = "vddio-pex-ctl";
+		pcie->supplies[i++].supply = "avdd-plle";
+
+		if (need_pexa) {
+			pcie->supplies[i++].supply = "avdd-pexa";
+			pcie->supplies[i++].supply = "vdd-pexa";
+		}
+
+		if (need_pexb) {
+			pcie->supplies[i++].supply = "avdd-pexb";
+			pcie->supplies[i++].supply = "vdd-pexb";
+		}
+	} else if (of_device_is_compatible(np, "nvidia,tegra20-pcie")) {
+		pcie->num_supplies = 5;
+
+		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+					      sizeof(*pcie->supplies),
+					      GFP_KERNEL);
+		if (!pcie->supplies)
+			return -ENOMEM;
+
+		pcie->supplies[0].supply = "avdd-pex";
+		pcie->supplies[1].supply = "vdd-pex";
+		pcie->supplies[2].supply = "avdd-pex-pll";
+		pcie->supplies[3].supply = "avdd-plle";
+		pcie->supplies[4].supply = "vddio-pex-clk";
+	}
+
+	return devm_regulator_bulk_get(pcie->dev, pcie->num_supplies,
+				       pcie->supplies);
+}
+
 static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 {
 	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
@@ -1440,20 +1480,6 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		return -EINVAL;
 	}
 
-	pcie->vdd_supply = devm_regulator_get(pcie->dev, "vdd");
-	if (IS_ERR(pcie->vdd_supply))
-		return PTR_ERR(pcie->vdd_supply);
-
-	pcie->pex_clk_supply = devm_regulator_get(pcie->dev, "pex-clk");
-	if (IS_ERR(pcie->pex_clk_supply))
-		return PTR_ERR(pcie->pex_clk_supply);
-
-	if (soc->has_avdd_supply) {
-		pcie->avdd_supply = devm_regulator_get(pcie->dev, "avdd");
-		if (IS_ERR(pcie->avdd_supply))
-			return PTR_ERR(pcie->avdd_supply);
-	}
-
 	for_each_of_pci_range(&parser, &range) {
 		of_pci_range_to_resource(&range, np, &res);
 
@@ -1563,6 +1589,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		return err;
 	}
 
+	err = tegra_pcie_get_regulators(pcie);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -1658,7 +1688,6 @@ static const struct tegra_pcie_soc_data tegra20_pcie_data = {
 	.has_pex_clkreq_en = false,
 	.has_pex_bias_ctrl = false,
 	.has_intr_prsnt_sense = false,
-	.has_avdd_supply = false,
 	.has_cml_clk = false,
 };
 
@@ -1670,7 +1699,6 @@ static const struct tegra_pcie_soc_data tegra30_pcie_data = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_avdd_supply = true,
 	.has_cml_clk = true,
 };
 
-- 
1.9.1

