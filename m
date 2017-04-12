Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/27] pci: Add BAR index argument to pci_mmap_page_range()
Date: Wed, 12 Apr 2017 13:25:58 +0100
Message-Id: <3101f310f852ee41c52b31b9b77a3debee28117a.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

In all cases we know which BAR it is. Passing it in means that arch code
(or generic code; watch this space) won't have to go looking for it again.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm/kernel/bios32.c                | 3 ++-
 arch/cris/arch-v32/drivers/pci/bios.c   | 3 ++-
 arch/ia64/pci/pci.c                     | 3 ++-
 arch/microblaze/pci/pci-common.c        | 2 +-
 arch/mips/pci/pci.c                     | 3 ++-
 arch/mn10300/unit-asb2305/pci-asb2305.c | 3 ++-
 arch/parisc/kernel/pci.c                | 3 ++-
 arch/powerpc/kernel/pci-common.c        | 3 ++-
 arch/sh/drivers/pci/pci.c               | 3 ++-
 arch/sparc/kernel/pci.c                 | 6 +++---
 arch/unicore32/kernel/pci.c             | 3 ++-
 arch/x86/pci/i386.c                     | 3 ++-
 arch/xtensa/kernel/pci.c                | 3 ++-
 drivers/pci/pci-sysfs.c                 | 2 +-
 drivers/pci/proc.c                      | 2 +-
 include/linux/pci.h                     | 3 ++-
 16 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2f0e077..a4fc3f4 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -597,7 +597,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	if (mmap_state == pci_mmap_io)
diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
index 212266a..a589686d 100644
--- a/arch/cris/arch-v32/drivers/pci/bios.c
+++ b/arch/cris/arch-v32/drivers/pci/bios.c
@@ -14,7 +14,8 @@ void pcibios_set_master(struct pci_dev *dev)
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 8f6ac2f..053c688 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -419,7 +419,8 @@ pcibios_align_resource (void *data, const struct resource *res,
 }
 
 int
-pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
+pci_mmap_page_range (struct pci_dev *dev, int bar,
+		     struct vm_area_struct *vma,
 		     enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 13bc932..404fb38 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -278,7 +278,7 @@ pgprot_t pci_phys_mem_access_prot(struct file *file,
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	resource_size_t offset =
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index f6325fa..f189502 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -58,7 +58,8 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 	*end = rsrc->start + size;
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.c b/arch/mn10300/unit-asb2305/pci-asb2305.c
index b7ab837..4abbbd5 100644
--- a/arch/mn10300/unit-asb2305/pci-asb2305.c
+++ b/arch/mn10300/unit-asb2305/pci-asb2305.c
@@ -211,7 +211,8 @@ void __init pcibios_resource_survey(void)
 	pcibios_allocate_resources(1);
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index 0903c6a..6538775 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -228,7 +228,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 }
 
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ffda24a..6dda4a2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -513,7 +513,8 @@ pgprot_t pci_phys_mem_access_prot(struct file *file,
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	resource_size_t offset =
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 84563e3..c8b36b7 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -269,7 +269,8 @@ void __ref pcibios_report_status(unsigned int status_mask, int warn)
 	}
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	/*
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 015e55a..7eceaa1 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -862,9 +862,9 @@ static void __pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vm
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state,
-			int write_combine)
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine)
 {
 	int ret;
 
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index 62137d1..1b43885 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -357,7 +357,8 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long phys;
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 0a9f2ca..8ca5e5d 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -411,7 +411,8 @@ static const struct vm_operations_struct pci_mmap_ops = {
 	.access = generic_access_phys,
 };
 
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long prot;
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 5b73fc2..903963e 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -343,7 +343,8 @@ __pci_mmap_make_offset(struct pci_dev *dev, struct vm_area_struct *vma,
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *dev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state,
 			int write_combine)
 {
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 534844d..bfd9efe 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1041,7 +1041,7 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	pci_resource_to_user(pdev, bar, res, &start, &end);
 	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
-	return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
+	return pci_mmap_page_range(pdev, bar, vma, mmap_type, write_combine);
 }
 
 static int pci_mmap_resource_uc(struct file *filp, struct kobject *kobj,
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 45e5cf7..098360d 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -262,7 +262,7 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 		else
 			return -EINVAL;
 	}
-	ret = pci_mmap_page_range(dev, vma,
+	ret = pci_mmap_page_range(dev, i, vma,
 				  fpriv->mmap_state, write_combine);
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 590cfcf..7173a67 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1630,7 +1630,8 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
  * Architectures provide this function if they set HAVE_PCI_MMAP, and
  * it accepts the 'write_combine' argument when arch_can_pci_mmap_wc()
  * evaluates to nonzero. */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
+int pci_mmap_page_range(struct pci_dev *pdev, int bar,
+			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine);
 
 #ifndef arch_can_pci_mmap_wc
-- 
2.9.3
