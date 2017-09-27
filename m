Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14594 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbdI0MAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2017 08:00:42 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mperttunen@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 2/4] PCI: tegra: Add Tegra186 PCIe support
Date: Wed, 27 Sep 2017 17:28:35 +0530
Message-ID: <1506513517-25870-3-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
References: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

UPHY programming is performed by BPMP, PHY enable calls are
not required for Tegra186 PCIe. Power partition ungate is
done by BPMP powergate driver.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
---
V2: Add soc->program_uphy check for phy_exit call
 drivers/pci/host/pci-tegra.c | 132 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 108 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 9c40da54f88a..96e8038c3019 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -159,10 +159,13 @@
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_SINGLE	(0x0 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_420	(0x0 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_X2_X1	(0x0 << 20)
+#define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_401	(0x0 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_DUAL	(0x1 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_222	(0x1 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_X4_X1	(0x1 << 20)
+#define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_211	(0x1 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_411	(0x2 << 20)
+#define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_111	(0x2 << 20)
 
 #define AFI_FUSE			0x104
 #define  AFI_FUSE_PCIE_T0_GEN2_DIS	(1 << 2)
@@ -252,6 +255,7 @@ struct tegra_pcie_soc {
 	bool has_cml_clk;
 	bool has_gen2;
 	bool force_pca_enable;
+	bool program_uphy;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -1012,10 +1016,12 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		afi_writel(pcie, value, AFI_FUSE);
 	}
 
-	err = tegra_pcie_phy_power_on(pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to power on PHY(s): %d\n", err);
-		return err;
+	if (soc->program_uphy) {
+		err = tegra_pcie_phy_power_on(pcie);
+		if (err < 0) {
+			dev_err(dev, "failed to power on PHY(s): %d\n", err);
+			return err;
+		}
 	}
 
 	/* take the PCIe interface module out of reset */
@@ -1048,19 +1054,23 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
+	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
 	/* TODO: disable and unprepare clocks? */
 
-	err = tegra_pcie_phy_power_off(pcie);
-	if (err < 0)
-		dev_err(dev, "failed to power off PHY(s): %d\n", err);
+	if (soc->program_uphy) {
+		err = tegra_pcie_phy_power_off(pcie);
+		if (err < 0)
+			dev_err(dev, "failed to power off PHY(s): %d\n", err);
+	}
 
 	reset_control_assert(pcie->pcie_xrst);
 	reset_control_assert(pcie->afi_rst);
 	reset_control_assert(pcie->pex_rst);
 
-	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
+	if (!dev->pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
 
 	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
@@ -1077,19 +1087,29 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	reset_control_assert(pcie->afi_rst);
 	reset_control_assert(pcie->pex_rst);
 
-	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
+	if (!dev->pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
 
 	/* enable regulators */
 	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
 		dev_err(dev, "failed to enable regulators: %d\n", err);
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
-						pcie->pex_clk,
-						pcie->pex_rst);
-	if (err) {
-		dev_err(dev, "powerup sequence failed: %d\n", err);
-		return err;
+	if (dev->pm_domain) {
+		err = clk_prepare_enable(pcie->pex_clk);
+		if (err) {
+			dev_err(dev, "failed to enable PEX clock: %d\n", err);
+			return err;
+		}
+		reset_control_deassert(pcie->pex_rst);
+	} else {
+		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
+							pcie->pex_clk,
+							pcie->pex_rst);
+		if (err) {
+			dev_err(dev, "powerup sequence failed: %d\n", err);
+			return err;
+		}
 	}
 
 	reset_control_deassert(pcie->afi_rst);
@@ -1262,6 +1282,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *pads, *afi, *res;
+	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
 	err = tegra_pcie_clocks_get(pcie);
@@ -1276,10 +1297,12 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 		return err;
 	}
 
-	err = tegra_pcie_phys_get(pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to get PHYs: %d\n", err);
-		return err;
+	if (soc->program_uphy) {
+		err = tegra_pcie_phys_get(pcie);
+		if (err < 0) {
+			dev_err(dev, "failed to get PHYs: %d\n", err);
+			return err;
+		}
 	}
 
 	err = tegra_pcie_power_on(pcie);
@@ -1341,6 +1364,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
+	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
 	if (pcie->irq > 0)
@@ -1348,9 +1372,11 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 
 	tegra_pcie_power_off(pcie);
 
-	err = phy_exit(pcie->phy);
-	if (err < 0)
-		dev_err(dev, "failed to teardown PHY: %d\n", err);
+	if (soc->program_uphy) {
+		err = phy_exit(pcie->phy);
+		if (err < 0)
+			dev_err(dev, "failed to teardown PHY: %d\n", err);
+	}
 
 	return 0;
 }
@@ -1616,7 +1642,31 @@ static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
 	struct device *dev = pcie->dev;
 	struct device_node *np = dev->of_node;
 
-	if (of_device_is_compatible(np, "nvidia,tegra124-pcie") ||
+	if (of_device_is_compatible(np, "nvidia,tegra186-pcie")) {
+		switch (lanes) {
+		case 0x010004:
+			dev_info(dev, "4x1, 1x1 configuration\n");
+			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_401;
+			return 0;
+
+		case 0x010102:
+			dev_info(dev, "2x1, 1X1, 1x1 configuration\n");
+			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_211;
+			return 0;
+
+		case 0x010101:
+			dev_info(dev, "1x1, 1x1, 1x1 configuration\n");
+			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_111;
+			return 0;
+
+		default:
+			dev_info(dev, "wrong configuration updated in DT, "
+				 "switching to default 2x1, 1x1, 1x1 "
+				 "configuration\n");
+			*xbar = AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_211;
+			return 0;
+		}
+	} else if (of_device_is_compatible(np, "nvidia,tegra124-pcie") ||
 	    of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
 		switch (lanes) {
 		case 0x0000104:
@@ -1737,7 +1787,20 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 	struct device_node *np = dev->of_node;
 	unsigned int i = 0;
 
-	if (of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
+	if (of_device_is_compatible(np, "nvidia,tegra186-pcie")) {
+		pcie->num_supplies = 4;
+
+		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+					      sizeof(*pcie->supplies),
+					      GFP_KERNEL);
+		if (!pcie->supplies)
+			return -ENOMEM;
+
+		pcie->supplies[i++].supply = "dvdd-pex";
+		pcie->supplies[i++].supply = "hvdd-pex-pll";
+		pcie->supplies[i++].supply = "hvdd-pex";
+		pcie->supplies[i++].supply = "vddio-pexctl-aud";
+	} else if (of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
 		pcie->num_supplies = 6;
 
 		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
@@ -2076,6 +2139,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_cml_clk = false,
 	.has_gen2 = false,
 	.force_pca_enable = false,
+	.program_uphy = true,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2091,6 +2155,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_cml_clk = true,
 	.has_gen2 = false,
 	.force_pca_enable = false,
+	.program_uphy = true,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2105,6 +2170,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_cml_clk = true,
 	.has_gen2 = true,
 	.force_pca_enable = false,
+	.program_uphy = true,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2119,9 +2185,27 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_cml_clk = true,
 	.has_gen2 = true,
 	.force_pca_enable = true,
+	.program_uphy = true,
+};
+
+static const struct tegra_pcie_soc tegra186_pcie = {
+	.num_ports = 3,
+	.msi_base_shift = 8,
+	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
+	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
+	.pads_refclk_cfg0 = 0x80b880b8,
+	.pads_refclk_cfg1 = 0x000480b8,
+	.has_pex_clkreq_en = true,
+	.has_pex_bias_ctrl = true,
+	.has_intr_prsnt_sense = true,
+	.has_cml_clk = false,
+	.has_gen2 = true,
+	.force_pca_enable = false,
+	.program_uphy = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
+	{ .compatible = "nvidia,tegra186-pcie", .data = &tegra186_pcie },
 	{ .compatible = "nvidia,tegra210-pcie", .data = &tegra210_pcie },
 	{ .compatible = "nvidia,tegra124-pcie", .data = &tegra124_pcie },
 	{ .compatible = "nvidia,tegra30-pcie", .data = &tegra30_pcie },
-- 
2.1.4
