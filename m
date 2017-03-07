Return-Path: <SRS0=HmHo=2Q=samsung.com=jh80.chung@kernel.org>
Return-Path: <SRS0=HmHo=2Q=samsung.com=jh80.chung@kernel.org>
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, helgaas@kernel.org, jingoohan1@gmail.com,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] PCI: exynos: fix the NULL pointer dereference about elbi_base
Date: Tue, 07 Mar 2017 19:54:05 +0900
Message-id: <20170307105405.7874-1-jh80.chung@samsung.com>
References: 
 <CGME20170307105407epcas5p3e77181793b26a5d2710bb6d7557033bb@epcas5p3.samsung.com>
List-ID: <linux-pci.vger.kernel.org>

Even though using phy framework, it has to get the elbi_base.
Before this patch, elbi_base should be NULL pointer.

Fixes: e7cd7ef58e1f ("PCI: exynos: Support the PHY generic framework")

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/pci/dwc/pci-exynos.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index 993b650..44f774c 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -132,10 +132,6 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
 	struct device *dev = pci->dev;
 	struct resource *res;
 
-	/* If using the PHY framework, doesn't need to get other resource */
-	if (ep->using_phy)
-		return 0;
-
 	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
 	if (!ep->mem_res)
 		return -ENOMEM;
@@ -145,6 +141,10 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
 	if (IS_ERR(ep->mem_res->elbi_base))
 		return PTR_ERR(ep->mem_res->elbi_base);
 
+	/* If using the PHY framework, doesn't need to get other resource */
+	if (ep->using_phy)
+		return 0;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	ep->mem_res->phy_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ep->mem_res->phy_base))
-- 
2.10.2
