Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] pci: Add pci_mmap_resource_range() and use it for ARM64
Date: Wed, 22 Mar 2017 13:25:23 +0000
Message-Id: <7c16b64b4099fac734cb2c53759b9c975df3d73b.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
MIME-Version: 1.0
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Starting to leave behind the legacy of the pci_mmap_page_range()
interface which takes "user-visible" BAR addresses. This takes just the
resource and offset.

For now, both APIs coexist and depending on the platform, one is
implemented as a wrapper around the other.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/filesystems/sysfs-pci.txt |  5 +-
 arch/arm64/include/asm/pci.h            |  3 ++
 drivers/pci/Makefile                    |  2 +-
 drivers/pci/mmap.c                      | 90 +++++++++++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 | 11 +---
 include/linux/pci.h                     | 19 +++++--
 6 files changed, 115 insertions(+), 15 deletions(-)
 create mode 100644 drivers/pci/mmap.c

diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.txt
index 25b7f1c..3e1016e 100644
--- a/Documentation/filesystems/sysfs-pci.txt
+++ b/Documentation/filesystems/sysfs-pci.txt
@@ -113,7 +113,10 @@ Supporting PCI access on new platforms
 --------------------------------------
 
 In order to support PCI resource mapping as described above, Linux platform
-code must define HAVE_PCI_MMAP and provide a pci_mmap_page_range function.
+code must define HAVE_PCI_MMAP and either provide a pci_mmap_page_range()
+function or (preferably) also define ARCH_GENERIC_PCI_MMAP_RESOURCE to use
+the generic implementation.
+
 Platforms are free to only support subsets of the mmap functionality, but
 useful return codes should be provided.
 
diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b9a7ba9..021da94 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -22,6 +22,9 @@
  */
 #define PCI_DMA_BUS_IS_PHYS	(0)
 
+#define HAVE_PCI_MMAP			1
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
+
 extern int isa_dma_bridge_buggy;
 
 #ifdef CONFIG_PCI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 8db5079..3d40e41 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,7 @@
 
 obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o setup-bus.o vc.o
+			irq.o vpd.o setup-bus.o vc.o mmap.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSFS) += slot.o
 
diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
new file mode 100644
index 0000000..bf28dae
--- /dev/null
+++ b/drivers/pci/mmap.c
@@ -0,0 +1,90 @@
+/*
+ * mmap.c — generic PCI resource mmap helper
+ *
+ * Copyright © 2017 Amazon.com, Inc. or its affiliates.
+ *
+ * Author: David Woodhouse <dwmw2@infradead.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+
+#ifdef HAVE_PCI_MMAP
+
+#ifdef ARCH_GENERIC_PCI_MMAP_RESOURCE
+/* Modern setup: generic pci_mmap_resource_range(), and implement the legacy
+ * pci_mmap_page_range() as a wrapper round it. */
+
+#ifdef HAVE_PCI_MMAP_IO
+/* We don't support this (yet), so prevent archietectures from trying it. */
+#error Generic pci_mmap_io not supported
+#endif
+
+static const struct vm_operations_struct pci_phys_vm_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+        .access = generic_access_phys,
+#endif
+};
+
+int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
+			    struct vm_area_struct *vma,
+			    enum pci_mmap_state mmap_state, int write_combine)
+{
+	unsigned long size;
+
+	if (mmap_state == pci_mmap_io)
+		return -EINVAL;
+
+	size = ((pci_resource_len(pdev, bar) - 1) >> PAGE_SHIFT) + 1;
+	if (vma->vm_pgoff + vma_pages(vma) > size)
+		return -EINVAL;
+
+	if (write_combine)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
+
+	vma->vm_pgoff += (pci_resource_start(pdev, bar) >> PAGE_SHIFT);
+        vma->vm_ops = &pci_phys_vm_ops;
+
+	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				  vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
+int pci_mmap_page_range(struct pci_dev *pdev, int bar,
+			struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine)
+{
+	/* Adjust vm_pgoff to be the offset within the resource */
+	resource_size_t start, end;
+
+	pci_resource_to_user(pdev, bar, &pdev->resource[bar], &start, &end);
+	vma->vm_pgoff -= start >> PAGE_SHIFT;
+	return pci_mmap_resource_range(pdev, bar, vma, mmap_state, write_combine);
+}
+
+#else
+/* Legacy setup: Impement pci_mmap_resource_range() as a wrapper around
+   the architecture's pci_mmap_page_range(), converting to "user visible"
+   addresses as necessary. */
+int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
+			    struct vm_area_struct *vma,
+			    enum pci_mmap_state mmap_state, int write_combine)
+{
+	resource_size_t start, end;
+	/* pci_mmap_page_range() expects the same kind of entry as coming
+	 * from /proc/bus/pci/ which is a "user visible" value. If this is
+	 * different from the resource itself, arch will do necessary fixup.
+	 */
+	pci_resource_to_user(pdev, bar, &pdev->resource[bar], &start, &end);
+	vma->vm_pgoff += start >> PAGE_SHIFT;
+	return pci_mmap_page_range(pdev, bar, vma, mmap_state, write_combine);
+}
+#endif
+#endif /* HAVE_PCI_MMAP */
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 063310a..9663d38 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1019,7 +1019,6 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
-	resource_size_t start, end;
 	struct resource *res = &pdev->resource[bar];
 
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
@@ -1033,15 +1032,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 			(u64)pci_resource_len(pdev, bar));
 		return -EINVAL;
 	}
-
-	/* pci_mmap_page_range() expects the same kind of entry as coming
-	 * from /proc/bus/pci/ which is a "user visible" value. If this is
-	 * different from the resource itself, arch will do necessary fixup.
-	 */
-	pci_resource_to_user(pdev, bar, res, &start, &end);
-	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
-	return pci_mmap_page_range(pdev, bar, vma, mmap_type, write_combine);
+
+	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
 }
 
 static int pci_mmap_resource_uc(struct file *filp, struct kobject *kobj,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ebc86c1..4dfec16 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1626,10 +1626,21 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #include <asm/pci.h>
 
-/* Map a range of PCI memory or I/O space for a device into user space.
- * Architectures provide this function if they set HAVE_PCI_MMAP, and
- * it accepts the 'write_combine' argument when arch_can_pci_mmap_wc()
- * evaluates to nonzero. */
+/* These two functions provide almost identical functionality. Depennding
+ * on the architecture, one will be implemented as a wrapper aroudn the
+ * other (in drivers/pci/mmap.c).
+ *
+ * pci_mmap_resource_range() maps a specific BAR, and vm->vm_pgoff
+ * is expected to be an offset within that region.
+ *
+ * pci_mmap_page_range() is the legacy architecture-specific interface,
+ * which accepts a "user visible" resource address converted by
+ * pci_resource_to_user(), as used in the legacy mmap() interface in
+ * /proc/bus/pci/.
+ */
+int pci_mmap_resource_range(struct pci_dev *dev, int bar,
+			    struct vm_area_struct *vma,
+			    enum pci_mmap_state mmap_state, int write_combine);
 int pci_mmap_page_range(struct pci_dev *pdev, int bar,
 			struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine);
-- 
2.9.3
