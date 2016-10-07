Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756705AbcJGQ3U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:20 -0400
Subject: [PATCH 2/9] PCI: xilinx: Rename accessors
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:28:56 -0500
Message-ID: <20161007162856.24137.21735.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename pcie_read() to xilinx_readl() and pcie_write() to xilinx_writel()
for consistency with other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 14e4187..f8e4c22 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -118,19 +118,19 @@ struct xilinx_pcie_port {
 
 static DECLARE_BITMAP(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
 
-static inline u32 pcie_read(struct xilinx_pcie_port *xilinx, u32 reg)
+static inline u32 xilinx_readl(struct xilinx_pcie_port *xilinx, u32 reg)
 {
 	return readl(xilinx->reg_base + reg);
 }
 
-static inline void pcie_write(struct xilinx_pcie_port *xilinx, u32 val, u32 reg)
+static inline void xilinx_writel(struct xilinx_pcie_port *xilinx, u32 val, u32 reg)
 {
 	writel(val, xilinx->reg_base + reg);
 }
 
 static inline bool xilinx_pcie_link_is_up(struct xilinx_pcie_port *xilinx)
 {
-	return (pcie_read(xilinx, XILINX_PCIE_REG_PSCR) &
+	return (xilinx_readl(xilinx, XILINX_PCIE_REG_PSCR) &
 		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
 }
 
@@ -140,12 +140,12 @@ static inline bool xilinx_pcie_link_is_up(struct xilinx_pcie_port *xilinx)
  */
 static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *xilinx)
 {
-	unsigned long val = pcie_read(xilinx, XILINX_PCIE_REG_RPEFR);
+	unsigned long val = xilinx_readl(xilinx, XILINX_PCIE_REG_RPEFR);
 
 	if (val & XILINX_PCIE_RPEFR_ERR_VALID) {
 		dev_dbg(xilinx->dev, "Requester ID %lu\n",
 			val & XILINX_PCIE_RPEFR_REQ_ID);
-		pcie_write(xilinx, XILINX_PCIE_RPEFR_ALL_MASK,
+		xilinx_writel(xilinx, XILINX_PCIE_RPEFR_ALL_MASK,
 			   XILINX_PCIE_REG_RPEFR);
 	}
 }
@@ -343,8 +343,8 @@ static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *xilinx)
 
 	xilinx->msi_pages = __get_free_pages(GFP_KERNEL, 0);
 	msg_addr = virt_to_phys((void *)xilinx->msi_pages);
-	pcie_write(xilinx, 0x0, XILINX_PCIE_REG_MSIBASE1);
-	pcie_write(xilinx, msg_addr, XILINX_PCIE_REG_MSIBASE2);
+	xilinx_writel(xilinx, 0x0, XILINX_PCIE_REG_MSIBASE1);
+	xilinx_writel(xilinx, msg_addr, XILINX_PCIE_REG_MSIBASE2);
 }
 
 /* INTx Functions */
@@ -386,8 +386,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	u32 val, mask, status, msi_data;
 
 	/* Read interrupt decode and mask registers */
-	val = pcie_read(xilinx, XILINX_PCIE_REG_IDR);
-	mask = pcie_read(xilinx, XILINX_PCIE_REG_IMR);
+	val = xilinx_readl(xilinx, XILINX_PCIE_REG_IDR);
+	mask = xilinx_readl(xilinx, XILINX_PCIE_REG_IMR);
 
 	status = val & mask;
 	if (!status)
@@ -425,7 +425,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 	if (status & XILINX_PCIE_INTR_INTX) {
 		/* INTx interrupt received */
-		val = pcie_read(xilinx, XILINX_PCIE_REG_RPIFR1);
+		val = xilinx_readl(xilinx, XILINX_PCIE_REG_RPIFR1);
 
 		/* Check whether interrupt valid */
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
@@ -435,7 +435,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
 			/* Clear interrupt FIFO register 1 */
-			pcie_write(xilinx, XILINX_PCIE_RPIFR1_ALL_MASK,
+			xilinx_writel(xilinx, XILINX_PCIE_RPIFR1_ALL_MASK,
 				   XILINX_PCIE_REG_RPIFR1);
 
 			/* Handle INTx Interrupt */
@@ -448,7 +448,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 	if (status & XILINX_PCIE_INTR_MSI) {
 		/* MSI Interrupt */
-		val = pcie_read(xilinx, XILINX_PCIE_REG_RPIFR1);
+		val = xilinx_readl(xilinx, XILINX_PCIE_REG_RPIFR1);
 
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
 			dev_warn(xilinx->dev, "RP Intr FIFO1 read error\n");
@@ -456,11 +456,11 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		}
 
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
-			msi_data = pcie_read(xilinx, XILINX_PCIE_REG_RPIFR2) &
+			msi_data = xilinx_readl(xilinx, XILINX_PCIE_REG_RPIFR2) &
 				   XILINX_PCIE_RPIFR2_MSG_DATA;
 
 			/* Clear interrupt FIFO register 1 */
-			pcie_write(xilinx, XILINX_PCIE_RPIFR1_ALL_MASK,
+			xilinx_writel(xilinx, XILINX_PCIE_RPIFR1_ALL_MASK,
 				   XILINX_PCIE_REG_RPIFR1);
 
 			if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -499,7 +499,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 error:
 	/* Clear the Interrupt Decode register */
-	pcie_write(xilinx, status, XILINX_PCIE_REG_IDR);
+	xilinx_writel(xilinx, status, XILINX_PCIE_REG_IDR);
 
 	return IRQ_HANDLED;
 }
@@ -560,19 +560,19 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *xilinx)
 		dev_info(xilinx->dev, "PCIe Link is DOWN\n");
 
 	/* Disable all interrupts */
-	pcie_write(xilinx, ~XILINX_PCIE_IDR_ALL_MASK,
+	xilinx_writel(xilinx, ~XILINX_PCIE_IDR_ALL_MASK,
 		   XILINX_PCIE_REG_IMR);
 
 	/* Clear pending interrupts */
-	pcie_write(xilinx, pcie_read(xilinx, XILINX_PCIE_REG_IDR) &
+	xilinx_writel(xilinx, xilinx_readl(xilinx, XILINX_PCIE_REG_IDR) &
 			 XILINX_PCIE_IMR_ALL_MASK,
 		   XILINX_PCIE_REG_IDR);
 
 	/* Enable all interrupts */
-	pcie_write(xilinx, XILINX_PCIE_IMR_ALL_MASK, XILINX_PCIE_REG_IMR);
+	xilinx_writel(xilinx, XILINX_PCIE_IMR_ALL_MASK, XILINX_PCIE_REG_IMR);
 
 	/* Enable the Bridge enable bit */
-	pcie_write(xilinx, pcie_read(xilinx, XILINX_PCIE_REG_RPSC) |
+	xilinx_writel(xilinx, xilinx_readl(xilinx, XILINX_PCIE_REG_RPSC) |
 			 XILINX_PCIE_REG_RPSC_BEN,
 		   XILINX_PCIE_REG_RPSC);
 }

