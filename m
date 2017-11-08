Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:57310 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdKHJUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 04:20:03 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Use runtime PM to control controller clock
Date: Wed,  8 Nov 2017 10:19:56 +0100
Message-Id: <20171108091956.8537-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dien Pham <dien.pham.ry@rvc.renesas.com>

The controller clock can be switched off during suspend/resume,
let runtime PM take care of that.

Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 8b51208875fc..889603783f01 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -145,7 +145,6 @@ struct rcar_pcie {
 	void __iomem		*base;
 	struct list_head	resources;
 	int			root_bus_nr;
-	struct clk		*clk;
 	struct clk		*bus_clk;
 	struct			rcar_msi msi;
 };
@@ -917,15 +916,6 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
-	pcie->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(pcie->clk)) {
-		dev_err(dev, "cannot get platform clock\n");
-		return PTR_ERR(pcie->clk);
-	}
-	err = clk_prepare_enable(pcie->clk);
-	if (err)
-		return err;
-
 	pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
 	if (IS_ERR(pcie->bus_clk)) {
 		dev_err(dev, "cannot get pcie bus clock\n");
@@ -957,7 +947,6 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 err_map_reg:
 	clk_disable_unprepare(pcie->bus_clk);
 fail_clk:
-	clk_disable_unprepare(pcie->clk);
 
 	return err;
 }
@@ -1126,6 +1115,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	rcar_pcie_parse_request_of_pci_ranges(pcie);
 
+	pm_runtime_enable(pcie->dev);
+	err = pm_runtime_get_sync(pcie->dev);
+	if (err < 0) {
+		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
+		goto err_pm_disable;
+	}
+
 	err = rcar_pcie_get_resources(pcie);
 	if (err < 0) {
 		dev_err(dev, "failed to request resources: %d\n", err);
@@ -1136,13 +1132,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto err_free_bridge;
 
-	pm_runtime_enable(dev);
-	err = pm_runtime_get_sync(dev);
-	if (err < 0) {
-		dev_err(dev, "pm_runtime_get_sync failed\n");
-		goto err_pm_disable;
-	}
-
 	/* Failure to get a link might just be that no cards are inserted */
 	hw_init_fn = of_device_get_match_data(dev);
 	err = hw_init_fn(pcie);
-- 
2.11.0
