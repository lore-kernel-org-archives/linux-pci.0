Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754985AbcJLNsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:14 -0400
Subject: [PATCH v2 1/8] PCI: imx6: Add local struct device pointers
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:47:40 -0500
Message-ID: <20161012134740.28919.52316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   79 +++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index ead4a5c..0838176 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -303,13 +303,14 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct pcie_port *pp = &imx6_pcie->pp;
+	struct device *dev = pp->dev;
 	int ret = 0;
 
 	switch (imx6_pcie->variant) {
 	case IMX6SX:
 		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
 		if (ret) {
-			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
+			dev_err(dev, "unable to enable pcie_axi clock\n");
 			break;
 		}
 
@@ -339,29 +340,30 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct device *dev = pp->dev;
 	int ret;
 
 	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
 	if (ret) {
-		dev_err(pp->dev, "unable to enable pcie_phy clock\n");
+		dev_err(dev, "unable to enable pcie_phy clock\n");
 		goto err_pcie_phy;
 	}
 
 	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
 	if (ret) {
-		dev_err(pp->dev, "unable to enable pcie_bus clock\n");
+		dev_err(dev, "unable to enable pcie_bus clock\n");
 		goto err_pcie_bus;
 	}
 
 	ret = clk_prepare_enable(imx6_pcie->pcie);
 	if (ret) {
-		dev_err(pp->dev, "unable to enable pcie clock\n");
+		dev_err(dev, "unable to enable pcie clock\n");
 		goto err_pcie;
 	}
 
 	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
 	if (ret) {
-		dev_err(pp->dev, "unable to enable pcie ref clock\n");
+		dev_err(dev, "unable to enable pcie ref clock\n");
 		goto err_ref_clk;
 	}
 
@@ -441,11 +443,13 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 
 static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 {
+	struct device *dev = pp->dev;
+
 	/* check if the link is up or not */
 	if (!dw_pcie_wait_for_link(pp))
 		return 0;
 
-	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
+	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
 		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
 		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
 	return -ETIMEDOUT;
@@ -453,6 +457,7 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 
 static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
 {
+	struct device *dev = pp->dev;
 	u32 tmp;
 	unsigned int retries;
 
@@ -464,7 +469,7 @@ static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
 		usleep_range(100, 1000);
 	}
 
-	dev_err(pp->dev, "Speed change timeout\n");
+	dev_err(dev, "Speed change timeout\n");
 	return -EINVAL;
 }
 
@@ -478,6 +483,7 @@ static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 static int imx6_pcie_establish_link(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct device *dev = pp->dev;
 	u32 tmp;
 	int ret;
 
@@ -497,7 +503,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 
 	ret = imx6_pcie_wait_for_link(pp);
 	if (ret) {
-		dev_info(pp->dev, "Link never came up\n");
+		dev_info(dev, "Link never came up\n");
 		goto err_reset_phy;
 	}
 
@@ -508,7 +514,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
 		writel(tmp, pp->dbi_base + PCIE_RC_LCR);
 	} else {
-		dev_info(pp->dev, "Link: Gen2 disabled\n");
+		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
 	/*
@@ -521,23 +527,23 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 
 	ret = imx6_pcie_wait_for_speed_change(pp);
 	if (ret) {
-		dev_err(pp->dev, "Failed to bring link up!\n");
+		dev_err(dev, "Failed to bring link up!\n");
 		goto err_reset_phy;
 	}
 
 	/* Make sure link training is finished as well! */
 	ret = imx6_pcie_wait_for_link(pp);
 	if (ret) {
-		dev_err(pp->dev, "Failed to bring link up!\n");
+		dev_err(dev, "Failed to bring link up!\n");
 		goto err_reset_phy;
 	}
 
 	tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
-	dev_info(pp->dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
+	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
 	return 0;
 
 err_reset_phy:
-	dev_dbg(pp->dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
+	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
 		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
 	imx6_pcie_reset_phy(pp);
@@ -575,21 +581,22 @@ static struct pcie_host_ops imx6_pcie_host_ops = {
 static int __init imx6_add_pcie_port(struct pcie_port *pp,
 			struct platform_device *pdev)
 {
+	struct device *dev = pp->dev;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 		if (pp->msi_irq <= 0) {
-			dev_err(&pdev->dev, "failed to get MSI irq\n");
+			dev_err(dev, "failed to get MSI irq\n");
 			return -ENODEV;
 		}
 
-		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+		ret = devm_request_irq(dev, pp->msi_irq,
 				       imx6_pcie_msi_handler,
 				       IRQF_SHARED | IRQF_NO_THREAD,
 				       "mx6-pcie-msi", pp);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request MSI irq\n");
+			dev_err(dev, "failed to request MSI irq\n");
 			return ret;
 		}
 	}
@@ -599,7 +606,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -608,29 +615,30 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 
 static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct imx6_pcie *imx6_pcie;
 	struct pcie_port *pp;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct resource *dbi_base;
-	struct device_node *node = pdev->dev.of_node;
+	struct device_node *node = dev->of_node;
 	int ret;
 
-	imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie), GFP_KERNEL);
+	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
 		return -ENOMEM;
 
 	pp = &imx6_pcie->pp;
-	pp->dev = &pdev->dev;
+	pp->dev = dev;
 
 	imx6_pcie->variant =
-		(enum imx6_pcie_variants)of_device_get_match_data(&pdev->dev);
+		(enum imx6_pcie_variants)of_device_get_match_data(dev);
 
 	/* Added for PCI abort handling */
 	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
 		"imprecise external abort");
 
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
+	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pp->dbi_base))
 		return PTR_ERR(pp->dbi_base);
 
@@ -639,44 +647,41 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	imx6_pcie->gpio_active_high = of_property_read_bool(np,
 						"reset-gpio-active-high");
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
+		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
 				imx6_pcie->gpio_active_high ?
 					GPIOF_OUT_INIT_HIGH :
 					GPIOF_OUT_INIT_LOW,
 				"PCIe reset");
 		if (ret) {
-			dev_err(&pdev->dev, "unable to get reset gpio\n");
+			dev_err(dev, "unable to get reset gpio\n");
 			return ret;
 		}
 	}
 
 	/* Fetch clocks */
-	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
+	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
 	if (IS_ERR(imx6_pcie->pcie_phy)) {
-		dev_err(&pdev->dev,
-			"pcie_phy clock source missing or invalid\n");
+		dev_err(dev, "pcie_phy clock source missing or invalid\n");
 		return PTR_ERR(imx6_pcie->pcie_phy);
 	}
 
-	imx6_pcie->pcie_bus = devm_clk_get(&pdev->dev, "pcie_bus");
+	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
 	if (IS_ERR(imx6_pcie->pcie_bus)) {
-		dev_err(&pdev->dev,
-			"pcie_bus clock source missing or invalid\n");
+		dev_err(dev, "pcie_bus clock source missing or invalid\n");
 		return PTR_ERR(imx6_pcie->pcie_bus);
 	}
 
-	imx6_pcie->pcie = devm_clk_get(&pdev->dev, "pcie");
+	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
 	if (IS_ERR(imx6_pcie->pcie)) {
-		dev_err(&pdev->dev,
-			"pcie clock source missing or invalid\n");
+		dev_err(dev, "pcie clock source missing or invalid\n");
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
 	if (imx6_pcie->variant == IMX6SX) {
-		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
+		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
 		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"pcie_incbound_axi clock missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
 		}
@@ -686,7 +691,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	imx6_pcie->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
-		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
+		dev_err(dev, "unable to find iomuxc registers\n");
 		return PTR_ERR(imx6_pcie->iomuxc_gpr);
 	}
 

