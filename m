Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:52329 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932583AbdJaWkg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 18:40:36 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/17] PCI: dwc: dra7xx: Add ifdefs for host/ep specific code
Date: Tue, 31 Oct 2017 23:39:27 +0100
Message-Id: <20171031223936.27549-10-niklas.cassel@axis.com>
In-Reply-To: <20171031223936.27549-1-niklas.cassel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This way you will not build and include unused code when only building
for one mode.

Moved dra7xx_pcie_enable_wrapper_interrupts() and dra7xx_add_pcie_port()
in order to keep all host specific code inside a single ifdef block.

Moved dra7xx_pcie_ep_unaligned_memaccess() in order to keep all ep
specific code inside a single ifdef block.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
V3:
* Fixed commit message.
* Moved functions in order to have just a single ifdef for host,
  and a single ifdef for ep.
* Removed ifdefs around match table and match table data.
* Removed ifdefs in probe, use dummy implementations instead.

 drivers/pci/dwc/pci-dra7xx.c | 201 ++++++++++++++++++++++++-------------------
 1 file changed, 111 insertions(+), 90 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 009f6aeeee1c..b4c204aa932a 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -171,6 +171,15 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
+			   INTERRUPTS);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
+			   INTERRUPTS);
+}
+
+#ifdef CONFIG_PCI_DRA7XX_HOST
 static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 {
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
@@ -181,14 +190,6 @@ static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 			   MSI | LEG_EP_INTERRUPTS);
 }
 
-static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
-{
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-			   INTERRUPTS);
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
-			   INTERRUPTS);
-}
-
 static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
 {
 	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
@@ -277,6 +278,56 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
+				       struct platform_device *pdev)
+{
+	int ret;
+	struct dw_pcie *pci = dra7xx->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
+	struct resource *res;
+
+	pp->irq = platform_get_irq(pdev, 1);
+	if (pp->irq < 0) {
+		dev_err(dev, "missing IRQ resource\n");
+		return pp->irq;
+	}
+
+	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       "dra7-pcie-msi",	dra7xx);
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		return ret;
+	}
+
+	ret = dra7xx_pcie_init_irq_domain(pp);
+	if (ret < 0)
+		return ret;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
+	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pci->dbi_base)
+		return -ENOMEM;
+
+	pp->ops = &dra7xx_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+#else
+static inline int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
+					      struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
 static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct dra7xx_pcie *dra7xx = arg;
@@ -336,6 +387,7 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_PCI_DRA7XX_EP
 static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -390,6 +442,48 @@ static struct dw_pcie_ep_ops pcie_ep_ops = {
 	.raise_irq = dra7xx_pcie_raise_irq,
 };
 
+/*
+ * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
+ * @dra7xx: the dra7xx device where the workaround should be applied
+ *
+ * Access to the PCIe slave port that are not 32-bit aligned will result
+ * in incorrect mapping to TLP Address and Byte enable fields. Therefore,
+ * byte and half-word accesses are not possible to byte offset 0x1, 0x2, or
+ * 0x3.
+ *
+ * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
+ */
+static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
+{
+	int ret;
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	struct regmap *regmap;
+
+	regmap = syscon_regmap_lookup_by_phandle(np,
+						 "ti,syscon-unaligned-access");
+	if (IS_ERR(regmap)) {
+		dev_dbg(dev, "can't get ti,syscon-unaligned-access\n");
+		return -EINVAL;
+	}
+
+	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-unaligned-access",
+					       2, 0, &args);
+	if (ret) {
+		dev_err(dev, "failed to parse ti,syscon-unaligned-access\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(regmap, args.args[0], args.args[1],
+				 args.args[1]);
+	if (ret)
+		dev_err(dev, "failed to enable unaligned access\n");
+
+	of_node_put(args.np);
+
+	return ret;
+}
+
 static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 				     struct platform_device *pdev)
 {
@@ -427,49 +521,18 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 
 	return 0;
 }
-
-static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
-				       struct platform_device *pdev)
+#else
+static inline int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
 {
-	int ret;
-	struct dw_pcie *pci = dra7xx->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	struct resource *res;
-
-	pp->irq = platform_get_irq(pdev, 1);
-	if (pp->irq < 0) {
-		dev_err(dev, "missing IRQ resource\n");
-		return pp->irq;
-	}
-
-	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
-			       IRQF_SHARED | IRQF_NO_THREAD,
-			       "dra7-pcie-msi",	dra7xx);
-	if (ret) {
-		dev_err(dev, "failed to request irq\n");
-		return ret;
-	}
-
-	ret = dra7xx_pcie_init_irq_domain(pp);
-	if (ret < 0)
-		return ret;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
-	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pci->dbi_base)
-		return -ENOMEM;
-
-	pp->ops = &dra7xx_pcie_host_ops;
-
-	ret = dw_pcie_host_init(pp);
-	if (ret) {
-		dev_err(dev, "failed to initialize host\n");
-		return ret;
-	}
+	return -ENODEV;
+}
 
-	return 0;
+static inline int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
+					    struct platform_device *pdev)
+{
+	return -ENODEV;
 }
+#endif
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
@@ -537,48 +600,6 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 	{},
 };
 
-/*
- * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
- * @dra7xx: the dra7xx device where the workaround should be applied
- *
- * Access to the PCIe slave port that are not 32-bit aligned will result
- * in incorrect mapping to TLP Address and Byte enable fields. Therefore,
- * byte and half-word accesses are not possible to byte offset 0x1, 0x2, or
- * 0x3.
- *
- * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
- */
-static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
-{
-	int ret;
-	struct device_node *np = dev->of_node;
-	struct of_phandle_args args;
-	struct regmap *regmap;
-
-	regmap = syscon_regmap_lookup_by_phandle(np,
-						 "ti,syscon-unaligned-access");
-	if (IS_ERR(regmap)) {
-		dev_dbg(dev, "can't get ti,syscon-unaligned-access\n");
-		return -EINVAL;
-	}
-
-	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-unaligned-access",
-					       2, 0, &args);
-	if (ret) {
-		dev_err(dev, "failed to parse ti,syscon-unaligned-access\n");
-		return ret;
-	}
-
-	ret = regmap_update_bits(regmap, args.args[0], args.args[1],
-				 args.args[1]);
-	if (ret)
-		dev_err(dev, "failed to enable unaligned access\n");
-
-	of_node_put(args.np);
-
-	return ret;
-}
-
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
-- 
2.14.2
