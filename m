Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34029 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbbFDWCP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 18:02:15 -0400
Received: by obew15 with SMTP id w15so42550190obe.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 15:02:14 -0700 (PDT)
Subject: [PATCH 5/5] PCI: designware: Wait for link to come up with
 consistent style
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 04 Jun 2015 17:02:12 -0500
Message-ID: <20150604220212.4377.70512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All the DesignWare-based host drivers loop waiting for the link to come up,
but they do it several ways that are needlessly different.

Wait for the link to come up in a consistent style across all the
DesignWare drivers.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c     |   16 ++++++----------
 drivers/pci/host/pci-exynos.c     |   34 +++++++++++++++-------------------
 drivers/pci/host/pci-imx6.c       |   20 +++++++++-----------
 drivers/pci/host/pci-keystone.c   |   16 +++++++---------
 drivers/pci/host/pci-layerscape.c |   14 ++++++--------
 drivers/pci/host/pcie-spear13xx.c |   17 ++++++++---------
 6 files changed, 51 insertions(+), 66 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index e3d15d7..80db09e 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -93,9 +93,9 @@ static int dra7xx_pcie_link_up(struct pcie_port *pp)
 
 static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 {
-	u32 reg;
-	unsigned int retries = 1000;
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	u32 reg;
+	unsigned int retries;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(pp->dev, "link is already up\n");
@@ -106,18 +106,14 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	while (retries--) {
+	for (retries = 0; retries < 1000; retries++) {
 		if (dw_pcie_link_up(pp))
-			break;
+			return 0;
 		usleep_range(10, 20);
 	}
 
-	if (retries == 0) {
-		dev_err(pp->dev, "link is not up\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	dev_err(pp->dev, "link is not up\n");
+	return -EINVAL;
 }
 
 static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index c139237..f9f468d 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -316,9 +316,9 @@ static void exynos_pcie_assert_reset(struct pcie_port *pp)
 
 static int exynos_pcie_establish_link(struct pcie_port *pp)
 {
-	u32 val;
-	int count = 0;
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	u32 val;
+	unsigned int retries;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(pp->dev, "Link already up\n");
@@ -357,27 +357,23 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 			  PCIE_APP_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
-	while (!dw_pcie_link_up(pp)) {
-		mdelay(100);
-		count++;
-		if (count == 10) {
-			while (exynos_phy_readl(exynos_pcie,
-						PCIE_PHY_PLL_LOCKED) == 0) {
-				val = exynos_blk_readl(exynos_pcie,
-						       PCIE_PHY_PLL_LOCKED);
-				dev_info(pp->dev, "PLL Locked: 0x%x\n", val);
-			}
-			/* power off phy */
-			exynos_pcie_power_off_phy(pp);
-
-			dev_err(pp->dev, "PCIe Link Fail\n");
-			return -EINVAL;
+	for (retries = 0; retries < 10; retries++) {
+		if (dw_pcie_link_up(pp)) {
+			dev_info(pp->dev, "Link up\n");
+			return 0;
 		}
+		mdelay(100);
 	}
 
-	dev_info(pp->dev, "Link up\n");
+	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
+		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
+		dev_info(pp->dev, "PLL Locked: 0x%x\n", val);
+	}
+	/* power off phy */
+	exynos_pcie_power_off_phy(pp);
 
-	return 0;
+	dev_err(pp->dev, "PCIe Link Fail\n");
+	return -EINVAL;
 }
 
 static void exynos_pcie_clear_irq_pulse(struct pcie_port *pp)
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 8cc0123..af7da8a 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -335,21 +335,19 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 
 static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 {
-	int count = 200;
+	unsigned int retries;
 
-	while (!dw_pcie_link_up(pp)) {
+	for (retries = 0; retries < 200; retries++) {
+		if (dw_pcie_link_up(pp))
+			return 0;
 		usleep_range(100, 1000);
-		if (--count)
-			continue;
-
-		dev_err(pp->dev, "phy link never came up\n");
-		dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-			readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-			readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
-		return -EINVAL;
 	}
 
-	return 0;
+	dev_err(pp->dev, "phy link never came up\n");
+	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
+		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
+		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+	return -EINVAL;
 }
 
 static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 75333b0..b75d684 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -88,7 +88,7 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
 static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
-	int count = 200;
+	unsigned int retries;
 
 	dw_pcie_setup_rc(pp);
 
@@ -99,17 +99,15 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 
 	ks_dw_pcie_initiate_link_train(ks_pcie);
 	/* check if the link is up or not */
-	while (!dw_pcie_link_up(pp)) {
+	for (retries = 0; retries < 200; retries++) {
+		if (dw_pcie_link_up(pp))
+			return 0;
 		usleep_range(100, 1000);
-		if (--count) {
-			ks_dw_pcie_initiate_link_train(ks_pcie);
-			continue;
-		}
-		dev_err(pp->dev, "phy link never came up\n");
-		return -EINVAL;
+		ks_dw_pcie_initiate_link_train(ks_pcie);
 	}
 
-	return 0;
+	dev_err(pp->dev, "phy link never came up\n");
+	return -EINVAL;
 }
 
 static void ks_pcie_msi_irq_handler(unsigned int irq, struct irq_desc *desc)
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 434b116..b2328ea1 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -64,18 +64,16 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 
 static int ls_pcie_establish_link(struct pcie_port *pp)
 {
-	int count = 0;
+	unsigned int retries;
 
-	while (!dw_pcie_link_up(pp)) {
+	for (retries = 0; retries < 200; retries++) {
+		if (dw_pcie_link_up(pp))
+			return 0;
 		usleep_range(100, 1000);
-		count++;
-		if (count >= 200) {
-			dev_err(pp->dev, "phy link never came up\n");
-			return -EINVAL;
-		}
 	}
 
-	return 0;
+	dev_err(pp->dev, "phy link never came up\n");
+	return -EINVAL;
 }
 
 static void ls_pcie_host_init(struct pcie_port *pp)
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 020d788..dfec428 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -146,10 +146,10 @@ struct pcie_app_reg {
 static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 {
 	u32 val;
-	int count = 0;
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
+	unsigned int retries;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(pp->dev, "link already up\n");
@@ -201,17 +201,16 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 			&app_reg->app_ctrl_0);
 
 	/* check if the link is up or not */
-	while (!dw_pcie_link_up(pp)) {
-		mdelay(100);
-		count++;
-		if (count == 10) {
-			dev_err(pp->dev, "link Fail\n");
-			return -EINVAL;
+	for (retries = 0; retries < 10; retries++) {
+		if (dw_pcie_link_up(pp)) {
+			dev_info(pp->dev, "link up\n");
+			return 0;
 		}
+		mdelay(100);
 	}
-	dev_info(pp->dev, "link up\n");
 
-	return 0;
+	dev_err(pp->dev, "link Fail\n");
+	return -EINVAL;
 }
 
 static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)

