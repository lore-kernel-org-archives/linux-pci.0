Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] mn10300: Use generic pci_mmap_resource_range()
Date: Wed, 22 Mar 2017 13:25:27 +0000
Message-Id: <fa831bd26dbaa1220f24a427c4ad959305942e0b.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

This was setting vma->vm_flags |= VM_LOCKED. Not sure why...

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/mn10300/include/asm/pci.h          |  1 +
 arch/mn10300/unit-asb2305/pci-asb2305.c | 24 ------------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index 082b6de..d276549 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -74,6 +74,7 @@ static inline int pci_controller_num(struct pci_dev *dev)
 }
 
 #define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.c b/arch/mn10300/unit-asb2305/pci-asb2305.c
index 4abbbd5..e0f4617 100644
--- a/arch/mn10300/unit-asb2305/pci-asb2305.c
+++ b/arch/mn10300/unit-asb2305/pci-asb2305.c
@@ -210,27 +210,3 @@ void __init pcibios_resource_survey(void)
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
 }
-
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	unsigned long prot;
-
-	/* Leave vm_pgoff as-is, the PCI space address is the physical
-	 * address on this platform.
-	 */
-	vma->vm_flags |= VM_LOCKED;
-
-	prot = pgprot_val(vma->vm_page_prot);
-	prot &= ~_PAGE_CACHE;
-	vma->vm_page_prot = __pgprot(prot);
-
-	/* Write-combine setting is ignored */
-	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot))
-		return -EAGAIN;
-
-	return 0;
-}
-- 
2.9.3
