Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 1/2] phy: ti-pipe3: get tx and rx MEM resource
Date: Wed, 6 Jan 2016 16:29:07 +0530
Message-ID: <1452077948-26232-2-git-send-email-kishon@ti.com>
In-Reply-To: <1452077948-26232-1-git-send-email-kishon@ti.com>
References: <1452077948-26232-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

get tx and rx MEM resource since this has to be used to configure
for DRA72x to work in X2 mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/phy-ti-pipe3.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 0a477d2..7d83d2b 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -91,6 +91,8 @@ struct pipe3_dpll_map {
 
 struct ti_pipe3 {
 	void __iomem		*pll_ctrl_base;
+	void __iomem		*phy_rx;
+	void __iomem		*phy_tx;
 	struct device		*dev;
 	struct device		*control_dev;
 	struct clk		*wkupclk;
@@ -536,6 +538,27 @@ static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
 	return 0;
 }
 
+static int ti_pipe3_get_rx_tx_base(struct ti_pipe3 *phy)
+{
+	struct resource *res;
+	struct device *dev = phy->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "phy_rx");
+	phy->phy_rx = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(phy->phy_rx))
+		return PTR_ERR(phy->phy_rx);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "phy_tx");
+	phy->phy_tx = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(phy->phy_tx))
+		return PTR_ERR(phy->phy_tx);
+
+	return 0;
+}
+
 static int ti_pipe3_probe(struct platform_device *pdev)
 {
 	struct ti_pipe3 *phy;
@@ -555,6 +578,10 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = ti_pipe3_get_rx_tx_base(phy);
+	if (ret)
+		return ret;
+
 	ret = ti_pipe3_get_sysctrl(phy);
 	if (ret)
 		return ret;
-- 
1.7.9.5

