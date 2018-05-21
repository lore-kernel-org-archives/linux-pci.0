Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43272 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeEUNLn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2018 09:11:43 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/4] PCI: rcar: Add missing irq_dispose_mapping() into failpath
Date: Mon, 21 May 2018 15:11:22 +0200
Message-Id: <20180521131123.2009-3-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The rcar_pcie_get_resources() is another misnomer with a side effect.
The function does not only get resources, but also maps MSI IRQs via
irq_of_parse_and_map(). In case anything fails afterward, the IRQ
mapping must be disposed through irq_dispose_mapping() which is not
done.

This patch handles irq_of_parse_and_map() failures in by disposing
of the mapping in rcar_pcie_get_resources() as well as in probe.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index eac4b71d9c60..3cc84f7e05f7 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -923,18 +923,25 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 	i = irq_of_parse_and_map(dev->of_node, 0);
 	if (!i) {
 		dev_err(dev, "cannot get platform resources for msi interrupt\n");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err_irq1;
 	}
 	pcie->msi.irq1 = i;
 
 	i = irq_of_parse_and_map(dev->of_node, 1);
 	if (!i) {
 		dev_err(dev, "cannot get platform resources for msi interrupt\n");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err_irq2;
 	}
 	pcie->msi.irq2 = i;
 
 	return 0;
+
+err_irq2:
+	irq_dispose_mapping(pcie->msi.irq1);
+err_irq1:
+	return err;
 }
 
 static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
@@ -1118,7 +1125,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(pcie->bus_clk);
 	if (err) {
 		dev_err(dev, "failed to enable bus clock: %d\n", err);
-		goto err_pm_put;
+		goto err_unmap_msi_irqs;
 	}
 
 	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
@@ -1156,6 +1163,10 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 err_clk_disable:
 	clk_disable_unprepare(pcie->bus_clk);
 
+err_unmap_msi_irqs:
+	irq_dispose_mapping(pcie->msi.irq2);
+	irq_dispose_mapping(pcie->msi.irq1);
+
 err_pm_put:
 	pm_runtime_put(dev);
 
-- 
2.16.2
