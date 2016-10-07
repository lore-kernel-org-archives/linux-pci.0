Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965058AbcJGQny (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:43:54 -0400
Subject: [PATCH 2/5] PCI: spear: Name private struct pointer "spear13xx"
 consistently
To: Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:43:44 -0500
Message-ID: <20161007164344.26585.71348.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164336.26585.23271.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164336.26585.23271.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "spear13xx", for struct spear13xx_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-spear13xx.c |   50 +++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 73f17da..d96f5f2 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -75,8 +75,8 @@ struct pcie_app_reg {
 static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 {
 	u32 val;
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
-	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct spear13xx_pcie *spear13xx = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx->app_base;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
 
 	if (dw_pcie_link_up(pp)) {
@@ -102,7 +102,7 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 * if is_gen1 is set then handle it, so that some buggy card
 	 * also works
 	 */
-	if (spear13xx_pcie->is_gen1) {
+	if (spear13xx->is_gen1) {
 		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
 					4, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
@@ -134,8 +134,8 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
-	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct spear13xx_pcie *spear13xx = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx->app_base;
 	unsigned int status;
 
 	status = readl(&app_reg->int_sts);
@@ -152,8 +152,8 @@ static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 
 static void spear13xx_pcie_enable_interrupts(struct pcie_port *pp)
 {
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
-	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct spear13xx_pcie *spear13xx = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx->app_base;
 
 	/* Enable MSI interrupt */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -165,8 +165,8 @@ static void spear13xx_pcie_enable_interrupts(struct pcie_port *pp)
 
 static int spear13xx_pcie_link_up(struct pcie_port *pp)
 {
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
-	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct spear13xx_pcie *spear13xx = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx->app_base;
 
 	if (readl(&app_reg->app_status_1) & XMLH_LINK_UP)
 		return 1;
@@ -218,20 +218,20 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
 
 static int spear13xx_pcie_probe(struct platform_device *pdev)
 {
-	struct spear13xx_pcie *spear13xx_pcie;
+	struct spear13xx_pcie *spear13xx;
 	struct pcie_port *pp;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
 	int ret;
 
-	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie), GFP_KERNEL);
-	if (!spear13xx_pcie)
+	spear13xx = devm_kzalloc(dev, sizeof(*spear13xx), GFP_KERNEL);
+	if (!spear13xx)
 		return -ENOMEM;
 
-	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-	if (IS_ERR(spear13xx_pcie->phy)) {
-		ret = PTR_ERR(spear13xx_pcie->phy);
+	spear13xx->phy = devm_phy_get(dev, "pcie-phy");
+	if (IS_ERR(spear13xx->phy)) {
+		ret = PTR_ERR(spear13xx->phy);
 		if (ret == -EPROBE_DEFER)
 			dev_info(dev, "probe deferred\n");
 		else
@@ -239,20 +239,20 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	phy_init(spear13xx_pcie->phy);
+	phy_init(spear13xx->phy);
 
-	spear13xx_pcie->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(spear13xx_pcie->clk)) {
+	spear13xx->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(spear13xx->clk)) {
 		dev_err(dev, "couldn't get clk for pcie\n");
-		return PTR_ERR(spear13xx_pcie->clk);
+		return PTR_ERR(spear13xx->clk);
 	}
-	ret = clk_prepare_enable(spear13xx_pcie->clk);
+	ret = clk_prepare_enable(spear13xx->clk);
 	if (ret) {
 		dev_err(dev, "couldn't enable clk for pcie\n");
 		return ret;
 	}
 
-	pp = &spear13xx_pcie->pp;
+	pp = &spear13xx->pp;
 
 	pp->dev = dev;
 
@@ -263,20 +263,20 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(pp->dbi_base);
 		goto fail_clk;
 	}
-	spear13xx_pcie->app_base = pp->dbi_base + 0x2000;
+	spear13xx->app_base = pp->dbi_base + 0x2000;
 
 	if (of_property_read_bool(np, "st,pcie-is-gen1"))
-		spear13xx_pcie->is_gen1 = true;
+		spear13xx->is_gen1 = true;
 
 	ret = spear13xx_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		goto fail_clk;
 
-	platform_set_drvdata(pdev, spear13xx_pcie);
+	platform_set_drvdata(pdev, spear13xx);
 	return 0;
 
 fail_clk:
-	clk_disable_unprepare(spear13xx_pcie->clk);
+	clk_disable_unprepare(spear13xx->clk);
 
 	return ret;
 }

