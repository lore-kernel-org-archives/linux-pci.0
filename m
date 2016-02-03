Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:58233 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102AbcBCLch (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2016 06:32:37 -0500
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC: Paul Burton <paul.burton@imgtec.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	"Jiang Liu" <jiang.liu@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	Russell Joyce <russell.joyce@york.ac.uk>,
	<linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jingoo Han" <jingoohan1@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 06/15] PCI: xilinx: Always clear interrupt decode register
Date: Wed, 3 Feb 2016 11:30:36 +0000
Message-ID: <1454499045-5020-7-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If an MSI or INTx interrupt is incorrectly triggered with an empty FIFO
then xilinx_pcie_intr_handler will print a warning & skip further
processing. However it did not clear the interrupt in the decode
register, so the same INTX or MSI interrupt would trigger again
immediately even though the FIFO is still empty. Clear the interrupt in
the decode register to avoid that situation.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")

---

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index afdfb09..1eb74a2 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -444,7 +444,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		/* Check whether interrupt valid */
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
 			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
-			return IRQ_HANDLED;
+			goto out;
 		}
 
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
@@ -492,6 +492,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	if (status & XILINX_PCIE_INTR_MST_ERRP)
 		dev_warn(port->dev, "Master error poison\n");
 
+out:
 	/* Clear the Interrupt Decode register */
 	pcie_write(port, status, XILINX_PCIE_REG_IDR);
 
-- 
2.7.0

