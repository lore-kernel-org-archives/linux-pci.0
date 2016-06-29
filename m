Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34541 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbcF2PSe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2016 11:18:34 -0400
Date: Wed, 29 Jun 2016 20:48:20 +0530
From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
To: bhelgaas@google.com, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
Subject: [PATCH] PCI: xilinx: Modify error handling
Message-ID: <20160629151820.GA14282@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Failure of of_get_next_child returns NULL, not an ERR_PTR. Use
appropriate error code -ENODEV to be returned on failure instead.

The Coccinelle semantic patch used to find this issue is as follows:
@@
expression E,E1;
@@

if (
*   E == NULL
   ) { <+... when != E = E1
        PTR_ERR(E)
       ...+> }

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/pci/host/pcie-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 65f0fe0..d76ea8d 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -550,7 +550,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 	pcie_intc_node = of_get_next_child(node, NULL);
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
-		return PTR_ERR(pcie_intc_node);
+		return -ENODEV;
 	}
 
 	port->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
-- 
1.9.1

