Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938859AbcJGQjs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:39:48 -0400
Subject: [PATCH 08/10] PCI: imx6: Replace imx6_pcie_readl() with
 dw_pcie_readl_rc()
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:39:39 -0500
Message-ID: <20161007163939.25776.84197.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces do the same as
imx6_pcie_readl() and imx6_pcie_writel(), and they also give us a clue that
we're using the DesignWare-generic functionality.  Use the dw_*()
interfaces and remove the hisi-specific ones.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   73 +++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 9971b73..2d9ccbb 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -95,24 +95,15 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
-static u32 imx6_pcie_readl(struct imx6_pcie *imx6, u32 offset)
-{
-	return readl(imx6->pp.dbi_base + offset);
-}
-
-static void imx6_pcie_writel(struct imx6_pcie *imx6, u32 offset, u32 val)
-{
-	writel(val, imx6->pp.dbi_base + offset);
-}
-
 static int imx6_pcie_phy_poll_ack(struct imx6_pcie *imx6, int exp_val)
 {
+	struct pcie_port *pp = &imx6->pp;
 	u32 val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = imx6_pcie_readl(imx6, PCIE_PHY_STAT);
+		val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
 		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
 		wait_counter++;
 
@@ -127,21 +118,22 @@ static int imx6_pcie_phy_poll_ack(struct imx6_pcie *imx6, int exp_val)
 
 static int imx6_pcie_phy_wait_ack(struct imx6_pcie *imx6, int addr)
 {
+	struct pcie_port *pp = &imx6->pp;
 	u32 val;
 	int ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	imx6_pcie_writel(imx6, val, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, val, PCIE_PHY_CTRL);
 
 	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
-	imx6_pcie_writel(imx6, val, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, val, PCIE_PHY_CTRL);
 
 	ret = imx6_pcie_phy_poll_ack(imx6, 1);
 	if (ret)
 		return ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	imx6_pcie_writel(imx6, val, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, val, PCIE_PHY_CTRL);
 
 	return imx6_pcie_phy_poll_ack(imx6, 0);
 }
@@ -149,6 +141,7 @@ static int imx6_pcie_phy_wait_ack(struct imx6_pcie *imx6, int addr)
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
 static int imx6_pcie_phy_read(struct imx6_pcie *imx6, int addr, int *data)
 {
+	struct pcie_port *pp = &imx6->pp;
 	u32 val, phy_ctl;
 	int ret;
 
@@ -158,23 +151,24 @@ static int imx6_pcie_phy_read(struct imx6_pcie *imx6, int addr, int *data)
 
 	/* assert Read signal */
 	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
-	imx6_pcie_writel(imx6, phy_ctl, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, phy_ctl, PCIE_PHY_CTRL);
 
 	ret = imx6_pcie_phy_poll_ack(imx6, 1);
 	if (ret)
 		return ret;
 
-	val = imx6_pcie_readl(imx6, PCIE_PHY_STAT);
+	val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
 	*data = val & 0xffff;
 
 	/* deassert Read signal */
-	imx6_pcie_writel(imx6, 0x00, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, 0x00, PCIE_PHY_CTRL);
 
 	return imx6_pcie_phy_poll_ack(imx6, 0);
 }
 
 static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 {
+	struct pcie_port *pp = &imx6->pp;
 	u32 var;
 	int ret;
 
@@ -185,11 +179,11 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 		return ret;
 
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, var, PCIE_PHY_CTRL);
 
 	/* capture data */
 	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
-	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, var, PCIE_PHY_CTRL);
 
 	ret = imx6_pcie_phy_poll_ack(imx6, 1);
 	if (ret)
@@ -197,7 +191,7 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 
 	/* deassert cap data */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, var, PCIE_PHY_CTRL);
 
 	/* wait for ack de-assertion */
 	ret = imx6_pcie_phy_poll_ack(imx6, 0);
@@ -206,7 +200,7 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 
 	/* assert wr signal */
 	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
-	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, var, PCIE_PHY_CTRL);
 
 	/* wait for ack */
 	ret = imx6_pcie_phy_poll_ack(imx6, 1);
@@ -215,14 +209,14 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 
 	/* deassert wr signal */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, var, PCIE_PHY_CTRL);
 
 	/* wait for ack de-assertion */
 	ret = imx6_pcie_phy_poll_ack(imx6, 0);
 	if (ret)
 		return ret;
 
-	imx6_pcie_writel(imx6, 0x0, PCIE_PHY_CTRL);
+	dw_pcie_writel_rc(pp, 0x0, PCIE_PHY_CTRL);
 
 	return 0;
 }
@@ -253,6 +247,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6)
 {
+	struct pcie_port *pp = &imx6->pp;
 	u32 val, gpr1, gpr12;
 
 	switch (imx6->variant) {
@@ -289,10 +284,10 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6)
 
 		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
 		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
-			val = imx6_pcie_readl(imx6, PCIE_PL_PFLR);
+			val = dw_pcie_readl_rc(pp, PCIE_PL_PFLR);
 			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
 			val |= PCIE_PL_PFLR_FORCE_LINK;
-			imx6_pcie_writel(imx6, val, PCIE_PL_PFLR);
+			dw_pcie_writel_rc(pp, val, PCIE_PL_PFLR);
 
 			regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -450,8 +445,8 @@ static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6)
 		return 0;
 
 	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R0),
-		imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
 	return -ETIMEDOUT;
 }
 
@@ -462,7 +457,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6)
 	unsigned int retries;
 
 	for (retries = 0; retries < 200; retries++) {
-		tmp = imx6_pcie_readl(imx6, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
 		/* Test if the speed change finished. */
 		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
 			return 0;
@@ -492,10 +487,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = imx6_pcie_readl(imx6, PCIE_RC_LCR);
+	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
 	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	imx6_pcie_writel(imx6, tmp, PCIE_RC_LCR);
+	dw_pcie_writel_rc(pp, tmp, PCIE_RC_LCR);
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
@@ -509,10 +504,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6)
 
 	if (imx6->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-		tmp = imx6_pcie_readl(imx6, PCIE_RC_LCR);
+		tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
 		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
-		imx6_pcie_writel(imx6, tmp, PCIE_RC_LCR);
+		dw_pcie_writel_rc(pp, tmp, PCIE_RC_LCR);
 	} else {
 		dev_info(pp->dev, "Link: Gen2 disabled\n");
 	}
@@ -521,9 +516,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6)
 	 * Start Directed Speed Change so the best possible speed both link
 	 * partners support can be negotiated.
 	 */
-	tmp = imx6_pcie_readl(imx6, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
-	imx6_pcie_writel(imx6, tmp, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	dw_pcie_writel_rc(pp, tmp, PCIE_LINK_WIDTH_SPEED_CONTROL);
 
 	ret = imx6_pcie_wait_for_speed_change(imx6);
 	if (ret) {
@@ -538,14 +533,14 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6)
 		goto err_reset_phy;
 	}
 
-	tmp = imx6_pcie_readl(imx6, PCIE_RC_LCSR);
+	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCSR);
 	dev_info(pp->dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
 	return 0;
 
 err_reset_phy:
 	dev_dbg(pp->dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
-		imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R0),
-		imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
 	imx6_pcie_reset_phy(imx6);
 
 	return ret;
@@ -567,9 +562,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
-	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
-
-	return imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R1) &
+	return dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1) &
 			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
 }
 

