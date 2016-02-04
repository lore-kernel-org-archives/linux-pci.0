Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:4407 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965006AbcBDQLp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 11:11:45 -0500
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-mips@linux-mips.org>
CC: Bharat Kumar Gogada <bharatku@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"Paul Burton" <paul.burton@imgtec.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"Grygorii Strashko" <grygorii.strashko@ti.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Russell Joyce <russell.joyce@york.ac.uk>,
	"Bjorn Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jingoo Han" <jingoohan1@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/6] PCI: xilinx: Clear interrupt FIFO during probe
Date: Thu, 4 Feb 2016 16:10:11 +0000
Message-ID: <1454602213-967-5-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

xilinx_pcie_init_port clears the pending interrupts in the interrupt
decode register, but does not clear the interrupt FIFO. This would lead
to spurious interrupts if any were present in the FIFO at probe time.
Clear the interrupt FIFO prior to the interrupt decode register in order
to start with a clean slate as expected.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")

---

Changes in v3:
- Split out from Boston patchset.

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 1eb74a2..6c5a503 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -568,6 +568,8 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
  */
 static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 {
+	u32 val;
+
 	if (xilinx_pcie_link_is_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -577,6 +579,17 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
 		   XILINX_PCIE_REG_IMR);
 
+	/* Clear interrupt FIFO */
+	while (1) {
+		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+
+		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID))
+			break;
+
+		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+			   XILINX_PCIE_REG_RPIFR1);
+	}
+
 	/* Clear pending interrupts */
 	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_IDR) &
 			 XILINX_PCIE_IMR_ALL_MASK,
-- 
2.7.0

