Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/27] xtensa: Use generic pci_mmap_resource_range()
Date: Wed, 12 Apr 2017 13:26:11 +0100
Message-Id: <cd5598d945d7fdac72da5b9b3c6e2b63bcbf95bb.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/xtensa/include/asm/pci.h |  7 ++--
 arch/xtensa/kernel/pci.c      | 94 ++++---------------------------------------
 2 files changed, 12 insertions(+), 89 deletions(-)

diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index e4f366a..0ddb411 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -46,9 +46,10 @@ struct pci_dev;
 
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
-/* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
-#define HAVE_PCI_MMAP		1
-#define arch_can_pci_mmap_io()	1
+/* Tell PCI code what kind of PCI resource mappings we support */
+#define HAVE_PCI_MMAP			1
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
+#define arch_can_pci_mmap_io()		1
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 903963e..8f11b6d 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -47,7 +47,6 @@
  * pcibios_align_resource
  * pcibios_fixup_bus
  * pci_bus_add_device
- * pci_mmap_page_range
  */
 
 struct pci_controller* pci_ctrl_head;
@@ -266,98 +265,21 @@ pci_controller_num(struct pci_dev *dev)
 #endif /* CONFIG_PROC_FS */
 
 /*
- * Platform support for /proc/bus/pci/X/Y mmap()s,
- * modelled on the sparc64 implementation by Dave Miller.
+ * Platform support for /proc/bus/pci/X/Y mmap()s.
  *  -- paulus.
  */
 
-/*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static __inline__ int
-__pci_mmap_make_offset(struct pci_dev *dev, struct vm_area_struct *vma,
-		       enum pci_mmap_state mmap_state)
+int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 {
-	struct pci_controller *pci_ctrl = (struct pci_controller*) dev->sysdata;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long io_offset = 0;
-	int i, res_bit;
+	struct pci_controller *pci_ctrl = (struct pci_controller*) pdev->sysdata;
+	resource_size_t ioaddr = pci_resource_start(pdev, bar);
 
 	if (pci_ctrl == 0)
 		return -EINVAL;		/* should never happen */
 
-	/* If memory, add on the PCI bridge address offset */
-	if (mmap_state == pci_mmap_mem) {
-		res_bit = IORESOURCE_MEM;
-	} else {
-		io_offset = (unsigned long)pci_ctrl->io_space.base;
-		offset += io_offset;
-		res_bit = IORESOURCE_IO;
-	}
-
-	/*
-	 * Check that the offset requested corresponds to one of the
-	 * resources of the device.
-	 */
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &dev->resource[i];
-		int flags = rp->flags;
-
-		/* treat ROM as memory (should be already) */
-		if (i == PCI_ROM_RESOURCE)
-			flags |= IORESOURCE_MEM;
-
-		/* Active and same type? */
-		if ((flags & res_bit) == 0)
-			continue;
-
-		/* In the range of this resource? */
-		if (offset < (rp->start & PAGE_MASK) || offset > rp->end)
-			continue;
-
-		/* found it! construct the final physical address */
-		if (mmap_state == pci_mmap_io)
-			offset += pci_ctrl->io_space.start - io_offset;
-		vma->vm_pgoff = offset >> PAGE_SHIFT;
-		return 0;
-	}
-
-	return -EINVAL;
-}
+	/* Convert to an offset within this PCI controller */
+	ioaddr -= (unsigned long)pci_ctrl->io_space.base;
 
-/*
- * Perform the actual remap of the pages for a PCI device mapping, as
- * appropriate for this architecture.  The region in the process to map
- * is described by vm_start and vm_end members of VMA, the base physical
- * address is found in vm_pgoff.
- * The pci device structure is provided so that architectures may make mapping
- * decisions on a per-device or per-bus basis.
- *
- * Returns a negative error code on failure, zero on success.
- */
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state,
-			int write_combine)
-{
-	int ret;
-
-	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-	if (ret < 0)
-		return ret;
-
-	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
-
-	ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			         vma->vm_end - vma->vm_start,vma->vm_page_prot);
-
-	return ret;
+	vma->vm_pgoff += (ioaddr + pci_ctrl->io_space.start) >> PAGE_SHIFT;
+	return 0;
 }
-- 
2.9.3
