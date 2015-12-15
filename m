Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60762 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933402AbbLOJRC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Dec 2015 04:17:02 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <tony@atomide.com>, <t-kristo@ti.com>
Subject: [PATCH v3 8/9] phy: omap-usb2: use omap_usb_power_off to power off the PHY during probe
Date: Tue, 15 Dec 2015 14:46:07 +0530
Message-ID: <1450170968-11282-9-git-send-email-kishon@ti.com>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Previously omap_control_phy_power() was used to power
off the PHY during probe. But once phy-omap-usb2 driver is adapted to
use syscon, omap_control_phy_power() cannot be used. Hence used
omap_usb_power_off to power off the PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-omap-usb2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index 0fe8058..c79633e 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -241,7 +241,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy->control_dev = &control_pdev->dev;
-	omap_control_phy_power(phy->control_dev, 0);
 
 	otg->set_host		= omap_usb_set_host;
 	otg->set_peripheral	= omap_usb_set_peripheral;
@@ -261,6 +260,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy_set_drvdata(generic_phy, phy);
+	omap_usb_power_off(generic_phy);
 
 	phy_provider = devm_of_phy_provider_register(phy->dev,
 			of_phy_simple_xlate);
-- 
1.7.9.5

