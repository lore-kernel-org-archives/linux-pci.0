Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933163AbcJGQcq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:32:46 -0400
Subject: [PATCH 1/8] PCI: artpec6: Name private struct pointer "artpec6"
 consistently
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Fri, 07 Oct 2016 11:32:33 -0500
Message-ID: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "artpec6", for struct artpec6_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-artpec6.c |   57 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index 39bf1a6..55f69eb 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -67,16 +67,16 @@ struct artpec6_pcie {
 
 static int artpec6_pcie_establish_link(struct pcie_port *pp)
 {
-	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pp);
+	struct artpec6_pcie *artpec6 = to_artpec6_pcie(pp);
 	u32 val;
 	unsigned int retries;
 
 	/* Hold DW core in reset */
-	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
+	regmap_read(artpec6->regmap, PCIECFG, &val);
 	val |= PCIECFG_CORE_RESET_REQ;
-	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
+	regmap_write(artpec6->regmap, PCIECFG, val);
 
-	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
+	regmap_read(artpec6->regmap, PCIECFG, &val);
 	val |=  PCIECFG_RISRCREN |	/* Receiver term. 50 Ohm */
 		PCIECFG_MODE_TX_DRV_EN |
 		PCIECFG_CISRREN |	/* Reference clock term. 100 Ohm */
@@ -84,27 +84,27 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	val |= PCIECFG_REFCLK_ENABLE;
 	val &= ~PCIECFG_DBG_OEN;
 	val &= ~PCIECFG_CLKREQ_B;
-	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
+	regmap_write(artpec6->regmap, PCIECFG, val);
 	usleep_range(5000, 6000);
 
-	regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
+	regmap_read(artpec6->regmap, NOCCFG, &val);
 	val |= NOCCFG_ENABLE_CLK_PCIE;
-	regmap_write(artpec6_pcie->regmap, NOCCFG, val);
+	regmap_write(artpec6->regmap, NOCCFG, val);
 	usleep_range(20, 30);
 
-	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
+	regmap_read(artpec6->regmap, PCIECFG, &val);
 	val |= PCIECFG_PCLK_ENABLE | PCIECFG_PLL_ENABLE;
-	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
+	regmap_write(artpec6->regmap, PCIECFG, val);
 	usleep_range(6000, 7000);
 
-	regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
+	regmap_read(artpec6->regmap, NOCCFG, &val);
 	val &= ~NOCCFG_POWER_PCIE_IDLEREQ;
-	regmap_write(artpec6_pcie->regmap, NOCCFG, val);
+	regmap_write(artpec6->regmap, NOCCFG, val);
 
 	retries = 50;
 	do {
 		usleep_range(1000, 2000);
-		regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
+		regmap_read(artpec6->regmap, NOCCFG, &val);
 		retries--;
 	} while (retries &&
 		(val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
@@ -112,14 +112,14 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	retries = 50;
 	do {
 		usleep_range(1000, 2000);
-		val = readl(artpec6_pcie->phy_base + PHY_STATUS);
+		val = readl(artpec6->phy_base + PHY_STATUS);
 		retries--;
 	} while (retries && !(val & PHY_COSPLLLOCK));
 
 	/* Take DW core out of reset */
-	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
+	regmap_read(artpec6->regmap, PCIECFG, &val);
 	val &= ~PCIECFG_CORE_RESET_REQ;
-	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
+	regmap_write(artpec6->regmap, PCIECFG, val);
 	usleep_range(100, 200);
 
 	/*
@@ -137,9 +137,9 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	/* assert LTSSM enable */
-	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
+	regmap_read(artpec6->regmap, PCIECFG, &val);
 	val |= PCIECFG_LTSSM_ENABLE;
-	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
+	regmap_write(artpec6->regmap, PCIECFG, val);
 
 	/* check if the link is up or not */
 	if (!dw_pcie_wait_for_link(pp))
@@ -227,18 +227,17 @@ static int artpec6_add_pcie_port(struct pcie_port *pp,
 
 static int artpec6_pcie_probe(struct platform_device *pdev)
 {
-	struct artpec6_pcie *artpec6_pcie;
+	struct artpec6_pcie *artpec6;
 	struct pcie_port *pp;
 	struct resource *dbi_base;
 	struct resource *phy_base;
 	int ret;
 
-	artpec6_pcie = devm_kzalloc(&pdev->dev, sizeof(*artpec6_pcie),
-				    GFP_KERNEL);
-	if (!artpec6_pcie)
+	artpec6 = devm_kzalloc(&pdev->dev, sizeof(*artpec6), GFP_KERNEL);
+	if (!artpec6)
 		return -ENOMEM;
 
-	pp = &artpec6_pcie->pp;
+	pp = &artpec6->pp;
 	pp->dev = &pdev->dev;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -247,21 +246,21 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 
 	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
-	artpec6_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
-	if (IS_ERR(artpec6_pcie->phy_base))
-		return PTR_ERR(artpec6_pcie->phy_base);
+	artpec6->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
+	if (IS_ERR(artpec6->phy_base))
+		return PTR_ERR(artpec6->phy_base);
 
-	artpec6_pcie->regmap =
+	artpec6->regmap =
 		syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						"axis,syscon-pcie");
-	if (IS_ERR(artpec6_pcie->regmap))
-		return PTR_ERR(artpec6_pcie->regmap);
+	if (IS_ERR(artpec6->regmap))
+		return PTR_ERR(artpec6->regmap);
 
 	ret = artpec6_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, artpec6_pcie);
+	platform_set_drvdata(pdev, artpec6);
 	return 0;
 }
 

