Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Trent Piepho <tpiepho@impinj.com>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] PCI: imx: Add workaround for e10728,
 IMX7d PCIe PLL failure
Date: Wed, 18 Jul 2018 12:44:24 -0700
Message-Id: <20180718194424.8844-3-tpiepho@impinj.com>
In-Reply-To: <20180718194424.8844-1-tpiepho@impinj.com>
References: <20180718194424.8844-1-tpiepho@impinj.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Trent Piepho <tpiepho@impinj.com>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This implements the workound described in the NXP IMX7d erratum e10728.

Initial VCO oscillation may fail under corner conditions such as cold
temperature.  It causes PCIe PLL to fail to lock in the initialization
phase, which results in the PCIe link failing to come up.

The workaround is to disable Duty-cycle Corrector (DCC) calibration
after G_RST.

To do this it is necessary to gain access to the undocumented and
currently unused PCIe PHY register bank.  A new device tree node of type
"fsl,imx-pcie-phy" is created for the PHY block and the existing PCIe
device uses a phandle named "fsl,pcie-phy" to point to it.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/pci/dwc/pci-imx6.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index dcf389b62944..32429afc9380 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -58,6 +59,7 @@ struct imx6_pcie {
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+	void __iomem		*phy_base;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -98,6 +100,23 @@ struct imx6_pcie {
 #define PCIE_PHY_RX_ASIC_OUT 0x100D
 #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
 
+/* iMX7 PCIe PHY registers */
+#define PCIE_PHY_CMN_REG4		0x14
+/* These are probably the bits that *aren't* DCC_FB_EN */
+#define PCIE_PHY_CMN_REG4_DCC_FB_EN	0x29
+
+#define PCIE_PHY_CMN_REG15	        0x54
+#define PCIE_PHY_CMN_REG15_DLY_4	BIT(2)
+#define PCIE_PHY_CMN_REG15_PLL_PD	BIT(5)
+#define PCIE_PHY_CMN_REG15_OVRD_PLL_PD	BIT(7)
+
+#define PCIE_PHY_CMN_REG24		0x90
+#define PCIE_PHY_CMN_REG24_RX_EQ	BIT(6)
+#define PCIE_PHY_CMN_REG24_RX_EQ_SEL	BIT(3)
+
+#define PCIE_PHY_CMN_REG26		0x98
+#define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
+
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
@@ -431,6 +450,26 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->variant) {
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
+
+		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
+		 * oscillate, especially when cold.  This turns off "Duty-cycle
+		 * Corrector" and other mysterious undocumented things.
+		 */
+		if (likely(imx6_pcie->phy_base)) {
+			/* De-assert DCC_FB_EN */
+			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
+			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
+			/* Assert RX_EQS and RX_EQS_SEL */
+			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
+				| PCIE_PHY_CMN_REG24_RX_EQ,
+			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
+			/* Assert ATT_MODE */
+			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
+			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
+		} else {
+			dev_err(dev, "PHY base address not set\n");
+		}
+
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
 		break;
 	case IMX6SX:
@@ -698,6 +737,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
+	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
@@ -717,6 +757,25 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	imx6_pcie->variant =
 		(enum imx6_pcie_variants)of_device_get_match_data(dev);
 
+	/* Find the PHY if one is defined, only imx7d uses it */
+	np = of_parse_phandle(node, "fsl,pcie-phy", 0);
+	if (np) {
+		struct resource res;
+
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret) {
+			dev_err(dev, "Unable to map PCIe PHY\n");
+			return ret;
+		}
+		imx6_pcie->phy_base = devm_ioremap_resource(dev, &res);
+		if (IS_ERR(imx6_pcie->phy_base)) {
+			dev_err(dev, "Unable to map PCIe PHY\n");
+			return PTR_ERR(imx6_pcie->phy_base);
+		}
+	} else {
+		imx6_pcie->phy_base = NULL;
+	}
+
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base))
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
