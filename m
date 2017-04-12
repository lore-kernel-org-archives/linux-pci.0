Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38110 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbdDLM0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2017 08:26:19 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/27] microblaze: Use generic pci_mmap_resource_range()
Date: Wed, 12 Apr 2017 13:26:10 +0100
Message-Id: <f6f2c84197a3ff15bb3f3a2882870a751f3f4eb2.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/microblaze/include/asm/pci.h |  7 +--
 arch/microblaze/pci/pci-common.c  | 99 ++++-----------------------------------
 2 files changed, 13 insertions(+), 93 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index efd4983..97452c0 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -47,9 +47,10 @@ extern int pci_proc_domain(struct pci_bus *bus);
 
 struct vm_area_struct;
 
-/* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
-#define HAVE_PCI_MMAP		1
-#define arch_can_pci_mmap_io()	1
+/* Tell PCI code what kind of PCI resource mappings we support */
+#define HAVE_PCI_MMAP			1
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
+#define arch_can_pci_mmap_io()		1
 
 extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
 			   size_t count);
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 404fb38..69c69f6 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -151,72 +151,22 @@ void pcibios_set_master(struct pci_dev *dev)
 }
 
 /*
- * Platform support for /proc/bus/pci/X/Y mmap()s,
- * modelled on the sparc64 implementation by Dave Miller.
- *  -- paulus.
+ * Platform support for /proc/bus/pci/X/Y mmap()s.
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
-static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-					       resource_size_t *offset,
-					       enum pci_mmap_state mmap_state)
+int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 {
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long io_offset = 0;
-	int i, res_bit;
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	resource_size_t ioaddr = pci_resource_start(pdev, bar);
 
 	if (!hose)
-		return NULL;		/* should never happen */
-
-	/* If memory, add on the PCI bridge address offset */
-	if (mmap_state == pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-		*offset += hose->pci_mem_offset;
-#endif
-		res_bit = IORESOURCE_MEM;
-	} else {
-		io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		*offset += io_offset;
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
+		return -EINVAL;		/* should never happen */
 
-		/* treat ROM as memory (should be already) */
-		if (i == PCI_ROM_RESOURCE)
-			flags |= IORESOURCE_MEM;
-
-		/* Active and same type? */
-		if ((flags & res_bit) == 0)
-			continue;
-
-		/* In the range of this resource? */
-		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
-			continue;
-
-		/* found it! construct the final physical address */
-		if (mmap_state == pci_mmap_io)
-			*offset += hose->io_base_phys - io_offset;
-		return rp;
-	}
+	/* Convert to an offset within this PCI controller */
+	ioaddr -= (unsigned long)hose->io_base_virt - _IO_BASE;
 
-	return NULL;
+	vma->vm_pgoff += (ioaddr + hose->io_base_phys) >> PAGE_SHIFT;
+	return 0;
 }
 
 /*
@@ -268,37 +218,6 @@ pgprot_t pci_phys_mem_access_prot(struct file *file,
 	return prot;
 }
 
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
-int pci_mmap_page_range(struct pci_dev *dev, int bar, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	resource_size_t offset =
-		((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
-	struct resource *rp;
-	int ret;
-
-	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
-	if (rp == NULL)
-		return -EINVAL;
-
-	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
-
-	return ret;
-}
-
 /* This provides legacy IO read access on a bus */
 int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t size)
 {
-- 
2.9.3
