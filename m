Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42378 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdAPGbq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2017 01:31:46 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V3 3/5] PCI: exynos: Remove the unnecessary variables
Date: Mon, 16 Jan 2017 15:31:36 +0900
Message-id: <20170116063138.25805-4-jh80.chung@samsung.com>
In-reply-to: <20170116063138.25805-1-jh80.chung@samsung.com>
References: <20170116063138.25805-1-jh80.chung@samsung.com>
 <CGME20170116063141epcas5p329a9496aabe28a9961176539c47065dc@epcas5p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the unnecessary variables(elbi/phy/block_base).
It needs one resource structure for assigning each resource.
So it replaces with one 'res' variable.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changelog on V3:
- None
Changelog on V2:
- None
 drivers/pci/host/pci-exynos.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 166881a..6255294 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -507,9 +507,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	struct exynos_pcie *ep;
 	struct pcie_port *pp;
 	struct device_node *np = dev->of_node;
-	struct resource *elbi_base;
-	struct resource *phy_base;
-	struct resource *block_base;
+	struct resource *res;
 	int ret;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
@@ -540,22 +538,22 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail_clk;
 
-	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ep->elbi_base = devm_ioremap_resource(dev, elbi_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ep->elbi_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ep->elbi_base)) {
 		ret = PTR_ERR(ep->elbi_base);
 		goto fail_bus_clk;
 	}
 
-	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ep->phy_base = devm_ioremap_resource(dev, phy_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	ep->phy_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ep->phy_base)) {
 		ret = PTR_ERR(ep->phy_base);
 		goto fail_bus_clk;
 	}
 
-	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	ep->block_base = devm_ioremap_resource(dev, block_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	ep->block_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ep->block_base)) {
 		ret = PTR_ERR(ep->block_base);
 		goto fail_bus_clk;
-- 
2.10.2

