Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938813AbcJGQ3V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:21 -0400
Subject: [PATCH 4/9] PCI: xilinx: Add local struct device pointers
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:29:11 -0500
Message-ID: <20161007162911.24137.26152.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |   47 +++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index b840737..44a2652 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -384,6 +384,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 {
 	struct xilinx_pcie_port *xilinx = (struct xilinx_pcie_port *)data;
+	struct device *dev = xilinx->dev;
 	u32 val, mask, status, msi_data;
 
 	/* Read interrupt decode and mask registers */
@@ -395,32 +396,32 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	if (status & XILINX_PCIE_INTR_LINK_DOWN)
-		dev_warn(xilinx->dev, "Link Down\n");
+		dev_warn(dev, "Link Down\n");
 
 	if (status & XILINX_PCIE_INTR_ECRC_ERR)
-		dev_warn(xilinx->dev, "ECRC failed\n");
+		dev_warn(dev, "ECRC failed\n");
 
 	if (status & XILINX_PCIE_INTR_STR_ERR)
-		dev_warn(xilinx->dev, "Streaming error\n");
+		dev_warn(dev, "Streaming error\n");
 
 	if (status & XILINX_PCIE_INTR_HOT_RESET)
-		dev_info(xilinx->dev, "Hot reset\n");
+		dev_info(dev, "Hot reset\n");
 
 	if (status & XILINX_PCIE_INTR_CFG_TIMEOUT)
-		dev_warn(xilinx->dev, "ECAM access timeout\n");
+		dev_warn(dev, "ECAM access timeout\n");
 
 	if (status & XILINX_PCIE_INTR_CORRECTABLE) {
-		dev_warn(xilinx->dev, "Correctable error message\n");
+		dev_warn(dev, "Correctable error message\n");
 		xilinx_pcie_clear_err_interrupts(xilinx);
 	}
 
 	if (status & XILINX_PCIE_INTR_NONFATAL) {
-		dev_warn(xilinx->dev, "Non fatal error message\n");
+		dev_warn(dev, "Non fatal error message\n");
 		xilinx_pcie_clear_err_interrupts(xilinx);
 	}
 
 	if (status & XILINX_PCIE_INTR_FATAL) {
-		dev_warn(xilinx->dev, "Fatal error message\n");
+		dev_warn(dev, "Fatal error message\n");
 		xilinx_pcie_clear_err_interrupts(xilinx);
 	}
 
@@ -430,7 +431,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 		/* Check whether interrupt valid */
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(xilinx->dev, "RP Intr FIFO1 read error\n");
+			dev_warn(dev, "RP Intr FIFO1 read error\n");
 			goto error;
 		}
 
@@ -452,7 +453,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		val = xilinx_readl(xilinx, XILINX_PCIE_REG_RPIFR1);
 
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(xilinx->dev, "RP Intr FIFO1 read error\n");
+			dev_warn(dev, "RP Intr FIFO1 read error\n");
 			goto error;
 		}
 
@@ -472,31 +473,31 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	}
 
 	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
-		dev_warn(xilinx->dev, "Slave unsupported request\n");
+		dev_warn(dev, "Slave unsupported request\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_UNEXP)
-		dev_warn(xilinx->dev, "Slave unexpected completion\n");
+		dev_warn(dev, "Slave unexpected completion\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_COMPL)
-		dev_warn(xilinx->dev, "Slave completion timeout\n");
+		dev_warn(dev, "Slave completion timeout\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_ERRP)
-		dev_warn(xilinx->dev, "Slave Error Poison\n");
+		dev_warn(dev, "Slave Error Poison\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_CMPABT)
-		dev_warn(xilinx->dev, "Slave Completer Abort\n");
+		dev_warn(dev, "Slave Completer Abort\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_ILLBUR)
-		dev_warn(xilinx->dev, "Slave Illegal Burst\n");
+		dev_warn(dev, "Slave Illegal Burst\n");
 
 	if (status & XILINX_PCIE_INTR_MST_DECERR)
-		dev_warn(xilinx->dev, "Master decode error\n");
+		dev_warn(dev, "Master decode error\n");
 
 	if (status & XILINX_PCIE_INTR_MST_SLVERR)
-		dev_warn(xilinx->dev, "Master slave error\n");
+		dev_warn(dev, "Master slave error\n");
 
 	if (status & XILINX_PCIE_INTR_MST_ERRP)
-		dev_warn(xilinx->dev, "Master error poison\n");
+		dev_warn(dev, "Master error poison\n");
 
 error:
 	/* Clear the Interrupt Decode register */
@@ -554,10 +555,12 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *xilinx)
  */
 static void xilinx_pcie_init_port(struct xilinx_pcie_port *xilinx)
 {
+	struct device *dev = xilinx->dev;
+
 	if (xilinx_pcie_link_is_up(xilinx))
-		dev_info(xilinx->dev, "PCIe Link is UP\n");
+		dev_info(dev, "PCIe Link is UP\n");
 	else
-		dev_info(xilinx->dev, "PCIe Link is DOWN\n");
+		dev_info(dev, "PCIe Link is DOWN\n");
 
 	/* Disable all interrupts */
 	xilinx_writel(xilinx, XILINX_PCIE_REG_IMR, ~XILINX_PCIE_IDR_ALL_MASK);
@@ -626,8 +629,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *xilinx)
  */
 static int xilinx_pcie_probe(struct platform_device *pdev)
 {
-	struct xilinx_pcie_port *xilinx;
 	struct device *dev = &pdev->dev;
+	struct xilinx_pcie_port *xilinx;
 	struct pci_bus *bus;
 	int err;
 	resource_size_t iobase = 0;

