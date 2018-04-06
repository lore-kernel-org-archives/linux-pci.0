Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33171 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDFLFE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Apr 2018 07:05:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id z73so1384685wrb.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Apr 2018 04:05:03 -0700 (PDT)
Subject: [PATCH 2/4] pcie-rcar: remove PHYRDY polling from
 rcar_pcie_hw_init_h1()
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
Message-ID: <5322b1c2-109d-bd0c-7785-697ca6a5324a@cogentembedded.com>
Date: Fri, 6 Apr 2018 14:04:52 +0300
MIME-Version: 1.0
In-Reply-To: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
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
