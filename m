Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35677 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeECThz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 15:37:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id y72-v6so13925783lfd.2
        for <linux-pci@vger.kernel.org>; Thu, 03 May 2018 12:37:54 -0700 (PDT)
Subject: [PATCH v3 2/5] pcie-rcar: remove PHYRDY polling from
 rcar_pcie_hw_init_h1()
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Message-ID: <c4fb4657-6628-fedc-cecf-0639817f4438@cogentembedded.com>
Date: Thu, 3 May 2018 22:37:52 +0300
MIME-Version: 1.0
In-Reply-To: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we've added PCIEPHYSR.PHYRDY polling to rcar_pcie_hw_init(),
there is no need anymore  for polling the PHY specific register in
rcar_pcie_hw_init_h1() -- remove it.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes in version 3:
- added Simon's tag;
- refreshed atop of Marek's patch.

 drivers/pci/host/pcie-rcar.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

Index: pci/drivers/pci/host/pcie-rcar.c
===================================================================
--- pci.orig/drivers/pci/host/pcie-rcar.c
+++ pci/drivers/pci/host/pcie-rcar.c
@@ -103,7 +103,6 @@
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
