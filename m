Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46597 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbdDLM0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2017 08:26:18 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/27] xtensa: Do not mmap PCI BARs to userspace as write-through
Date: Wed, 12 Apr 2017 13:25:53 +0100
Message-Id: <6816f5f6ecc8d862718d3b0f87a7916576f5cef5.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

These should be uncached, not write-through.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/xtensa/kernel/pci.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index b848cc3..5b73fc2 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -334,25 +334,6 @@ __pci_mmap_make_offset(struct pci_dev *dev, struct vm_area_struct *vma,
 }
 
 /*
- * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
- * device mapping.
- */
-static __inline__ void
-__pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vma,
-		      enum pci_mmap_state mmap_state, int write_combine)
-{
-	int prot = pgprot_val(vma->vm_page_prot);
-
-	/* Set to write-through */
-	prot = (prot & _PAGE_CA_MASK) | _PAGE_CA_WT;
-#if 0
-	if (!write_combine)
-		prot |= _PAGE_WRITETHRU;
-#endif
-	vma->vm_page_prot = __pgprot(prot);
-}
-
-/*
  * Perform the actual remap of the pages for a PCI device mapping, as
  * appropriate for this architecture.  The region in the process to map
  * is described by vm_start and vm_end members of VMA, the base physical
@@ -372,7 +353,7 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 	if (ret < 0)
 		return ret;
 
-	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
+	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
 
 	ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			         vma->vm_end - vma->vm_start,vma->vm_page_prot);
-- 
2.9.3
