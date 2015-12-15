Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59859 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932262AbbLOJQl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Dec 2015 04:16:41 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <tony@atomide.com>, <t-kristo@ti.com>
Subject: [PATCH v3 2/9] phy: ti-pipe3: move clk initialization to a separate function
Date: Tue, 15 Dec 2015 14:46:01 +0530
Message-ID: <1450170968-11282-3-git-send-email-kishon@ti.com>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Moved clock initialization done in probe to a
separate function as part of cleaning up ti_pipe3_probe.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-ti-pipe3.c |  127 +++++++++++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 55 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index c511105..3379a4d 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -308,48 +308,11 @@ static const struct phy_ops ops = {
 
 static const struct of_device_id ti_pipe3_id_table[];
 
-static int ti_pipe3_probe(struct platform_device *pdev)
+static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 {
-	struct ti_pipe3 *phy;
-	struct phy *generic_phy;
-	struct phy_provider *phy_provider;
-	struct resource *res;
-	struct device_node *node = pdev->dev.of_node;
-	struct device_node *control_node;
-	struct platform_device *control_pdev;
-	const struct of_device_id *match;
 	struct clk *clk;
-	struct device *dev = &pdev->dev;
-
-	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
-
-	phy->dev		= dev;
-
-	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
-		match = of_match_device(ti_pipe3_id_table, dev);
-		if (!match)
-			return -EINVAL;
-
-		phy->dpll_map = (struct pipe3_dpll_map *)match->data;
-		if (!phy->dpll_map) {
-			dev_err(dev, "no DPLL data\n");
-			return -EINVAL;
-		}
-
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "pll_ctrl");
-		phy->pll_ctrl_base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(phy->pll_ctrl_base))
-			return PTR_ERR(phy->pll_ctrl_base);
-
-		phy->sys_clk = devm_clk_get(dev, "sysclk");
-		if (IS_ERR(phy->sys_clk)) {
-			dev_err(dev, "unable to get sysclk\n");
-			return -EINVAL;
-		}
-	}
+	struct device *dev = phy->dev;
+	struct device_node *node = dev->of_node;
 
 	phy->refclk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(phy->refclk)) {
@@ -369,25 +332,17 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 		}
 	} else {
 		phy->wkupclk = ERR_PTR(-ENODEV);
-		phy->dpll_reset_syscon = syscon_regmap_lookup_by_phandle(node,
-							"syscon-pllreset");
-		if (IS_ERR(phy->dpll_reset_syscon)) {
-			dev_info(dev,
-				 "can't get syscon-pllreset, sata dpll won't idle\n");
-			phy->dpll_reset_syscon = NULL;
-		} else {
-			if (of_property_read_u32_index(node,
-						       "syscon-pllreset", 1,
-						       &phy->dpll_reset_reg)) {
-				dev_err(dev,
-					"couldn't get pllreset reg. offset\n");
-				return -EINVAL;
-			}
+	}
+
+	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
+		phy->sys_clk = devm_clk_get(dev, "sysclk");
+		if (IS_ERR(phy->sys_clk)) {
+			dev_err(dev, "unable to get sysclk\n");
+			return -EINVAL;
 		}
 	}
 
 	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
-
 		clk = devm_clk_get(dev, "dpll_ref");
 		if (IS_ERR(clk)) {
 			dev_err(dev, "unable to get dpll ref clk\n");
@@ -418,6 +373,68 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 		phy->div_clk = ERR_PTR(-ENODEV);
 	}
 
+	return 0;
+}
+
+static int ti_pipe3_probe(struct platform_device *pdev)
+{
+	struct ti_pipe3 *phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *control_node;
+	struct platform_device *control_pdev;
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->dev		= dev;
+
+	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
+		match = of_match_device(ti_pipe3_id_table, dev);
+		if (!match)
+			return -EINVAL;
+
+		phy->dpll_map = (struct pipe3_dpll_map *)match->data;
+		if (!phy->dpll_map) {
+			dev_err(dev, "no DPLL data\n");
+			return -EINVAL;
+		}
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "pll_ctrl");
+		phy->pll_ctrl_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(phy->pll_ctrl_base))
+			return PTR_ERR(phy->pll_ctrl_base);
+	}
+
+	if (of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+		phy->dpll_reset_syscon = syscon_regmap_lookup_by_phandle(node,
+							"syscon-pllreset");
+		if (IS_ERR(phy->dpll_reset_syscon)) {
+			dev_info(dev,
+				 "can't get syscon-pllreset, sata dpll won't idle\n");
+			phy->dpll_reset_syscon = NULL;
+		} else {
+			if (of_property_read_u32_index(node,
+						       "syscon-pllreset", 1,
+						       &phy->dpll_reset_reg)) {
+				dev_err(dev,
+					"couldn't get pllreset reg. offset\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	ret = ti_pipe3_get_clk(phy);
+	if (ret)
+		return ret;
+
 	control_node = of_parse_phandle(node, "ctrl-module", 0);
 	if (!control_node) {
 		dev_err(dev, "Failed to get control device phandle\n");
-- 
1.7.9.5

