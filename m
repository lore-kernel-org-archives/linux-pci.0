Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:46536 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbdGSJ4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 05:56:17 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 1/7] PCI: rockchip: split out rockchip_pcie_get_phys
Date: Wed, 19 Jul 2017 17:55:12 +0800
Message-Id: <1500458118-139042-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500458118-139042-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500458118-139042-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We plan to introduce per-lanes PHY, so split out new
function to make it easy in the future. No functional
change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4:
- use err variable to check return value of
  rockchip_pcie_get_phys
- add Brian's tag

Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 5acf869..c42feab 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -853,6 +853,19 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->dev;
+
+	rockchip->phy = devm_phy_get(dev, "pcie-phy");
+	if (IS_ERR(rockchip->phy)) {
+		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
+			dev_err(dev, "missing phy\n");
+		return PTR_ERR(rockchip->phy);
+	}
+
+	return 0;
+}
 
 /**
  * rockchip_pcie_parse_dt - Parse Device Tree
@@ -883,12 +896,9 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	if (IS_ERR(rockchip->apb_base))
 		return PTR_ERR(rockchip->apb_base);
 
-	rockchip->phy = devm_phy_get(dev, "pcie-phy");
-	if (IS_ERR(rockchip->phy)) {
-		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
-			dev_err(dev, "missing phy\n");
-		return PTR_ERR(rockchip->phy);
-	}
+	err = rockchip_pcie_get_phys(rockchip);
+	if (err)
+		return err;
 
 	rockchip->lanes = 1;
 	err = of_property_read_u32(node, "num-lanes", &rockchip->lanes);
-- 
1.9.1
