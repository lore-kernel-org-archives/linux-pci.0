Return-Path: <BATV+d7a49962a47fb612189d+4736+infradead.org+hch@bombadil.srs.infradead.org>
Return-Path: <BATV+d7a49962a47fb612189d+4736+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-pci@vger.kernel.org,
	helgaas@kernel.org,
	agordeev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pci: use positive flags in pci_alloc_irq_vectors
Date: Thu, 11 Aug 2016 07:11:04 -0700
Message-Id: <1470924665-25860-2-git-send-email-hch@lst.de>
In-Reply-To: <1470924665-25860-1-git-send-email-hch@lst.de>
References: <1470924665-25860-1-git-send-email-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

Instead of using PCI_IRQ_NO* to disable behavior in pci_alloc_irq_vectors
switch to passing the inverted flags to enable each of them individually.

This is based on a number of pending driver conversions that just happend
to be a whole more obvious to read this way, and given that we have no
users in the tree yet it can still easily be done.

I've also added a PCI_IRQ_ALL_TYPES catchall to keep the case of accepting
all interrupt types very simple.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/PCI/MSI-HOWTO.txt | 21 +++++++++------------
 drivers/pci/msi.c               | 15 +++++++--------
 include/linux/pci.h             | 10 ++++++----
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index c55df29..8faf14a 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -94,14 +94,11 @@ has a requirements for a minimum number of vectors the driver can pass a
 min_vecs argument set to this limit, and the PCI core will return -ENOSPC
 if it can't meet the minimum number of vectors.
 
-The flags argument should normally be set to 0, but can be used to pass the
-PCI_IRQ_NOMSI and PCI_IRQ_NOMSIX flag in case a device claims to support
-MSI or MSI-X, but the support is broken, or to pass PCI_IRQ_NOLEGACY in
-case the device does not support legacy interrupt lines.
-
-By default this function will spread the interrupts around the available
-CPUs, but this feature can be disabled by passing the PCI_IRQ_NOAFFINITY
-flag.
+The flags argument is used to specify which type of interrupt can be used
+by the device and the driver (PCI_IRQ_LEGACY, PCI_IRQ_MSI, PCI_IRQ_MSIX).
+A conveniant short-hand (PCI_IRQ_ALL_TYPES) is also avaiable to ask for
+any possible kind of interrupt. If the PCI_IRQ_NOAFFINITY flag is set,
+pci_alloc_irq_vectors will spread the interrupts around the available CPUs.
 
 To get the Linux IRQ numbers passed to request_irq() and free_irq() and the
 vectors, use the following function:
@@ -131,7 +128,7 @@ larger than the number supported by the device it will automatically be
 capped to the supported limit, so there is no need to query the number of
 vectors supported beforehand:
 
-	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, 0);
+	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_ALL_TYPES)
 	if (nvec < 0)
 		goto out_err;
 
@@ -140,7 +137,7 @@ interrupts it can request a particular number of interrupts by passing that
 number to pci_alloc_irq_vectors() function as both 'min_vecs' and
 'max_vecs' parameters:
 
-	ret = pci_alloc_irq_vectors(pdev, nvec, nvec, 0);
+	ret = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		goto out_err;
 
@@ -148,7 +145,7 @@ The most notorious example of the request type described above is enabling
 the single MSI mode for a device.  It could be done by passing two 1s as
 'min_vecs' and 'max_vecs':
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, 0);
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		goto out_err;
 
@@ -156,7 +153,7 @@ Some devices might not support using legacy line interrupts, in which case
 the PCI_IRQ_NOLEGACY flag can be used to fail the request if the platform
 can't provide MSI or MSI-X interrupts:
 
-	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_NOLEGACY);
+	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nvec < 0)
 		goto out_err;
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a02981e..9233e7f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1069,7 +1069,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 		nvec = maxvec;
 
 	for (;;) {
-		if (!(flags & PCI_IRQ_NOAFFINITY)) {
+		if (flags & PCI_IRQ_AFFINITY) {
 			dev->irq_affinity = irq_create_affinity_mask(&nvec);
 			if (nvec < minvec)
 				return -ENOSPC;
@@ -1105,7 +1105,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
  **/
 int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 {
-	return __pci_enable_msi_range(dev, minvec, maxvec, PCI_IRQ_NOAFFINITY);
+	return __pci_enable_msi_range(dev, minvec, maxvec, 0);
 }
 EXPORT_SYMBOL(pci_enable_msi_range);
 
@@ -1120,7 +1120,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 		return -ERANGE;
 
 	for (;;) {
-		if (!(flags & PCI_IRQ_NOAFFINITY)) {
+		if (flags & PCI_IRQ_AFFINITY) {
 			dev->irq_affinity = irq_create_affinity_mask(&nvec);
 			if (nvec < minvec)
 				return -ENOSPC;
@@ -1160,8 +1160,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 		int minvec, int maxvec)
 {
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec,
-			PCI_IRQ_NOAFFINITY);
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, 0);
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
@@ -1187,21 +1186,21 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 {
 	int vecs = -ENOSPC;
 
-	if (!(flags & PCI_IRQ_NOMSIX)) {
+	if (flags & PCI_IRQ_MSIX) {
 		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
 				flags);
 		if (vecs > 0)
 			return vecs;
 	}
 
-	if (!(flags & PCI_IRQ_NOMSI)) {
+	if (flags & PCI_IRQ_MSI) {
 		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, flags);
 		if (vecs > 0)
 			return vecs;
 	}
 
 	/* use legacy irq if allowed */
-	if (!(flags & PCI_IRQ_NOLEGACY) && min_vecs == 1)
+	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1)
 		return 1;
 	return vecs;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2599a98..fbc1fa6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1251,10 +1251,12 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 
-#define PCI_IRQ_NOLEGACY	(1 << 0) /* don't use legacy interrupts */
-#define PCI_IRQ_NOMSI		(1 << 1) /* don't use MSI interrupts */
-#define PCI_IRQ_NOMSIX		(1 << 2) /* don't use MSI-X interrupts */
-#define PCI_IRQ_NOAFFINITY	(1 << 3) /* don't auto-assign affinity */
+#define PCI_IRQ_LEGACY		(1 << 0) /* allow legacy interrupts */
+#define PCI_IRQ_MSI		(1 << 1) /* allow MSI interrupts */
+#define PCI_IRQ_MSIX		(1 << 2) /* allow MSI-X interrupts */
+#define PCI_IRQ_AFFINITY	(1 << 3) /* auto-assign affinity */
+#define PCI_IRQ_ALL_TYPES \
+	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
-- 
2.1.4
