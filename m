Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932845AbcJLM7U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:59:20 -0400
Subject: [PATCH v2 5/5] PCI: rcar-gen2: Add local struct device pointers
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 07:59:15 -0500
Message-ID: <20161012125915.24785.8161.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pci/host/pci-rcar-gen2.c |   46 +++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 597566f..1eeefa4 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -154,10 +154,11 @@ static int rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 {
 	struct rcar_pci_priv *priv = pw;
+	struct device *dev = priv->dev;
 	u32 status = ioread32(priv->reg + RCAR_PCI_INT_STATUS_REG);
 
 	if (status & RCAR_PCI_INT_ALLERRORS) {
-		dev_err(priv->dev, "error irq: status %08x\n", status);
+		dev_err(dev, "error irq: status %08x\n", status);
 
 		/* clear the error(s) */
 		iowrite32(status & RCAR_PCI_INT_ALLERRORS,
@@ -170,13 +171,14 @@ static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 
 static void rcar_pci_setup_errirq(struct rcar_pci_priv *priv)
 {
+	struct device *dev = priv->dev;
 	int ret;
 	u32 val;
 
-	ret = devm_request_irq(priv->dev, priv->irq, rcar_pci_err_irq,
+	ret = devm_request_irq(dev, priv->irq, rcar_pci_err_irq,
 			       IRQF_SHARED, "error irq", priv);
 	if (ret) {
-		dev_err(priv->dev, "cannot claim IRQ for error handling\n");
+		dev_err(dev, "cannot claim IRQ for error handling\n");
 		return;
 	}
 
@@ -192,15 +194,16 @@ static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
 static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 {
 	struct rcar_pci_priv *priv = sys->private_data;
+	struct device *dev = priv->dev;
 	void __iomem *reg = priv->reg;
 	u32 val;
 	int ret;
 
-	pm_runtime_enable(priv->dev);
-	pm_runtime_get_sync(priv->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 
 	val = ioread32(reg + RCAR_PCI_UNIT_REV_REG);
-	dev_info(priv->dev, "PCI: bus%u revision %x\n", sys->busnr, val);
+	dev_info(dev, "PCI: bus%u revision %x\n", sys->busnr, val);
 
 	/* Disable Direct Power Down State and assert reset */
 	val = ioread32(reg + RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
@@ -275,7 +278,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 
 	/* Add PCI resources */
 	pci_add_resource(&sys->resources, &priv->mem_res);
-	ret = devm_request_pci_bus_resources(priv->dev, &sys->resources);
+	ret = devm_request_pci_bus_resources(dev, &sys->resources);
 	if (ret < 0)
 		return ret;
 
@@ -311,6 +314,7 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
 					 struct device_node *np)
 {
+	struct device *dev = pci->dev;
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	int index = 0;
@@ -331,14 +335,14 @@ static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
 
 		/* Catch HW limitations */
 		if (!(range.flags & IORESOURCE_PREFETCH)) {
-			dev_err(pci->dev, "window must be prefetchable\n");
+			dev_err(dev, "window must be prefetchable\n");
 			return -EINVAL;
 		}
 		if (pci->window_addr) {
 			u32 lowaddr = 1 << (ffs(pci->window_addr) - 1);
 
 			if (lowaddr < pci->window_size) {
-				dev_err(pci->dev, "invalid window size/addr\n");
+				dev_err(dev, "invalid window size/addr\n");
 				return -EINVAL;
 			}
 		}
@@ -350,6 +354,7 @@ static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
 
 static int rcar_pci_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct resource *cfg_res, *mem_res;
 	struct rcar_pci_priv *priv;
 	void __iomem *reg;
@@ -357,7 +362,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	void *hw_private[1];
 
 	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(&pdev->dev, cfg_res);
+	reg = devm_ioremap_resource(dev, cfg_res);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
@@ -368,8 +373,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	if (mem_res->start & 0xFFFF)
 		return -EINVAL;
 
-	priv = devm_kzalloc(&pdev->dev,
-			    sizeof(struct rcar_pci_priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(struct rcar_pci_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -378,10 +382,10 @@ static int rcar_pci_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	priv->reg = reg;
-	priv->dev = &pdev->dev;
+	priv->dev = dev;
 
 	if (priv->irq < 0) {
-		dev_err(&pdev->dev, "no valid irq found\n");
+		dev_err(dev, "no valid irq found\n");
 		return priv->irq;
 	}
 
@@ -390,23 +394,23 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	priv->window_pci = 0x40000000;
 	priv->window_size = SZ_1G;
 
-	if (pdev->dev.of_node) {
+	if (dev->of_node) {
 		struct resource busnr;
 		int ret;
 
-		ret = of_pci_parse_bus_range(pdev->dev.of_node, &busnr);
+		ret = of_pci_parse_bus_range(dev->of_node, &busnr);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to parse bus-range\n");
+			dev_err(dev, "failed to parse bus-range\n");
 			return ret;
 		}
 
 		priv->busnr = busnr.start;
 		if (busnr.end != busnr.start)
-			dev_warn(&pdev->dev, "only one bus number supported\n");
+			dev_warn(dev, "only one bus number supported\n");
 
-		ret = rcar_pci_parse_map_dma_ranges(priv, pdev->dev.of_node);
+		ret = rcar_pci_parse_map_dma_ranges(priv, dev->of_node);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to parse dma-range\n");
+			dev_err(dev, "failed to parse dma-range\n");
 			return ret;
 		}
 	} else {
@@ -421,7 +425,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	hw.map_irq = rcar_pci_map_irq;
 	hw.ops = &rcar_pci_ops;
 	hw.setup = rcar_pci_setup;
-	pci_common_init_dev(&pdev->dev, &hw);
+	pci_common_init_dev(dev, &hw);
 	return 0;
 }
 

