Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Roger Quadros <rogerq@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] phy: ti-pipe3: Update pcie phy settings
Date: Mon, 9 Oct 2017 14:33:38 +0530
Message-ID: <20171009090338.26033-3-kishon@ti.com>
In-Reply-To: <20171009090338.26033-1-kishon@ti.com>
References: <20171009090338.26033-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update the PCIe phy settings based on new settings available
in AM572x Technical Reference Manual[1] Revision I, revised
April 2017 in Table 26-62 "Preferred PCIe_PHY_RX SCP Register
Settings".

[1] http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf

Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[nsekhar@ti.com: commit message updates]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/ti/phy-ti-pipe3.c | 101 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 0e564f32749f..68ce4a082b9b 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -68,6 +68,40 @@
 #define PCIE_PCS_MASK			0xFF0000
 #define PCIE_PCS_DELAY_COUNT_SHIFT	0x10
 
+#define PCIEPHYRX_ANA_PROGRAMMABILITY	0x0000000C
+#define INTERFACE_MASK			GENMASK(31, 27)
+#define INTERFACE_SHIFT			27
+#define LOSD_MASK			GENMASK(17, 14)
+#define LOSD_SHIFT			14
+#define MEM_PLLDIV			GENMASK(6, 5)
+
+#define PCIEPHYRX_TRIM			0x0000001C
+#define MEM_DLL_TRIM_SEL		GENMASK(31, 30)
+#define MEM_DLL_TRIM_SHIFT		30
+
+#define PCIEPHYRX_DLL			0x00000024
+#define MEM_DLL_PHINT_RATE		GENMASK(31, 30)
+
+#define PCIEPHYRX_DIGITAL_MODES		0x00000028
+#define MEM_CDR_FASTLOCK		BIT(23)
+#define MEM_CDR_LBW			GENMASK(22, 21)
+#define MEM_CDR_STEPCNT			GENMASK(20, 19)
+#define MEM_CDR_STL_MASK		GENMASK(18, 16)
+#define MEM_CDR_STL_SHIFT		16
+#define MEM_CDR_THR_MASK		GENMASK(15, 13)
+#define MEM_CDR_THR_SHIFT		13
+#define MEM_CDR_THR_MODE		BIT(12)
+#define MEM_CDR_CDR_2NDO_SDM_MODE	BIT(11)
+#define MEM_OVRD_HS_RATE		BIT(26)
+
+#define PCIEPHYRX_EQUALIZER		0x00000038
+#define MEM_EQLEV			GENMASK(31, 16)
+#define MEM_EQFTC			GENMASK(15, 11)
+#define MEM_EQCTL			GENMASK(10, 7)
+#define MEM_EQCTL_SHIFT			7
+#define MEM_OVRD_EQLEV			BIT(2)
+#define MEM_OVRD_EQFTC			BIT(1)
+
 /*
  * This is an Empirical value that works, need to confirm the actual
  * value required for the PIPE3PHY_PLL_CONFIGURATION2.PLL_IDLE status
@@ -91,6 +125,8 @@ struct pipe3_dpll_map {
 
 struct ti_pipe3 {
 	void __iomem		*pll_ctrl_base;
+	void __iomem		*phy_rx;
+	void __iomem		*phy_tx;
 	struct device		*dev;
 	struct device		*control_dev;
 	struct clk		*wkupclk;
@@ -261,6 +297,37 @@ static int ti_pipe3_dpll_program(struct ti_pipe3 *phy)
 	return ti_pipe3_dpll_wait_lock(phy);
 }
 
+static void ti_pipe3_calibrate(struct ti_pipe3 *phy)
+{
+	u32 val;
+
+	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY);
+	val &= ~(INTERFACE_MASK | LOSD_MASK | MEM_PLLDIV);
+	val = (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
+	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY, val);
+
+	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_DIGITAL_MODES);
+	val &= ~(MEM_CDR_STEPCNT | MEM_CDR_STL_MASK | MEM_CDR_THR_MASK |
+		 MEM_CDR_CDR_2NDO_SDM_MODE | MEM_OVRD_HS_RATE);
+	val |= (MEM_CDR_FASTLOCK | MEM_CDR_LBW | 0x3 << MEM_CDR_STL_SHIFT |
+		0x1 << MEM_CDR_THR_SHIFT | MEM_CDR_THR_MODE);
+	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_DIGITAL_MODES, val);
+
+	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_TRIM);
+	val &= ~MEM_DLL_TRIM_SEL;
+	val |= 0x2 << MEM_DLL_TRIM_SHIFT;
+	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_TRIM, val);
+
+	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_DLL);
+	val |= MEM_DLL_PHINT_RATE;
+	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_DLL, val);
+
+	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_EQUALIZER);
+	val &= ~(MEM_EQLEV | MEM_EQCTL | MEM_OVRD_EQLEV | MEM_OVRD_EQFTC);
+	val |= MEM_EQFTC | 0x1 << MEM_EQCTL_SHIFT;
+	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_EQUALIZER, val);
+}
+
 static int ti_pipe3_init(struct phy *x)
 {
 	struct ti_pipe3 *phy = phy_get_drvdata(x);
@@ -282,7 +349,12 @@ static int ti_pipe3_init(struct phy *x)
 		val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
 		ret = regmap_update_bits(phy->pcs_syscon, phy->pcie_pcs_reg,
 					 PCIE_PCS_MASK, val);
-		return ret;
+		if (ret)
+			return ret;
+
+		ti_pipe3_calibrate(phy);
+
+		return 0;
 	}
 
 	/* Bring it out of IDLE if it is IDLE */
@@ -513,6 +585,29 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 	return 0;
 }
 
+static int ti_pipe3_get_tx_rx_base(struct ti_pipe3 *phy)
+{
+	struct resource *res;
+	struct device *dev = phy->dev;
+	struct device_node *node = dev->of_node;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie"))
+		return 0;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "phy_rx");
+	phy->phy_rx = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->phy_rx))
+		return PTR_ERR(phy->phy_rx);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "phy_tx");
+	phy->phy_tx = devm_ioremap_resource(dev, res);
+
+	return PTR_ERR_OR_ZERO(phy->phy_tx);
+}
+
 static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
 {
 	struct resource *res;
@@ -559,6 +654,10 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = ti_pipe3_get_tx_rx_base(phy);
+	if (ret)
+		return ret;
+
 	ret = ti_pipe3_get_sysctrl(phy);
 	if (ret)
 		return ret;
-- 
2.11.0
