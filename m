Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:41362 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759781AbcIMRM4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 13:12:56 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, <kishon@ti.com>,
        <nsekhar@ti.com>
Subject: [RFC PATCH] pci: controller: dra7xx: Add EP mode support
Date: Tue, 13 Sep 2016 22:40:50 +0530
Message-ID: <1473786653-12759-9-git-send-email-kishon@ti.com>
In-Reply-To: <1473786653-12759-1-git-send-email-kishon@ti.com>
References: <1473786653-12759-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe controller integrated in dra7xx SoCs is capable of operating
in endpoint mode. Add support for dra7xx SoCs to operate in endpoint
mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt |   30 ++-
 drivers/pci/controller/Kconfig                   |   21 +++
 drivers/pci/controller/pci-dra7xx.c              |  211 +++++++++++++++++++---
 3 files changed, 225 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 60e2516..b0e76f6 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -1,17 +1,22 @@
 TI PCI Controllers
 
 PCIe Designware Controller
- - compatible: Should be "ti,dra7-pcie""
- - reg : Two register ranges as listed in the reg-names property
- - reg-names : The first entry must be "ti-conf" for the TI specific registers
-	       The second entry must be "rc-dbics" for the designware pcie
-	       registers
-	       The third entry must be "config" for the PCIe configuration space
+ - compatible: Should be "ti,dra7-pcie" for RC
+	       Should be "ti,dra7-pcie-ep" for EP
  - phys : list of PHY specifiers (used by generic PHY framework)
  - phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
 	       number of PHYs as specified in *phys* property.
  - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
 	       where <X> is the instance number of the pcie from the HW spec.
+ - num-lanes as specified in ../designware-pcie.txt
+
+HOST MODE
+=========
+ - reg : Two register ranges as listed in the reg-names property
+ - reg-names : The first entry must be "ti-conf" for the TI specific registers
+	       The second entry must be "rc-dbics" for the designware pcie
+	       registers
+	       The third entry must be "config" for the PCIe configuration space
  - interrupts : Two interrupt entries must be specified. The first one is for
 		main interrupt line and the second for MSI interrupt line.
  - #address-cells,
@@ -19,13 +24,24 @@ PCIe Designware Controller
    #interrupt-cells,
    device_type,
    ranges,
-   num-lanes,
    interrupt-map-mask,
    interrupt-map : as specified in ../designware-pcie.txt
 
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
 
