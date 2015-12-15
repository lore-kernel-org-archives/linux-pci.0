Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <tony@atomide.com>, <t-kristo@ti.com>
Subject: [PATCH v3 4/9] phy: ti-pipe3: move mem resource initialization to a separate function
Date: Tue, 15 Dec 2015 14:46:03 +0530
Message-ID: <1450170968-11282-5-git-send-email-kishon@ti.com>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Moved mem resource initialization done in
probe to a separate function as part of cleaning up
ti_pipe3_probe.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-ti-pipe3.c |   52 ++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 3154da0..1991efd 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -418,14 +418,42 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 	return 0;
 }
 
+static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
+{
+	struct resource *res;
+	const struct of_device_id *match;
+	struct device *dev = phy->dev;
+	struct device_node *node = dev->of_node;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie"))
+		return 0;
+
+	match = of_match_device(ti_pipe3_id_table, dev);
+	if (!match)
+		return -EINVAL;
+
+	phy->dpll_map = (struct pipe3_dpll_map *)match->data;
+	if (!phy->dpll_map) {
+		dev_err(dev, "no DPLL data\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "pll_ctrl");
+	phy->pll_ctrl_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->pll_ctrl_base))
+		return PTR_ERR(phy->pll_ctrl_base);
+
+	return 0;
+}
+
 static int ti_pipe3_probe(struct platform_device *pdev)
 {
 	struct ti_pipe3 *phy;
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
-	struct resource *res;
 	struct device_node *node = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -435,23 +463,9 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 
 	phy->dev		= dev;
 
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
-	}
+	ret = ti_pipe3_get_pll_base(phy);
+	if (ret)
+		return ret;
 
 	ret = ti_pipe3_get_sysctrl(phy);
 	if (ret)
-- 
1.7.9.5

