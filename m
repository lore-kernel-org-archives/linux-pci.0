Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932765AbcJLNhZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:37:25 -0400
Subject: [PATCH v2 1/5] PCI: exynos: Add local struct device pointers
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Wed, 12 Oct 2016 08:37:15 -0500
Message-ID: <20161012133715.28194.55964.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |   46 +++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index f559b49..e633817 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -308,19 +308,21 @@ static void exynos_pcie_init_phy(struct pcie_port *pp)
 static void exynos_pcie_assert_reset(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct device *dev = pp->dev;
 
 	if (exynos_pcie->reset_gpio >= 0)
-		devm_gpio_request_one(pp->dev, exynos_pcie->reset_gpio,
+		devm_gpio_request_one(dev, exynos_pcie->reset_gpio,
 				GPIOF_OUT_INIT_HIGH, "RESET");
 }
 
 static int exynos_pcie_establish_link(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct device *dev = pp->dev;
 	u32 val;
 
 	if (dw_pcie_link_up(pp)) {
-		dev_err(pp->dev, "Link already up\n");
+		dev_err(dev, "Link already up\n");
 		return 0;
 	}
 
@@ -361,7 +363,7 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 
 	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
 		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
-		dev_info(pp->dev, "PLL Locked: 0x%x\n", val);
+		dev_info(dev, "PLL Locked: 0x%x\n", val);
 	}
 	/* power off phy */
 	exynos_pcie_power_off_phy(pp);
@@ -493,33 +495,34 @@ static struct pcie_host_ops exynos_pcie_host_ops = {
 static int __init exynos_add_pcie_port(struct pcie_port *pp,
 				       struct platform_device *pdev)
 {
+	struct device *dev = pp->dev;
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 1);
 	if (!pp->irq) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+		dev_err(dev, "failed to get irq\n");
 		return -ENODEV;
 	}
-	ret = devm_request_irq(&pdev->dev, pp->irq, exynos_pcie_irq_handler,
+	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
 				IRQF_SHARED, "exynos-pcie", pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to request irq\n");
+		dev_err(dev, "failed to request irq\n");
 		return ret;
 	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (!pp->msi_irq) {
-			dev_err(&pdev->dev, "failed to get msi irq\n");
+			dev_err(dev, "failed to get msi irq\n");
 			return -ENODEV;
 		}
 
-		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+		ret = devm_request_irq(dev, pp->msi_irq,
 					exynos_pcie_msi_irq_handler,
 					IRQF_SHARED | IRQF_NO_THREAD,
 					"exynos-pcie", pp);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request msi irq\n");
+			dev_err(dev, "failed to request msi irq\n");
 			return ret;
 		}
 	}
@@ -529,7 +532,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -538,37 +541,36 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
 
 static int __init exynos_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct exynos_pcie *exynos_pcie;
 	struct pcie_port *pp;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct resource *elbi_base;
 	struct resource *phy_base;
 	struct resource *block_base;
 	int ret;
 
-	exynos_pcie = devm_kzalloc(&pdev->dev, sizeof(*exynos_pcie),
-				GFP_KERNEL);
+	exynos_pcie = devm_kzalloc(dev, sizeof(*exynos_pcie), GFP_KERNEL);
 	if (!exynos_pcie)
 		return -ENOMEM;
 
 	pp = &exynos_pcie->pp;
-
-	pp->dev = &pdev->dev;
+	pp->dev = dev;
 
 	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
 
-	exynos_pcie->clk = devm_clk_get(&pdev->dev, "pcie");
+	exynos_pcie->clk = devm_clk_get(dev, "pcie");
 	if (IS_ERR(exynos_pcie->clk)) {
-		dev_err(&pdev->dev, "Failed to get pcie rc clock\n");
+		dev_err(dev, "Failed to get pcie rc clock\n");
 		return PTR_ERR(exynos_pcie->clk);
 	}
 	ret = clk_prepare_enable(exynos_pcie->clk);
 	if (ret)
 		return ret;
 
-	exynos_pcie->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
+	exynos_pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
 	if (IS_ERR(exynos_pcie->bus_clk)) {
-		dev_err(&pdev->dev, "Failed to get pcie bus clock\n");
+		dev_err(dev, "Failed to get pcie bus clock\n");
 		ret = PTR_ERR(exynos_pcie->bus_clk);
 		goto fail_clk;
 	}
@@ -577,21 +579,21 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 		goto fail_clk;
 
 	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	exynos_pcie->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);
+	exynos_pcie->elbi_base = devm_ioremap_resource(dev, elbi_base);
 	if (IS_ERR(exynos_pcie->elbi_base)) {
 		ret = PTR_ERR(exynos_pcie->elbi_base);
 		goto fail_bus_clk;
 	}
 
 	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	exynos_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
+	exynos_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
 	if (IS_ERR(exynos_pcie->phy_base)) {
 		ret = PTR_ERR(exynos_pcie->phy_base);
 		goto fail_bus_clk;
 	}
 
 	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	exynos_pcie->block_base = devm_ioremap_resource(&pdev->dev, block_base);
+	exynos_pcie->block_base = devm_ioremap_resource(dev, block_base);
 	if (IS_ERR(exynos_pcie->block_base)) {
 		ret = PTR_ERR(exynos_pcie->block_base);
 		goto fail_bus_clk;

