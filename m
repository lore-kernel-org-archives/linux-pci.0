Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57663 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdETNVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 May 2017 09:21:36 -0400
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/msi: fix the pci_alloc_irq_vectors_affinity stub
Date: Sat, 20 May 2017 15:21:29 +0200
Message-Id: <20170520132129.16430-2-hch@lst.de>
In-Reply-To: <20170520132129.16430-1-hch@lst.de>
References: <20170520132129.16430-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to return an error for any call that asks for MSI / MSI-X
vectors only, so that non-trivial fallback logic can work properly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: aff17164 ("PCI: Provide sensible IRQ vector alloc/free routines")
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33c2b0b77429..5a7fd3b6a7b9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1342,7 +1342,7 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			       unsigned int max_vecs, unsigned int flags,
 			       const struct irq_affinity *aff_desc)
 {
-	if (min_vecs > 1)
+	if (min_vecs > 1 || !(flags & PCI_IRQ_LEGACY))
 		return -EINVAL;
 	return 1;
 }
-- 
2.11.0
