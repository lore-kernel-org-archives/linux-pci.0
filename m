Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/27] mips: Use generic pci_mmap_resource_range()
Date: Wed, 12 Apr 2017 13:26:02 +0100
Message-Id: <9afaaa92928c01c73c2c008cd0d9539cb592010f.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/mips/include/asm/pci.h |  2 +-
 arch/mips/pci/pci.c         | 25 -------------------------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 3141e2a..1000c1b 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -110,7 +110,7 @@ extern unsigned long PCIBIOS_MIN_MEM;
 extern void pcibios_set_master(struct pci_dev *dev);
 
 #define HAVE_PCI_MMAP
-
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 
 /*
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index f189502..bd67ac7 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -57,28 +57,3 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 	*start = fixup_bigphys_addr(rsrc->start, size);
 	*end = rsrc->start + size;
 }
-
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	unsigned long prot;
-
-	/*
-	 * I/O space can be accessed via normal processor loads and stores on
-	 * this platform but for now we elect not to do this and portable
-	 * drivers should not do this anyway.
-	 */
-	if (mmap_state == pci_mmap_io)
-		return -EINVAL;
-
-	/*
-	 * Ignore write-combine; for now only return uncached mappings.
-	 */
-	prot = pgprot_val(vma->vm_page_prot);
-	prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
-	vma->vm_page_prot = __pgprot(prot);
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-		vma->vm_end - vma->vm_start, vma->vm_page_prot);
-}
-- 
2.9.3
