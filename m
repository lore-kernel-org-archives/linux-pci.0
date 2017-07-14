Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:42795 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753182AbdGNDxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2017 23:53:07 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 3/6] phy: rockcip-pcie: reconstruct driver to support per-lane PHYs
Date: Fri, 14 Jul 2017 11:52:43 +0800
Message-Id: <1500004366-241633-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500004101-240296-1-git-send-email-shawn.lin@rock-chips.com>
 <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch reconstructs the whole driver to support per-lane
PHYs. Note that we could also support the legacy PHY if you
don't provide argument to our of_xlate.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/phy/rockchip/phy-rockchip-pcie.c | 116 +++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 6904633..da74b47 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -73,10 +73,35 @@ struct rockchip_pcie_data {
 struct rockchip_pcie_phy {
 	struct rockchip_pcie_data *phy_data;
 	struct regmap *reg_base;
+	struct phy **phys;
 	struct reset_control *phy_rst;
 	struct clk *clk_pciephy_ref;
+	u32 pwr_cnt;
+	bool initialized;
 };
 
+static struct phy *rockchip_pcie_phy_of_xlate(struct device *dev,
+					      struct of_phandle_args *args)
+{
+	struct rockchip_pcie_phy *rk_phy = dev_get_drvdata(dev);
+
+	if (!rk_phy)
+		return ERR_PTR(-ENODEV);
+
+	switch (args->args[0]) {
+	case 1:
+		return rk_phy->phys[1];
+	case 2:
+		return rk_phy->phys[2];
+	case 3:
+		return rk_phy->phys[3];
+	case 0:
+		/* keep backward compatibility to legacy phy */
+	default:
+		return rk_phy->phys[0];
+	}
+}
+
 static inline void phy_wr_cfg(struct rockchip_pcie_phy *rk_phy,
 			      u32 addr, u32 data)
 {
@@ -114,20 +139,55 @@ static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
 	return val;
 }
 
-static int rockchip_pcie_phy_power_off(struct phy *phy)
+static int rockchip_pcie_phy_common_power_off(struct phy *phy)
 {
 	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
 	int err = 0;
 
+	if (WARN_ON(!rk_phy->pwr_cnt))
+		return -EINVAL;
+
+	if (rk_phy->pwr_cnt > 0)
+		return 0;
+
 	err = reset_control_assert(rk_phy->phy_rst);
 	if (err) {
 		dev_err(&phy->dev, "assert phy_rst err %d\n", err);
 		return err;
 	}
 
+	rk_phy->pwr_cnt--;
+
 	return 0;
 }
 
+#define DECLARE_PHY_POWER_OFF_PER_LANE(id) \
+static int rockchip_pcie_lane##id##_phy_power_off(struct phy *phy) \
+{ \
+	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy); \
+\
+	regmap_write(rk_phy->reg_base, \
+		     rk_phy->phy_data->pcie_laneoff, \
+		     HIWORD_UPDATE(PHY_LANE_IDLE_OFF, \
+				   PHY_LANE_IDLE_MASK, \
+				   PHY_LANE_IDLE_A_SHIFT + id)); \
+	return rockchip_pcie_phy_common_power_off(phy); \
+}
+
+DECLARE_PHY_POWER_OFF_PER_LANE(0);
+DECLARE_PHY_POWER_OFF_PER_LANE(1);
+DECLARE_PHY_POWER_OFF_PER_LANE(2);
+DECLARE_PHY_POWER_OFF_PER_LANE(3);
+
+#define PROVIDE_PHY_OPS(id) \
+	{ \
+		.init = rockchip_pcie_phy_init, \
+		.exit = rockchip_pcie_phy_exit, \
+		.power_on = rockchip_pcie_phy_power_on, \
+		.power_off = rockchip_pcie_lane##id##_phy_power_off, \
+		.owner  = THIS_MODULE, \
+}
+
 static int rockchip_pcie_phy_power_on(struct phy *phy)
 {
 	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
@@ -135,6 +195,12 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 	u32 status;
 	unsigned long timeout;
 
+	if (WARN_ON(rk_phy->pwr_cnt > PHY_MAX_LANE_NUM))
+		return -EINVAL;
+
+	if (rk_phy->pwr_cnt)
+		return 0;
+
 	err = reset_control_deassert(rk_phy->phy_rst);
 	if (err) {
 		dev_err(&phy->dev, "deassert phy_rst err %d\n", err);
@@ -214,6 +280,7 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 		goto err_pll_lock;
 	}
 
+	rk_phy->pwr_cnt++;
 	return 0;
 
 err_pll_lock:
@@ -226,6 +293,9 @@ static int rockchip_pcie_phy_init(struct phy *phy)
 	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
 	int err = 0;
 
+	if (rk_phy->initialized)
+		return 0;
+
 	err = clk_prepare_enable(rk_phy->clk_pciephy_ref);
 	if (err) {
 		dev_err(&phy->dev, "Fail to enable pcie ref clock.\n");
@@ -238,7 +308,9 @@ static int rockchip_pcie_phy_init(struct phy *phy)
 		goto err_reset;
 	}
 
-	return err;
+	rk_phy->initialized = true;
+
+	return 0;
 
 err_reset:
 	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
@@ -250,17 +322,21 @@ static int rockchip_pcie_phy_exit(struct phy *phy)
 {
 	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
 
+	if (!rk_phy->initialized)
+		return 0;
+
 	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
 
+	rk_phy->initialized = false;
+
 	return 0;
 }
 
-static const struct phy_ops ops = {
-	.init		= rockchip_pcie_phy_init,
-	.exit		= rockchip_pcie_phy_exit,
-	.power_on	= rockchip_pcie_phy_power_on,
-	.power_off	= rockchip_pcie_phy_power_off,
-	.owner		= THIS_MODULE,
+static const struct phy_ops ops[PHY_MAX_LANE_NUM] = {
+	PROVIDE_PHY_OPS(0),
+	PROVIDE_PHY_OPS(1),
+	PROVIDE_PHY_OPS(2),
+	PROVIDE_PHY_OPS(3),
 };
 
 static const struct rockchip_pcie_data rk3399_pcie_data = {
@@ -283,10 +359,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie_phy *rk_phy;
-	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
 	struct regmap *grf;
 	const struct of_device_id *of_id;
+	int i;
 
 	grf = syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(grf)) {
@@ -319,14 +395,24 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(rk_phy->clk_pciephy_ref);
 	}
 
-	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
-	if (IS_ERR(generic_phy)) {
-		dev_err(dev, "failed to create PHY\n");
-		return PTR_ERR(generic_phy);
+	rk_phy->phys = devm_kcalloc(dev, sizeof(struct phy),
+				    PHY_MAX_LANE_NUM, GFP_KERNEL);
+	if (!rk_phy->phys)
+		return -ENOMEM;
+
+	for (i = 0; i < PHY_MAX_LANE_NUM; i++) {
+		rk_phy->phys[i] = devm_phy_create(dev, dev->of_node, &ops[i]);
+		if (IS_ERR(rk_phy->phys[i])) {
+			dev_err(dev, "failed to create PHY%d\n", i);
+			return PTR_ERR(rk_phy->phys[i]);
+		}
+
+		phy_set_drvdata(rk_phy->phys[i], rk_phy);
 	}
 
-	phy_set_drvdata(generic_phy, rk_phy);
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	platform_set_drvdata(pdev, rk_phy);
+	phy_provider = devm_of_phy_provider_register(dev,
+					rockchip_pcie_phy_of_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
-- 
1.9.1
