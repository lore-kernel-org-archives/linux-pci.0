Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:62186 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab3I2C3N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Sep 2013 22:29:13 -0400
MIME-Version: 1.0
Date: Sun, 29 Sep 2013 10:29:11 +0800
Message-ID: <CAPgLHd_RTNxi-OYhmTZ35NttjnAg-gQ_WKHkUQr5ueMhXVLTMg@mail.gmail.com>
Subject: [PATCH] PCI: exynos: missing clk_disable_unprepare() on error in exynos_pcie_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: bhelgaas@google.com, kgene.kim@samsung.com,
	grant.likely@linaro.org, rob.herring@calxeda.com,
	jg1.han@samsung.com, tgih.jun@samsung.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing clk_disable_unprepare() before return
from exynos_pcie_probe() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pci/host/pci-exynos.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 94e096b..e25598a 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -487,18 +487,24 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 
 	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	exynos_pcie->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);
-	if (IS_ERR(exynos_pcie->elbi_base))
-		return PTR_ERR(exynos_pcie->elbi_base);
+	if (IS_ERR(exynos_pcie->elbi_base)) {
+		ret = PTR_ERR(exynos_pcie->elbi_base);
+		goto fail_bus_clk;
+	}
 
 	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	exynos_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
-	if (IS_ERR(exynos_pcie->phy_base))
-		return PTR_ERR(exynos_pcie->phy_base);
+	if (IS_ERR(exynos_pcie->phy_base)) {
+		ret = PTR_ERR(exynos_pcie->phy_base);
+		goto fail_bus_clk;
+	}
 
 	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
 	exynos_pcie->block_base = devm_ioremap_resource(&pdev->dev, block_base);
-	if (IS_ERR(exynos_pcie->block_base))
-		return PTR_ERR(exynos_pcie->block_base);
+	if (IS_ERR(exynos_pcie->block_base)) {
+		ret = PTR_ERR(exynos_pcie->block_base);
+		goto fail_bus_clk;
+	}
 
 	ret = add_pcie_port(pp, pdev);
 	if (ret < 0)

