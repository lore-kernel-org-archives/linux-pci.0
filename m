Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38108 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbdDLM0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2017 08:26:19 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/27] pci: Move multiple declarations of pci_mmap_page_range() to <linux/pci.h>
Date: Wed, 12 Apr 2017 13:25:55 +0100
Message-Id: <3391759e33092e5925d8d260960b2f76fce366b3.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

We can declare it <linux/pci.h> even on platforms where it isn't going
to be defined. There's no need to have it littered through the various
<asm/pci.h> files.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm/include/asm/pci.h        | 2 --
 arch/cris/include/asm/pci.h       | 3 ---
 arch/ia64/include/asm/pci.h       | 2 --
 arch/microblaze/include/asm/pci.h | 3 ---
 arch/mips/include/asm/pci.h       | 3 ---
 arch/mn10300/include/asm/pci.h    | 3 ---
 arch/parisc/include/asm/pci.h     | 3 ---
 arch/powerpc/include/asm/pci.h    | 3 ---
 arch/sh/include/asm/pci.h         | 3 +--
 arch/sparc/include/asm/pci_64.h   | 4 ----
 arch/unicore32/include/asm/pci.h  | 2 --
 arch/x86/include/asm/pci.h        | 4 ----
 arch/xtensa/include/asm/pci.h     | 4 ----
 include/linux/pci.h               | 7 +++++++
 14 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 057d381..51118a0 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -29,8 +29,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-                               enum pci_mmap_state mmap_state, int write_combine);
 
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
index b1b289d..65198cb 100644
--- a/arch/cris/include/asm/pci.h
+++ b/arch/cris/include/asm/pci.h
@@ -42,9 +42,6 @@ struct pci_dev;
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			       enum pci_mmap_state mmap_state, int write_combine);
-
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 6283758..fc60b3d 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -53,8 +53,6 @@ extern unsigned long ia64_max_iommu_merge_mask;
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	1
 
-extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
-				enum pci_mmap_state mmap_state, int write_combine);
 #define HAVE_PCI_LEGACY
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      struct vm_area_struct *vma,
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 2a120bb..ab381d2 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -46,9 +46,6 @@ extern int pci_domain_nr(struct pci_bus *bus);
 extern int pci_proc_domain(struct pci_bus *bus);
 
 struct vm_area_struct;
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 30d1129..3141e2a 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -111,9 +111,6 @@ extern void pcibios_set_master(struct pci_dev *dev);
 
 #define HAVE_PCI_MMAP
 
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-	enum pci_mmap_state mmap_state, int write_combine);
-
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 
 /*
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index 51159ff..082b6de 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -74,9 +74,6 @@ static inline int pci_controller_num(struct pci_dev *dev)
 }
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			       enum pci_mmap_state mmap_state,
-			       int write_combine);
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index defebd9..bb9ea90 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -201,7 +201,4 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 
 #define HAVE_PCI_MMAP
 
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-	enum pci_mmap_state mmap_state, int write_combine);
-
 #endif /* __ASM_PARISC_PCI_H */
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index b5b68c6..55887d1 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -77,9 +77,6 @@ extern int pci_domain_nr(struct pci_bus *bus);
 extern int pci_proc_domain(struct pci_bus *bus);
 
 struct vm_area_struct;
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() and it does WC */
 #define HAVE_PCI_MMAP		1
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 644314f..46abbc9 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -66,8 +66,7 @@ extern unsigned long PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM;
 struct pci_dev;
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-	enum pci_mmap_state mmap_state, int write_combine);
+
 extern void pcibios_set_master(struct pci_dev *dev);
 
 /* Dynamic DMA mapping stuff.
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 2303635..516fda7 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -45,10 +45,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state,
-			int write_combine);
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return PCI_IRQ_NONE;
diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index 37e55d0..a5129086 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -17,8 +17,6 @@
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-	enum pci_mmap_state mmap_state, int write_combine);
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index f6e22c2..734cc94 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -104,10 +104,6 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	pat_enabled()
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			       enum pci_mmap_state mmap_state,
-			       int write_combine);
-
 
 #ifdef CONFIG_PCI
 extern void early_quirks(void);
diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index 5d6bd93..bb5510b 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -46,10 +46,6 @@ struct pci_dev;
 
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
-
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e614fb4..e7bb4b62 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1626,6 +1626,13 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #include <asm/pci.h>
 
+/* Map a range of PCI memory or I/O space for a device into user space.
+ * Architectures provide this function if they set HAVE_PCI_MMAP, and
+ * it accepts the 'write_combine' argument when arch_can_pci_mmap_wc()
+ * evaluates to nonzero. */
+int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine);
+
 #ifndef arch_can_pci_mmap_wc
 #define arch_can_pci_mmap_wc()		0
 #endif
-- 
2.9.3
