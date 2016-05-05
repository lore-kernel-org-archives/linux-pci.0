Return-Path: <BATV+ebca6d033c7666f223e0+4638+infradead.org+hch@bombadil.srs.infradead.org>
Return-Path: <BATV+ebca6d033c7666f223e0+4638+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: helgaas@kernel.org
Cc: agordeev@redhat.com,
	pjw@netapp.com,
	axboe@fb.com,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
Date: Thu,  5 May 2016 16:04:55 +0200
Message-Id: <1462457096-19795-2-git-send-email-hch@lst.de>
In-Reply-To: <1462457096-19795-1-git-send-email-hch@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

Add a new pci_alloc_irq_vectors helper that allocates MSI-X or multi-MSI
vectors for PCI device while isolating the driver from the arcane details.

This include handling both MSI-X, MSI and legacy interrupt fallbacks
transparently, automatic capping to the available vectors as well as storing
the information needed for request_irq in the PCI device itself so that
a lot of boiler plate code in the driver can be removed.

In the future this will also allow us to automatically set up spreading
for interrupt vectors without having to duplicate it in all the drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c   | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  19 +++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..a510484 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2003-2004 Intel
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ * Copyright (c) 2016 Christoph Hellwig.
  */
 
 #include <linux/err.h>
@@ -1120,6 +1121,113 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
+static int __pci_enable_msix(struct pci_dev *dev, int nr_vecs)
+{
+	struct msix_entry *msix_entries;
+	int ret, i;
+
+	msix_entries = kcalloc(nr_vecs, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_vecs; i++)
+		msix_entries[i].entry = i;
+
+	ret = msix_capability_init(dev, msix_entries, nr_vecs);
+	if (ret == 0) {
+		for (i = 0; i < nr_vecs; i++)
+			dev->irqs[i] = msix_entries[i].vector;
+	}
+
+	kfree(msix_entries);
+	return ret;
+}
+
+static int __pci_enable_msi(struct pci_dev *dev, int nr_vecs)
+{
+	int ret, i;
+
+	ret = msi_capability_init(dev, nr_vecs);
+	if (ret == 0) {
+		for (i = 0; i < nr_vecs; i++)
+			dev->irqs[i] = dev->irq + i;
+	}
+
+	return ret;
+}
+
+/**
+ * pci_alloc_irq_vectors - allocate multiple IRQs for a device
+ * @dev:		PCI device to operate on
+ * @nr_vecs:		number of vectors to operate on
+ * @flags:		flags or quirks for the allocation
+ *
+ * Allocate @nr_vecs interrupt vectors for @dev, using MSI-X or MSI
+ * vectors if available, and fall back to a single legacy vector
+ * if neither is available.  Return the number of vectors allocated
+ * (which might be smaller than @nr_vecs) if successful, or a negative
+ * error code on error.  The Linux irq numbers for the allocated
+ * vectors are stored in pdev->irqs.
+ */
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
+		unsigned int flags)
+{
+	unsigned int ret;
+
+	if (WARN_ON_ONCE(dev->msi_enabled || dev->msix_enabled))
+		return -EINVAL;
+
+	if (!pci_msi_supported(dev, 1))
+		goto use_legacy_irq;
+
+	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
+		nr_vecs = min_t(unsigned int, nr_vecs, pci_msix_vec_count(dev));
+	else if (dev->msi_cap)
+		nr_vecs = min_t(unsigned int, nr_vecs, pci_msi_vec_count(dev));
+	else
+		goto use_legacy_irq;
+
+	dev->irqs = kcalloc(nr_vecs, sizeof(u32), GFP_KERNEL);
+	if (!dev->irqs)
+		return -ENOMEM;
+
+	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
+		ret = __pci_enable_msix(dev, nr_vecs);
+	else
+		ret = __pci_enable_msi(dev, nr_vecs);
+	if (ret)
+		goto out_free_irqs;
+
+	return 0;
+
+out_free_irqs:
+	kfree(dev->irqs);
+use_legacy_irq:
+	dev->irqs = &dev->irq;
+	return 1;
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors);
+
+/**
+ * pci_free_irq_vectors - free previously allocated IRQs for a device
+ * @dev:		PCI device to operate on
+ *
+ * Undoes the allocations and enabling in pci_alloc_irq_vectors().
+ */
+void pci_free_irq_vectors(struct pci_dev *dev)
+{
+	if (dev->msix_enabled)
+		pci_disable_msix(dev);
+	else if (dev->msi_enabled)
+		pci_disable_msi(dev);
+
+	if (dev->irqs != &dev->irq)
+		kfree(dev->irqs);
+	dev->irqs = NULL;
+}
+EXPORT_SYMBOL(pci_free_irq_vectors);
+
+
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 932ec74..e201d0d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -322,6 +322,7 @@ struct pci_dev {
 	 * directly, use the values stored here. They might be different!
 	 */
 	unsigned int	irq;
+	unsigned int	*irqs;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
 	bool match_driver;		/* Skip attaching driver */
@@ -1255,6 +1256,8 @@ struct msix_entry {
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
+#define PCI_IRQ_NOMSIX		(1 << 0) /* don't try to use MSI-X interrupts */
+
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_msi_shutdown(struct pci_dev *dev);
@@ -1283,6 +1286,10 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		return rc;
 	return 0;
 }
+
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
+		unsigned int flags);
+void pci_free_irq_vectors(struct pci_dev *dev);
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_msi_shutdown(struct pci_dev *dev) { }
@@ -1306,6 +1313,18 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		      struct msix_entry *entries, int nvec)
 { return -ENOSYS; }
+
+static inline int pci_alloc_irq_vectors(struct pci_dev *dev,
+		unsigned int nr_vecs, unsigned int flags)
+{
+	dev->irqs = &dev->irq;
+	return 1;
+}
+
+static inline void pci_free_irq_vectors(struct pci_dev *dev)
+{
+	dev->irqs = NULL;
+}
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-- 
2.1.4
