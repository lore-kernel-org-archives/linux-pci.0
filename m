Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/27] x86: Use generic pci_mmap_resource_range()
Date: Wed, 12 Apr 2017 13:26:07 +0100
Message-Id: <d56ef188d8769d84fb97e691222876772e209a54.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
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
