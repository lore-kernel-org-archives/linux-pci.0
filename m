Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:5006 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753378AbaLGT0m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Dec 2014 14:26:42 -0500
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: kernel-janitors@vger.kernel.org, linux@rasmusvillemoes.dk,
	joe@perches.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/20] PCI: keystone: fix misspelling of current function in string
Date: Sun,  7 Dec 2014 20:20:44 +0100
Message-Id: <1417980062-25151-3-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace a misspelled function name by %s and then __func__.

The function name contains pcie, not pci as in the string.

This was done using Coccinelle, including the use of Levenshtein distance,
as proposed by Rasmus Villemoes.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The semantic patch is difficult to summarize, but is available in the cover
letter of this patch series.

 drivers/pci/host/pci-keystone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 78f79e3..e2f600e 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -119,7 +119,7 @@ static void ks_pcie_msi_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct pcie_port *pp = &ks_pcie->pp;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	dev_dbg(pp->dev, "ks_pci_msi_irq_handler, irq %d\n", irq);
+	dev_dbg(pp->dev, "%s, irq %d\n", __func__, irq);
 
 	/*
 	 * The chained irq handler installation would have replaced normal

