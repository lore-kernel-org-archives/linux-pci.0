Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] pci: Add HAVE_PCI_MMAP_IO to architectures which can mmap() I/O space
Date: Wed, 22 Mar 2017 13:25:20 +0000
Message-Id: <42237243c5aa180dd305769d06079d5842aeb32a.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
References: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

This is relatively esoteric, and knowing that we don't have it makes
life easier in some cases rather than just an eventual -EINVAL from
pci_mmap_page_range().

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/microblaze/include/asm/pci.h |  3 ++-
 arch/powerpc/include/asm/pci.h    |  1 +
 arch/sparc/include/asm/pci_64.h   |  1 +
 arch/xtensa/include/asm/pci.h     |  1 +
 drivers/pci/pci-sysfs.c           | 14 +++++++++-----
 drivers/pci/proc.c                | 10 ++++++++--
 6 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index ab381d2..41f5986 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -48,7 +48,8 @@ extern int pci_proc_domain(struct pci_bus *bus);
 struct vm_area_struct;
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
-#define HAVE_PCI_MMAP	1
+#define HAVE_PCI_MMAP		1
+#define HAVE_PCI_MMAP_IO	1
 
 extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
 			   size_t count);
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 55887d1..849a7dd 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -80,6 +80,7 @@ struct vm_area_struct;
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() and it does WC */
 #define HAVE_PCI_MMAP		1
+#define HAVE_PCI_MMAP_IO	1
 #define arch_can_pci_mmap_wc()	1
 
 extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 516fda7..4fe2f05 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -42,6 +42,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
 #define HAVE_PCI_MMAP
+#define HAVE_PCI_MMAP_IO
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
 
diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index e594eee..e4c1b43e 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -48,6 +48,7 @@ struct pci_dev;
 
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP		1
+#define HAVE_PCI_MMAP_IO	1
 
 /* This was wrapped in #if 0 since the first merge of xtensa support...
 #define arch_can_pci_mmap_wc()	1
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index cf2c7d8..07cb2fc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1174,11 +1174,15 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
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
+#ifdef HAVE_PCI_MMAP_IO
+			res_attr->mmap = pci_mmap_resource_uc;
+#endif
+		} else {
+			res_attr->mmap = pci_mmap_resource_uc;
+		}
 	}
 	res_attr->attr.name = res_attr_name;
 	res_attr->attr.mode = S_IRUSR | S_IWUSR;
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index c49be71..f387231 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -200,11 +200,12 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 		ret = pci_domain_nr(dev->bus);
 		break;
 
-#ifdef HAVE_PCI_MMAP
+#ifdef HAVE_PCI_MMAP_IO
 	case PCIIOC_MMAP_IS_IO:
 		fpriv->mmap_state = pci_mmap_io;
 		break;
-
+#endif
+#ifdef HAVE_PCI_MMAP
 	case PCIIOC_MMAP_IS_MEM:
 		fpriv->mmap_state = pci_mmap_mem;
 		break;
@@ -239,6 +240,11 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
+#ifndef HAVE_PCI_MMAP_IO
+	if (fpriv->mmap_state == pci_mmap_io)
+		return -EINVAL;
+#endif
+
 	if (fpriv->mmap_state == pci_mmap_io)
 		res_bit = IORESOURCE_IO;
 	else
-- 
2.9.3
