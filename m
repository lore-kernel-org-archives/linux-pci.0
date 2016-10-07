Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939767AbcJGQZy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:25:54 -0400
Subject: [PATCH 08/10] PCI: rcar-gen2: Name private struct pointer "rcar"
 consistently
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:25:44 -0500
Message-ID: <20161007162544.23279.49603.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename struct rcar_pci_priv to rcar_pci, along the lines of other drivers.

Use a device-specific name, "rcar", for struct rcar_pci pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-rcar-gen2.c |  121 +++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 597566f..cba27bc 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -95,7 +95,7 @@
 
 #define RCAR_PCI_UNIT_REV_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x48)
 
-struct rcar_pci_priv {
+struct rcar_pci {
 	struct device *dev;
 	void __iomem *reg;
 	struct resource mem_res;
@@ -112,7 +112,7 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 				       int where)
 {
 	struct pci_sys_data *sys = bus->sysdata;
-	struct rcar_pci_priv *priv = sys->private_data;
+	struct rcar_pci *rcar = sys->private_data;
 	int slot, val;
 
 	if (sys->busnr != bus->number || PCI_FUNC(devfn))
@@ -130,20 +130,20 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 	val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
 		     RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
 
-	iowrite32(val, priv->reg + RCAR_AHBPCI_WIN1_CTR_REG);
-	return priv->reg + (slot >> 1) * 0x100 + where;
+	iowrite32(val, rcar->reg + RCAR_AHBPCI_WIN1_CTR_REG);
+	return rcar->reg + (slot >> 1) * 0x100 + where;
 }
 
 /* PCI interrupt mapping */
 static int rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pci_sys_data *sys = dev->bus->sysdata;
-	struct rcar_pci_priv *priv = sys->private_data;
+	struct rcar_pci *rcar = sys->private_data;
 	int irq;
 
 	irq = of_irq_parse_and_map_pci(dev, slot, pin);
 	if (!irq)
-		irq = priv->irq;
+		irq = rcar->irq;
 
 	return irq;
 }
@@ -153,54 +153,54 @@ static int rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 {
-	struct rcar_pci_priv *priv = pw;
-	u32 status = ioread32(priv->reg + RCAR_PCI_INT_STATUS_REG);
+	struct rcar_pci *rcar = pw;
+	u32 status = ioread32(rcar->reg + RCAR_PCI_INT_STATUS_REG);
 
 	if (status & RCAR_PCI_INT_ALLERRORS) {
-		dev_err(priv->dev, "error irq: status %08x\n", status);
+		dev_err(rcar->dev, "error irq: status %08x\n", status);
 
 		/* clear the error(s) */
 		iowrite32(status & RCAR_PCI_INT_ALLERRORS,
-			  priv->reg + RCAR_PCI_INT_STATUS_REG);
+			  rcar->reg + RCAR_PCI_INT_STATUS_REG);
 		return IRQ_HANDLED;
 	}
 
 	return IRQ_NONE;
 }
 
-static void rcar_pci_setup_errirq(struct rcar_pci_priv *priv)
+static void rcar_pci_setup_errirq(struct rcar_pci *rcar)
 {
 	int ret;
 	u32 val;
 
-	ret = devm_request_irq(priv->dev, priv->irq, rcar_pci_err_irq,
-			       IRQF_SHARED, "error irq", priv);
+	ret = devm_request_irq(rcar->dev, rcar->irq, rcar_pci_err_irq,
+			       IRQF_SHARED, "error irq", rcar);
 	if (ret) {
-		dev_err(priv->dev, "cannot claim IRQ for error handling\n");
+		dev_err(rcar->dev, "cannot claim IRQ for error handling\n");
 		return;
 	}
 
-	val = ioread32(priv->reg + RCAR_PCI_INT_ENABLE_REG);
+	val = ioread32(rcar->reg + RCAR_PCI_INT_ENABLE_REG);
 	val |= RCAR_PCI_INT_ALLERRORS;
-	iowrite32(val, priv->reg + RCAR_PCI_INT_ENABLE_REG);
+	iowrite32(val, rcar->reg + RCAR_PCI_INT_ENABLE_REG);
 }
 #else
