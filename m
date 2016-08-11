Return-Path: <BATV+d7a49962a47fb612189d+4736+infradead.org+hch@bombadil.srs.infradead.org>
Return-Path: <BATV+d7a49962a47fb612189d+4736+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-pci@vger.kernel.org,
	helgaas@kernel.org,
	agordeev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pci: call pci_intx when using legacy interrupts in pci_alloc_irq_vectors
Date: Thu, 11 Aug 2016 07:11:05 -0700
Message-Id: <1470924665-25860-3-git-send-email-hch@lst.de>
In-Reply-To: <1470924665-25860-1-git-send-email-hch@lst.de>
References: <1470924665-25860-1-git-send-email-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

ahci currently insists on an explicit call to pci_intx before falling back
from MSI or MSI-X to legacy irqs.  As pci_intx is a no-op if the command
register already contains the right value is seems safe and useful to add
this call to pci_alloc_irq_vectors so that ahci can just use
pci_alloc_irq_vectors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9233e7f..593698e 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1200,8 +1200,11 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	/* use legacy irq if allowed */
-	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1)
+	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1) {
+		pci_intx(dev, 1);
 		return 1;
+	}
+
 	return vecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors);
-- 
2.1.4
