Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:63878 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbdHOTL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 15:11:56 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v7 1/3] PCI: xilinx: Unify INTx & MSI interrupt decode
Date: Tue, 15 Aug 2017 12:11:15 -0700
Message-ID: <20170815191117.19882-2-paul.burton@imgtec.com>
In-Reply-To: <20170815191117.19882-1-paul.burton@imgtec.com>
References: <20170815191117.19882-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The INTx & MSI interrupt decode paths duplicated a fair bit of common
functionality. They also strictly handled interrupts in order of INTx
then MSI, so if both types of interrupt were to be asserted
simultaneously and the MSI interrupt were first in the FIFO then the
INTx code would read it & ignore it before the MSI code then had to read
it again, wasting the original FIFO read.

Unify the INTx & MSI decode in order to reduce that duplication & allow
a single FIFO read to be performed for each interrupt regardless of its
type.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
Cc: linux-pci@vger.kernel.org
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-xilinx.c | 48 +++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 9a8d5ad1dd70..a7880bed56fc 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -385,7 +385,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 {
 	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
 	struct device *dev = port->dev;
-	u32 val, mask, status, msi_data;
+	u32 val, mask, status;
 
 	/* Read interrupt decode and mask registers */
 	val = pcie_read(port, XILINX_PCIE_REG_IDR);
@@ -425,8 +425,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		xilinx_pcie_clear_err_interrupts(port);
 	}
 
-	if (status & XILINX_PCIE_INTR_INTX) {
-		/* INTx interrupt received */
+	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
 		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
 
 		/* Check whether interrupt valid */
@@ -435,41 +434,24 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			goto error;
 		}
 
-		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
-			/* Clear interrupt FIFO register 1 */
-			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
-				   XILINX_PCIE_REG_RPIFR1);
-
-			/* Handle INTx Interrupt */
+		/* Decode the IRQ number */
+		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
+			val = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
+				XILINX_PCIE_RPIFR2_MSG_DATA;
+		} else {
 			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT;
-			generic_handle_irq(irq_find_mapping(port->leg_domain,
-							    val));
+			val = irq_find_mapping(port->leg_domain, val);
 		}
-	}
 
-	if (status & XILINX_PCIE_INTR_MSI) {
-		/* MSI Interrupt */
-		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+		/* Clear interrupt FIFO register 1 */
+		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+			   XILINX_PCIE_REG_RPIFR1);
 
-		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(dev, "RP Intr FIFO1 read error\n");
-			goto error;
-		}
-
-		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
-			msi_data = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
-				   XILINX_PCIE_RPIFR2_MSG_DATA;
-
-			/* Clear interrupt FIFO register 1 */
-			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
-				   XILINX_PCIE_REG_RPIFR1);
-
-			if (IS_ENABLED(CONFIG_PCI_MSI)) {
-				/* Handle MSI Interrupt */
-				generic_handle_irq(msi_data);
-			}
-		}
+		/* Handle the interrupt */
+		if (IS_ENABLED(CONFIG_PCI_MSI) ||
+		    !(val & XILINX_PCIE_RPIFR1_MSI_INTR))
+			generic_handle_irq(val);
 	}
 
 	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
-- 
2.14.1
