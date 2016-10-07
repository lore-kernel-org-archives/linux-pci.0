Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936336AbcJGQ3V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:21 -0400
Subject: [PATCH 3/9] PCI: xilinx: Swap order of xilinx_writel() reg/val
 arguments
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:29:03 -0500
Message-ID: <20161007162903.24137.66452.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of xilinx_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |   39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index f8e4c22..b840737 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -123,7 +123,8 @@ static inline u32 xilinx_readl(struct xilinx_pcie_port *xilinx, u32 reg)
 	return readl(xilinx->reg_base + reg);
 }
 
-static inline void xilinx_writel(struct xilinx_pcie_port *xilinx, u32 val, u32 reg)
+static inline void xilinx_writel(struct xilinx_pcie_port *xilinx, u32 reg,
+				 u32 val)
 {
 	writel(val, xilinx->reg_base + reg);
 }
@@ -145,8 +146,8 @@ static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *xilinx)
 	if (val & XILINX_PCIE_RPEFR_ERR_VALID) {
 		dev_dbg(xilinx->dev, "Requester ID %lu\n",
 			val & XILINX_PCIE_RPEFR_REQ_ID);
-		xilinx_writel(xilinx, XILINX_PCIE_RPEFR_ALL_MASK,
-			   XILINX_PCIE_REG_RPEFR);
+		xilinx_writel(xilinx, XILINX_PCIE_REG_RPEFR,
+			      XILINX_PCIE_RPEFR_ALL_MASK);
 	}
 }
 
@@ -343,8 +344,8 @@ static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *xilinx)
 
 	xilinx->msi_pages = __get_free_pages(GFP_KERNEL, 0);
 	msg_addr = virt_to_phys((void *)xilinx->msi_pages);
-	xilinx_writel(xilinx, 0x0, XILINX_PCIE_REG_MSIBASE1);
-	xilinx_writel(xilinx, msg_addr, XILINX_PCIE_REG_MSIBASE2);
+	xilinx_writel(xilinx, XILINX_PCIE_REG_MSIBASE1, 0);
+	xilinx_writel(xilinx, XILINX_PCIE_REG_MSIBASE2, msg_addr);
 }
 
 /* INTx Functions */
@@ -435,8 +436,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
 			/* Clear interrupt FIFO register 1 */
-			xilinx_writel(xilinx, XILINX_PCIE_RPIFR1_ALL_MASK,
-				   XILINX_PCIE_REG_RPIFR1);
+			xilinx_writel(xilinx, XILINX_PCIE_REG_RPIFR1,
+				      XILINX_PCIE_RPIFR1_ALL_MASK);
 
 			/* Handle INTx Interrupt */
 			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
@@ -460,8 +461,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 				   XILINX_PCIE_RPIFR2_MSG_DATA;
 
 			/* Clear interrupt FIFO register 1 */
-			xilinx_writel(xilinx, XILINX_PCIE_RPIFR1_ALL_MASK,
-				   XILINX_PCIE_REG_RPIFR1);
+			xilinx_writel(xilinx, XILINX_PCIE_REG_RPIFR1,
+				      XILINX_PCIE_RPIFR1_ALL_MASK);
 
 			if (IS_ENABLED(CONFIG_PCI_MSI)) {
 				/* Handle MSI Interrupt */
@@ -499,8 +500,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 error:
 	/* Clear the Interrupt Decode register */
-	xilinx_writel(xilinx, status, XILINX_PCIE_REG_IDR);
-
+	xilinx_writel(xilinx, XILINX_PCIE_REG_IDR, status);
 	return IRQ_HANDLED;
 }
 
@@ -560,21 +560,20 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *xilinx)
 		dev_info(xilinx->dev, "PCIe Link is DOWN\n");
 
 	/* Disable all interrupts */
-	xilinx_writel(xilinx, ~XILINX_PCIE_IDR_ALL_MASK,
-		   XILINX_PCIE_REG_IMR);
+	xilinx_writel(xilinx, XILINX_PCIE_REG_IMR, ~XILINX_PCIE_IDR_ALL_MASK);
 
 	/* Clear pending interrupts */
-	xilinx_writel(xilinx, xilinx_readl(xilinx, XILINX_PCIE_REG_IDR) &
-			 XILINX_PCIE_IMR_ALL_MASK,
-		   XILINX_PCIE_REG_IDR);
+	xilinx_writel(xilinx, XILINX_PCIE_REG_IDR,
+		      xilinx_readl(xilinx, XILINX_PCIE_REG_IDR) &
+			XILINX_PCIE_IMR_ALL_MASK);
 
 	/* Enable all interrupts */
-	xilinx_writel(xilinx, XILINX_PCIE_IMR_ALL_MASK, XILINX_PCIE_REG_IMR);
+	xilinx_writel(xilinx, XILINX_PCIE_REG_IMR, XILINX_PCIE_IMR_ALL_MASK);
 
 	/* Enable the Bridge enable bit */
-	xilinx_writel(xilinx, xilinx_readl(xilinx, XILINX_PCIE_REG_RPSC) |
-			 XILINX_PCIE_REG_RPSC_BEN,
-		   XILINX_PCIE_REG_RPSC);
+	xilinx_writel(xilinx, XILINX_PCIE_REG_RPSC,
+		      xilinx_readl(xilinx, XILINX_PCIE_REG_RPSC) |
+			XILINX_PCIE_REG_RPSC_BEN);
 }
 
 /**

