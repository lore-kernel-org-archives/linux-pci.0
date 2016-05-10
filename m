Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17870 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcEJGGf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2016 02:06:35 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [RFC PATCH v3 1/2] PCI: Let pci_mmap_page_range() extra resource pointer
Date: Mon,  9 May 2016 23:05:41 -0700
Message-Id: <1462860342-2560-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This one is preparing patch for next one:
  PCI: Let pci_mmap_page_range() take resource addr

We need to pass extra resource pointer to avoid searching that again
for powerpc and microblaze prot set operation.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/arm/include/asm/pci.h              |    2 --
 arch/arm/kernel/bios32.c                |    3 ++-
 arch/cris/arch-v32/drivers/pci/bios.c   |    3 ++-
 arch/cris/include/asm/pci.h             |    3 ---
 arch/ia64/include/asm/pci.h             |    2 --
 arch/ia64/pci/pci.c                     |    3 ++-
 arch/microblaze/include/asm/pci.h       |    3 ---
 arch/microblaze/pci/pci-common.c        |    3 ++-
 arch/mips/include/asm/pci.h             |    3 ---
 arch/mips/pci/pci.c                     |    3 ++-
 arch/mn10300/include/asm/pci.h          |    3 ---
 arch/mn10300/unit-asb2305/pci-asb2305.c |    3 ++-
 arch/parisc/include/asm/pci.h           |    3 ---
 arch/parisc/kernel/pci.c                |    3 ++-
 arch/powerpc/include/asm/pci.h          |    3 ---
 arch/powerpc/kernel/pci-common.c        |    3 ++-
 arch/sh/drivers/pci/pci.c               |    3 ++-
 arch/sh/include/asm/pci.h               |    2 --
 arch/sparc/include/asm/pci_64.h         |    4 ----
 arch/sparc/kernel/pci.c                 |    3 ++-
 arch/unicore32/include/asm/pci.h        |    2 --
 arch/unicore32/kernel/pci.c             |    3 ++-
 arch/x86/include/asm/pci.h              |    4 ----
 arch/x86/pci/i386.c                     |    3 ++-
 arch/xtensa/include/asm/pci.h           |    4 ----
 arch/xtensa/kernel/pci.c                |    3 ++-
 drivers/pci/pci-sysfs.c                 |    2 +-
 drivers/pci/pci.h                       |    2 +-
 drivers/pci/proc.c                      |    2 +-
 include/linux/pci.h                     |    6 ++++++
 30 files changed, 35 insertions(+), 54 deletions(-)

Index: linux-2.6/arch/arm/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/arm/include/asm/pci.h
+++ linux-2.6/arch/arm/include/asm/pci.h
@@ -29,8 +29,6 @@ static inline int pci_proc_domain(struct
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-                               enum pci_mmap_state mmap_state, int write_combine);
 
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
Index: linux-2.6/arch/arm/kernel/bios32.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/bios32.c
+++ linux-2.6/arch/arm/kernel/bios32.c
@@ -605,7 +605,8 @@ int pcibios_enable_device(struct pci_dev
 	return pci_enable_resources(dev, mask);
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	if (mmap_state == pci_mmap_io)
Index: linux-2.6/arch/cris/arch-v32/drivers/pci/bios.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/drivers/pci/bios.c
+++ linux-2.6/arch/cris/arch-v32/drivers/pci/bios.c
@@ -14,7 +14,8 @@ void pcibios_set_master(struct pci_dev *
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
Index: linux-2.6/arch/cris/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/cris/include/asm/pci.h
+++ linux-2.6/arch/cris/include/asm/pci.h
@@ -42,9 +42,6 @@ struct pci_dev;
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			       enum pci_mmap_state mmap_state, int write_combine);
-
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6/arch/ia64/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/ia64/include/asm/pci.h
+++ linux-2.6/arch/ia64/include/asm/pci.h
@@ -51,8 +51,6 @@ extern unsigned long ia64_max_iommu_merg
 #define PCI_DMA_BUS_IS_PHYS	(ia64_max_iommu_merge_mask == ~0UL)
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
-				enum pci_mmap_state mmap_state, int write_combine);
 #define HAVE_PCI_LEGACY
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      struct vm_area_struct *vma,
Index: linux-2.6/arch/ia64/pci/pci.c
===================================================================
--- linux-2.6.orig/arch/ia64/pci/pci.c
+++ linux-2.6/arch/ia64/pci/pci.c
@@ -419,7 +419,8 @@ pcibios_align_resource (void *data, cons
 }
 
 int
-pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
+pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+		     struct vm_area_struct *vma,
 		     enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
Index: linux-2.6/arch/microblaze/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/microblaze/include/asm/pci.h
+++ linux-2.6/arch/microblaze/include/asm/pci.h
@@ -46,9 +46,6 @@ extern int pci_domain_nr(struct pci_bus
 extern int pci_proc_domain(struct pci_bus *bus);
 
 struct vm_area_struct;
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
Index: linux-2.6/arch/mips/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/mips/include/asm/pci.h
+++ linux-2.6/arch/mips/include/asm/pci.h
@@ -77,9 +77,6 @@ extern void pcibios_set_master(struct pc
 
 #define HAVE_PCI_MMAP
 
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-	enum pci_mmap_state mmap_state, int write_combine);
-
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 
 static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
Index: linux-2.6/arch/mips/pci/pci.c
===================================================================
--- linux-2.6.orig/arch/mips/pci/pci.c
+++ linux-2.6/arch/mips/pci/pci.c
@@ -322,7 +322,8 @@ void pcibios_fixup_bus(struct pci_bus *b
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
Index: linux-2.6/arch/mn10300/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/mn10300/include/asm/pci.h
+++ linux-2.6/arch/mn10300/include/asm/pci.h
@@ -74,9 +74,6 @@ static inline int pci_controller_num(str
 }
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			       enum pci_mmap_state mmap_state,
-			       int write_combine);
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6/arch/mn10300/unit-asb2305/pci-asb2305.c
===================================================================
--- linux-2.6.orig/arch/mn10300/unit-asb2305/pci-asb2305.c
+++ linux-2.6/arch/mn10300/unit-asb2305/pci-asb2305.c
@@ -211,7 +211,8 @@ void __init pcibios_resource_survey(void
 	pcibios_allocate_resources(1);
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
Index: linux-2.6/arch/parisc/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/parisc/include/asm/pci.h
+++ linux-2.6/arch/parisc/include/asm/pci.h
@@ -201,7 +201,4 @@ static inline int pci_get_legacy_ide_irq
 
 #define HAVE_PCI_MMAP
 
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-	enum pci_mmap_state mmap_state, int write_combine);
-
 #endif /* __ASM_PARISC_PCI_H */
Index: linux-2.6/arch/parisc/kernel/pci.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/pci.c
+++ linux-2.6/arch/parisc/kernel/pci.c
@@ -228,7 +228,8 @@ resource_size_t pcibios_align_resource(v
 }
 
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
Index: linux-2.6/arch/powerpc/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/pci.h
+++ linux-2.6/arch/powerpc/include/asm/pci.h
@@ -77,9 +77,6 @@ extern int pci_domain_nr(struct pci_bus
 extern int pci_proc_domain(struct pci_bus *bus);
 
 struct vm_area_struct;
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
Index: linux-2.6/arch/sh/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/arch/sh/drivers/pci/pci.c
+++ linux-2.6/arch/sh/drivers/pci/pci.c
@@ -269,7 +269,8 @@ void __init_refok pcibios_report_status(
 	}
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	/*
Index: linux-2.6/arch/sh/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/sh/include/asm/pci.h
+++ linux-2.6/arch/sh/include/asm/pci.h
@@ -66,8 +66,6 @@ extern unsigned long PCIBIOS_MIN_IO, PCI
 struct pci_dev;
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-	enum pci_mmap_state mmap_state, int write_combine);
 extern void pcibios_set_master(struct pci_dev *dev);
 
 /* Dynamic DMA mapping stuff.
Index: linux-2.6/arch/sparc/include/asm/pci_64.h
===================================================================
--- linux-2.6.orig/arch/sparc/include/asm/pci_64.h
+++ linux-2.6/arch/sparc/include/asm/pci_64.h
@@ -45,10 +45,6 @@ static inline int pci_proc_domain(struct
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state,
-			int write_combine);
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return PCI_IRQ_NONE;
Index: linux-2.6/arch/unicore32/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/unicore32/include/asm/pci.h
+++ linux-2.6/arch/unicore32/include/asm/pci.h
@@ -17,8 +17,6 @@
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-	enum pci_mmap_state mmap_state, int write_combine);
 
 #endif /* __KERNEL__ */
 #endif
Index: linux-2.6/arch/unicore32/kernel/pci.c
===================================================================
--- linux-2.6.orig/arch/unicore32/kernel/pci.c
+++ linux-2.6/arch/unicore32/kernel/pci.c
@@ -362,7 +362,8 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long phys;
Index: linux-2.6/arch/x86/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/pci.h
+++ linux-2.6/arch/x86/include/asm/pci.h
@@ -88,10 +88,6 @@ int pcibios_set_irq_routing(struct pci_d
 
 
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			       enum pci_mmap_state mmap_state,
-			       int write_combine);
-
 
 #ifdef CONFIG_PCI
 extern void early_quirks(void);
Index: linux-2.6/arch/x86/pci/i386.c
===================================================================
--- linux-2.6.orig/arch/x86/pci/i386.c
+++ linux-2.6/arch/x86/pci/i386.c
@@ -411,7 +411,8 @@ static const struct vm_operations_struct
 	.access = generic_access_phys,
 };
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
Index: linux-2.6/arch/xtensa/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/xtensa/include/asm/pci.h
+++ linux-2.6/arch/xtensa/include/asm/pci.h
@@ -46,10 +46,6 @@ struct pci_dev;
 
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
-
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
 
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -30,7 +30,7 @@ enum pci_mmap_api {
 	PCI_MMAP_PROCFS	/* mmap on /proc/bus/pci/<BDF> */
 };
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
-		  enum pci_mmap_api mmap_api);
+		  enum pci_mmap_state mmap_type, enum pci_mmap_api mmap_api);
 #endif
 int pci_probe_reset_function(struct pci_dev *dev);
 
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -70,6 +70,12 @@ enum pci_mmap_state {
 	pci_mmap_mem
 };
 
