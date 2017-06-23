Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32827 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbdFWV6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2017 17:58:10 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so7614724pgb.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2017 14:58:10 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
To: bhelgaas@google.com
To: michal.simek@xilinx.com
To: soren.brinkmann@xilinx.com
To: bharat.kumar.gogada@xilinx.com
To: po.liu@nxp.com
To: christophe.jaillet@wanadoo.fr
To: paul.gortmaker@windriver.com
To: linux-pci@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Wesley W. Terpstra" <wesley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] pcie-xilinx: OF-PCIe numbers legacy interrupts from 1
Date: Fri, 23 Jun 2017 14:57:20 -0700
Message-Id: <20170623215720.27057-1-palmer@dabbelt.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Wesley W. Terpstra" <wesley@sifive.com>

Without this patch we can't use the 4th legacy PCIe interrupt.  This
is a workaround: there are only 4 legacy interrupts, but since they're
numbered starting from 1 instead of 0 this just adds a 5th interrupt.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
---
 drivers/pci/host/pcie-xilinx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 2fe2df51f9f8..8804145d399a 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -443,7 +443,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
 			generic_handle_irq(irq_find_mapping(port->leg_domain,
-							    val));
+							    val + 1));
 		}
 	}
 
@@ -524,7 +524,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
+	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 5,
 						 &intx_domain_ops,
 						 port);
 	if (!port->leg_domain) {
-- 
2.13.0
