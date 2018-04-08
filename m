Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54548 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeDHR7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Apr 2018 13:59:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id r191so13332334wmg.4
        for <linux-pci@vger.kernel.org>; Sun, 08 Apr 2018 10:59:39 -0700 (PDT)
Subject: [PATCH v2 1/5] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
Message-ID: <7fc00e4d-68ee-3092-a705-292140d4e6df@cogentembedded.com>
Date: Sun, 8 Apr 2018 20:59:37 +0300
MIME-Version: 1.0
In-Reply-To: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In  all the R-Car gen1/2/3 manuals, we are instructed to poll PCIEPHYSR
for PHYRDY=1  at  an early stage of the PCIEC initialization -- while
the driver only does this on R-Car H1 (polling a PHY specific register).
Add the PHYRDY polling to rcar_pcie_hw_init(). Note that without the
special PHY driver on the R-Car V3H the PCIEC initialization just freezes
the kernel --  adding the PHYRDY polling allows the init code to exit
gracefully on timeout (PHY starts powered down after reset on this SoC).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/pci/host/pcie-rcar.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: pci/drivers/pci/host/pcie-rcar.c
===================================================================
--- pci.orig/drivers/pci/host/pcie-rcar.c
+++ pci/drivers/pci/host/pcie-rcar.c
@@ -36,6 +36,8 @@
 #define PCIECDR			0x000020
 #define PCIEMSR			0x000028
 #define PCIEINTXR		0x000400
+#define PCIEPHYSR		0x0007f0
+#define  PHYRDY			1
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
