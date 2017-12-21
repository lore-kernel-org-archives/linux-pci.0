Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11378 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbdLUMON (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Dec 2017 07:14:13 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, krzk@kernel.org,
        jingoohan1@gmail.com, kgene@kernel.org, lorenzo.pieralisi@arm.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC 2/2] pci: dwc: pci-exynos: add the coedes to support the
 exynos5433
Date: Thu, 21 Dec 2017 21:14:08 +0900
Message-id: <20171221121408.22636-3-jh80.chung@samsung.com>
In-reply-to: <20171221121408.22636-1-jh80.chung@samsung.com>
References: <20171221121408.22636-1-jh80.chung@samsung.com>
        <CGME20171221121409epcas1p1a65748f09d457de61c141ebfab9c14d3@epcas1p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Exynos5433 has the PCIe for WiFi.
Add the codes relevant to PCIe for supporting the exynos5433.
Also changed the binding documentation name to
'samsung,exynos-pcie.txt'.
(It's not only exynos5440 anymore.)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 ...exynos5440-pcie.txt => samsung,exynos-pcie.txt} |   2 +-
 drivers/pci/dwc/pci-exynos.c                       | 183 ++++++++++++++++-----
 2 files changed, 144 insertions(+), 41 deletions(-)
 rename Documentation/devicetree/bindings/pci/{samsung,exynos5440-pcie.txt => samsung,exynos-pcie.txt} (97%)

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.txt
similarity index 97%
rename from Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
rename to Documentation/devicetree/bindings/pci/samsung,exynos-pcie.txt
index 34a11bfbfb60..958dcc150505 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.txt
@@ -4,7 +4,7 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: "samsung,exynos5440-pcie"
+- compatible: "samsung,exynos5440-pcie" or "samsung,exynos5433-pcie"
 - reg: base addresses and lengths of the PCIe controller,
 	the PHY controller, additional register for the PHY controller.
 	(Registers for the PHY controller are DEPRECATED.
diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index 5596fdedbb94..8dee2e90347e 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -40,6 +40,8 @@
 #define PCIE_IRQ_SPECIAL		0x008
 #define PCIE_IRQ_EN_PULSE		0x00c
 #define PCIE_IRQ_EN_LEVEL		0x010
+#define PCIE_SW_WAKE			0x018
+#define PCIE_BUS_EN			BIT(1)
 #define IRQ_MSI_ENABLE			BIT(2)
 #define PCIE_IRQ_EN_SPECIAL		0x014
 #define PCIE_PWR_RESET			0x018
@@ -49,7 +51,8 @@
 #define PCIE_NONSTICKY_RESET		0x024
 #define PCIE_APP_INIT_RESET		0x028
 #define PCIE_APP_LTSSM_ENABLE		0x02c
-#define PCIE_ELBI_RDLH_LINKUP		0x064
+#define PCIE_ELBI_RDLH_LINKUP		0x074
+#define PCIE_ELBI_XMLH_LINKUP		BIT(4)
 #define PCIE_ELBI_LTSSM_ENABLE		0x1
 #define PCIE_ELBI_SLV_AWMISC		0x11c
 #define PCIE_ELBI_SLV_ARMISC		0x120
@@ -94,6 +97,10 @@
 #define PCIE_PHY_TRSV3_PD_TSV		BIT(7)
 #define PCIE_PHY_TRSV3_LVCC		0x31c
 
+/* DBI register */
+#define PCIE_MISC_CONTROL_1_OFF		0x8BC
+#define DBI_RO_WR_EN			BIT(0)
+
 struct exynos_pcie_mem_res {
 	void __iomem *elbi_base;   /* DT 0th resource: PCIe CTRL */
 	void __iomem *phy_base;    /* DT 1st resource: PHY CTRL */
@@ -221,6 +228,96 @@ static const struct exynos_pcie_ops exynos5440_pcie_ops = {
 	.deinit_clk_resources	= exynos5440_pcie_deinit_clk_resources,
 };
 
+static int exynos5433_pcie_get_mem_resources(struct platform_device *pdev,
+					     struct exynos_pcie *ep)
+{
+	struct dw_pcie *pci = ep->pci;
+	struct device *dev = pci->dev;
+	struct resource *res;
+
+	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
+	if (!ep->mem_res)
+		return -ENOMEM;
+
+	/* External Local Bus interface(ELBI) Register */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
+	ep->mem_res->elbi_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ep->mem_res->elbi_base))
+		return PTR_ERR(ep->mem_res->elbi_base);
+
+	/* Data Bus Interface(DBI) Register */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	pci->dbi_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	return 0;
+}
+
+static int exynos5433_pcie_get_clk_resources(struct exynos_pcie *ep)
+{
+	struct dw_pcie *pci = ep->pci;
+	struct device *dev = pci->dev;
+
+	ep->clk_res = devm_kzalloc(dev, sizeof(*ep->clk_res), GFP_KERNEL);
+	if (!ep->clk_res)
+		return -ENOMEM;
+
+	ep->clk_res->clk = devm_clk_get(dev, "pcie");
+	if (IS_ERR(ep->clk_res->clk)) {
+		dev_err(dev, "Failed to get pcie rc clock\n");
+		return PTR_ERR(ep->clk_res->clk);
+	}
+
+	ep->clk_res->bus_clk = devm_clk_get(dev, "pcie_bus");
+	if (IS_ERR(ep->clk_res->bus_clk)) {
+		dev_err(dev, "Failed to get pcie bus clock\n");
+		return PTR_ERR(ep->clk_res->bus_clk);
+	}
+
+	return 0;
+}
+
+static void exynos5433_pcie_deinit_clk_resources(struct exynos_pcie *ep)
+{
+	clk_disable_unprepare(ep->clk_res->bus_clk);
+	clk_disable_unprepare(ep->clk_res->clk);
+}
+
+
+static int exynos5433_pcie_init_clk_resources(struct exynos_pcie *ep)
+{
+	struct dw_pcie *pci = ep->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = clk_prepare_enable(ep->clk_res->clk);
+	if (ret) {
+		dev_err(dev, "cannot enable pcie rc clock");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(ep->clk_res->bus_clk);
+	if (ret) {
+		dev_err(dev, "cannot enable pcie bus clock");
+		goto err_bus_clk;
+	}
+
+	return 0;
+
+err_bus_clk:
+	clk_disable_unprepare(ep->clk_res->clk);
+
+	return ret;
+}
+
+static const struct exynos_pcie_ops exynos5433_pcie_ops = {
+	.get_mem_resources	= exynos5433_pcie_get_mem_resources,
+	.get_clk_resources	= exynos5433_pcie_get_clk_resources,
+	.init_clk_resources	= exynos5433_pcie_init_clk_resources,
+	.deinit_clk_resources	= exynos5433_pcie_deinit_clk_resources,
+};
+
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
 {
 	writel(val, base + reg);
@@ -279,7 +376,9 @@ static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
 	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_NONSTICKY_RESET);
 	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_APP_INIT_RESET);
 	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_APP_INIT_RESET);
