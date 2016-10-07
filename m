Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941014AbcJGQ0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:26:06 -0400
Subject: [PATCH 10/10] PCI: rcar-gen2: Add local struct device pointers
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:26:01 -0500
Message-ID: <20161007162601.23279.76660.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-rcar-gen2.c |   47 +++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index b210ec0..97f15b0 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -164,10 +164,11 @@ static int rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 {
 	struct rcar_pci *rcar = pw;
+	struct device *dev = rcar->dev;
 	u32 status = rcar_readl(rcar, RCAR_PCI_INT_STATUS_REG);
 
 	if (status & RCAR_PCI_INT_ALLERRORS) {
-		dev_err(rcar->dev, "error irq: status %08x\n", status);
+		dev_err(dev, "error irq: status %08x\n", status);
 
 		/* clear the error(s) */
 		rcar_writel(rcar, RCAR_PCI_INT_STATUS_REG,
@@ -180,13 +181,14 @@ static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 
 static void rcar_pci_setup_errirq(struct rcar_pci *rcar)
 {
+	struct device *dev = rcar->dev;
 	int ret;
 	u32 val;
 
-	ret = devm_request_irq(rcar->dev, rcar->irq, rcar_pci_err_irq,
+	ret = devm_request_irq(dev, rcar->irq, rcar_pci_err_irq,
 			       IRQF_SHARED, "error irq", rcar);
 	if (ret) {
-		dev_err(rcar->dev, "cannot claim IRQ for error handling\n");
+		dev_err(dev, "cannot claim IRQ for error handling\n");
 		return;
 	}
 
@@ -202,14 +204,15 @@ static inline void rcar_pci_setup_errirq(struct rcar_pci *rcar) { }
 static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 {
 	struct rcar_pci *rcar = sys->private_data;
+	struct device *dev = rcar->dev;
 	u32 val;
 	int ret;
 
-	pm_runtime_enable(rcar->dev);
-	pm_runtime_get_sync(rcar->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 
 	val = rcar_readl(rcar, RCAR_PCI_UNIT_REV_REG);
-	dev_info(rcar->dev, "PCI: bus%u revision %x\n", sys->busnr, val);
+	dev_info(dev, "PCI: bus%u revision %x\n", sys->busnr, val);
 
 	/* Disable Direct Power Down State and assert reset */
 	val = rcar_readl(rcar, RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
@@ -284,7 +287,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 
 	/* Add PCI resources */
 	pci_add_resource(&sys->resources, &rcar->mem_res);
-	ret = devm_request_pci_bus_resources(rcar->dev, &sys->resources);
+	ret = devm_request_pci_bus_resources(dev, &sys->resources);
 	if (ret < 0)
 		return ret;
 
@@ -320,6 +323,7 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 static int rcar_pci_parse_map_dma_ranges(struct rcar_pci *rcar,
 					 struct device_node *np)
 {
+	struct device *dev = rcar->dev;
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	int index = 0;
@@ -340,14 +344,14 @@ static int rcar_pci_parse_map_dma_ranges(struct rcar_pci *rcar,
 
 		/* Catch HW limitations */
 		if (!(range.flags & IORESOURCE_PREFETCH)) {
-			dev_err(rcar->dev, "window must be prefetchable\n");
+			dev_err(dev, "window must be prefetchable\n");
 			return -EINVAL;
 		}
 		if (rcar->window_addr) {
 			u32 lowaddr = 1 << (ffs(rcar->window_addr) - 1);
 
 			if (lowaddr < rcar->window_size) {
-				dev_err(rcar->dev, "invalid window size/addr\n");
+				dev_err(dev, "invalid window size/addr\n");
 				return -EINVAL;
 			}
 		}
@@ -359,14 +363,15 @@ static int rcar_pci_parse_map_dma_ranges(struct rcar_pci *rcar,
 
 static int rcar_pci_probe(struct platform_device *pdev)
 {
-	struct resource *cfg_res, *mem_res;
+	struct device *dev = &pdev->dev;
 	struct rcar_pci *rcar;
+	struct resource *cfg_res, *mem_res;
 	void __iomem *reg;
 	struct hw_pci hw;
 	void *hw_private[1];
 
 	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(&pdev->dev, cfg_res);
+	reg = devm_ioremap_resource(dev, cfg_res);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
@@ -377,7 +382,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	if (mem_res->start & 0xFFFF)
 		return -EINVAL;
 
-	rcar = devm_kzalloc(&pdev->dev, sizeof(*rcar), GFP_KERNEL);
+	rcar = devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
 	if (!rcar)
 		return -ENOMEM;
 
@@ -386,10 +391,10 @@ static int rcar_pci_probe(struct platform_device *pdev)
 
 	rcar->irq = platform_get_irq(pdev, 0);
 	rcar->reg = reg;
-	rcar->dev = &pdev->dev;
+	rcar->dev = dev;
 
 	if (rcar->irq < 0) {
-		dev_err(&pdev->dev, "no valid irq found\n");
+		dev_err(dev, "no valid irq found\n");
 		return rcar->irq;
 	}
 
@@ -398,23 +403,23 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	rcar->window_pci = 0x40000000;
 	rcar->window_size = SZ_1G;
 
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
 
 		rcar->busnr = busnr.start;
 		if (busnr.end != busnr.start)
-			dev_warn(&pdev->dev, "only one bus number supported\n");
+			dev_warn(dev, "only one bus number supported\n");
 
-		ret = rcar_pci_parse_map_dma_ranges(rcar, pdev->dev.of_node);
+		ret = rcar_pci_parse_map_dma_ranges(rcar, dev->of_node);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to parse dma-range\n");
+			dev_err(dev, "failed to parse dma-range\n");
 			return ret;
 		}
 	} else {
@@ -429,7 +434,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	hw.map_irq = rcar_pci_map_irq;
 	hw.ops = &rcar_pci_ops;
 	hw.setup = rcar_pci_setup;
-	pci_common_init_dev(&pdev->dev, &hw);
+	pci_common_init_dev(dev, &hw);
 	return 0;
 }
 

