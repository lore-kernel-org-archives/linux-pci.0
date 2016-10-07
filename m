Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQgj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:36:39 -0400
Subject: [PATCH 8/8] PCI: exynos: Add local struct device pointers
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Fri, 07 Oct 2016 11:36:31 -0500
Message-ID: <20161007163631.25314.5123.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |   44 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 4fb3ce7..0e3cdc4 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -296,19 +296,21 @@ static void exynos_pcie_init_phy(struct exynos_pcie *exynos)
 static void exynos_pcie_assert_reset(struct exynos_pcie *exynos)
 {
 	struct pcie_port *pp = &exynos->pp;
+	struct device *dev = pp->dev;
 
 	if (exynos->reset_gpio >= 0)
-		devm_gpio_request_one(pp->dev, exynos->reset_gpio,
+		devm_gpio_request_one(dev, exynos->reset_gpio,
 				GPIOF_OUT_INIT_HIGH, "RESET");
 }
 
 static int exynos_pcie_establish_link(struct exynos_pcie *exynos)
 {
 	struct pcie_port *pp = &exynos->pp;
+	struct device *dev = pp->dev;
 	u32 val;
 
 	if (dw_pcie_link_up(pp)) {
-		dev_err(pp->dev, "Link already up\n");
+		dev_err(dev, "Link already up\n");
 		return 0;
 	}
 
@@ -337,7 +339,7 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos)
 
 	while (exynos_phy_readl(exynos, PCIE_PHY_PLL_LOCKED) == 0) {
 		val = exynos_blk_readl(exynos, PCIE_PHY_PLL_LOCKED);
-		dev_info(pp->dev, "PLL Locked: 0x%x\n", val);
+		dev_info(dev, "PLL Locked: 0x%x\n", val);
 	}
 	exynos_pcie_power_off_phy(exynos);
 	return -ETIMEDOUT;
@@ -475,33 +477,34 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *exynos,
 				       struct platform_device *pdev)
 {
 	struct pcie_port *pp = &exynos->pp;
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
 				IRQF_SHARED, "exynos-pcie", exynos);
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
 					"exynos-pcie", exynos);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request msi irq\n");
+			dev_err(dev, "failed to request msi irq\n");
 			return ret;
 		}
 	}
@@ -511,7 +514,7 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *exynos,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -520,35 +523,36 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *exynos,
 
 static int __init exynos_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct exynos_pcie *exynos;
 	struct pcie_port *pp;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct resource *elbi_base;
 	struct resource *phy_base;
 	struct resource *block_base;
 	int ret;
 
-	exynos = devm_kzalloc(&pdev->dev, sizeof(*exynos), GFP_KERNEL);
+	exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
 	if (!exynos)
 		return -ENOMEM;
 
 	pp = &exynos->pp;
-	pp->dev = &pdev->dev;
+	pp->dev = dev;
 
 	exynos->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
 
-	exynos->clk = devm_clk_get(&pdev->dev, "pcie");
+	exynos->clk = devm_clk_get(dev, "pcie");
 	if (IS_ERR(exynos->clk)) {
-		dev_err(&pdev->dev, "Failed to get pcie rc clock\n");
+		dev_err(dev, "Failed to get pcie rc clock\n");
 		return PTR_ERR(exynos->clk);
 	}
 	ret = clk_prepare_enable(exynos->clk);
 	if (ret)
 		return ret;
 
-	exynos->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
+	exynos->bus_clk = devm_clk_get(dev, "pcie_bus");
 	if (IS_ERR(exynos->bus_clk)) {
-		dev_err(&pdev->dev, "Failed to get pcie bus clock\n");
+		dev_err(dev, "Failed to get pcie bus clock\n");
 		ret = PTR_ERR(exynos->bus_clk);
 		goto fail_clk;
 	}
@@ -557,21 +561,21 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 		goto fail_clk;
 
 	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	exynos->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);
+	exynos->elbi_base = devm_ioremap_resource(dev, elbi_base);
 	if (IS_ERR(exynos->elbi_base)) {
 		ret = PTR_ERR(exynos->elbi_base);
 		goto fail_bus_clk;
 	}
 
 	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	exynos->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
+	exynos->phy_base = devm_ioremap_resource(dev, phy_base);
 	if (IS_ERR(exynos->phy_base)) {
 		ret = PTR_ERR(exynos->phy_base);
 		goto fail_bus_clk;
 	}
 
 	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	exynos->block_base = devm_ioremap_resource(&pdev->dev, block_base);
+	exynos->block_base = devm_ioremap_resource(dev, block_base);
 	if (IS_ERR(exynos->block_base)) {
 		ret = PTR_ERR(exynos->block_base);
 		goto fail_bus_clk;

