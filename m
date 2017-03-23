Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/17] x86: Use generic pci_mmap_resource_range()
Date: Thu, 23 Mar 2017 14:29:34 +0000
Message-Id: <7d3b0692a8c539b81b3feda8ad18503b49534c9e.1490279148.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
Actually it turns out this is fairly trivial for x86 too; it just looked
more interesting at first glance. But pgprot_writecombine() and
pgprot_device() will both do the right thing here, and allowing WC
conditionally based on pat_enabled() is already working so we'll never
get asked to do that when we don't want to.

 arch/x86/include/asm/pci.h |  1 +
 arch/x86/pci/i386.c        | 48 ----------------------------------------------
 2 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 734cc94..f513cc2 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -104,6 +104,7 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	pat_enabled()
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #ifdef CONFIG_PCI
 extern void early_quirks(void);
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 8ca5e5d..68499cf 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -406,51 +406,3 @@ void __init pcibios_resource_survey(void)
 	 */
 	ioapic_insert_resources();
 }
-
-static const struct vm_operations_struct pci_mmap_ops = {
-	.access = generic_access_phys,
-};
-
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	unsigned long prot;
-
-	/* I/O space cannot be accessed via normal processor loads and
-	 * stores on this platform.
-	 */
-	if (mmap_state == pci_mmap_io)
-		return -EINVAL;
-
-	prot = pgprot_val(vma->vm_page_prot);
-
-	/*
- 	 * Return error if pat is not enabled and write_combine is requested.
- 	 * Caller can followup with UC MINUS request and add a WC mtrr if there
- 	 * is a free mtrr slot.
- 	 */
-	if (!pat_enabled() && write_combine)
-		return -EINVAL;
-
-	if (pat_enabled() && write_combine)
-		prot |= cachemode2protval(_PAGE_CACHE_MODE_WC);
-	else if (pat_enabled() || boot_cpu_data.x86 > 3)
-		/*
-		 * ioremap() and ioremap_nocache() defaults to UC MINUS for now.
-		 * To avoid attribute conflicts, request UC MINUS here
-		 * as well.
-		 */
-		prot |= cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS);
-
-	vma->vm_page_prot = __pgprot(prot);
-
-	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot))
-		return -EAGAIN;
-
-	vma->vm_ops = &pci_mmap_ops;
-
-	return 0;
-}
-- 
2.9.3
