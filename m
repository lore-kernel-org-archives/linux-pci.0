Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0087.outbound.protection.outlook.com ([104.47.36.87]:47264
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbeIEUwc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 16:52:32 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>
CC: <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <cyrille.pitchen@bootlin.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [PATCH] pci: cadence: Correct probe behaviour when failing to get PHY
Date: Wed, 5 Sep 2018 17:20:08 +0100
Message-ID: <1536164408-10959-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Test the correct value to see whether the PHY get failed.
Use devm_phy_get() instead of devm_phy_optional_get(), since it is
only called if phy name is given in devicetree and so should exist.
If failure when getting or linking PHY, put any PHYs which were
already got and unlink them.

Fixes: dfb80534692ddc5b ("PCI: cadence: Add generic PHY support to host and EP drivers")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index 86f1b00..67d2f98 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -190,14 +190,16 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
-		phy[i] = devm_phy_optional_get(dev, name);
-		if (IS_ERR(phy))
-			return PTR_ERR(phy);
-
+		phy[i] = devm_phy_get(dev, name);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_phy;
+		}
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {
+			devm_phy_put(dev, phy[i]);
 			ret = -EINVAL;
-			goto err_link;
+			goto err_phy;
 		}
 	}
 
@@ -207,13 +209,15 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
-		goto err_link;
+		goto err_phy;
 
 	return 0;
 
-err_link:
+err_phy:
 	while (--i >= 0)
 		device_link_del(link[i]);
+	while (--i >= 0)
+		devm_phy_put(dev, phy[i]);
 
 	return ret;
 }
-- 
1.9.0
