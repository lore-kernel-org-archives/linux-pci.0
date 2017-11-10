Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:52568 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdKJVyQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2017 16:54:16 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3] PCI: rcar: Use runtime PM to control controller clock
Date: Fri, 10 Nov 2017 22:54:11 +0100
Message-Id: <20171110215411.31912-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dien Pham <dien.pham.ry@rvc.renesas.com>

The controller clock can be switched off during suspend/resume,
let runtime PM take care of that.

Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: - Reorder the fail path in rcar_pcie_probe() to cater for the
      reordering of function calls in probe
    - Dispose of fail_clk in rcar_pcie_get_resources()
V3: - Fix up the failpath in probe function
---
 drivers/pci/host/pcie-rcar.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 12796eccb2be..e00f865952d5 100644
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
@@ -917,24 +916,14 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
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
-		err = PTR_ERR(pcie->bus_clk);
-		goto fail_clk;
+		return PTR_ERR(pcie->bus_clk);
 	}
 	err = clk_prepare_enable(pcie->bus_clk);
 	if (err)
-		goto fail_clk;
+		return err;
 
 	i = irq_of_parse_and_map(dev->of_node, 0);
 	if (!i) {
@@ -956,8 +945,6 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 
 err_map_reg:
 	clk_disable_unprepare(pcie->bus_clk);
-fail_clk:
-	clk_disable_unprepare(pcie->clk);
 
 	return err;
 }
@@ -1125,22 +1112,22 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
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
-		goto err_free_bridge;
+		goto err_pm_put;
 	}
 
 	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
 	if (err)
-		goto err_free_bridge;
-
-	pm_runtime_enable(dev);
-	err = pm_runtime_get_sync(dev);
-	if (err < 0) {
-		dev_err(dev, "pm_runtime_get_sync failed\n");
-		goto err_pm_disable;
-	}
+		goto err_pm_put;
 
 	/* Failure to get a link might just be that no cards are inserted */
 	hw_init_fn = of_device_get_match_data(dev);
@@ -1172,13 +1159,10 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 err_pm_put:
 	pm_runtime_put(dev);
-
 err_pm_disable:
 	pm_runtime_disable(dev);
-
-err_free_bridge:
-	pci_free_host_bridge(bridge);
 	pci_free_resource_list(&pcie->resources);
+	pci_free_host_bridge(bridge);
 
 	return err;
 }
-- 
2.11.0
