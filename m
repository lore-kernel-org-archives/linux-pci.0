Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941180AbcJGQeq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:34:46 -0400
Subject: [PATCH 4/9] PCI: dra7xx: Remove redundant struct device pointer
 from dra7xx_pcie
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Fri, 07 Oct 2016 11:34:18 -0500
Message-ID: <20161007163418.24926.97909.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The DesignWare core already stores the struct device pointer in struct
pcie_port.  Remove the redundant copy from struct dra7xx_pcie.dev.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 942c95c..73d4948 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -67,7 +67,6 @@ struct dra7xx_pcie {
 	void __iomem		*base;
 	struct phy		**phy;
 	int			phy_count;
-	struct device		*dev;
 	struct pcie_port	pp;
 };
 
@@ -223,50 +222,51 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct dra7xx_pcie *dra7xx = arg;
 	u32 reg;
+	struct device *dev = dra7xx->pp.dev;
 
 	reg = dra7xx_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
 
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
+		dev_dbg(dev,
 			"PM Power Management Event message received\n");
 
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
 
 	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN, reg);
 
@@ -313,7 +313,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(dra7xx->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -389,7 +389,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	dra7xx->base = base;
 	dra7xx->phy = phy;
-	dra7xx->dev = dev;
 	dra7xx->phy_count = phy_count;
 
 	pm_runtime_enable(dev);

