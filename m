Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44169 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752082AbcAOS4y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 13:56:54 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>, linux-pci@vger.kernel.org,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 1/4] PCI: imx6: move PHY reset function to other PHY handling functions
Date: Fri, 15 Jan 2016 19:56:47 +0100
Message-Id: <1452884210-11359-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
References: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This moves the PHY reset function to the other PHY related
functions in the file, which is mostly a cosmetic change, but also
allows to do the following changes without introducing needless
forward declarations.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 22e8224126fd..48ee2ed26be3 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -202,6 +202,23 @@ static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
 	return 0;
 }
 
+static void imx6_pcie_reset_phy(struct pcie_port *pp)
+{
+	u32 tmp;
+
+	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
+	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
+
+	usleep_range(2000, 3000);
+
+	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
+	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
+}
+
 /*  Added for PCI abort handling */
 static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
@@ -441,23 +458,6 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 		dw_pcie_msi_init(pp);
 }
 
-static void imx6_pcie_reset_phy(struct pcie_port *pp)
-{
-	u32 tmp;
-
-	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
-	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
-
-	usleep_range(2000, 3000);
-
-	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
-	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
-}
-
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
 	u32 rc, debug_r0, rx_valid;
-- 
2.6.4

