Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34005 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbbGGQzP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2015 12:55:15 -0400
Received: by wgfr2 with SMTP id r2so18522588wgf.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2015 09:55:13 -0700 (PDT)
From: Russell Joyce <russell.joyce@york.ac.uk>
To: bhelgaas@google.com, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com, sthokal@xilinx.com,
	jiang.liu@linux.intel.com, arnd@arndb.de, tglx@linutronix.de,
	wangyijing@huawei.com, wsa@the-dreams.de, robh@kernel.org,
	russell.joyce@york.ac.uk
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: xilinx: Add check for MSI interrupt flag before handling as INTx
Date: Tue,  7 Jul 2015 17:54:19 +0100
Message-Id: <1436288059-22925-1-git-send-email-russell.joyce@york.ac.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Occasionally both MSI and INTx bits in the interrupt decode register are
set at once by the Xilinx AXI PCIe Bridge, so the MSI flag in the
interrupt message should be checked to ensure that the correct handler is
used.

If this check is not in place and the interrupt message type is MSI, the
INTx handler will be used erroneously when both type bits are set.
This will also be followed by a second read of the message FIFO, which can
result in the function returning early and the interrupt decode register
not being cleared if the FIFO is now empty.

Signed-off-by: Russell Joyce <russell.joyce@york.ac.uk>
---
 drivers/pci/host/pcie-xilinx.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index f1a06a0..dcb9b57 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -449,14 +449,17 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			return IRQ_HANDLED;
 		}
 
-		/* Clear interrupt FIFO register 1 */
-		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
-			   XILINX_PCIE_REG_RPIFR1);
-
-		/* Handle INTx Interrupt */
-		val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
-			XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
-		generic_handle_irq(irq_find_mapping(port->irq_domain, val));
+		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
+			/* Clear interrupt FIFO register 1 */
+			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+				   XILINX_PCIE_REG_RPIFR1);
+
+			/* Handle INTx Interrupt */
+			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
+				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
+			generic_handle_irq(irq_find_mapping(port->irq_domain,
+							    val));
+		}
 	}
 
 	if (status & XILINX_PCIE_INTR_MSI) {
-- 
2.1.4

