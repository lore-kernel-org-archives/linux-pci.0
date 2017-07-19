Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:60082 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdGSHYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 03:24:52 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v4 2/7] PCI: rockchip: introduce per-lanes PHYs support
Date: Wed, 19 Jul 2017 15:22:54 +0800
Message-Id: <1500448979-93067-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500448979-93067-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500448979-93067-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We distinguish the legacy PHY with the newer per-lane
PHYs by adding legacy_phy flag. Note that the legacy phy
is still the first option to be searched in order not to
break the backward compatibility of DTB.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4:
- move rockchip_pcie_get_phys to where it stands in
  patch 1.
- print PHY index in err output log

Changes in v3:
- kill rockchip_pcie_manipulate_phys and related stuff
- use phys array
- improve the commit msg

Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 77 +++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c42feab..f510349 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -47,6 +47,7 @@
 #define HIWORD_UPDATE_BIT(val)		HIWORD_UPDATE(val, val)
 
 #define ENCODE_LANES(x)			((((x) >> 1) & 3) << 4)
+#define MAX_LANE_NUM			4
 
 #define PCIE_CLIENT_BASE		0x0
 #define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
@@ -210,7 +211,8 @@
 struct rockchip_pcie {
 	void	__iomem *reg_base;		/* DT axi-base */
 	void	__iomem *apb_base;		/* DT apb-base */
-	struct	phy *phy;
+	bool    legacy_phy;
+	struct  phy *phys[MAX_LANE_NUM];
 	struct	reset_control *core_rst;
 	struct	reset_control *mgmt_rst;
 	struct	reset_control *mgmt_sticky_rst;
@@ -514,7 +516,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
-	int err;
+	int err, i;
 	u32 status;
 
 	gpiod_set_value(rockchip->ep_gpio, 0);
@@ -537,10 +539,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
-	err = phy_init(rockchip->phy);
-	if (err < 0) {
-		dev_err(dev, "fail to init phy, err %d\n", err);
-		return err;
+	for (i = 0; i < MAX_LANE_NUM; i++) {
+		err = phy_init(rockchip->phys[i]);
+		if (err) {
+			dev_err(dev, "init phy%d err %d\n", i, err);
+			return err;
+		}
 	}
 
 	err = reset_control_assert(rockchip->core_rst);
@@ -602,10 +606,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			    PCIE_CLIENT_MODE_RC,
 			    PCIE_CLIENT_CONFIG);
 
-	err = phy_power_on(rockchip->phy);
-	if (err) {
-		dev_err(dev, "fail to power on phy, err %d\n", err);
-		return err;
+	for (i = 0; i < MAX_LANE_NUM; i++) {
+		err = phy_power_on(rockchip->phys[i]);
+		if (err) {
+			dev_err(dev, "power on phy%d err %d\n", i, err);
+			return err;
+		}
 	}
 
 	/*
@@ -856,12 +862,38 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
+	struct phy *phy;
+	char *name;
+	u32 i;
+
+	rockchip->phys[0] = devm_phy_get(dev, "pcie-phy");
+	if (IS_ERR(rockchip->phys[0])) {
+		if (PTR_ERR(rockchip->phys[0]) == -EPROBE_DEFER)
+			return PTR_ERR(rockchip->phys[0]);
+		dev_dbg(dev, "missing legacy phy, and search for per-lane PHY\n");
+	} else {
+		rockchip->legacy_phy = true;
+		dev_warn(dev, "legacy phy model is deprecated!\n");
+		return 0;
+	}
+
+	for (i = 0; i < MAX_LANE_NUM; i++) {
+		name = kasprintf(GFP_KERNEL, "pcie-phy-%u", i);
+		if (!name)
+			return -ENOMEM;
+
+		phy = devm_of_phy_get(rockchip->dev,
+				      rockchip->dev->of_node, name);
+		kfree(name);
 
-	rockchip->phy = devm_phy_get(dev, "pcie-phy");
-	if (IS_ERR(rockchip->phy)) {
-		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
-			dev_err(dev, "missing phy\n");
-		return PTR_ERR(rockchip->phy);
+		if (IS_ERR(phy)) {
+			if (PTR_ERR(phy) != -EPROBE_DEFER)
+				dev_err(dev, "missing phy for lane %d: %ld\n",
+					i, PTR_ERR(phy));
+			return PTR_ERR(phy);
+		}
+
+		rockchip->phys[i] = phy;
 	}
 
 	return 0;
@@ -1283,7 +1315,7 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
 static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
-	int ret;
+	int ret, i;
 
 	/* disable core and cli int since we don't need to ack PME_ACK */
 	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) |
@@ -1296,8 +1328,10 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 		return ret;
 	}
 
-	phy_power_off(rockchip->phy);
-	phy_exit(rockchip->phy);
+	for (i = 0; i < MAX_LANE_NUM; i++) {
+		phy_power_off(rockchip->phys[i]);
+		phy_exit(rockchip->phys[i]);
+	}
 
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
 	clk_disable_unprepare(rockchip->hclk_pcie);
@@ -1533,14 +1567,17 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+	int i;
 
 	pci_stop_root_bus(rockchip->root_bus);
 	pci_remove_root_bus(rockchip->root_bus);
 	pci_unmap_iospace(rockchip->io);
 	irq_domain_remove(rockchip->irq_domain);
 
-	phy_power_off(rockchip->phy);
-	phy_exit(rockchip->phy);
+	for (i = 0; i < MAX_LANE_NUM; i++) {
+		phy_power_off(rockchip->phys[i]);
+		phy_exit(rockchip->phys[i]);
+	}
 
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
 	clk_disable_unprepare(rockchip->hclk_pcie);
-- 
1.9.1
