Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59883 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933386AbbLOJRA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Dec 2015 04:17:00 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <tony@atomide.com>, <t-kristo@ti.com>
Subject: [PATCH v3 7/9] phy: ti-pipe3: use *syscon* framework API to set PCS value of the PHY
Date: Tue, 15 Dec 2015 14:46:06 +0530
Message-ID: <1450170968-11282-8-git-send-email-kishon@ti.com>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Deprecate using phy-omap-control driver to set PCS value of the PHY
and start using *syscon* API to do the same.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt |    2 ++
 drivers/phy/phy-ti-pipe3.c                       |   34 +++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index e06f980..49e5b0c 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -83,6 +83,8 @@ Optional properties:
  - syscon-pllreset: Handle to system control region that contains the
    CTRL_CORE_SMA_SW_0 register and register offset to the CTRL_CORE_SMA_SW_0
    register that contains the SATA_PLL_SOFT_RESET bit. Only valid for sata_phy.
+ - syscon-pcs : phandle/offset pair. Phandle to the system control module and the
+   register offset to write the PCS delay value.
 
 Deprecated properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index bc03625..684d467 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -65,6 +65,9 @@
 #define PIPE3_PHY_TX_RX_POWERON		0x3
 #define PIPE3_PHY_TX_RX_POWEROFF	0x0
 
+#define PCIE_PCS_MASK			0xFF0000
+#define PCIE_PCS_DELAY_COUNT_SHIFT	0x10
+
 /*
  * This is an Empirical value that works, need to confirm the actual
  * value required for the PIPE3PHY_PLL_CONFIGURATION2.PLL_IDLE status
@@ -96,9 +99,11 @@ struct ti_pipe3 {
 	struct clk		*div_clk;
 	struct pipe3_dpll_map	*dpll_map;
 	struct regmap		*phy_power_syscon; /* ctrl. reg. acces */
+	struct regmap		*pcs_syscon; /* ctrl. reg. acces */
 	struct regmap		*dpll_reset_syscon; /* ctrl. reg. acces */
 	unsigned int		dpll_reset_reg; /* reg. index within syscon */
 	unsigned int		power_reg; /* power reg. index within syscon */
+	unsigned int		pcie_pcs_reg; /* pcs reg. index in syscon */
 	bool			sata_refclk_enabled;
 };
 
@@ -275,7 +280,16 @@ static int ti_pipe3_init(struct phy *x)
 	 * 18-1804.
 	 */
 	if (of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
-		omap_control_pcie_pcs(phy->control_dev, 0x96);
+		if (phy->pcs_syscon) {
+			val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
+			ret = regmap_update_bits(phy->pcs_syscon,
+						 phy->pcie_pcs_reg,
+						 PCIE_PCS_MASK, val);
+			if (ret < 0)
+				return ret;
+		} else {
+			omap_control_pcie_pcs(phy->control_dev, 0x96);
+		}
 		return 0;
 	}
 
@@ -461,6 +475,24 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 		phy->control_dev = &control_pdev->dev;
 	}
 
+	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
+		phy->pcs_syscon = syscon_regmap_lookup_by_phandle(node,
+								  "syscon-pcs");
+		if (IS_ERR(phy->pcs_syscon)) {
+			dev_dbg(dev,
+				"can't get syscon-pcs, using omap control\n");
+			phy->pcs_syscon = NULL;
+		} else {
+			if (of_property_read_u32_index(node,
+						       "syscon-pcs", 1,
+						       &phy->pcie_pcs_reg)) {
+				dev_err(dev,
+					"couldn't get pcie pcs reg. offset\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	if (of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
 		phy->dpll_reset_syscon = syscon_regmap_lookup_by_phandle(node,
 							"syscon-pllreset");
-- 
1.7.9.5

