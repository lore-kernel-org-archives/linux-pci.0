Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 7 Mar 2016 12:28:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] pci: move pci_dma_* helpers to common code
Message-ID: <20160307182848.GC13818@localhost>
References: <1457277475-8913-1-git-send-email-hch@lst.de>
 <1457277475-8913-4-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457277475-8913-4-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Arnd]

On Sun, Mar 06, 2016 at 04:17:55PM +0100, Christoph Hellwig wrote:
> For a long time all architectures implement the pci_dma_* functions
> using the generic DMA API, and they all use the same header to do
> so.  This patch moves this header, pci-dma-compat.h, to include/linux
> and includes it from the generic pci.h instead of having each arch
> duplicate this include.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I applied this to pci/misc for v4.6, thanks!  It could go via another
tree, but it does have minor conflicts with my previous patches that
removed asm-generic/pci-dma-compat.h, so I think it makes sense for me
to take it so I can resolve the conflicts.

I wonder if we can consolidate a little more pci_dma_*-related stuff
in pci-dma-compat.h, e.g.,


commit fe537670eab767157eecc50538bd28e8d9b0ce9f
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Mar 7 11:39:16 2016 -0600

    PCI: Consolidate PCI DMA constants and interfaces in linux/pci-dma-compat.h
    
    Christoph added a generic include/linux/pci-dma-compat.h, so now there's
    one place with most of the PCI DMA interfaces.  Move more PCI DMA-related
    things there:
    
      - The PCI_DMA_* direction constants from linux/pci.h
      - The pci_set_dma_max_seg_size() and pci_set_dma_seg_boundary()
        CONFIG_PCI implementations from drivers/pci/pci.c
      - The pci_set_dma_max_seg_size() and pci_set_dma_seg_boundary()
        !CONFIG_PCI stubs from linux/pci.h
      - The pci_set_dma_mask() and pci_set_consistent_dma_mask()
        !CONFIG_PCI stubs from linux/pci.h
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 64c0a12..0a9c8db 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3385,18 +3385,6 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
 
-int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size)
-{
-	return dma_set_max_seg_size(&dev->dev, size);
-}
-EXPORT_SYMBOL(pci_set_dma_max_seg_size);
-
-int pci_set_dma_seg_boundary(struct pci_dev *dev, unsigned long mask)
-{
-	return dma_set_seg_boundary(&dev->dev, mask);
-}
-EXPORT_SYMBOL(pci_set_dma_seg_boundary);
-
 /**
  * pci_wait_for_pending_transaction - waits for pending transaction
  * @dev: the PCI device to operate on
diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
index eafce7b..39726ca 100644
--- a/include/linux/pci-dma-compat.h
+++ b/include/linux/pci-dma-compat.h
@@ -6,6 +6,12 @@
 
 #include <linux/dma-mapping.h>
 
+/* This defines the direction arg to the DMA mapping routines. */
+#define PCI_DMA_BIDIRECTIONAL	0
+#define PCI_DMA_TODEVICE	1
+#define PCI_DMA_FROMDEVICE	2
+#define PCI_DMA_NONE		3
+
 static inline void *
 pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 		     dma_addr_t *dma_handle)
@@ -113,6 +119,29 @@ static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 {
 	return dma_set_coherent_mask(&dev->dev, mask);
 }
+
+static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
+					   unsigned int size)
+{
+	return dma_set_max_seg_size(&dev->dev, size);
+}
+
+static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
+					   unsigned long mask)
+{
+	return dma_set_seg_boundary(&dev->dev, mask);
+}
+#else
+static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
+{ return -EIO; }
+static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
+{ return -EIO; }
+static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
+					   unsigned int size)
+{ return -EIO; }
+static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
+					   unsigned long mask)
+{ return -EIO; }
 #endif
 
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5db6e0c..5049bd6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -70,12 +70,6 @@ enum pci_mmap_state {
 	pci_mmap_mem
 };
 
-/* This defines the direction arg to the DMA mapping routines. */
-#define PCI_DMA_BIDIRECTIONAL	0
-#define PCI_DMA_TODEVICE	1
-#define PCI_DMA_FROMDEVICE	2
-#define PCI_DMA_NONE		3
-
 /*
  *  For PCI devices, the region numbers are assigned this way:
  */
@@ -1038,8 +1032,6 @@ void pci_intx(struct pci_dev *dev, int enable);
 bool pci_intx_mask_supported(struct pci_dev *dev);
 bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
-int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size);
-int pci_set_dma_seg_boundary(struct pci_dev *dev, unsigned long mask);
 int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask);
 int pci_wait_for_pending_transaction(struct pci_dev *dev);
 int pcix_get_max_mmrbc(struct pci_dev *dev);
@@ -1255,6 +1247,7 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
+
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
 #include <linux/pci-dma.h>
@@ -1466,16 +1459,6 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
-static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
-{ return -EIO; }
-static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
-{ return -EIO; }
-static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
-					unsigned int size)
-{ return -EIO; }
-static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
-					unsigned long mask)
-{ return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i)
 { return -EBUSY; }
 static inline int __pci_register_driver(struct pci_driver *drv,
