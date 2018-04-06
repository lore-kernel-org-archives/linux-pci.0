Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36574 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDFLCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Apr 2018 07:02:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id y55so1370138wry.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Apr 2018 04:02:55 -0700 (PDT)
Subject: [PATCH 1/4] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
Message-ID: <35e8fb4a-4b43-dac9-7a6f-cc7083c06453@cogentembedded.com>
Date: Fri, 6 Apr 2018 14:02:52 +0300
MIME-Version: 1.0
In-Reply-To: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
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
