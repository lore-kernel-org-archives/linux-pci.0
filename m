Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34926 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbFLUYA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2015 16:24:00 -0400
Received: by iesa3 with SMTP id a3so31052118ies.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2015 13:23:59 -0700 (PDT)
Subject: [PATCH] PCI: imx6: Use "u32", not "uint32_t"
To: Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marek Vasut <marex@denx.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Troy Kisky <troy.kisky@boundarydevices.com>
Date: Fri, 12 Jun 2015 15:23:57 -0500
Message-ID: <20150612202357.17586.99216.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use "u32", not "uint32_t", for consistency.  Use "tmp", not "temp", for
consistency within the driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 2bbd38d..a032c01 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -354,7 +354,7 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 
 static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
 {
-	uint32_t tmp;
+	u32 tmp;
 	unsigned int retries;
 
 	for (retries = 0; retries < 200; retries++)
@@ -379,7 +379,7 @@ static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 static int imx6_pcie_start_link(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
-	uint32_t tmp;
+	u32 tmp;
 	int ret;
 
 	/*
@@ -450,19 +450,19 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)
 {
-	uint32_t temp;
+	u32 tmp;
 
-	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &temp);
-	temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		 PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, temp);
+	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
+	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
 
 	usleep_range(2000, 3000);
 
-	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &temp);
-	temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
+	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, temp);
+	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
 }
 
 static int imx6_pcie_link_up(struct pcie_port *pp)

