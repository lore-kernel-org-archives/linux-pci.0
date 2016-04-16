Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] pci: spread interrupt vectors in pci_alloc_irq_vectors
Date: Fri, 15 Apr 2016 18:35:51 -0700
Message-Id: <1460770552-31260-8-git-send-email-hch@lst.de>
In-Reply-To: <1460770552-31260-1-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Set the affinity_mask before allocating vectors.  And for now we also
need a little hack after allocation, hopefully someone smarter than me
can move this into the core code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/irq.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index b683465..d26df69 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -55,9 +55,14 @@ int pci_alloc_irq_vectors(struct pci_dev *pdev, int nr_vecs)
 
 	nr_vecs = min(nr_vecs, pci_nr_irq_vectors(pdev));
 
+	ret = irq_create_affinity_mask(&pdev->dev.irq_affinity, nr_vecs);
+	if (ret)
+		return ret;
+
+	ret = -ENOMEM;
 	irqs = kcalloc(nr_vecs, sizeof(u32), GFP_KERNEL);
 	if (!irqs)
-		return -ENOMEM;
+		goto out_free_affinity;
 
 	vecs = pci_enable_msix_range_wrapper(pdev, irqs, nr_vecs);
 	if (vecs <= 0) {
@@ -75,11 +80,20 @@ int pci_alloc_irq_vectors(struct pci_dev *pdev, int nr_vecs)
 			irqs[i] = pdev->irq + i;
 	}
 
+	/* XXX: this should really move into the core IRQ allocation code.. */
+	if (vecs > 1) {
+		for (i = 0; i < vecs; i++)
+			irq_program_affinity(irqs[i]);
+	}
+
 	pdev->irqs = irqs;
 	return vecs;
 
 out_free_irqs:
 	kfree(irqs);
+out_free_affinity:
+	kfree(pdev->dev.irq_affinity);
+	pdev->dev.irq_affinity = NULL;
 	return ret;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors);
-- 
2.1.4
