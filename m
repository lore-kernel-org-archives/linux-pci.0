Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38961 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdALCR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2017 21:17:28 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V2 2/4] PCI: exynos: Remove the unnecessary variables
Date: Thu, 12 Jan 2017 11:17:17 +0900
Message-id: <20170112021719.24986-2-jh80.chung@samsung.com>
In-reply-to: <20170112021719.24986-1-jh80.chung@samsung.com>
References: <20170112021719.24986-1-jh80.chung@samsung.com>
 <CGME20170112021721epcas5p4a68623b842f9233c7303deb8cd3b3ee2@epcas5p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the unnecessary variables(elbi/phy/block_base).
It needs one resource structure for assigning each resource.
So it replaces with one 'res' variable.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changelog on V2:
- None

 drivers/pci/host/pci-exynos.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 92856cd..3a7e09b 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -509,9 +509,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	struct exynos_pcie *ep;
 	struct pcie_port *pp;
 	struct device_node *np = dev->of_node;
-	struct resource *elbi_base;
-	struct resource *phy_base;
-	struct resource *block_base;
+	struct resource *res;
 	int ret;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
@@ -542,22 +540,22 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
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

