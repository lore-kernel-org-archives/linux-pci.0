Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44687 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeECTnQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 15:43:16 -0400
Received: by mail-lf0-f67.google.com with SMTP id h197-v6so27655026lfg.11
        for <linux-pci@vger.kernel.org>; Thu, 03 May 2018 12:43:15 -0700 (PDT)
Subject: [PATCH v3 4/5] pcie-rcar: factor out rcar_pcie_hw_init() call
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Message-ID: <8cd69bd4-b244-766e-9c3e-d4cd5999c1b0@cogentembedded.com>
Date: Thu, 3 May 2018 22:43:13 +0300
MIME-Version: 1.0
In-Reply-To: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We now have rcar_pcie_hw_init_{h1|gen2|gen3}() differing only in the PCIe
PHY init code and all ending with a call to rcar_pcie_hw_init(), thus it
makes  sense to move that call into the driver's probe() method and then
rename those functions to rcar_pcie_phy_init_{h1|gen2|gen3}() -- doing
this saves 48 bytes of object code (AArch64 gcc 4.8.5)...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes in version 3:
- added Simon's tag;
- refreshed atop of the recent driver patches.

 drivers/pci/host/pcie-rcar.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

Index: pci/drivers/pci/host/pcie-rcar.c
===================================================================
--- pci.orig/drivers/pci/host/pcie-rcar.c
+++ pci/drivers/pci/host/pcie-rcar.c
@@ -626,7 +626,7 @@ static int rcar_pcie_hw_init(struct rcar
 	return 0;
 }
 
-static int rcar_pcie_hw_init_h1(struct rcar_pcie *pcie)
+static int rcar_pcie_phy_init_h1(struct rcar_pcie *pcie)
 {
 	/* Initialize the phy */
 	phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
@@ -646,10 +646,10 @@ static int rcar_pcie_hw_init_h1(struct r
 	phy_write_reg(pcie, 0, 0x64, 0x1, 0x3F0F1F0F);
 	phy_write_reg(pcie, 0, 0x66, 0x1, 0x00008000);
 
-	return rcar_pcie_hw_init(pcie);
+	return 0;
 }
 
-static int rcar_pcie_hw_init_gen2(struct rcar_pcie *pcie)
+static int rcar_pcie_phy_init_gen2(struct rcar_pcie *pcie)
 {
 	/*
 	 * These settings come from the R-Car Series, 2nd Generation User's
@@ -666,10 +666,10 @@ static int rcar_pcie_hw_init_gen2(struct
 	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
 	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
 
-	return rcar_pcie_hw_init(pcie);
+	return 0;
 }
 
-static int rcar_pcie_hw_init_gen3(struct rcar_pcie *pcie)
+static int rcar_pcie_phy_init_gen3(struct rcar_pcie *pcie)
 {
 	int err;
 
@@ -677,11 +677,7 @@ static int rcar_pcie_hw_init_gen3(struct
 	if (err)
 		return err;
 
-	err = phy_power_on(pcie->phy);
-	if (err)
-		return err;
-
-	return rcar_pcie_hw_init(pcie);
+	return phy_power_on(pcie->phy);
 }
 
 static int rcar_msi_alloc(struct rcar_msi *chip)
@@ -1070,17 +1066,18 @@ static int rcar_pcie_parse_map_dma_range
 }
 
 static const struct of_device_id rcar_pcie_of_match[] = {
-	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
+	{ .compatible = "renesas,pcie-r8a7779",
+	  .data = rcar_pcie_phy_init_h1 },
 	{ .compatible = "renesas,pcie-r8a7790",
-	  .data = rcar_pcie_hw_init_gen2 },
+	  .data = rcar_pcie_phy_init_gen2 },
 	{ .compatible = "renesas,pcie-r8a7791",
-	  .data = rcar_pcie_hw_init_gen2 },
+	  .data = rcar_pcie_phy_init_gen2 },
 	{ .compatible = "renesas,pcie-rcar-gen2",
-	  .data = rcar_pcie_hw_init_gen2 },
+	  .data = rcar_pcie_phy_init_gen2 },
 	{ .compatible = "renesas,pcie-r8a7795",
-	  .data = rcar_pcie_hw_init_gen3 },
+	  .data = rcar_pcie_phy_init_gen3 },
 	{ .compatible = "renesas,pcie-rcar-gen3",
-	  .data = rcar_pcie_hw_init_gen3 },
+	  .data = rcar_pcie_phy_init_gen3 },
 	{},
 };
 
@@ -1128,7 +1125,7 @@ static int rcar_pcie_probe(struct platfo
 	struct rcar_pcie *pcie;
 	unsigned int data;
 	int err;
-	int (*hw_init_fn)(struct rcar_pcie *);
+	int (*phy_init_fn)(struct rcar_pcie *);
 	struct pci_host_bridge *bridge;
 
 	bridge = pci_alloc_host_bridge(sizeof(*pcie));
@@ -1162,10 +1159,15 @@ static int rcar_pcie_probe(struct platfo
 	if (err)
 		goto err_pm_put;
 
-	/* Failure to get a link might just be that no cards are inserted */
-	hw_init_fn = of_device_get_match_data(dev);
-	err = hw_init_fn(pcie);
+	phy_init_fn = of_device_get_match_data(dev);
+	err = phy_init_fn(pcie);
 	if (err) {
+		dev_err(dev, "failed to init PCIe PHY\n");
+		goto err_pm_put;
+	}
+
+	/* Failure to get a link might just be that no cards are inserted */
+	if (rcar_pcie_hw_init(pcie)) {
 		dev_info(dev, "PCIe link down\n");
 		err = -ENODEV;
 		goto err_pm_put;
