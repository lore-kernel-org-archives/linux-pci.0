Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/27] pci: Add arch_can_pci_mmap_io() on architectures which can mmap() I/O space
Date: Wed, 12 Apr 2017 13:25:56 +0100
Message-Id: <80de9ad4acdf80cb6a65134b9b01efdf445a6749.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

This is relatively esoteric, and knowing that we don't have it makes
life easier in some cases rather than just an eventual -EINVAL from
pci_mmap_page_range().

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/filesystems/sysfs-pci.txt |  3 ++-
 arch/microblaze/include/asm/pci.h       |  3 ++-
 arch/powerpc/include/asm/pci.h          |  1 +
 arch/sparc/include/asm/pci_64.h         |  1 +
 arch/xtensa/include/asm/pci.h           |  3 ++-
 drivers/pci/pci-sysfs.c                 | 13 ++++++++-----
 drivers/pci/proc.c                      | 11 +++++++----
 include/linux/pci.h                     |  3 +++
 8 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.txt
index 25b7f1c..46b95d8 100644
--- a/Documentation/filesystems/sysfs-pci.txt
+++ b/Documentation/filesystems/sysfs-pci.txt
@@ -119,7 +119,8 @@ useful return codes should be provided.
 
 Platforms which support write-combining maps of PCI resources must define
 arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
-write-combining is permitted.
+write-combining is permitted. Platforms which support maps of I/O resources
+define arch_can_pci_mmap_io() similarly.
 
 Legacy resources are protected by the HAVE_PCI_LEGACY define.  Platforms
 wishing to support legacy functionality should define it and provide
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index ab381d2..efd4983 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -48,7 +48,8 @@ extern int pci_proc_domain(struct pci_bus *bus);
 struct vm_area_struct;
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
-#define HAVE_PCI_MMAP	1
+#define HAVE_PCI_MMAP		1
+#define arch_can_pci_mmap_io()	1
 
 extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
 			   size_t count);
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 55887d1..c8975da 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -80,6 +80,7 @@ struct vm_area_struct;
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() and it does WC */
 #define HAVE_PCI_MMAP		1
+#define arch_can_pci_mmap_io()	1
 #define arch_can_pci_mmap_wc()	1
 
 extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 516fda7..b957ca5 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -42,6 +42,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
 #define HAVE_PCI_MMAP
+#define arch_can_pci_mmap_io()	1
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
 
diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index bb5510b..e4f366a 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -47,7 +47,8 @@ struct pci_dev;
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
-#define HAVE_PCI_MMAP	1
+#define HAVE_PCI_MMAP		1
+#define arch_can_pci_mmap_io()	1
 
 #endif /* __KERNEL__ */
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7d494bd..cb04bc2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1174,11 +1174,14 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	} else {
 		pdev->res_attr[num] = res_attr;
 		sprintf(res_attr_name, "resource%d", num);
-		res_attr->mmap = pci_mmap_resource_uc;
-	}
-	if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
-		res_attr->read = pci_read_resource_io;
-		res_attr->write = pci_write_resource_io;
+		if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
+			res_attr->read = pci_read_resource_io;
+			res_attr->write = pci_write_resource_io;
+			if (arch_can_pci_mmap_io())
+				res_attr->mmap = pci_mmap_resource_uc;
+		} else {
+			res_attr->mmap = pci_mmap_resource_uc;
+		}
 	}
 	res_attr->attr.name = res_attr_name;
 	res_attr->attr.mode = S_IRUSR | S_IWUSR;
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index a2aa58a..45e5cf7 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -202,6 +202,8 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 
 #ifdef HAVE_PCI_MMAP
 	case PCIIOC_MMAP_IS_IO:
+		if (!arch_can_pci_mmap_io())
+			return -EINVAL;
 		fpriv->mmap_state = pci_mmap_io;
 		break;
 
@@ -232,15 +234,16 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
 	struct pci_filp_private *fpriv = file->private_data;
-	int i, ret, write_combine = 0, res_bit;
+	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-	if (fpriv->mmap_state == pci_mmap_io)
+	if (fpriv->mmap_state == pci_mmap_io) {
+		if (!arch_can_pci_mmap_io())
+			return -EINVAL;
 		res_bit = IORESOURCE_IO;
-	else
-		res_bit = IORESOURCE_MEM;
+	}
 
 	/* Make sure the caller is mapping a real resource for this device */
 	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e7bb4b62..590cfcf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1636,6 +1636,9 @@ int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
 #ifndef arch_can_pci_mmap_wc
 #define arch_can_pci_mmap_wc()		0
 #endif
+#ifndef arch_can_pci_mmap_io
+#define arch_can_pci_mmap_io()		0
+#endif
 
 #ifndef pci_root_bus_fwnode
 #define pci_root_bus_fwnode(bus)	NULL
-- 
2.9.3
