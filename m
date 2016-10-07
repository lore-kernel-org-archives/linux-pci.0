Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938859AbcJGQjT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:39:19 -0400
Subject: [PATCH 03/10] PCI: imx6: Add register accessors
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:38:59 -0500
Message-ID: <20161007163859.25776.98950.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device-specific register accessors for consistency across host drivers.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   74 ++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 11c8a8b..e4bd92b 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -96,15 +96,24 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
+static u32 imx6_pcie_readl(struct imx6_pcie *imx6, u32 offset)
+{
+	return readl(imx6->pp.dbi_base + offset);
+}
+
+static void imx6_pcie_writel(struct imx6_pcie *imx6, u32 offset, u32 val)
+{
+	writel(val, imx6->pp.dbi_base + offset);
+}
+
 static int imx6_pcie_phy_poll_ack(struct imx6_pcie *imx6, int exp_val)
 {
-	void __iomem *dbi_base = imx6->pp.dbi_base;
 	u32 val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = readl(dbi_base + PCIE_PHY_STAT);
+		val = imx6_pcie_readl(imx6, PCIE_PHY_STAT);
 		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
 		wait_counter++;
 
@@ -119,22 +128,21 @@ static int imx6_pcie_phy_poll_ack(struct imx6_pcie *imx6, int exp_val)
 
 static int imx6_pcie_phy_wait_ack(struct imx6_pcie *imx6, int addr)
 {
-	void __iomem *dbi_base = imx6->pp.dbi_base;
 	u32 val;
 	int ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	writel(val, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, val, PCIE_PHY_CTRL);
 
 	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
-	writel(val, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, val, PCIE_PHY_CTRL);
 
 	ret = imx6_pcie_phy_poll_ack(imx6, 1);
 	if (ret)
 		return ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	writel(val, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, val, PCIE_PHY_CTRL);
 
 	return imx6_pcie_phy_poll_ack(imx6, 0);
 }
@@ -142,7 +150,6 @@ static int imx6_pcie_phy_wait_ack(struct imx6_pcie *imx6, int addr)
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
 static int imx6_pcie_phy_read(struct imx6_pcie *imx6, int addr, int *data)
 {
-	void __iomem *dbi_base = imx6->pp.dbi_base;
 	u32 val, phy_ctl;
 	int ret;
 
@@ -152,24 +159,23 @@ static int imx6_pcie_phy_read(struct imx6_pcie *imx6, int addr, int *data)
 
 	/* assert Read signal */
 	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
-	writel(phy_ctl, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, phy_ctl, PCIE_PHY_CTRL);
 
 	ret = imx6_pcie_phy_poll_ack(imx6, 1);
 	if (ret)
 		return ret;
 
-	val = readl(dbi_base + PCIE_PHY_STAT);
+	val = imx6_pcie_readl(imx6, PCIE_PHY_STAT);
 	*data = val & 0xffff;
 
 	/* deassert Read signal */
-	writel(0x00, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, 0x00, PCIE_PHY_CTRL);
 
 	return imx6_pcie_phy_poll_ack(imx6, 0);
 }
 
 static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 {
-	void __iomem *dbi_base = imx6->pp.dbi_base;
 	u32 var;
 	int ret;
 
@@ -180,11 +186,11 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 		return ret;
 
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
 
 	/* capture data */
 	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
 
 	ret = imx6_pcie_phy_poll_ack(imx6, 1);
 	if (ret)
@@ -192,7 +198,7 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 
 	/* deassert cap data */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
 
 	/* wait for ack de-assertion */
 	ret = imx6_pcie_phy_poll_ack(imx6, 0);
@@ -201,7 +207,7 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 
 	/* assert wr signal */
 	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
 
 	/* wait for ack */
 	ret = imx6_pcie_phy_poll_ack(imx6, 1);
@@ -210,14 +216,14 @@ static int imx6_pcie_phy_write(struct imx6_pcie *imx6, int addr, int data)
 
 	/* deassert wr signal */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	writel(var, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, var, PCIE_PHY_CTRL);
 
 	/* wait for ack de-assertion */
 	ret = imx6_pcie_phy_poll_ack(imx6, 0);
 	if (ret)
 		return ret;
 
-	writel(0x0, dbi_base + PCIE_PHY_CTRL);
+	imx6_pcie_writel(imx6, 0x0, PCIE_PHY_CTRL);
 
 	return 0;
 }
@@ -286,10 +292,10 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 
 		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
 		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
-			val = readl(pp->dbi_base + PCIE_PL_PFLR);
+			val = imx6_pcie_readl(imx6, PCIE_PL_PFLR);
 			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
 			val |= PCIE_PL_PFLR_FORCE_LINK;
-			writel(val, pp->dbi_base + PCIE_PL_PFLR);
+			imx6_pcie_writel(imx6, val, PCIE_PL_PFLR);
 
 			regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -451,8 +457,8 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 		return 0;
 
 	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+		imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R0),
+		imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R1));
 	return -ETIMEDOUT;
 }
 
@@ -462,7 +468,7 @@ static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
 	unsigned int retries;
 
 	for (retries = 0; retries < 200; retries++) {
-		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+		tmp = imx6_pcie_readl(imx6, PCIE_LINK_WIDTH_SPEED_CONTROL);
 		/* Test if the speed change finished. */
 		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
 			return 0;
@@ -491,10 +497,10 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
+	tmp = imx6_pcie_readl(imx6, PCIE_RC_LCR);
 	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+	imx6_pcie_writel(imx6, tmp, PCIE_RC_LCR);
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
@@ -508,10 +514,10 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 
 	if (imx6->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-		tmp = readl(pp->dbi_base + PCIE_RC_LCR);
+		tmp = imx6_pcie_readl(imx6, PCIE_RC_LCR);
 		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
-		writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+		imx6_pcie_writel(imx6, tmp, PCIE_RC_LCR);
 	} else {
 		dev_info(pp->dev, "Link: Gen2 disabled\n");
 	}
@@ -520,9 +526,9 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	 * Start Directed Speed Change so the best possible speed both link
 	 * partners support can be negotiated.
 	 */
-	tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	tmp = imx6_pcie_readl(imx6, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
-	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	imx6_pcie_writel(imx6, tmp, PCIE_LINK_WIDTH_SPEED_CONTROL);
 
 	ret = imx6_pcie_wait_for_speed_change(pp);
 	if (ret) {
@@ -537,15 +543,15 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 		goto err_reset_phy;
 	}
 
-	tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
+	tmp = imx6_pcie_readl(imx6, PCIE_RC_LCSR);
 	dev_info(pp->dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
 	return 0;
 
 err_reset_phy:
 	dev_dbg(pp->dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
-	imx6_pcie_reset_phy(pp);
+		imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R0),
+		imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R1));
+	imx6_pcie_reset_phy(imx6);
 
 	return ret;
 }
@@ -568,7 +574,9 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
-	return readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) &
+	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
+
+	return imx6_pcie_readl(imx6, PCIE_PHY_DEBUG_R1) &
 			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
 }
 

