Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:39539 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeFWPQl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 23 Jun 2018 11:16:41 -0400
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] PCI: faraday: add missing of_node_put()
Date: Sat, 23 Jun 2018 17:14:59 +0200
Message-Id: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 The call to of_get_next_child() returns a node pointer with refcount
incremented thus it must be explicitly decremented here in the error
path and after the last usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
---

Patch found my experimental coccinelle script

Patch was compile tested with: gemini_defconfig (implies CONFIG_PCI_FTPCI100=y)

Patch is against 4.18-rc1 (localversion-next is next-20180621)

 drivers/pci/controller/pci-ftpci100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index a1ebe9e..20bb256 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -355,11 +355,13 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
 		dev_err(p->dev, "failed to get parent IRQ\n");
+		of_node_put(intc);
 		return irq ?: -EINVAL;
 	}
 
 	p->irqdomain = irq_domain_add_linear(intc, PCI_NUM_INTX,
 					     &faraday_pci_irqdomain_ops, p);
+	of_node_put(intc);
 	if (!p->irqdomain) {
 		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
 		return -EINVAL;
-- 
2.1.4
