Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/27] ia64: Use generic pci_mmap_resource_range()
Date: Wed, 12 Apr 2017 13:26:14 +0100
Message-Id: <109e9ddbde4334d0da34f331797236309d789353.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Now that we eliminated the different behaviour in separately-reviewable
commits, we can switch IA64 to the generic implementation.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/ia64/include/asm/pci.h |  1 +
 arch/ia64/pci/pci.c         | 30 ------------------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index fc60b3d..6459f2d 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -51,6 +51,7 @@ extern unsigned long ia64_max_iommu_merge_mask;
 #define PCI_DMA_BUS_IS_PHYS	(ia64_max_iommu_merge_mask == ~0UL)
 
 #define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define arch_can_pci_mmap_wc()	1
 
 #define HAVE_PCI_LEGACY
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 7438e8c..4068bde 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -418,36 +418,6 @@ pcibios_align_resource (void *data, const struct resource *res,
 	return res->start;
 }
 
-int
-pci_mmap_page_range (struct pci_dev *dev, int bar,
-		     struct vm_area_struct *vma,
-		     enum pci_mmap_state mmap_state, int write_combine)
-{
-	/*
-	 * I/O space cannot be accessed via normal processor loads and
-	 * stores on this platform.
-	 */
-	if (mmap_state == pci_mmap_io)
-		/*
-		 * XXX we could relax this for I/O spaces for which ACPI
-		 * indicates that the space is 1-to-1 mapped.  But at the
-		 * moment, we don't support multiple PCI address spaces and
-		 * the legacy I/O space is not 1-to-1 mapped, so this is moot.
-		 */
-		return -EINVAL;
-
-	if (write_combine)
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	else
-		vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
-
-	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
-
-	return 0;
-}
-
 /**
  * ia64_pci_get_legacy_mem - generic legacy mem routine
  * @bus: bus to get legacy memory base address for
-- 
2.9.3
