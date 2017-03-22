Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] sh: Use generic pci_mmap_resource_range()
Date: Wed, 22 Mar 2017 13:25:29 +0000
Message-Id: <becdfc8e2154d3d21665fcae4a642c9a629fe688.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/sh/drivers/pci/pci.c | 22 ----------------------
 arch/sh/include/asm/pci.h |  1 +
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index c8b36b7..c99ee28 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -269,28 +269,6 @@ void __ref pcibios_report_status(unsigned int status_mask, int warn)
 	}
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
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
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot);
-}
-
 #ifndef CONFIG_GENERIC_IOMAP
 
 void __iomem *__pci_ioport_map(struct pci_dev *dev,
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 46abbc9..17fa69b 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -66,6 +66,7 @@ extern unsigned long PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM;
 struct pci_dev;
 
 #define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 extern void pcibios_set_master(struct pci_dev *dev);
 
-- 
2.9.3
