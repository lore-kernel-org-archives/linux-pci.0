Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755068AbcJLNsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:14 -0400
Subject: [PATCH v2 4/8] PCI: imx6: Pass struct imx6_pcie to PHY accessors
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:48:04 -0500
Message-ID: <20161012134804.28919.79193.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pass the struct imx6_pcie pointer, not dbi_base address, to PHY accessors.
This enables future simplifications.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 7af64b2..8a6a8d5 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -95,8 +95,9 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
-static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
+static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
+	void __iomem *dbi_base = imx6_pcie->pp.dbi_base;
 	u32 val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
@@ -115,8 +116,9 @@ static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
 	return -ETIMEDOUT;
 }
 
-static int pcie_phy_wait_ack(void __iomem *dbi_base, int addr)
+static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 {
+	void __iomem *dbi_base = imx6_pcie->pp.dbi_base;
 	u32 val;
 	int ret;
 
@@ -126,23 +128,24 @@ static int pcie_phy_wait_ack(void __iomem *dbi_base, int addr)
 	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
 	writel(val, dbi_base + PCIE_PHY_CTRL);
 
-	ret = pcie_phy_poll_ack(dbi_base, 1);
+	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
 	writel(val, dbi_base + PCIE_PHY_CTRL);
 
-	return pcie_phy_poll_ack(dbi_base, 0);
+	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
-static int pcie_phy_read(void __iomem *dbi_base, int addr, int *data)
+static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 {
+	void __iomem *dbi_base = imx6_pcie->pp.dbi_base;
 	u32 val, phy_ctl;
 	int ret;
 
-	ret = pcie_phy_wait_ack(dbi_base, addr);
+	ret = pcie_phy_wait_ack(imx6_pcie, addr);
 	if (ret)
 		return ret;
 
@@ -150,7 +153,7 @@ static int pcie_phy_read(void __iomem *dbi_base, int addr, int *data)
 	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
 	writel(phy_ctl, dbi_base + PCIE_PHY_CTRL);
 
-	ret = pcie_phy_poll_ack(dbi_base, 1);
+	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
@@ -160,17 +163,18 @@ static int pcie_phy_read(void __iomem *dbi_base, int addr, int *data)
 	/* deassert Read signal */
 	writel(0x00, dbi_base + PCIE_PHY_CTRL);
 
-	return pcie_phy_poll_ack(dbi_base, 0);
+	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
-static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
+static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 {
+	void __iomem *dbi_base = imx6_pcie->pp.dbi_base;
 	u32 var;
 	int ret;
 
 	/* write addr */
 	/* cap addr */
-	ret = pcie_phy_wait_ack(dbi_base, addr);
+	ret = pcie_phy_wait_ack(imx6_pcie, addr);
 	if (ret)
 		return ret;
 
@@ -181,7 +185,7 @@ static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
 	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
 	writel(var, dbi_base + PCIE_PHY_CTRL);
 
-	ret = pcie_phy_poll_ack(dbi_base, 1);
+	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
@@ -190,7 +194,7 @@ static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
 	writel(var, dbi_base + PCIE_PHY_CTRL);
 
 	/* wait for ack de-assertion */
-	ret = pcie_phy_poll_ack(dbi_base, 0);
+	ret = pcie_phy_poll_ack(imx6_pcie, 0);
 	if (ret)
 		return ret;
 
@@ -199,7 +203,7 @@ static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
 	writel(var, dbi_base + PCIE_PHY_CTRL);
 
 	/* wait for ack */
-	ret = pcie_phy_poll_ack(dbi_base, 1);
+	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
@@ -208,7 +212,7 @@ static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
 	writel(var, dbi_base + PCIE_PHY_CTRL);
 
 	/* wait for ack de-assertion */
-	ret = pcie_phy_poll_ack(dbi_base, 0);
+	ret = pcie_phy_poll_ack(imx6_pcie, 0);
 	if (ret)
 		return ret;
 
@@ -219,19 +223,20 @@ static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)
 {
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	u32 tmp;
 
-	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
+	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
+	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 
 	usleep_range(2000, 3000);
 
-	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &tmp);
+	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, tmp);
+	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
 /*  Added for PCI abort handling */