-static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
+static inline void rcar_pci_setup_errirq(struct rcar_pci *rcar) { }
 #endif
 
 /* PCI host controller setup */
 static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 {
-	struct rcar_pci_priv *priv = sys->private_data;
-	void __iomem *reg = priv->reg;
+	struct rcar_pci *rcar = sys->private_data;
+	void __iomem *reg = rcar->reg;
 	u32 val;
 	int ret;
 
-	pm_runtime_enable(priv->dev);
-	pm_runtime_get_sync(priv->dev);
+	pm_runtime_enable(rcar->dev);
+	pm_runtime_get_sync(rcar->dev);
 
 	val = ioread32(reg + RCAR_PCI_UNIT_REV_REG);
-	dev_info(priv->dev, "PCI: bus%u revision %x\n", sys->busnr, val);
+	dev_info(rcar->dev, "PCI: bus%u revision %x\n", sys->busnr, val);
 
 	/* Disable Direct Power Down State and assert reset */
 	val = ioread32(reg + RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
@@ -213,7 +213,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 		 RCAR_USBCTR_USBH_RST | RCAR_USBCTR_PLL_RST);
 
 	/* Setup PCIAHB window1 size */
-	switch (priv->window_size) {
+	switch (rcar->window_size) {
 	case SZ_2G:
 		val |= RCAR_USBCTR_PCIAHB_WIN1_2G;
 		break;
@@ -225,8 +225,8 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 		break;
 	default:
 		pr_warn("unknown window size %ld - defaulting to 256M\n",
-			priv->window_size);
-		priv->window_size = SZ_256M;
+			rcar->window_size);
+		rcar->window_size = SZ_256M;
 		/* fall-through */
 	case SZ_256M:
 		val |= RCAR_USBCTR_PCIAHB_WIN1_256M;
@@ -244,21 +244,21 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	iowrite32(val, reg + RCAR_PCI_ARBITER_CTR_REG);
 
 	/* PCI-AHB mapping */
-	iowrite32(priv->window_addr | RCAR_PCIAHB_PREFETCH16,
+	iowrite32(rcar->window_addr | RCAR_PCIAHB_PREFETCH16,
 		  reg + RCAR_PCIAHB_WIN1_CTR_REG);
 
 	/* AHB-PCI mapping: OHCI/EHCI registers */
-	val = priv->mem_res.start | RCAR_AHBPCI_WIN_CTR_MEM;
+	val = rcar->mem_res.start | RCAR_AHBPCI_WIN_CTR_MEM;
 	iowrite32(val, reg + RCAR_AHBPCI_WIN2_CTR_REG);
 
 	/* Enable AHB-PCI bridge PCI configuration access */
 	iowrite32(RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG,
 		  reg + RCAR_AHBPCI_WIN1_CTR_REG);
 	/* Set PCI-AHB Window1 address */
-	iowrite32(priv->window_pci | PCI_BASE_ADDRESS_MEM_PREFETCH,
+	iowrite32(rcar->window_pci | PCI_BASE_ADDRESS_MEM_PREFETCH,
 		  reg + PCI_BASE_ADDRESS_1);
 	/* Set AHB-PCI bridge PCI communication area address */
-	val = priv->cfg_res->start + RCAR_AHBPCI_PCICOM_OFFSET;
+	val = rcar->cfg_res->start + RCAR_AHBPCI_PCICOM_OFFSET;
 	iowrite32(val, reg + PCI_BASE_ADDRESS_0);
 
 	val = ioread32(reg + PCI_COMMAND);
@@ -270,17 +270,17 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	iowrite32(RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME,
 		  reg + RCAR_PCI_INT_ENABLE_REG);
 
-	if (priv->irq > 0)
-		rcar_pci_setup_errirq(priv);
+	if (rcar->irq > 0)
+		rcar_pci_setup_errirq(rcar);
 
 	/* Add PCI resources */
-	pci_add_resource(&sys->resources, &priv->mem_res);
-	ret = devm_request_pci_bus_resources(priv->dev, &sys->resources);
+	pci_add_resource(&sys->resources, &rcar->mem_res);
+	ret = devm_request_pci_bus_resources(rcar->dev, &sys->resources);
 	if (ret < 0)
 		return ret;
 
 	/* Setup bus number based on platform device id / of bus-range */
-	sys->busnr = priv->busnr;
+	sys->busnr = rcar->busnr;
 	return 1;
 }
 
@@ -308,7 +308,7 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 	return 0;
 }
 
-static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
+static int rcar_pci_parse_map_dma_ranges(struct rcar_pci *rcar,
 					 struct device_node *np)
 {
 	struct of_pci_range range;
@@ -325,20 +325,20 @@ static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
 		if (index)
 			return -EINVAL;
 
-		pci->window_addr = (unsigned long)range.cpu_addr;
-		pci->window_pci = (unsigned long)range.pci_addr;
-		pci->window_size = (unsigned long)range.size;
+		rcar->window_addr = (unsigned long)range.cpu_addr;
+		rcar->window_pci = (unsigned long)range.pci_addr;
+		rcar->window_size = (unsigned long)range.size;
 
 		/* Catch HW limitations */
 		if (!(range.flags & IORESOURCE_PREFETCH)) {
-			dev_err(pci->dev, "window must be prefetchable\n");
+			dev_err(rcar->dev, "window must be prefetchable\n");
 			return -EINVAL;
 		}
-		if (pci->window_addr) {
-			u32 lowaddr = 1 << (ffs(pci->window_addr) - 1);
+		if (rcar->window_addr) {
+			u32 lowaddr = 1 << (ffs(rcar->window_addr) - 1);
 
-			if (lowaddr < pci->window_size) {
-				dev_err(pci->dev, "invalid window size/addr\n");
+			if (lowaddr < rcar->window_size) {
+				dev_err(rcar->dev, "invalid window size/addr\n");
 				return -EINVAL;
 			}
 		}
@@ -351,7 +351,7 @@ static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
 static int rcar_pci_probe(struct platform_device *pdev)
 {
 	struct resource *cfg_res, *mem_res;
-	struct rcar_pci_priv *priv;
+	struct rcar_pci *rcar;
 	void __iomem *reg;
 	struct hw_pci hw;
 	void *hw_private[1];
@@ -368,27 +368,26 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	if (mem_res->start & 0xFFFF)
 		return -EINVAL;
 
-	priv = devm_kzalloc(&pdev->dev,
-			    sizeof(struct rcar_pci_priv), GFP_KERNEL);
-	if (!priv)
+	rcar = devm_kzalloc(&pdev->dev, sizeof(*rcar), GFP_KERNEL);
+	if (!rcar)
 		return -ENOMEM;
 
-	priv->mem_res = *mem_res;
-	priv->cfg_res = cfg_res;
+	rcar->mem_res = *mem_res;
+	rcar->cfg_res = cfg_res;
 
-	priv->irq = platform_get_irq(pdev, 0);
-	priv->reg = reg;
-	priv->dev = &pdev->dev;
+	rcar->irq = platform_get_irq(pdev, 0);
+	rcar->reg = reg;
+	rcar->dev = &pdev->dev;
 
-	if (priv->irq < 0) {
+	if (rcar->irq < 0) {
 		dev_err(&pdev->dev, "no valid irq found\n");
-		return priv->irq;
+		return rcar->irq;
 	}
 
 	/* default window addr and size if not specified in DT */
-	priv->window_addr = 0x40000000;
-	priv->window_pci = 0x40000000;
-	priv->window_size = SZ_1G;
+	rcar->window_addr = 0x40000000;
+	rcar->window_pci = 0x40000000;
+	rcar->window_size = SZ_1G;
 
 	if (pdev->dev.of_node) {
 		struct resource busnr;
@@ -400,20 +399,20 @@ static int rcar_pci_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		priv->busnr = busnr.start;
+		rcar->busnr = busnr.start;
 		if (busnr.end != busnr.start)
 			dev_warn(&pdev->dev, "only one bus number supported\n");
 
-		ret = rcar_pci_parse_map_dma_ranges(priv, pdev->dev.of_node);
+		ret = rcar_pci_parse_map_dma_ranges(rcar, pdev->dev.of_node);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to parse dma-range\n");
 			return ret;
 		}
 	} else {
-		priv->busnr = pdev->id;
+		rcar->busnr = pdev->id;
 	}
 
-	hw_private[0] = priv;
+	hw_private[0] = rcar;
 	memset(&hw, 0, sizeof(hw));
 	hw.nr_controllers = ARRAY_SIZE(hw_private);
 	hw.io_optional = 1;

