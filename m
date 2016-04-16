Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] pci: provide sensible irq vector alloc/free routines
Date: Fri, 15 Apr 2016 18:35:50 -0700
Message-Id: <1460770552-31260-7-git-send-email-hch@lst.de>
In-Reply-To: <1460770552-31260-1-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hide all the MSI-X vs MSI vs legacy bullshit, and provide an array of
interrupt vectors in the pci_dev structure, and ensure we get proper
interrupt affinity by default.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/irq.c   | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/msi.c   |  2 +-
 drivers/pci/pci.h   |  5 +++
 include/linux/pci.h |  5 +++
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index 6684f15..b683465 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -1,7 +1,8 @@
 /*
- * PCI IRQ failure handing code
+ * PCI IRQ handing code
  *
  * Copyright (c) 2008 James Bottomley <James.Bottomley@HansenPartnership.com>
+ * Copyright (c) 2016 Christoph Hellwig.
  */
 
 #include <linux/acpi.h>
@@ -9,6 +10,92 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
+#include "pci.h"
+
+static int pci_nr_irq_vectors(struct pci_dev *pdev)
+{
+	int nr_entries;
+
+	nr_entries = pci_msix_vec_count(pdev);
+	if (nr_entries <= 0 && pci_msi_supported(pdev, 1))
+		nr_entries = pci_msi_vec_count(pdev);
+	if (nr_entries <= 0)
+		nr_entries = 1;
+	return nr_entries;
+}
+
+static int pci_enable_msix_range_wrapper(struct pci_dev *pdev, u32 *irqs,
+		int nr_vecs)
+{
+	struct msix_entry *msix_entries;
+	int vecs, i;
+
+	msix_entries = kcalloc(nr_vecs, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_vecs; i++)
+		msix_entries[i].entry = i;
+
+	vecs = pci_enable_msix_range(pdev, msix_entries, 1, nr_vecs);
+	if (vecs > 0) {
+		for (i = 0; i < vecs; i++)
+			irqs[i] = msix_entries[i].vector;
+	}
+
+	kfree(msix_entries);
+	return vecs;
+}
+
+int pci_alloc_irq_vectors(struct pci_dev *pdev, int nr_vecs)
+{
+	int vecs, ret, i;
+	u32 *irqs;
+
+	nr_vecs = min(nr_vecs, pci_nr_irq_vectors(pdev));
+
+	irqs = kcalloc(nr_vecs, sizeof(u32), GFP_KERNEL);
+	if (!irqs)
+		return -ENOMEM;
+
+	vecs = pci_enable_msix_range_wrapper(pdev, irqs, nr_vecs);
+	if (vecs <= 0) {
+		vecs = pci_enable_msi_range(pdev, 1, min(nr_vecs, 32));
+		if (vecs <= 0) {
+			ret = -EIO;
+			if (!pdev->irq)
+				goto out_free_irqs;
+
+			/* use legacy irq */
+			vecs = 1;
+		}
+
+		for (i = 0; i < vecs; i++)
+			irqs[i] = pdev->irq + i;
+	}
+
+	pdev->irqs = irqs;
+	return vecs;
+
+out_free_irqs:
+	kfree(irqs);
+	return ret;
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors);
+
+void pci_free_irq_vectors(struct pci_dev *pdev)
+{
+	if (pdev->msi_enabled)
+		pci_disable_msi(pdev);
+	else if (pdev->msix_enabled)
+		pci_disable_msix(pdev);
+
+	kfree(pdev->dev.irq_affinity);
+	pdev->dev.irq_affinity = NULL;
+	kfree(pdev->irqs);
+}
+EXPORT_SYMBOL(pci_free_irq_vectors);
 
 static void pci_note_irq_problem(struct pci_dev *pdev, const char *reason)
 {
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..544d306 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -815,7 +815,7 @@ out_free:
  * to determine if MSI/-X are supported for the device. If MSI/-X is
  * supported return 1, else return 0.
  **/
-static int pci_msi_supported(struct pci_dev *dev, int nvec)
+int pci_msi_supported(struct pci_dev *dev, int nvec)
 {
 	struct pci_bus *bus;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d0fb934..263422c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -144,8 +144,13 @@ extern unsigned int pci_pm_d3_delay;
 
 #ifdef CONFIG_PCI_MSI
 void pci_no_msi(void);
+int pci_msi_supported(struct pci_dev *dev, int nvec);
 #else
 static inline void pci_no_msi(void) { }
+static int pci_msi_supported(struct pci_dev *dev, int nvec)
+{
+	return 0;
+}
 #endif
 
 static inline void pci_msi_set_enable(struct pci_dev *dev, int enable)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 004b813..4fbc14f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -322,6 +322,7 @@ struct pci_dev {
 	 * directly, use the values stored here. They might be different!
 	 */
 	unsigned int	irq;
+	unsigned int	*irqs;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
 	bool match_driver;		/* Skip attaching driver */
@@ -1235,6 +1236,9 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 
+int pci_alloc_irq_vectors(struct pci_dev *dev, int nr_vecs);
+void pci_free_irq_vectors(struct pci_dev *pdev);
+
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
 #include <linux/pci-dma.h>
@@ -1282,6 +1286,7 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		return rc;
 	return 0;
 }
+
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_msi_shutdown(struct pci_dev *dev) { }
-- 
2.1.4
