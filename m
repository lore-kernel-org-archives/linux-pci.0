Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Xiaowei Song <songxiaowei@hisilicon.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@axis.com
Subject: [PATCH v3 14/17] PCI: dwc: artpec6: Add support for endpoint mode
Date: Tue, 31 Oct 2017 23:39:32 +0100
Message-Id: <20171031223936.27549-15-niklas.cassel@axis.com>
In-Reply-To: <20171031223936.27549-1-niklas.cassel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
V3:
* Removed ifdefs around match table and match table data.
* Removed ifdefs in probe, use dummy implementations instead.

 drivers/pci/dwc/Kconfig        |  23 ++++--
 drivers/pci/dwc/pcie-artpec6.c | 162 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 174 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 3954353e3e2e..0fb96c7754de 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -148,15 +148,28 @@ config PCIE_ARMADA_8K
 	  DesignWare core functions to implement the driver.
 
 config PCIE_ARTPEC6
-	bool "Axis ARTPEC-6 PCIe controller"
-	depends on PCI
+	bool
+
+config PCIE_ARTPEC6_HOST
+	bool "Axis ARTPEC-6 PCIe controller Host Mode"
 	depends on MACH_ARTPEC6
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI && PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
+	select PCIE_ARTPEC6
+	help
+	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
+	  host mode. This uses the DesignWare core.
+
+config PCIE_ARTPEC6_EP
+	bool "Axis ARTPEC-6 PCIe controller Endpoint Mode"
+	depends on MACH_ARTPEC6
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCIE_ARTPEC6
 	help
-	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
-	  SoCs.  This PCIe controller uses the DesignWare core.
+	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
+	  endpoint mode. This uses the DesignWare core.
 
 config PCIE_KIRIN
 	depends on OF && ARM64
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 3b635e745d25..413683d7bd9d 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
@@ -30,8 +31,15 @@ struct artpec6_pcie {
 	struct dw_pcie		*pci;
 	struct regmap		*regmap;	/* DT axis,syscon-pcie */
 	void __iomem		*phy_base;	/* DT phy */
+	enum dw_pcie_device_mode mode;
 };
 
+struct artpec_pcie_of_data {
+	enum dw_pcie_device_mode mode;
+};
+
+static const struct of_device_id artpec6_pcie_of_match[];
+
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET			0x700
 #define PCIE_PHY_DEBUG_R0		(PL_OFFSET + 0x28)
@@ -42,6 +50,7 @@ struct artpec6_pcie {
 #define  PCIECFG_DBG_OEN		BIT(24)
 #define  PCIECFG_CORE_RESET_REQ		BIT(21)
 #define  PCIECFG_LTSSM_ENABLE		BIT(20)
+#define  PCIECFG_DEVICE_TYPE_MASK	GENMASK(19, 16)
 #define  PCIECFG_CLKREQ_B		BIT(11)
 #define  PCIECFG_REFCLK_ENABLE		BIT(10)
 #define  PCIECFG_PLL_ENABLE		BIT(9)
@@ -92,6 +101,22 @@ static int artpec6_pcie_establish_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void artpec6_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
+	u32 val;
+
+	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
+	val &= ~PCIECFG_LTSSM_ENABLE;
+	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
+}
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.cpu_addr_fixup = artpec6_pcie_cpu_addr_fixup,
+	.start_link = artpec6_pcie_establish_link,
+	.stop_link = artpec6_pcie_stop_link,
+};
+
 static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
 {
 	u32 val;
@@ -157,6 +182,7 @@ static void artpec6_pcie_deassert_core_reset(struct artpec6_pcie *artpec6_pcie)
 	usleep_range(100, 200);
 }
 
+#ifdef CONFIG_PCIE_ARTPEC6_HOST
 static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
 {
 	struct dw_pcie *pci = artpec6_pcie->pci;
@@ -231,11 +257,92 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 
 	return 0;
 }
+#else
+static inline int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
+					struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
 
-static const struct dw_pcie_ops dw_pcie_ops = {
-	.cpu_addr_fixup = artpec6_pcie_cpu_addr_fixup,
+#ifdef CONFIG_PCIE_ARTPEC6_EP
+static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
+	enum pci_barno bar;
+
+	artpec6_pcie_assert_core_reset(artpec6_pcie);
+	artpec6_pcie_init_phy(artpec6_pcie);
+	artpec6_pcie_deassert_core_reset(artpec6_pcie);
+
+	for (bar = BAR_0; bar <= BAR_5; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+}
+
+static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep,
+				  enum pci_epc_irq_type type, u8 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
+		return -EINVAL;
+	case PCI_EPC_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, interrupt_num);
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+	}
+
+	return 0;
+}
+
+static struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = artpec6_pcie_ep_init,
+	.raise_irq = artpec6_pcie_raise_irq,
 };
 
+static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
+			       struct platform_device *pdev)
+{
+	int ret;
+	struct dw_pcie_ep *ep;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = artpec6_pcie->pci;
+
+	ep = &pci->ep;
+	ep->ops = &pcie_ep_ops;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
+	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(pci->dbi_base2))
+		return PTR_ERR(pci->dbi_base2);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+
+	return 0;
+}
+#else
+static inline int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
+				      struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
 static int artpec6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -244,6 +351,16 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	struct resource *dbi_base;
 	struct resource *phy_base;
 	int ret;
+	const struct of_device_id *match;
+	const struct artpec_pcie_of_data *data;
+	enum dw_pcie_device_mode mode;
+
+	match = of_match_device(artpec6_pcie_of_match, dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct artpec_pcie_of_data *)match->data;
+	mode = (enum dw_pcie_device_mode)data->mode;
 
 	artpec6_pcie = devm_kzalloc(dev, sizeof(*artpec6_pcie), GFP_KERNEL);
 	if (!artpec6_pcie)
@@ -257,6 +374,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 
 	artpec6_pcie->pci = pci;
+	artpec6_pcie->mode = mode;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
@@ -276,15 +394,47 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, artpec6_pcie);
 
-	ret = artpec6_add_pcie_port(artpec6_pcie, pdev);
-	if (ret < 0)
-		return ret;
+	switch (artpec6_pcie->mode) {
+	case DW_PCIE_RC_TYPE:
+		ret = artpec6_add_pcie_port(artpec6_pcie, pdev);
+		if (ret < 0)
+			return ret;
+		break;
+	case DW_PCIE_EP_TYPE: {
+		u32 val;
+
+		val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
+		val &= ~PCIECFG_DEVICE_TYPE_MASK;
+		artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
+		ret = artpec6_add_pcie_ep(artpec6_pcie, pdev);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+	default:
+		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
+	}
 
 	return 0;
 }
 
+static const struct artpec_pcie_of_data artpec6_pcie_rc_of_data = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct artpec_pcie_of_data artpec6_pcie_ep_of_data = {
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static const struct of_device_id artpec6_pcie_of_match[] = {
-	{ .compatible = "axis,artpec6-pcie", },
+	{
+		.compatible = "axis,artpec6-pcie",
+		.data = &artpec6_pcie_rc_of_data,
+	},
+	{
+		.compatible = "axis,artpec6-pcie-ep",
+		.data = &artpec6_pcie_ep_of_data,
+	},
 	{},
 };
 
-- 
2.14.2
