Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Thu, 12 May 2016 16:29:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, helgaas@kernel.org, pjw@netapp.com,
	axboe@fb.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160512142902.GA14166@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de> <1462457096-19795-2-git-send-email-hch@lst.de> <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com> <20160511085049.GA20279@lst.de> <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com> <20160512073552.GA4027@lst.de> <20160512094432.GA14671@agordeev.lab.eng.brq.redhat.com> <20160512110318.GA9192@lst.de> <20160512121155.GB8681@agordeev.lab.eng.brq.redhat.com> <20160512121933.GA11084@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160512121933.GA11084@lst.de>
List-ID: <linux-pci.vger.kernel.org>

Alexander, what do you think about the version below?  Survived
quick testing with nvme so far.


diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a510484..cee3962 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1121,98 +1121,131 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
-static int __pci_enable_msix(struct pci_dev *dev, int nr_vecs)
+static int __pci_enable_msi(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs)
 {
-	struct msix_entry *msix_entries;
-	int ret, i;
+	int nr_vecs, i;
 
-	msix_entries = kcalloc(nr_vecs, sizeof(struct msix_entry), GFP_KERNEL);
-	if (!msix_entries)
-		return -ENOMEM;
+	nr_vecs = pci_msi_vec_count(dev);
+	if (nr_vecs <= 0)
+		return -EINVAL;
+	max_vecs = min_t(unsigned int, max_vecs, nr_vecs);
 
-	for (i = 0; i < nr_vecs; i++)
-		msix_entries[i].entry = i;
+	nr_vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
+	if (nr_vecs > 1) {
+		dev->irqs = kcalloc(nr_vecs, sizeof(u32), GFP_KERNEL);
+		if (!dev->irqs) {
+			pci_disable_msi(dev);
+			return -ENOMEM;
+		}
 
-	ret = msix_capability_init(dev, msix_entries, nr_vecs);
-	if (ret == 0) {
 		for (i = 0; i < nr_vecs; i++)
-			dev->irqs[i] = msix_entries[i].vector;
+			dev->irqs[i] = dev->irq + i;
+	} else if (nr_vecs == 1) {
+		dev->irqs = &dev->irq;
 	}
 
-	kfree(msix_entries);
-	return ret;
+	WARN_ON_ONCE(nr_vecs == 0);
+	return nr_vecs;
 }
 
-static int __pci_enable_msi(struct pci_dev *dev, int nr_vecs)
+static int __pci_enable_msix(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs)
 {
-	int ret, i;
+	struct msix_entry *msix_entries;
+	int nr_vecs, i;
 
-	ret = msi_capability_init(dev, nr_vecs);
-	if (ret == 0) {
-		for (i = 0; i < nr_vecs; i++)
-			dev->irqs[i] = dev->irq + i;
+	nr_vecs = pci_msix_vec_count(dev);
+	if (nr_vecs <= 0)
+		return -EINVAL;
+	max_vecs = min_t(unsigned int, max_vecs, nr_vecs);
+
+	msix_entries = kcalloc(max_vecs, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < max_vecs; i++)
+		msix_entries[i].entry = i;
+
+	nr_vecs = pci_enable_msix_range(dev, msix_entries, min_vecs, max_vecs);
+	if (nr_vecs < 0)
+		goto out_free_entries;
+
+	dev->irqs = kcalloc(nr_vecs, sizeof(u32), GFP_KERNEL);
+	if (!dev->irqs) {
+		pci_disable_msix(dev);
+		nr_vecs = -ENOMEM;
+		goto out_free_entries;
 	}
 
-	return ret;
+	for (i = 0; i < nr_vecs; i++)
+		dev->irqs[i] = msix_entries[i].vector;
+
+out_free_entries:
+	WARN_ON_ONCE(nr_vecs == 0);
+	kfree(msix_entries);
+	return nr_vecs;
 }
 
 /**
  * pci_alloc_irq_vectors - allocate multiple IRQs for a device
  * @dev:		PCI device to operate on
- * @nr_vecs:		number of vectors to operate on
+ * @min_vecs:		minimum vectors required
+ * @max_vecs:		maximum vectors requested
  * @flags:		flags or quirks for the allocation
  *
- * Allocate @nr_vecs interrupt vectors for @dev, using MSI-X or MSI
- * vectors if available, and fall back to a single legacy vector
- * if neither is available.  Return the number of vectors allocated
- * (which might be smaller than @nr_vecs) if successful, or a negative
- * error code on error.  The Linux irq numbers for the allocated
- * vectors are stored in pdev->irqs.
+ * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
+ * vectors if available, and fall back to a single legacy vector if neither
+ * is available.  Return the number of vectors allocated (which might be
+ * smaller than @max_vecs) if successful, or a negative error code on error.
+ *
+ * The Linux irq numbers for the allocated vectors are stored in pdev->irqs.
+ *
+ * If @min_vecs is set to a number bigger than zero the function will fail
+ * with -%ENOSPC if les than @min_vecs vectors are available.
  */
-int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
-		unsigned int flags)
+int pci_alloc_irq_vectors_range(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags)
 {
-	unsigned int ret;
-
+	if (WARN_ON_ONCE(min_vecs == 0))
+		return -EINVAL;
+	if (WARN_ON_ONCE(max_vecs < min_vecs))
+		return -EINVAL;
 	if (WARN_ON_ONCE(dev->msi_enabled || dev->msix_enabled))
 		return -EINVAL;
 
-	if (!pci_msi_supported(dev, 1))
-		goto use_legacy_irq;
-
-	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
-		nr_vecs = min_t(unsigned int, nr_vecs, pci_msix_vec_count(dev));
-	else if (dev->msi_cap)
-		nr_vecs = min_t(unsigned int, nr_vecs, pci_msi_vec_count(dev));
-	else
-		goto use_legacy_irq;
-
-	dev->irqs = kcalloc(nr_vecs, sizeof(u32), GFP_KERNEL);
-	if (!dev->irqs)
-		return -ENOMEM;
-
-	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
-		ret = __pci_enable_msix(dev, nr_vecs);
-	else
-		ret = __pci_enable_msi(dev, nr_vecs);
-	if (ret)
-		goto out_free_irqs;
-
-	return 0;
+	if (pci_msi_supported(dev, 1)) {
+		if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX)) {
+			int ret = __pci_enable_msix(dev, min_vecs, max_vecs);
+			if (ret > 0)
+				return ret;
+		}
+		if (dev->msi_cap) {
+			int ret = __pci_enable_msi(dev, min_vecs, max_vecs);
+			if (ret > 0)
+				return ret;
+		}
+	}
 
-out_free_irqs:
-	kfree(dev->irqs);
-use_legacy_irq:
+	/* no MSI or MSI-X vectors available, use the legacy IRQ: */
 	dev->irqs = &dev->irq;
 	return 1;
 }
+EXPORT_SYMBOL(pci_alloc_irq_vectors_range);
+
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
+		unsigned int flags)
+{
+	return pci_alloc_irq_vectors_range(dev, 1, nr_vecs, flags);
+}
 EXPORT_SYMBOL(pci_alloc_irq_vectors);
 
 /**
  * pci_free_irq_vectors - free previously allocated IRQs for a device
  * @dev:		PCI device to operate on
  *
- * Undoes the allocations and enabling in pci_alloc_irq_vectors().
+ * Undoes the allocations and enabling in pci_alloc_irq_vectors() or
+ * pci_alloc_irq_vectors_range().
  */
 void pci_free_irq_vectors(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e201d0d..cd5800a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1289,6 +1289,8 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 
 int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
 		unsigned int flags);
+int pci_alloc_irq_vectors_range(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags);
 void pci_free_irq_vectors(struct pci_dev *dev);
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
