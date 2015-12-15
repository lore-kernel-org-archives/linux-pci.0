Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <tony@atomide.com>, <t-kristo@ti.com>
Subject: [PATCH v3 5/9] phy: ti-pipe3: use ti_pipe3_power_off to power off the PHY during probe
Date: Tue, 15 Dec 2015 14:46:04 +0530
Message-ID: <1450170968-11282-6-git-send-email-kishon@ti.com>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Previously omap_control_phy_power() was used to power
off the PHY during probe. But once PIPE3 driver is adapted to use syscon,
omap_control_phy_power() cannot be used. Hence used ti_pipe3_power_off
to power off the PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-ti-pipe3.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 1991efd..0ce4194 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -475,8 +475,6 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	omap_control_phy_power(phy->control_dev, 0);
-
 	platform_set_drvdata(pdev, phy);
 	pm_runtime_enable(dev);
 
@@ -495,6 +493,9 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 		return PTR_ERR(generic_phy);
 
 	phy_set_drvdata(generic_phy, phy);
+
+	ti_pipe3_power_off(generic_phy);
+
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider))
 		return PTR_ERR(phy_provider);
-- 
1.7.9.5

