Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42671 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdBANlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2017 08:41:52 -0500
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI/msi: check that we have a legacy interrupt line before using it
Date: Wed,  1 Feb 2017 14:41:42 +0100
Message-Id: <1485956503-8194-2-git-send-email-hch@lst.de>
In-Reply-To: <1485956503-8194-1-git-send-email-hch@lst.de>
References: <1485956503-8194-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It seems like there are some devices (e.g. the PCIe root port driver) that
may not always have a INTx interrupt.  Check for dev->irq before returning
a legacy interrupt in pci_irq_alloc_vectors to properly handle this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 16dda43..98525f6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1217,9 +1217,11 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	/* use legacy irq if allowed */
-	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1) {
-		pci_intx(dev, 1);
-		return 1;
+	if (flags & PCI_IRQ_LEGACY) {
+		if (min_vecs == 1 && dev->irq) {
+			pci_intx(dev, 1);
+			return 1;
+		}
 	}
 
 	return vecs;
-- 
2.1.4
