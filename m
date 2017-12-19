Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:35489 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965627AbdLSJqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 04:46:01 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <kishon@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: [PATCH 2/2] phy: ti-pipe3: configure usb3 phy to be used as pcie phy
Date: Tue, 19 Dec 2017 15:15:40 +0530
Message-ID: <20171219094540.18432-3-kishon@ti.com>
In-Reply-To: <20171219094540.18432-1-kishon@ti.com>
References: <20171219094540.18432-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DRA72 uses USB3 PHY for the 2nd lane of PCIE. The configuration
required to make USB3 PHY used for the 2nd lane of PCIe is done
here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-ti-pipe3.c | 47 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 68ce4a082b9b..d5a7cc435fb7 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -56,6 +56,12 @@
 
 #define SATA_PLL_SOFT_RESET	BIT(18)
 
+#define PHY_RX_ANA_PRGRAMMABILITY_REG	0xC
+#define MEM_EN_PLLBYP			BIT(7)
+
+#define PHY_TX_TEST_CONFIG		0x2C
+#define MEM_ENTESTCLK			BIT(31)
+
 #define PIPE3_PHY_PWRCTL_CLK_CMD_MASK	0x003FC000
 #define PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT	14
 
@@ -110,6 +116,10 @@
 #define PLL_IDLE_TIME	100	/* in milliseconds */
 #define PLL_LOCK_TIME	100	/* in milliseconds */
 
+#define PIPE3_PHY_DISABLE_SYNC_POWER	BIT(4)
+
+#define CONFIGURE_AS_PCIE		BIT(0)
+
 struct pipe3_dpll_params {
 	u16	m;
 	u8	n;
@@ -141,6 +151,7 @@ struct ti_pipe3 {
 	unsigned int		power_reg; /* power reg. index within syscon */
 	unsigned int		pcie_pcs_reg; /* pcs reg. index in syscon */
 	bool			sata_refclk_enabled;
+	u32			flags;
 };
 
 static struct pipe3_dpll_map dpll_map_usb[] = {
@@ -233,11 +244,22 @@ static int ti_pipe3_power_on(struct phy *x)
 	rate = rate / 1000000;
 	mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK |
 		  OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK;
-	val = PIPE3_PHY_TX_RX_POWERON << PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
+	val = PIPE3_PHY_TX_RX_POWERON;
+	if (phy->flags & CONFIGURE_AS_PCIE)
+		val |= PIPE3_PHY_DISABLE_SYNC_POWER;
+	val <<= PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
 	val |= rate << OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
 
 	ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
 				 mask, val);
+
+	if (phy->flags & CONFIGURE_AS_PCIE) {
+		ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
+					 mask, val);
+		if (ret < 0)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -335,6 +357,19 @@ static int ti_pipe3_init(struct phy *x)
 	int ret = 0;
 
 	ti_pipe3_enable_clocks(phy);
+
+	if (phy->flags & CONFIGURE_AS_PCIE) {
+		val = ti_pipe3_readl(phy->phy_rx,
+				     PHY_RX_ANA_PRGRAMMABILITY_REG);
+		val |= MEM_EN_PLLBYP;
+		ti_pipe3_writel(phy->phy_rx, PHY_RX_ANA_PRGRAMMABILITY_REG,
+				val);
+		val = ti_pipe3_readl(phy->phy_tx, PHY_TX_TEST_CONFIG);
+		val |= MEM_ENTESTCLK;
+		ti_pipe3_writel(phy->phy_tx, PHY_TX_TEST_CONFIG, val);
+		return 0;
+	}
+
 	/*
 	 * Set pcie_pcs register to 0x96 for proper functioning of phy
 	 * as recommended in AM572x TRM SPRUHZ6, section 18.5.2.2, table
@@ -395,7 +430,8 @@ static int ti_pipe3_exit(struct phy *x)
 		return 0;
 
 	/* PCIe doesn't have internal DPLL */
-	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
+	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie") &&
+	    !(phy->flags & CONFIGURE_AS_PCIE)) {
 		/* Put DPLL in IDLE mode */
 		val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
 		val |= PLL_IDLE;
@@ -589,12 +625,8 @@ static int ti_pipe3_get_tx_rx_base(struct ti_pipe3 *phy)
 {
 	struct resource *res;
 	struct device *dev = phy->dev;
-	struct device_node *node = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 
-	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie"))
-		return 0;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "phy_rx");
 	phy->phy_rx = devm_ioremap_resource(dev, res);
@@ -666,6 +698,9 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(node, "ti,configure-as-pcie"))
+		phy->flags |= CONFIGURE_AS_PCIE;
+
 	platform_set_drvdata(pdev, phy);
 	pm_runtime_enable(dev);
 
-- 
2.11.0
