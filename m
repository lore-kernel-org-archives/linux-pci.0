Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Thu, 12 May 2016 09:35:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, helgaas@kernel.org, pjw@netapp.com,
	axboe@fb.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160512073552.GA4027@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de> <1462457096-19795-2-git-send-email-hch@lst.de> <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com> <20160511085049.GA20279@lst.de> <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

what do you think about the incremental patch below?  This should
address the concerns about the strange PPC bridges, although I don't
have a way to test one:

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a510484..32ce65e 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1177,6 +1177,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
 	if (WARN_ON_ONCE(dev->msi_enabled || dev->msix_enabled))
 		return -EINVAL;
 
+retry:
 	if (!pci_msi_supported(dev, 1))
 		goto use_legacy_irq;
 
@@ -1191,17 +1192,26 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
 	if (!dev->irqs)
 		return -ENOMEM;
 
-	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
+	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX)) {
 		ret = __pci_enable_msix(dev, nr_vecs);
-	else
+		if (ret < 0)
+			flags |= PCI_IRQ_NOMSIX;
+	} else {
 		ret = __pci_enable_msi(dev, nr_vecs);
-	if (ret)
-		goto out_free_irqs;
+	}
 
-	return 0;
+	/* if we succeeded getting all vectors return the number we got: */
+	if (!ret)
+		return nr_vecs;
 
-out_free_irqs:
 	kfree(dev->irqs);
+	/* if ret is positive it's the numbers of vectors we can use, retry: */
+	if (ret > 0) {
+		nr_vecs = ret;
+		goto retry;
+	}
+
+	/* no MSI or MSI-X vectors available, fall back to the legacy IRQ: */
 use_legacy_irq:
 	dev->irqs = &dev->irq;
 	return 1;
