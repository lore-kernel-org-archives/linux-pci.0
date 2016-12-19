Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39068 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbcLSIQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2016 03:16:22 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/4] PCI: exynos: Remove the unnecessary variables
Date: Mon, 19 Dec 2016 17:16:12 +0900
Message-id: <20161219081614.5403-3-jh80.chung@samsung.com>
In-reply-to: <20161219081614.5403-1-jh80.chung@samsung.com>
References: <20161219081614.5403-1-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the unnecessary variables(elbi/phy/block_base).
It needs one resource structure for assigning each resource.
So it replaces with one 'res' variable.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/pci/host/pci-exynos.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 6dbfa2c..d64e8f1 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -509,9 +509,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	struct exynos_pcie *exynos_pcie;
 	struct pcie_port *pp;
 	struct device_node *np = dev->of_node;
-	struct resource *elbi_base;
-	struct resource *phy_base;
-	struct resource *block_base;
+	struct resource *res;
 	int ret;
 
 	exynos_pcie = devm_kzalloc(dev, sizeof(*exynos_pcie), GFP_KERNEL);
@@ -542,22 +540,22 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail_clk;
 
-	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	exynos_pcie->elbi_base = devm_ioremap_resource(dev, elbi_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	exynos_pcie->elbi_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(exynos_pcie->elbi_base)) {
 		ret = PTR_ERR(exynos_pcie->elbi_base);
 		goto fail_bus_clk;
 	}
 
-	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	exynos_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	exynos_pcie->phy_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(exynos_pcie->phy_base)) {
 		ret = PTR_ERR(exynos_pcie->phy_base);
 		goto fail_bus_clk;
 	}
 
-	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	exynos_pcie->block_base = devm_ioremap_resource(dev, block_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	exynos_pcie->block_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(exynos_pcie->block_base)) {
 		ret = PTR_ERR(exynos_pcie->block_base);
 		goto fail_bus_clk;
-- 
2.10.2