+DEVICE MODE
+===========
+ - reg : Two register ranges as listed in the reg-names property
+ - reg-names : "ti-conf" for the TI specific registers
+	       "ep_dbics" for the standard configuration registers as
+		they are locally accessed within the DIF CS space
+	       "ep_dbics2" for the standard configuration registers as
+		they are locally accessed within the DIF CS2 space
+ - interrupts : one interrupt entries must be specified for main interrupt.
+ - num-ib-windows : number of inbound address translation windows
+ - num-ob-windows : number of outbound address translation windows
+
 Example:
 axi {
 	compatible = "simple-bus";
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8574828..4d70981 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -23,6 +23,27 @@ config PCI_DRA7XX_HOST
 	 Enables support for the PCIe controller in the DRA7xx SoC to work in
 	 host mode.
 
+config PCI_DRA7XX_EP
+	bool "Endpoint Only Mode"
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	 Enables support for the PCIe controller in the DRA7xx SoC to work in
+	 endpoint mode.
+
+config PCI_DRA7XX_HOST_EP
+	bool "Both Host and Endpoint Mode"
+	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI
+	depends on PCI_ENDPOINT
+	select PCIE_DW_HOST
+	select PCIE_DW_EP
+	help
+	 Enables support for the PCIe controller in the DRA7xx SoC to work in
+	 both endpoint mode and host mode. If the board has 2 PCIe ports and
+	 one of them has to work in host mode and the other has to work in
+	 EP mode then this option has to be enabled.
+
 endchoice
 
 endif
diff --git a/drivers/pci/controller/pci-dra7xx.c b/drivers/pci/controller/pci-dra7xx.c
index dc5b8ef..5b49367 100644
--- a/drivers/pci/controller/pci-dra7xx.c
+++ b/drivers/pci/controller/pci-dra7xx.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -17,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -56,6 +58,11 @@
 #define	MSI						BIT(4)
 #define	LEG_EP_INTERRUPTS (INTA | INTB | INTC | INTD)
 
+#define	PCIECTRL_TI_CONF_DEVICE_TYPE			0x0100
+#define	DEVICE_TYPE_EP					0x0
+#define	DEVICE_TYPE_LEG_EP				0x1
+#define	DEVICE_TYPE_RC					0x4
+
 #define	PCIECTRL_DRA7XX_CONF_DEVICE_CMD			0x0104
 #define	LTSSM_EN					0x1
 
@@ -63,12 +70,20 @@
 #define	LINK_UP						BIT(16)
 #define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
 
+#define	PCIECTRL_TI_CONF_INTX_ASSERT			0x0124
+#define	PCIECTRL_TI_CONF_INTX_DEASSERT			0x0128
+
 struct dra7xx_pcie {
 	void __iomem		*base;
 	struct phy		**phy;
 	int			phy_count;
 	struct device		*dev;
 	struct dw_pcie		*pci;
+	enum dw_pcie_device_mode mode;
+};
+
+struct dra7xx_pcie_of_data {
+	enum dw_pcie_device_mode mode;
 };
 
 #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
@@ -248,6 +263,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct dra7xx_pcie *dra7xx = arg;
+	struct dw_pcie *pci = dra7xx->pci;
+	struct dw_pcie_ep *ep = &pci->ep;
 	u32 reg;
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
@@ -285,8 +302,11 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	if (reg & LINK_REQ_RST)
 		dev_dbg(dra7xx->dev, "Link Request Reset\n");
 
-	if (reg & LINK_UP_EVT)
+	if (reg & LINK_UP_EVT) {
+		if (dra7xx->mode == DW_PCIE_EP_TYPE)
+			dw_pcie_ep_linkup(ep);
 		dev_dbg(dra7xx->dev, "Link-up state change\n");
+	}
 
 	if (reg & CFG_BME_EVT)
 		dev_dbg(dra7xx->dev, "CFG 'Bus Master Enable' change\n");
@@ -299,6 +319,82 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+
+	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
+}
+
+static void dra7xx_pcie_raise_legacy_irq(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_INTX_ASSERT, 0x1);
+	mdelay(1);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_INTX_DEASSERT, 0x1);
+}
+
+void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx)
+{
+	/* TODO */
+}
+
+static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep,
+				 enum pci_epc_irq_type type)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		dra7xx_pcie_raise_legacy_irq(dra7xx);
+		break;
+	case PCI_EPC_IRQ_MSI:
+		dra7xx_pcie_raise_msi_irq(dra7xx);
+		break;
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+	}
+
+	return 0;
+}
+
+static struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = dra7xx_pcie_ep_init,
+	.raise_irq = dra7xx_pcie_raise_irq,
+};
+
+static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
+				     struct platform_device *pdev)
+{
+	int ret;
+	struct dw_pcie_ep *ep;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = dra7xx->pci;
+
+	ep = &pci->ep;
+	ep->ops = &pcie_ep_ops;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
+	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pci->dbi_base)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
+	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pci->dbi_base2)
+		return -ENOMEM;
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dra7xx->dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 				       struct platform_device *pdev)
 {
@@ -346,12 +442,57 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	return 0;
 }
 
+static const struct dra7xx_pcie_of_data dra7xx_pcie_rc_of_data = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct dra7xx_pcie_of_data dra7xx_pcie_ep_of_data = {
+	.mode = DW_PCIE_EP_TYPE,
+};
+
+static const struct of_device_id of_dra7xx_pcie_match[] = {
+	{
+		.compatible = "ti,dra7-pcie",
+		.data = &dra7xx_pcie_rc_of_data,
+	},
+	{
+		.compatible = "ti,dra7-pcie-ep",
+		.data = &dra7xx_pcie_ep_of_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_dra7xx_pcie_match);
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = dra7xx_pcie_start_link,
 	.stop_link = dra7xx_pcie_stop_link,
 	.link_up = dra7xx_pcie_link_up,
 };
 
