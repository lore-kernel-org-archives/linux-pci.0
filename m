Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55577 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbcIKHJd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2016 03:09:33 -0400
From: Christoph Hellwig <hch@lst.de>
To: agordeev@redhat.com, linux-pci@vger.kernel.org
Cc: davem@davemloft.net, shane.huang@amd.com
Subject: [PATCH, RFC] PCI: use pci_intx_for_msi in pci_alloc_irq_vectors
Date: Sun, 11 Sep 2016 09:09:27 +0200
Message-Id: <1473577767-9888-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex pointed out that we might want to use pci_intx_for_msi in
pci_alloc_irq_vectors for the case where allocating MSI or MSI-X vectors
fails completely.  I tried to read up the history behind pci_intx_for_msi,
but the changelogs seem a bit confusing, e.g. the comment in the tg3
around that code that was replaced by this quirk only talk about
_disabling_ INT-X.  Maybe someone can help me to shed some light about
this workaround, and help answering the question wether we need it
in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: David Miller <davem@davemloft.net>
Cc: Shane Huang <shane.huang@amd.com>
---
 drivers/pci/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9da5ecb..a4b443f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1215,7 +1215,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 
 	/* use legacy irq if allowed */
 	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1) {
-		pci_intx(dev, 1);
+		pci_intx_for_msi(dev, 1);
 		return 1;
 	}
 
-- 
2.1.4

