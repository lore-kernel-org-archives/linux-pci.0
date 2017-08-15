Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbdHOVik (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Aug 2017 17:38:40 -0400
Subject: [PATCH] PCI: dra7xx: Use PCI_NUM_INTX
From: Bjorn Helgaas <bhelgaas@google.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>
Date: Tue, 15 Aug 2017 16:38:38 -0500
Message-ID: <20170815213838.8231.59214.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the PCI_NUM_INTX macro to indicate the number of PCI INTx interrupts
rather than the magic number 4. This makes it clearer where the number
comes from & what it relates to.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index f2fc5f47064e..30131ecaadea 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -238,7 +238,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 		return -ENODEV;
 	}
 
-	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
+	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						   &intx_domain_ops, pp);
 	if (!dra7xx->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
