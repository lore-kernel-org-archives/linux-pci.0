Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933599AbcJLNcr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:32:47 -0400
Subject: [PATCH v2 1/7] PCI: dra7xx: Add local struct device pointers
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Wed, 12 Oct 2016 08:32:42 -0500
Message-ID: <20161012133242.27714.50176.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 19223ed..2323679 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -106,10 +106,11 @@ static int dra7xx_pcie_link_up(struct pcie_port *pp)
 static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct device *dev = pp->dev;
 	u32 reg;
 
 	if (dw_pcie_link_up(pp)) {
-		dev_err(pp->dev, "link is already up\n");
+		dev_err(dev, "link is already up\n");
 		return 0;
 	}
 
@@ -223,51 +224,51 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct dra7xx_pcie *dra7xx = arg;
+	struct device *dev = dra7xx->pp.dev;
 	u32 reg;
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
 
 	if (reg & ERR_SYS)
-		dev_dbg(dra7xx->dev, "System Error\n");
+		dev_dbg(dev, "System Error\n");
 
 	if (reg & ERR_FATAL)
-		dev_dbg(dra7xx->dev, "Fatal Error\n");
+		dev_dbg(dev, "Fatal Error\n");
 
 	if (reg & ERR_NONFATAL)
-		dev_dbg(dra7xx->dev, "Non Fatal Error\n");
+		dev_dbg(dev, "Non Fatal Error\n");
 
 	if (reg & ERR_COR)
-		dev_dbg(dra7xx->dev, "Correctable Error\n");
+		dev_dbg(dev, "Correctable Error\n");
 
 	if (reg & ERR_AXI)
-		dev_dbg(dra7xx->dev, "AXI tag lookup fatal Error\n");
+		dev_dbg(dev, "AXI tag lookup fatal Error\n");
 
 	if (reg & ERR_ECRC)
-		dev_dbg(dra7xx->dev, "ECRC Error\n");
+		dev_dbg(dev, "ECRC Error\n");
 
 	if (reg & PME_TURN_OFF)
-		dev_dbg(dra7xx->dev,
+		dev_dbg(dev,
 			"Power Management Event Turn-Off message received\n");
 
 	if (reg & PME_TO_ACK)
-		dev_dbg(dra7xx->dev,
+		dev_dbg(dev,
 			"Power Management Turn-Off Ack message received\n");
 
 	if (reg & PM_PME)
-		dev_dbg(dra7xx->dev,
-			"PM Power Management Event message received\n");
+		dev_dbg(dev, "PM Power Management Event message received\n");
 
 	if (reg & LINK_REQ_RST)
-		dev_dbg(dra7xx->dev, "Link Request Reset\n");
+		dev_dbg(dev, "Link Request Reset\n");
 
 	if (reg & LINK_UP_EVT)
-		dev_dbg(dra7xx->dev, "Link-up state change\n");
+		dev_dbg(dev, "Link-up state change\n");
 
 	if (reg & CFG_BME_EVT)
-		dev_dbg(dra7xx->dev, "CFG 'Bus Master Enable' change\n");
+		dev_dbg(dev, "CFG 'Bus Master Enable' change\n");
 
 	if (reg & CFG_MSE_EVT)
-		dev_dbg(dra7xx->dev, "CFG 'Memory Space Enable' change\n");
+		dev_dbg(dev, "CFG 'Memory Space Enable' change\n");
 
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN, reg);
 
@@ -292,12 +293,11 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return -EINVAL;
 	}
 
-	ret = devm_request_irq(&pdev->dev, pp->irq,
-			       dra7xx_pcie_msi_irq_handler,
+	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "dra7-pcie-msi",	pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to request irq\n");
+		dev_err(dev, "failed to request irq\n");
 		return ret;
 	}
 
@@ -314,7 +314,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(dra7xx->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -407,7 +407,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
 					    "pcie_reset");
 		if (ret) {
-			dev_err(&pdev->dev, "gpio%d request failed, ret %d\n",
+			dev_err(dev, "gpio%d request failed, ret %d\n",
 				gpio_sel, ret);
 			goto err_gpio;
 		}

