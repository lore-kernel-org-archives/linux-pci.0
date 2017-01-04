Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40049 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967299AbdADMgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 07:36:00 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V2 4/5] PCI: exynos: support the using PHY generic framework
Date: Wed, 04 Jan 2017 21:34:34 +0900
Message-id: <20170104123435.30740-5-jh80.chung@samsung.com>
In-reply-to: <20170104123435.30740-1-jh80.chung@samsung.com>
References: <20170104123435.30740-1-jh80.chung@samsung.com>
 <CGME20170104123436epcas1p1651443c5fe13f67006864aed2f70fa9d@epcas1p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is for using PHY generic framework.
To maintain backward compatibility, check whether phy is supported or
not with 'using_phy'.

And if someone use the old dt-file, display the "deprecated" message.
But it's still working fine with it.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog on V2:
- This patch is split from previous PATCH[1/4]
- Maintain the backward compatibility
- Adds 'using_phy' for cheching whether phy framework is used or not
- Adds 'DEPRECATED' message for old dt-binding way

 drivers/pci/host/pci-exynos.c | 61 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index feed0fd..34f2eed 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -21,6 +21,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
@@ -110,6 +111,10 @@ struct exynos_pcie {
 	struct exynos_pcie_clk_res	*clk_res;
 	const struct exynos_pcie_ops	*ops;
 	int				reset_gpio;
+
+	/* For Generic PHY Framework */
+	bool				using_phy;
+	struct phy			*phy;
 };
 
 struct exynos_pcie_ops {
@@ -135,6 +140,10 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
 	if (IS_ERR(ep->mem_res->elbi_base))
 		return PTR_ERR(ep->mem_res->elbi_base);
 
+	/* If using the PHY framework, doesn't need to get other resource */
+	if (ep->using_phy)
+		return 0;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	ep->mem_res->phy_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ep->mem_res->phy_base))
@@ -396,17 +405,28 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 	}
 
 	exynos_pcie_assert_core_reset(exynos_pcie);
-	exynos_pcie_assert_phy_reset(exynos_pcie);
-	exynos_pcie_deassert_phy_reset(exynos_pcie);
-	exynos_pcie_power_on_phy(exynos_pcie);
-	exynos_pcie_init_phy(exynos_pcie);
-
-	/* pulse for common reset */
-	exynos_pcie_writel(exynos_pcie->mem_res->block_base, 1,
-				PCIE_PHY_COMMON_RESET);
-	udelay(500);
-	exynos_pcie_writel(exynos_pcie->mem_res->block_base, 0,
-				PCIE_PHY_COMMON_RESET);
+
+	if (exynos_pcie->using_phy) {
+		phy_reset(exynos_pcie->phy);
+
+		exynos_pcie_writel(exynos_pcie->mem_res->elbi_base, 1,
+				PCIE_PWR_RESET);
+
+		phy_power_on(exynos_pcie->phy);
+		phy_init(exynos_pcie->phy);
+	} else {
+		exynos_pcie_assert_phy_reset(exynos_pcie);
+		exynos_pcie_deassert_phy_reset(exynos_pcie);
+		exynos_pcie_power_on_phy(exynos_pcie);
+		exynos_pcie_init_phy(exynos_pcie);
+
+		/* pulse for common reset */
+		exynos_pcie_writel(exynos_pcie->mem_res->block_base, 1,
+					PCIE_PHY_COMMON_RESET);
+		udelay(500);
+		exynos_pcie_writel(exynos_pcie->mem_res->block_base, 0,
+					PCIE_PHY_COMMON_RESET);
+	}
 
 	exynos_pcie_deassert_core_reset(exynos_pcie);
 	dw_pcie_setup_rc(pp);
@@ -420,6 +440,11 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 	if (!dw_pcie_wait_for_link(pp))
 		return 0;
 
+	if (exynos_pcie->using_phy) {
+		phy_power_off(exynos_pcie->phy);
+		return -ETIMEDOUT;
+	}
+
 	while (exynos_pcie_readl(exynos_pcie->mem_res->phy_base,
 				PCIE_PHY_PLL_LOCKED) == 0) {
 		val = exynos_pcie_readl(exynos_pcie->mem_res->block_base,
@@ -633,6 +658,17 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 
 	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
 
+	/* Assume that controller doesn't use the PHY framework */
+	exynos_pcie->using_phy = false;
+
+	exynos_pcie->phy = devm_of_phy_get(dev, np, NULL);
+	if (IS_ERR(exynos_pcie->phy)) {
+		if (PTR_ERR(exynos_pcie->phy) == -EPROBE_DEFER)
+			return PTR_ERR(exynos_pcie->phy);
+		dev_warn(dev, "Use the 'phy' property. Current DT of pci-exynos was deprecated!!\n");
+	} else
+		exynos_pcie->using_phy = true;
+
 	if (exynos_pcie->ops && exynos_pcie->ops->get_mem_resources) {
 		ret = exynos_pcie->ops->get_mem_resources(pdev, exynos_pcie);
 		if (ret)
@@ -657,6 +693,9 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 fail_probe:
+	if (exynos_pcie->using_phy)
+		phy_exit(exynos_pcie->phy);
+
 	if (exynos_pcie->ops && exynos_pcie->ops->deinit_clk_resources)
 		exynos_pcie->ops->deinit_clk_resources(exynos_pcie);
 	return ret;
-- 
2.10.2

