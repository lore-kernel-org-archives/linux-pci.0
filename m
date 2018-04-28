Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:46730 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD1B5l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 21:57:41 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 5/9] PCI: faraday: Use pci_alloc_intx_irqd() helper to get irq domain for INTx
Date: Sat, 28 Apr 2018 09:49:48 +0800
Message-Id: <1524880188-101096-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
References: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/pci/host/pci-ftpci100.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 5008fd8..018e4f4 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -344,24 +344,19 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 	int irq;
 	int i;
 
-	if (!intc) {
-		dev_err(p->dev, "missing child interrupt-controller node\n");
-		return -EINVAL;
-	}
+	p->irqdomain = pci_alloc_intx_irqd(p->dev, p, false,
+					   &faraday_pci_irqdomain_ops, intc)
+	if (IS_ERR(p->irqdomain))
+		return PTR_ERR(p->irqdomain);
 
 	/* All PCI IRQs cascade off this one */
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
 		dev_err(p->dev, "failed to get parent IRQ\n");
+		irq_domain_remove(p->irqdomain);
 		return irq ?: -EINVAL;
 	}
 
-	p->irqdomain = irq_domain_add_linear(intc, PCI_NUM_INTX,
-					     &faraday_pci_irqdomain_ops, p);
-	if (!p->irqdomain) {
-		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
-		return -EINVAL;
-	}
 
 	irq_set_chained_handler_and_data(irq, faraday_pci_irq_handler, p);
 
-- 
1.9.1
