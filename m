Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42342 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeDHSBr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Apr 2018 14:01:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id s18so6360577wrg.9
        for <linux-pci@vger.kernel.org>; Sun, 08 Apr 2018 11:01:46 -0700 (PDT)
Subject: [PATCH v2 2/5] pcie-rcar: remove PHYRDY polling from
 rcar_pcie_hw_init_h1()
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
Message-ID: <3c582c72-cee2-54b3-f82a-186999450f44@cogentembedded.com>
Date: Sun, 8 Apr 2018 21:01:44 +0300
MIME-Version: 1.0
In-Reply-To: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we've added PCIEPHYSR.PHYRDY polling to rcar_pcie_hw_init(),
there is no need anymore  for polling the PHY specific register in
rcar_pcie_hw_init_h1() -- remove it.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/pci/host/pcie-rcar.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

Index: pci/drivers/pci/host/pcie-rcar.c
===================================================================
--- pci.orig/drivers/pci/host/pcie-rcar.c
+++ pci/drivers/pci/host/pcie-rcar.c
@@ -102,7 +102,6 @@
 #define  LANE_POS		8
 #define  ADR_POS		0
 #define H1_PCIEPHYDOUTR		0x040014
-#define H1_PCIEPHYSR		0x040018
 
 /* R-Car Gen2 PHY */
 #define GEN2_PCIEPHYADDR	0x780
@@ -627,8 +626,6 @@ static int rcar_pcie_hw_init(struct rcar
 
 static int rcar_pcie_hw_init_h1(struct rcar_pcie *pcie)
 {
-	unsigned int timeout = 10;
-
 	/* Initialize the phy */
 	phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
 	phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
@@ -647,14 +644,7 @@ static int rcar_pcie_hw_init_h1(struct r
 	phy_write_reg(pcie, 0, 0x64, 0x1, 0x3F0F1F0F);
 	phy_write_reg(pcie, 0, 0x66, 0x1, 0x00008000);
 
-	while (timeout--) {
-		if (rcar_pci_read_reg(pcie, H1_PCIEPHYSR))
-			return rcar_pcie_hw_init(pcie);
-
-		msleep(5);
-	}
-
-	return -ETIMEDOUT;
+	return rcar_pcie_hw_init(pcie);
 }
 
 static int rcar_pcie_hw_init_gen2(struct rcar_pcie *pcie)
