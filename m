Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757217AbcJGQe0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:34:26 -0400
Subject: [PATCH 1/9] PCI: dra7xx: Rename accessors
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Fri, 07 Oct 2016 11:33:50 -0500
Message-ID: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename dra7xx_pcie_readl() to dra7xx_readl() and dra7xx_pcie_writel() to
dra7xx_writel() for consistency with other drivers.  Uninline them; there's
no performance issue here, and the compiler can inline them if it's
worthwhile.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |   45 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 19223ed..765f48b 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -73,13 +73,12 @@ struct dra7xx_pcie {
 
 #define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
 
-static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
+static u32 dra7xx_readl(struct dra7xx_pcie *pcie, u32 offset)
 {
 	return readl(pcie->base + offset);
 }
 
-static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
-				      u32 value)
+static void dra7xx_writel(struct dra7xx_pcie *pcie, u32 offset, u32 value)
 {
 	writel(value, pcie->base + offset);
 }
@@ -98,7 +97,7 @@ static inline void dra7xx_pcie_writel_rc(struct pcie_port *pp, u32 offset,
 static int dra7xx_pcie_link_up(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
-	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
+	u32 reg = dra7xx_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
 
 	return !!(reg & LINK_UP);
 }
@@ -113,9 +112,9 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 		return 0;
 	}
 
-	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
+	reg = dra7xx_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg |= LTSSM_EN;
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
+	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
 	return dw_pcie_wait_for_link(pp);
 }
@@ -124,20 +123,20 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
 
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-			   ~INTERRUPTS);
-	dra7xx_pcie_writel(dra7xx,
-			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
-			   ~LEG_EP_INTERRUPTS & ~MSI);
+	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
+		      ~INTERRUPTS);
+	dra7xx_writel(dra7xx,
+		      PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
+	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
+		      ~LEG_EP_INTERRUPTS & ~MSI);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dra7xx_pcie_writel(dra7xx,
-				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI, MSI);
+		dra7xx_writel(dra7xx,
+			      PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI, MSI);
 	else
-		dra7xx_pcie_writel(dra7xx,
-				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
-				   LEG_EP_INTERRUPTS);
+		dra7xx_writel(dra7xx,
+			      PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
+			      LEG_EP_INTERRUPTS);
 }
 
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
@@ -200,7 +199,7 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
 	u32 reg;
 
-	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
+	reg = dra7xx_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
 
 	switch (reg) {
 	case MSI:
@@ -214,7 +213,7 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 		break;
 	}
 
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
+	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
 
 	return IRQ_HANDLED;
 }
@@ -225,7 +224,7 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	struct dra7xx_pcie *dra7xx = arg;
 	u32 reg;
 
-	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
+	reg = dra7xx_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
 
 	if (reg & ERR_SYS)
 		dev_dbg(dra7xx->dev, "System Error\n");
@@ -269,7 +268,7 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	if (reg & CFG_MSE_EVT)
 		dev_dbg(dra7xx->dev, "CFG 'Memory Space Enable' change\n");
 
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN, reg);
+	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN, reg);
 
 	return IRQ_HANDLED;
 }
@@ -416,9 +415,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		goto err_gpio;
 	}
 
-	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
+	reg = dra7xx_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg &= ~LTSSM_EN;
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
+	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
 	platform_set_drvdata(pdev, dra7xx);
 

