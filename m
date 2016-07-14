Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:49890 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbcGNVSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2016 17:18:36 -0400
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: kishon@ti.com, bhelgaas@google.com
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: dra7xx: Fix return value in case of error
Date: Thu, 14 Jul 2016 23:18:27 +0200
Message-Id: <1468531107-3639-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In function 'dra7xx_pcie_init_irq_domain', the pattern used to check and
return error is:

   if (!var) {
      dev_err(...);
      return PTR_ERR(var);
   }

So the returned value in case of error is always 0, which means 'success'.
Change it to return -ENODEV instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/host/pci-dra7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index f441130..81b3949 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -181,14 +181,14 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
-		return PTR_ERR(pcie_intc_node);
+		return -ENODEV;
 	}
 
 	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
 					       &intx_domain_ops, pp);
 	if (!pp->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return PTR_ERR(pp->irq_domain);
+		return -ENODEV;
 	}
 
 	return 0;
-- 
2.7.4


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

