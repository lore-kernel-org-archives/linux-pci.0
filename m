Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47290 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759808AbdCVNZd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2017 09:25:33 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] parisc: Use generic pci_mmap_resource_range()
Date: Wed, 22 Mar 2017 13:25:28 +0000
Message-Id: <1e07d41a8fbb2824718c0432db8e06f39e4272e2.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/parisc/include/asm/pci.h |  1 +
 arch/parisc/kernel/pci.c      | 29 -----------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index bb9ea90..1de1a3f 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -200,5 +200,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 }
 
 #define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #endif /* __ASM_PARISC_PCI_H */
diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index 6538775..13ee356 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -227,35 +227,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return start;
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
-	if (write_combine)
-		return -EINVAL;
-
-	/*
-	 * Ignore write-combine; for now only return uncached mappings.
-	 */
-	prot = pgprot_val(vma->vm_page_prot);
-	prot |= _PAGE_NO_CACHE;
-	vma->vm_page_prot = __pgprot(prot);
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-		vma->vm_end - vma->vm_start, vma->vm_page_prot);
-}
-
 /*
  * A driver is enabling the device.  We make sure that all the appropriate
  * bits are set to allow the device to operate as the driver is expecting.
-- 
2.9.3