-	exynos_pcie_writel(ep->mem_res->block_base, 1, PCIE_PHY_MAC_RESET);
+	if (ep->mem_res->block_base)
+		exynos_pcie_writel(ep->mem_res->block_base, 1,
+				PCIE_PHY_MAC_RESET);
 }
 
 static void exynos_pcie_assert_phy_reset(struct exynos_pcie *ep)
@@ -413,9 +512,6 @@ static int exynos_pcie_establish_link(struct exynos_pcie *ep)
 	if (ep->using_phy) {
 		phy_reset(ep->phy);
 
-		exynos_pcie_writel(ep->mem_res->elbi_base, 1,
-				PCIE_PWR_RESET);
-
 		phy_power_on(ep->phy);
 		phy_init(ep->phy);
 	} else {
@@ -430,14 +526,16 @@ static int exynos_pcie_establish_link(struct exynos_pcie *ep)
 		udelay(500);
 		exynos_pcie_writel(ep->mem_res->block_base, 0,
 					PCIE_PHY_COMMON_RESET);
+		exynos_pcie_deassert_core_reset(ep);
 	}
 
-	/* pulse for common reset */
-	exynos_pcie_writel(ep->mem_res->block_base, 1, PCIE_PHY_COMMON_RESET);
-	udelay(500);
-	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_COMMON_RESET);
+	/*
+	 * Enable DBI_RO_WR_EN bit.
+	 * - When set to 1, some RO and HWinit bits are wriatble from
+	 *   the local application through the DBI.
+	 */
+	dw_pcie_writel_dbi(pci, PCIE_MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
 
-	exynos_pcie_deassert_core_reset(ep);
 	dw_pcie_setup_rc(pp);
 	exynos_pcie_assert_reset(ep);
 
@@ -472,16 +570,6 @@ static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
 	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_PULSE);
 }
 
