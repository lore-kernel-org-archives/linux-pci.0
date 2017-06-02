Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:63931 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdFBSzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2017 14:55:13 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v4 1/4] PCI: xilinx: Fix INTX irq dispatch
Date: Fri, 2 Jun 2017 11:54:16 -0700
Message-ID: <20170602185420.22281-2-paul.burton@imgtec.com>
In-Reply-To: <20170602185420.22281-1-paul.burton@imgtec.com>
References: <20170602185420.22281-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The IRQ domain for INTX interrupts has 4 entries, numbered 0 to 3. This
matches what the hardware reports from the interrupt FIFO exactly, but
xilinx_pcie_intr_handler was adding 1 to that value to convert to the
range 1 to 4. Stop adding 1, such that all of INTA through to INTD fall
within the range of the IRQ domain.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
Cc: linux-pci@vger.kernel.org

---

Changes in v4: None

Changes in v3:
- Split out from Boston patchset.

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 2fe2df51f9f8..6be2e5ee44f1 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -440,8 +440,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 				   XILINX_PCIE_REG_RPIFR1);
 
 			/* Handle INTx Interrupt */
-			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
-				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
+			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
+				XILINX_PCIE_RPIFR1_INTR_SHIFT;
 			generic_handle_irq(irq_find_mapping(port->leg_domain,
 							    val));
 		}
-- 
2.13.0
