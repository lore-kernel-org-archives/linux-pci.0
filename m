Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35362 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbaE1Ov5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 10:51:57 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 3/5] PCI: tegra: Implement accurate power supply scheme
Date: Wed, 28 May 2014 16:49:13 +0200
Message-Id: <1401288555-24197-4-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
References: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The current description of power supplies doesn't match the hardware.
Instead it's designed to support the needs of current designs, which
will break as soon as a new design appears that cannot be described
using the current assumptions.

In order to fully support all possible future designs, all power supply
inputs to the PCIe block need to be accurately described and separately
configurable.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix typo "enable" -> "disable"

 drivers/pci/host/pci-tegra.c | 148 +++++++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 083cf37ca047..7df5aaf58921 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -233,7 +233,6 @@ struct tegra_pcie_soc_data {
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
-	bool has_avdd_supply;
 	bool has_cml_clk;
 };
 
@@ -272,9 +271,8 @@ struct tegra_pcie {
 	unsigned int num_ports;
 	u32 xbar_config;
 
-	struct regulator *pex_clk_supply;
-	struct regulator *vdd_supply;
-	struct regulator *avdd_supply;
+	struct regulator_bulk_data *supplies;
+	unsigned int num_supplies;
 
 	const struct tegra_pcie_soc_data *soc_data;
 };
@@ -894,7 +892,6 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 
 static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 {
-	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
 	int err;
 
 	/* TODO: disable and unprepare clocks? */
@@ -905,23 +902,9 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 
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
+		dev_warn(pcie->dev, "failed to disable regulators: %d\n", err);
 }
 
 static int tegra_pcie_power_on(struct tegra_pcie *pcie)
@@ -936,28 +919,9 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
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
@@ -1394,14 +1358,83 @@ static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
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
+static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
+{
+	struct device_node *np = pcie->dev->of_node;
+	unsigned int i = 0;
+
+	if (of_device_is_compatible(np, "nvidia,tegra30-pcie")) {
+		bool need_pexa = false, need_pexb = false;
+
+		/* VDD_PEXA and AVDD_PEXA supply lanes 0 to 3 */
+		if (lane_mask & 0x0f)
+			need_pexa = true;
+
+		/* VDD_PEXB and AVDD_PEXB supply lanes 4 to 5 */
+		if (lane_mask & 0x30)
+			need_pexb = true;
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
 	struct device_node *np = pcie->dev->of_node, *port;
 	struct of_pci_range_parser parser;
 	struct of_pci_range range;
+	u32 lanes = 0, mask = 0;
+	unsigned int lane = 0;
 	struct resource res;
-	u32 lanes = 0;
 	int err;
 
 	if (of_pci_range_parser_init(&parser, np)) {
@@ -1409,20 +1442,6 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
 
@@ -1490,8 +1509,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 		lanes |= value << (index << 3);
 
-		if (!of_device_is_available(port))
+		if (!of_device_is_available(port)) {
+			lane += value;
 			continue;
+		}
+
+		mask |= ((1 << value) - 1) << lane;
+		lane += value;
 
 		rp = devm_kzalloc(pcie->dev, sizeof(*rp), GFP_KERNEL);
 		if (!rp)
@@ -1522,6 +1546,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		return err;
 	}
 
+	err = tegra_pcie_get_regulators(pcie, mask);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -1615,7 +1643,6 @@ static const struct tegra_pcie_soc_data tegra20_pcie_data = {
 	.has_pex_clkreq_en = false,
 	.has_pex_bias_ctrl = false,
 	.has_intr_prsnt_sense = false,
-	.has_avdd_supply = false,
 	.has_cml_clk = false,
 };
 
@@ -1627,7 +1654,6 @@ static const struct tegra_pcie_soc_data tegra30_pcie_data = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_avdd_supply = true,
 	.has_cml_clk = true,
 };
 
-- 
1.9.2

