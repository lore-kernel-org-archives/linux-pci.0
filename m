Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46790 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeEUNLm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2018 09:11:42 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/4] PCI: rcar: Pull bus clock enable/disable from rcar_pcie_get_resources()
Date: Mon, 21 May 2018 15:11:21 +0200
Message-Id: <20180521131123.2009-2-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The rcar_pcie_get_resources() is another misnomer with a side effect.
The function does not only get resources, but also enables/disables bus
clock. This is forgotten in the probe() function though and if anything
in probe() fails after rcar_pcie_get_resources() is called, the bus
clock are never disabled.

This patch pulls the clock handling out of the rcar_pcie_get_resources()
and enables clock after all the resources were requested. Moreover, this
patch also always disables the clock in case of failure.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index dbc80e457f95..eac4b71d9c60 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -919,32 +919,22 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 		dev_err(dev, "cannot get pcie bus clock\n");
 		return PTR_ERR(pcie->bus_clk);
 	}
-	err = clk_prepare_enable(pcie->bus_clk);
-	if (err)
-		return err;
 
 	i = irq_of_parse_and_map(dev->of_node, 0);
 	if (!i) {
 		dev_err(dev, "cannot get platform resources for msi interrupt\n");
-		err = -ENOENT;
-		goto err_map_reg;
+		return -ENOENT;
 	}
 	pcie->msi.irq1 = i;
 
 	i = irq_of_parse_and_map(dev->of_node, 1);
 	if (!i) {
 		dev_err(dev, "cannot get platform resources for msi interrupt\n");
-		err = -ENOENT;
-		goto err_map_reg;
+		return -ENOENT;
 	}
 	pcie->msi.irq2 = i;
 
 	return 0;
-
-err_map_reg:
-	clk_disable_unprepare(pcie->bus_clk);
-
-	return err;
 }
 
 static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
@@ -1125,9 +1115,15 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		goto err_pm_put;
 	}
 
+	err = clk_prepare_enable(pcie->bus_clk);
+	if (err) {
+		dev_err(dev, "failed to enable bus clock: %d\n", err);
+		goto err_pm_put;
+	}
+
 	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
 	if (err)
-		goto err_pm_put;
+		goto err_clk_disable;
 
 	/* Failure to get a link might just be that no cards are inserted */
 	hw_init_fn = of_device_get_match_data(dev);
@@ -1135,7 +1131,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	if (err) {
 		dev_info(dev, "PCIe link down\n");
 		err = -ENODEV;
-		goto err_pm_put;
+		goto err_clk_disable;
 	}
 
 	data = rcar_pci_read_reg(pcie, MACSR);
@@ -1147,16 +1143,19 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 			dev_err(dev,
 				"failed to enable MSI support: %d\n",
 				err);
-			goto err_pm_put;
+			goto err_clk_disable;
 		}
 	}
 
 	err = rcar_pcie_enable(pcie);
 	if (err)
-		goto err_pm_put;
+		goto err_clk_disable;
 
 	return 0;
 
+err_clk_disable:
+	clk_disable_unprepare(pcie->bus_clk);
+
 err_pm_put:
 	pm_runtime_put(dev);
 
-- 
2.16.2
