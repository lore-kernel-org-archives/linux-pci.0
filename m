Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50571 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbcAFK7f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 05:59:35 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 2/2] phy: ti-pipe3: configure usb3 phy to be used as pcie phy
Date: Wed, 6 Jan 2016 16:29:08 +0530
Message-ID: <1452077948-26232-3-git-send-email-kishon@ti.com>
In-Reply-To: <1452077948-26232-1-git-send-email-kishon@ti.com>
References: <1452077948-26232-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DRA72 uses USB3 PHY for the 2nd lane of PCIE. The configuration
required to make USB3 PHY used for the 2nd lane of PCIe is done
here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt |    2 ++
 drivers/phy/phy-ti-pipe3.c                       |   30 +++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index a3b3945..6a7de94 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -91,6 +91,8 @@ Optional properties:
    register that contains the SATA_PLL_SOFT_RESET bit. Only valid for sata_phy.
  - syscon-pcs : phandle/offset pair. Phandle to the system control module and the
    register offset to write the PCS delay value.
+ - "ti,configure-as-pcie" : property to indicate if the PHY should be
+   configured as PCIE PHY.
 
 Deprecated properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 7d83d2b..793185e 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -56,6 +56,12 @@
 
 #define SATA_PLL_SOFT_RESET	BIT(18)
 
+#define PHY_RX_ANA_PRGRAMMABILITY_REG	0xC
+#define MEM_EN_PLLBYP			BIT(7)
+
+#define PHY_TX_TEST_CONFIG	0x2C
+#define MEM_ENTESTCLK		BIT(31)
+
 #define PIPE3_PHY_PWRCTL_CLK_CMD_MASK	0x003FC000
 #define PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT	14
 
@@ -68,6 +74,10 @@
 #define PCIE_PCS_MASK			0xFF0000
 #define PCIE_PCS_DELAY_COUNT_SHIFT	0x10
 
+#define PIPE3_PHY_DISABLE_SYNC_POWER	BIT(4)
+
+#define CONFIGURE_AS_PCIE		BIT(0)
+
 /*
  * This is an Empirical value that works, need to confirm the actual
  * value required for the PIPE3PHY_PLL_CONFIGURATION2.PLL_IDLE status
@@ -90,6 +100,7 @@ struct pipe3_dpll_map {
 };
 
 struct ti_pipe3 {
+	u32			flags;
 	void __iomem		*pll_ctrl_base;
 	void __iomem		*phy_rx;
 	void __iomem		*phy_tx;
@@ -270,6 +281,19 @@ static int ti_pipe3_init(struct phy *x)
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
@@ -318,7 +342,8 @@ static int ti_pipe3_exit(struct phy *x)
 		return 0;
 
 	/* PCIe doesn't have internal DPLL */
-	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
+	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie") &&
+			!(phy->flags & CONFIGURE_AS_PCIE)) {
 		/* Put DPLL in IDLE mode */
 		val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
 		val |= PLL_IDLE;
@@ -590,6 +615,9 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(node, "ti,configure-as-pcie"))
+		phy->flags |= CONFIGURE_AS_PCIE;
+
 	platform_set_drvdata(pdev, phy);
 	pm_runtime_enable(dev);
 
-- 
1.7.9.5

