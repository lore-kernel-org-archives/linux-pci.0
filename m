Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Duc Dang <dhdang@apm.com>
Cc: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] PCI: dwc: artpec6: add support for endpoint mode
Date: Fri, 13 Oct 2017 18:09:11 +0200
Message-Id: <20171013160914.3220-9-niklas.cassel@axis.com>
In-Reply-To: <20171013160914.3220-1-niklas.cassel@axis.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   3 +-
 drivers/pci/dwc/Kconfig                            |  41 +++--
 drivers/pci/dwc/Makefile                           |   4 +-
 drivers/pci/dwc/pcie-artpec6.c                     | 202 ++++++++++++++++++++-
 4 files changed, 233 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 4e4aee4439ea..33eef7ae5a23 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: "axis,artpec6-pcie", "snps,dw-pcie"
+- compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
+	      "axis,artpec6-pcie-ep", "snps,dw-pcie" for ARTPEC-6 in EP mode;
 - reg: base addresses and lengths of the PCIe controller (DBI),
 	the PHY controller, and configuration address space.
 - reg-names: Must include the following entries:
diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 22ec82fcdea2..e333283fb1ed 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -14,6 +14,36 @@ config PCIE_DW_EP
 	depends on PCI_ENDPOINT
 	select PCIE_DW
 
+config PCIE_ARTPEC6
+	bool "Axis ARTPEC-6 PCIe controller"
+	depends on (PCI && PCI_MSI_IRQ_DOMAIN) || PCI_ENDPOINT
+	depends on MACH_ARTPEC6
+	help
+	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
+	  SoCs.  This PCIe controller uses the DesignWare core.
+
+if PCIE_ARTPEC6
+
+config PCIE_ARTPEC6_HOST
+	bool "Axis ARTPEC-6 Host Mode"
+	depends on PCI
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIEPORTBUS
+	select PCIE_DW_HOST
+	help
+	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
+	  host mode.
+
+config PCIE_ARTPEC6_EP
+	bool "Axis ARTPEC-6 Endpoint Mode"
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
+	  endpoint mode.
+
+endif
+
 config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
 	depends on SOC_DRA7XX || COMPILE_TEST
@@ -148,17 +178,6 @@ config PCIE_ARMADA_8K
 	  DesignWare hardware and therefore the driver re-uses the
 	  DesignWare core functions to implement the driver.
 
-config PCIE_ARTPEC6
-	bool "Axis ARTPEC-6 PCIe controller"
-	depends on PCI
-	depends on MACH_ARTPEC6
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIEPORTBUS
-	select PCIE_DW_HOST
-	help
-	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
-	  SoCs.  This PCIe controller uses the DesignWare core.
-
 config PCIE_KIRIN
 	depends on OF && ARM64
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
index c61be9738cce..ac98242b83a9 100644
--- a/drivers/pci/dwc/Makefile
+++ b/drivers/pci/dwc/Makefile
@@ -2,6 +2,9 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
+ifneq ($(filter y,$(CONFIG_PCIE_ARTPEC6_HOST) $(CONFIG_PCIE_ARTPEC6_EP)),)
+        obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
+endif
 ifneq ($(filter y,$(CONFIG_PCI_DRA7XX_HOST) $(CONFIG_PCI_DRA7XX_EP)),)
         obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 endif
@@ -12,7 +15,6 @@ obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
-obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index c5d7f98dc6b2..21ea9ffef784 100644
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
@@ -126,6 +135,16 @@ static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
 	} while (retries && !(val & PHY_COSPLLLOCK));
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
 static int artpec6_pcie_establish_link(struct dw_pcie *pci)
 {
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
@@ -195,6 +214,136 @@ static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
+static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
+{
+	u32 reg;
+
+	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi2(pci, reg, 0x0);
+	dw_pcie_writel_dbi(pci, reg, 0x0);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
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
+static int artpec6_pcie_raise_msi_irq(struct dw_pcie_ep *ep,
+				      u8 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct pci_epc *epc = ep->epc;
+	u32 cap_addr, cap_value, cap_id, next_ptr, msg_ctrl, msg_data;
+	u32 msg_addr_lower, msg_addr_upper;
+	u64 msg_addr;
+	bool has_upper;
+	int ret;
+
+	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
+	cap_addr = dw_pcie_readl_dbi(pci, PCI_CAPABILITY_LIST);
+	while (1) {
+		cap_value = dw_pcie_readl_dbi(pci, cap_addr);
+		cap_id = cap_value & GENMASK(7, 0);
+		if (cap_id == PCI_CAP_ID_MSI)
+			break;
+		next_ptr = (cap_value & GENMASK(15, 8)) >> 8;
+		if (next_ptr == 0) {
+			dev_err(pci->dev, "No MSI cap found!\n");
+			return -EINVAL;
+		}
+		cap_addr = next_ptr;
+	}
+	msg_ctrl = (cap_value & GENMASK(31, 16)) >> 16;
+	has_upper = !!(msg_ctrl & BIT(7));
+	msg_addr_lower = dw_pcie_readl_dbi(pci, cap_addr + 0x4);
+	if (has_upper) {
+		msg_addr_upper = dw_pcie_readl_dbi(pci, cap_addr + 0x8);
+		msg_data = dw_pcie_readl_dbi(pci, cap_addr + 0xc) &
+			GENMASK(15, 0);
+	} else {
+		msg_addr_upper = 0;
+		msg_data = dw_pcie_readl_dbi(pci, cap_addr + 0x8) &
+			GENMASK(15, 0);
+	}
+	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
+	ret = epc->ops->map_addr(epc, ep->msi_mem_phys, msg_addr, PAGE_SIZE);
+	if (ret)
+		return ret;
+
+	writel(msg_data | (interrupt_num - 1), ep->msi_mem);
+
+	epc->ops->unmap_addr(epc, ep->msi_mem_phys);
+
+	return 0;
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
+		return artpec6_pcie_raise_msi_irq(ep, interrupt_num);
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
+};
+
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
+
 static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 				 struct platform_device *pdev)
 {
@@ -234,6 +383,8 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.cpu_addr_fixup = artpec6_pcie_cpu_addr_fixup,
+	.start_link = artpec6_pcie_establish_link,
+	.stop_link = artpec6_pcie_stop_link,
 };
 
 static int artpec6_pcie_probe(struct platform_device *pdev)
@@ -244,6 +395,16 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
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
@@ -257,6 +418,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 
 	artpec6_pcie->pci = pci;
+	artpec6_pcie->mode = mode;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
@@ -276,15 +438,47 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
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
2.11.0