+static int dra7xx_pcie_gpio_reset(struct device *dev)
+{
+	int ret;
+	int gpio_sel;
+	enum of_gpio_flags flags;
+	unsigned long gpio_flags;
+
+	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
+	if (gpio_is_valid(gpio_sel)) {
+		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
+			      GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
+		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
+					    "pcie_reset");
+		if (ret)
+			dev_err(dev, "gpio%d request failed, ret %d\n",
+				gpio_sel, ret);
+		return ret;
+	}
+	if (gpio_sel == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -367,9 +508,16 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	char name[10];
-	int gpio_sel;
-	enum of_gpio_flags flags;
-	unsigned long gpio_flags;
+	const struct of_device_id *match;
+	const struct dra7xx_pcie_of_data *data;
+	enum dw_pcie_device_mode mode;
+
+	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct dra7xx_pcie_of_data *)match->data;
+	mode = (enum dw_pcie_device_mode)data->mode;
 
 	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
 	if (!dra7xx)
@@ -440,31 +588,34 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
-	if (gpio_is_valid(gpio_sel)) {
-		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
-				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
-		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
-					    "pcie_reset");
-		if (ret) {
-			dev_err(&pdev->dev, "gpio%d request failed, ret %d\n",
-				gpio_sel, ret);
-			goto err_gpio;
-		}
-	} else if (gpio_sel == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto err_gpio;
-	}
-
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg &= ~LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
 	platform_set_drvdata(pdev, dra7xx);
 
-	ret = dra7xx_add_pcie_port(dra7xx, pdev);
-	if (ret < 0)
-		goto err_gpio;
+	switch (mode) {
+	case DW_PCIE_RC_TYPE:
+		ret = dra7xx_pcie_gpio_reset(dev);
+		if (ret)
+			goto err_gpio;
+		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
+				   DEVICE_TYPE_RC);
+		ret = dra7xx_add_pcie_port(dra7xx, pdev);
+		if (ret < 0)
+			goto err_gpio;
+		break;
+	case DW_PCIE_EP_TYPE:
+		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
+				   DEVICE_TYPE_EP);
+		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
+		if (ret < 0)
+			goto err_gpio;
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", mode);
+	}
+	dra7xx->mode = mode;
 
 	return 0;
 
@@ -491,7 +642,7 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int count = dra7xx->phy_count;
 
-	if (pp->irq_domain)
+	if (dra7xx->mode == DW_PCIE_RC_TYPE && pp->irq_domain)
 		irq_domain_remove(pp->irq_domain);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
@@ -510,6 +661,9 @@ static int dra7xx_pcie_suspend(struct device *dev)
 	struct dw_pcie *pci = dra7xx->pci;
 	u32 val;
 
+	if (dra7xx->mode != DW_PCIE_RC_TYPE)
+		return 0;
+
 	/* clear MSE */
 	val = dra7xx_pcie_readl_dbi(pci->dbi_base, PCI_COMMAND);
 	val &= ~PCI_COMMAND_MEMORY;
@@ -524,6 +678,9 @@ static int dra7xx_pcie_resume(struct device *dev)
 	struct dw_pcie *pci = dra7xx->pci;
 	u32 val;
 
+	if (dra7xx->mode != DW_PCIE_RC_TYPE)
+		return 0;
+
 	/* set MSE */
 	val = dra7xx_pcie_readl_dbi(pci->dbi_base, PCI_COMMAND);
 	val |= PCI_COMMAND_MEMORY;
@@ -582,12 +739,6 @@ static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
 				      dra7xx_pcie_resume_noirq)
 };
 
-static const struct of_device_id of_dra7xx_pcie_match[] = {
-	{ .compatible = "ti,dra7-pcie", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, of_dra7xx_pcie_match);
-
 static struct platform_driver dra7xx_pcie_driver = {
 	.remove		= __exit_p(dra7xx_pcie_remove),
 	.driver = {
-- 
1.7.9.5

