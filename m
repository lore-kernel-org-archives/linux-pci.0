Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45771 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeECTgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 15:36:41 -0400
Received: by mail-lf0-f68.google.com with SMTP id y14-v6so27301522lfy.12
        for <linux-pci@vger.kernel.org>; Thu, 03 May 2018 12:36:40 -0700 (PDT)
Subject: [PATCH v3 1/5] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Message-ID: <89f4bb11-918a-397d-0dd8-5a6e630504f7@cogentembedded.com>
Date: Thu, 3 May 2018 22:36:37 +0300
MIME-Version: 1.0
In-Reply-To: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In  all the R-Car gen1/2/3 manuals, we are instructed to poll PCIEPHYSR
for PHYRDY=1  at  an early stage of the PCIEC initialization -- while
the driver only does this on R-Car H1 (polling a PHY specific register).
Add the PHYRDY polling to rcar_pcie_hw_init(). Note that without the
special PHY driver on the R-Car V3H (R8A77980) the PCIEC initialization
just freezes the kernel -- adding the PHYRDY polling allows the init code
to exit gracefully on timeout (PHY starts powered down after reset on this
SoC).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes in version 3:
- used the BIT() macro in #define PHYRDY;
- added the SoC model # to the patch description;
- added Rob's and Simon's tags;
- refreshed atop of Marek's patch.

 drivers/pci/host/pcie-rcar.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: pci/drivers/pci/host/pcie-rcar.c
===================================================================
--- pci.orig/drivers/pci/host/pcie-rcar.c
+++ pci/drivers/pci/host/pcie-rcar.c
@@ -37,6 +37,8 @@
 #define PCIECDR			0x000020
 #define PCIEMSR			0x000028
 #define PCIEINTXR		0x000400
+#define PCIEPHYSR		0x0007f0
+#define  PHYRDY			BIT(0)
 #define PCIEMSITXR		0x000840
 
 /* Transfer control */
@@ -527,6 +529,20 @@ static void phy_write_reg(struct rcar_pc
 	phy_wait_for_ack(pcie);
 }
 
+static int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
+{
+	unsigned int timeout = 10;
+
+	while (timeout--) {
+		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
+			return 0;
+
+		msleep(5);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
 {
 	unsigned int timeout = 10;
@@ -551,6 +567,10 @@ static int rcar_pcie_hw_init(struct rcar
 	/* Set mode */
 	rcar_pci_write_reg(pcie, 1, PCIEMSR);
 
+	err = rcar_pcie_wait_for_phyrdy(pcie);
+	if (err)
+		return err;
+
 	/*
 	 * Initial header for port config space is type 1, set the device
 	 * class to match. Hardware takes care of propagating the IDSETR
