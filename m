Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/27] ia64: Remove redundant checks for WC in pci_mmap_page_range()
Date: Wed, 12 Apr 2017 13:26:13 +0100
Message-Id: <9c83a007289d75decdb182afd0434dc517fe433b.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

For a PCI MMIO BAR, phys_mem_access_prot() should always return UC or WC.
And while a mixture of cached and uncached mappings is forbidden, we were
already mixing WC and UC, which is OK. Just do as we're asked.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/ia64/pci/pci.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 27020f3..7438e8c 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -423,9 +423,6 @@ pci_mmap_page_range (struct pci_dev *dev, int bar,
 		     struct vm_area_struct *vma,
 		     enum pci_mmap_state mmap_state, int write_combine)
 {
-	unsigned long size = vma->vm_end - vma->vm_start;
-	pgprot_t prot;
-
 	/*
 	 * I/O space cannot be accessed via normal processor loads and
 	 * stores on this platform.
@@ -439,21 +436,10 @@ pci_mmap_page_range (struct pci_dev *dev, int bar,
 		 */
 		return -EINVAL;
 
-	prot = phys_mem_access_prot(NULL, vma->vm_pgoff, size,
-				    vma->vm_page_prot);
-
-	/*
-	 * If the user requested WC, the kernel uses UC or WC for this region,
-	 * and the chipset supports WC, we can use WC. Otherwise, we have to
-	 * use the same attribute the kernel uses.
-	 */
-	if (write_combine &&
-	    ((pgprot_val(prot) & _PAGE_MA_MASK) == _PAGE_MA_UC ||
-	     (pgprot_val(prot) & _PAGE_MA_MASK) == _PAGE_MA_WC) &&
-	    efi_range_is_wc(vma->vm_start, vma->vm_end - vma->vm_start))
+	if (write_combine)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	else
-		vma->vm_page_prot = prot;
+		vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
 
 	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
-- 
2.9.3
