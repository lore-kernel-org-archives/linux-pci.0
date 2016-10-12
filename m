Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755189AbcJLNs0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:26 -0400
Subject: [PATCH v2 6/8] PCI: imx6: Use generic DesignWare accessors
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:48:20 -0500
Message-ID: <20161012134820.28919.82110.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces already add in
pp->dbi_base, so use those instead of doing it ourselves in the imx6
driver.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   67 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 7dfe400..bedd436 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -97,13 +97,13 @@ struct imx6_pcie {
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
-	void __iomem *dbi_base = imx6_pcie->pp.dbi_base;
+	struct pcie_port *pp = &imx6_pcie->pp;
 	u32 val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = readl(dbi_base + PCIE_PHY_STAT);
+		val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
 		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
 		wait_counter++;
 
@@ -118,22 +118,22 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 
 static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 {
-	void __iomem *dbi_base = imx6_pcie->pp.dbi_base;
+	struct pcie_port *pp = &imx6_pcie->pp;
 	u32 val;
 	int ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	writel(val, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
 
 	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
-	writel(val, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	writel(val, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
@@ -141,7 +141,7 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
 static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 {
-	void __iomem *dbi_base = imx6_pcie->pp.dbi_base;
+	struct pcie_port *pp = &imx6_pcie->pp;
 	u32 val, phy_ctl;
 	int ret;
 
@@ -151,24 +151,24 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 
 	/* assert Read signal */
 	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
-	writel(phy_ctl, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
-	val = readl(dbi_base + PCIE_PHY_STAT);
+	val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
 	*data = val & 0xffff;
 
 	/* deassert Read signal */
-	writel(0x00, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, 0x00);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
 static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 {
-	void __iomem *dbi_base = imx6_pcie->pp.dbi_base;
+	struct pcie_port *pp = &imx6_pcie->pp;
 	u32 var;
 	int ret;
 
@@ -179,11 +179,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
 
 	/* capture data */
 	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
@@ -191,7 +191,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* deassert cap data */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
@@ -200,7 +200,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* assert wr signal */
 	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -209,14 +209,14 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* deassert wr signal */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
 	if (ret)
 		return ret;
 
-	writel(0x0, dbi_base + PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, 0x0);
 
 	return 0;
 }
@@ -284,10 +284,10 @@ static int imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
 		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
-			val = readl(pp->dbi_base + PCIE_PL_PFLR);
+			val = dw_pcie_readl_rc(pp, PCIE_PL_PFLR);
 			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
 			val |= PCIE_PL_PFLR_FORCE_LINK;
-			writel(val, pp->dbi_base + PCIE_PL_PFLR);
+			dw_pcie_writel_rc(pp, PCIE_PL_PFLR, val);
 
 			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -452,8 +452,8 @@ static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 		return 0;
 
 	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
 	return -ETIMEDOUT;
 }
 
@@ -465,7 +465,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	unsigned int retries;
 
 	for (retries = 0; retries < 200; retries++) {
-		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+		tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
 		/* Test if the speed change finished. */
 		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
 			return 0;
@@ -496,10 +496,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
+	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
 	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+	dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -513,10 +513,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
 	if (imx6_pcie->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-		tmp = readl(pp->dbi_base + PCIE_RC_LCR);
+		tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
 		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
-		writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+		dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
 	} else {
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
@@ -525,9 +525,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * Start Directed Speed Change so the best possible speed both link
 	 * partners support can be negotiated.
 	 */
-	tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
-	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
 	ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
 	if (ret) {
@@ -542,16 +542,15 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		goto err_reset_phy;
 	}
 
-	tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
+	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCSR);
 	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
 	return 0;
 
 err_reset_phy:
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
-	imx6_pcie_reset_phy(pp);
-
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
+	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
 
@@ -571,7 +570,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
-	return readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) &
+	return dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1) &
 			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
 }
 

