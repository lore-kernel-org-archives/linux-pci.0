Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759809AbdCVNZd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2017 09:25:33 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] arm: Use generic pci_mmap_resource_range()
Date: Wed, 22 Mar 2017 13:25:24 +0000
Message-Id: <60f1a26d0f10bf8b6f1e88283ba1df1b3b1d0c0a.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm/include/asm/pci.h |  1 +
 arch/arm/kernel/bios32.c   | 20 --------------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 51118a0..396c92b 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -29,6 +29,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
 #define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index a4fc3f4..b259956 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -597,26 +597,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	if (mmap_state == pci_mmap_io)
-		return -EINVAL;
-
-	/*
-	 * Mark this as IO
-	 */
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			     vma->vm_end - vma->vm_start,
-			     vma->vm_page_prot))
-		return -EAGAIN;
-
-	return 0;
-}
-
 void __init pci_map_io_early(unsigned long pfn)
 {
 	struct map_desc pci_io_desc = {
-- 
2.9.3