+struct vm_area_struct;
+/* Map a range of PCI memory or I/O space for a device into user space */
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine);
+
 /*
  *  For PCI devices, the region numbers are assigned this way:
  */
Index: linux-2.6/arch/microblaze/pci/pci-common.c
===================================================================
--- linux-2.6.orig/arch/microblaze/pci/pci-common.c
+++ linux-2.6/arch/microblaze/pci/pci-common.c
@@ -302,7 +302,8 @@ pgprot_t pci_phys_mem_access_prot(struct
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *rp,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	resource_size_t offset =
Index: linux-2.6/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci-common.c
+++ linux-2.6/arch/powerpc/kernel/pci-common.c
@@ -445,7 +445,8 @@ pgprot_t pci_phys_mem_access_prot(struct
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *rp,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	resource_size_t offset =
Index: linux-2.6/arch/sparc/kernel/pci.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/pci.c
+++ linux-2.6/arch/sparc/kernel/pci.c
@@ -862,7 +862,8 @@ static void __pci_mmap_set_pgprot(struct
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state,
 			int write_combine)
 {
Index: linux-2.6/arch/xtensa/kernel/pci.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/pci.c
+++ linux-2.6/arch/xtensa/kernel/pci.c
@@ -362,7 +362,8 @@ __pci_mmap_set_pgprot(struct pci_dev *de
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state,
 			int write_combine)
 {
Index: linux-2.6/drivers/pci/pci-sysfs.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-sysfs.c
+++ linux-2.6/drivers/pci/pci-sysfs.c
@@ -1027,7 +1027,7 @@ static int pci_mmap_resource(struct kobj
 	pci_resource_to_user(pdev, i, res, &start, &end);
 	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
-	return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
+	return pci_mmap_page_range(pdev, res, vma, mmap_type, write_combine);
 }
 
 static int pci_mmap_resource_uc(struct file *filp, struct kobject *kobj,
Index: linux-2.6/drivers/pci/proc.c
===================================================================
--- linux-2.6.orig/drivers/pci/proc.c
+++ linux-2.6/drivers/pci/proc.c
@@ -245,7 +245,7 @@ static int proc_bus_pci_mmap(struct file
 	if (i >= PCI_ROM_RESOURCE)
 		return -ENODEV;
 
-	ret = pci_mmap_page_range(dev, vma,
+	ret = pci_mmap_page_range(dev, &dev->resource[i], vma,
 				  fpriv->mmap_state,
 				  fpriv->write_combine);
 	if (ret < 0)