-static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
-{
-	u32 val;
-
-	/* enable INTX interrupt */
-	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
-		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_PULSE);
-}
-
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 {
 	struct exynos_pcie *ep = arg;
@@ -513,9 +601,16 @@ static void exynos_pcie_msi_init(struct exynos_pcie *ep)
 	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_LEVEL);
 }
 
-static void exynos_pcie_enable_interrupts(struct exynos_pcie *ep)
+static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
 {
-	exynos_pcie_enable_irq_pulse(ep);
+	u32 val;
+
+	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
+		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
+	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_PULSE);
+
+	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_IRQ_EN_LEVEL);
+	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_IRQ_EN_SPECIAL);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		exynos_pcie_msi_init(ep);
@@ -575,10 +670,8 @@ static int exynos_pcie_link_up(struct dw_pcie *pci)
 	u32 val;
 
 	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_ELBI_RDLH_LINKUP);
-	if (val == PCIE_ELBI_LTSSM_ENABLE)
-		return 1;
 
-	return 0;
+	return (val & PCIE_ELBI_XMLH_LINKUP);
 }
 
 static int exynos_pcie_host_init(struct pcie_port *pp)
@@ -587,7 +680,7 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 
 	exynos_pcie_establish_link(ep);
-	exynos_pcie_enable_interrupts(ep);
+	exynos_pcie_enable_irq_pulse(ep);
 
 	return 0;
 }
@@ -608,8 +701,11 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 
 	pp->irq = platform_get_irq(pdev, 1);
 	if (pp->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
-		return pp->irq;
+		pp->irq = platform_get_irq_byname(pdev, "intr");
+		if (pp->irq < 0) {
+			dev_err(dev, "failed to get irq\n");
+			return pp->irq;
+		}
 	}
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
 				IRQF_SHARED, "exynos-pcie", ep);
@@ -678,13 +774,23 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 
 	ep->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
 
-	/* Assume that controller doesn't use the PHY framework */
-	ep->using_phy = false;
+	/*
+	 * In case of Exynos5440,
+	 * Assume that controller doesn't use the PHY frameork.
+	 * Other SoCs might be used the PHY framework.
+	 */
+
+	if (of_device_is_compatible(np, "samsung,exynos5440-pcie"))
+		ep->using_phy = false;
 
-	ep->phy = devm_of_phy_get(dev, np, NULL);
+	ep->phy = devm_of_phy_get(dev, np, "pcie-phy");
 	if (IS_ERR(ep->phy)) {
 		if (PTR_ERR(ep->phy) == -EPROBE_DEFER)
 			return PTR_ERR(ep->phy);
+		if (!of_device_is_compatible(np, "samsung,exynos5440-pcie")) {
+			dev_err(dev, "Can't find the pcie-phy\n");
+			return PTR_ERR(ep->phy);
+		}
 		dev_warn(dev, "Use the 'phy' property. Current DT of pci-exynos was deprecated!!\n");
 	} else
 		ep->using_phy = true;
@@ -734,23 +840,20 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
 static const struct of_device_id exynos_pcie_of_match[] = {
 	{
 		.compatible = "samsung,exynos5440-pcie",
-		.data = &exynos5440_pcie_ops
+		.data = &exynos5440_pcie_ops,
+	}, {
+		.compatible = "samsung,exynos5433-pcie",
+		.data = &exynos5433_pcie_ops,
 	},
 	{},
 };
 
 static struct platform_driver exynos_pcie_driver = {
+	.probe		= exynos_pcie_probe,
 	.remove		= __exit_p(exynos_pcie_remove),
 	.driver = {
 		.name	= "exynos-pcie",
 		.of_match_table = exynos_pcie_of_match,
 	},
 };
-
-/* Exynos PCIe driver does not allow module unload */
-
-static int __init exynos_pcie_init(void)
-{
-	return platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
-}
-subsys_initcall(exynos_pcie_init);
+builtin_platform_driver(exynos_pcie_driver);
-- 
2.15.0
