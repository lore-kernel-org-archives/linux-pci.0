Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47105 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753458AbdDLM0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2017 08:26:18 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/27] pci: Add arch_can_pci_mmap_wc() macro
Date: Wed, 12 Apr 2017 13:25:54 +0100
Message-Id: <8536a58aa86a634c8ac53c54499351b3981ef20a.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Most of the almost-identical versions of pci_mmap_page_range() silently
ignore the 'write_combine' argument and give uncached mappings.

Yet we allow the PCIIOC_WRITE_COMBINE ioctl in /proc/bus/pci, expose the
'resourceX_wc' file in sysfs, and allow an attempted mapping to apparently
succeed.

To fix this, introduce a macro arch_can_pci_mmap_wc() which indicates
whether the platform can do a write-combining mapping. On x86 this ends
up being pat_enabled(), while the few other platforms that support it
can just set it to a literal '1'.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/filesystems/sysfs-pci.txt |  4 ++++
 arch/ia64/include/asm/pci.h             |  2 ++
 arch/powerpc/include/asm/pci.h          |  5 +++--
 arch/x86/include/asm/pci.h              |  2 ++
 drivers/pci/pci-sysfs.c                 |  4 ++--
 drivers/pci/proc.c                      | 15 ++++++++-------
 include/linux/pci.h                     |  4 ++++
 7 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.txt
index 6ea1ced..25b7f1c 100644
--- a/Documentation/filesystems/sysfs-pci.txt
+++ b/Documentation/filesystems/sysfs-pci.txt
@@ -117,6 +117,10 @@ code must define HAVE_PCI_MMAP and provide a pci_mmap_page_range function.
 Platforms are free to only support subsets of the mmap functionality, but
 useful return codes should be provided.
 
+Platforms which support write-combining maps of PCI resources must define
+arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
+write-combining is permitted.
+
 Legacy resources are protected by the HAVE_PCI_LEGACY define.  Platforms
 wishing to support legacy functionality should define it and provide
 pci_legacy_read, pci_legacy_write and pci_mmap_legacy_page_range functions.
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index c0835b0..6283758 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -51,6 +51,8 @@ extern unsigned long ia64_max_iommu_merge_mask;
 #define PCI_DMA_BUS_IS_PHYS	(ia64_max_iommu_merge_mask == ~0UL)
 
 #define HAVE_PCI_MMAP
+#define arch_can_pci_mmap_wc()	1
+
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
 #define HAVE_PCI_LEGACY
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 93eded8..b5b68c6 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -81,8 +81,9 @@ struct vm_area_struct;
 int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine);
 
-/* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
-#define HAVE_PCI_MMAP	1
+/* Tell drivers/pci/proc.c that we have pci_mmap_page_range() and it does WC */
+#define HAVE_PCI_MMAP		1
+#define arch_can_pci_mmap_wc()	1
 
 extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
 			   size_t count);
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 1411dbe..f6e22c2 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <linux/scatterlist.h>
 #include <asm/io.h>
+#include <asm/pat.h>
 #include <asm/x86_init.h>
 
 #ifdef __KERNEL__
@@ -102,6 +103,7 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
 
 #define HAVE_PCI_MMAP
+#define arch_can_pci_mmap_wc()	pat_enabled()
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state,
 			       int write_combine);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7ac258f..7d494bd 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1211,9 +1211,9 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 
 		retval = pci_create_attr(pdev, i, 0);
 		/* for prefetchable resources, create a WC mappable file */
-		if (!retval && pdev->resource[i].flags & IORESOURCE_PREFETCH)
+		if (!retval && arch_can_pci_mmap_wc() &&
+		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
 			retval = pci_create_attr(pdev, i, 1);
-
 		if (retval) {
 			pci_remove_resource_files(pdev);
 			return retval;
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index dc8912e..a2aa58a 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -210,14 +210,15 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case PCIIOC_WRITE_COMBINE:
-		if (arg)
-			fpriv->write_combine = 1;
-		else
-			fpriv->write_combine = 0;
-		break;
-
+		if (arch_can_pci_mmap_wc()) {
+			if (arg)
+				fpriv->write_combine = 1;
+			else
+				fpriv->write_combine = 0;
+			break;
+		}
+		/* If arch decided it can't, fall through... */
 #endif /* HAVE_PCI_MMAP */
-
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..e614fb4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1626,6 +1626,10 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #include <asm/pci.h>
 
+#ifndef arch_can_pci_mmap_wc
+#define arch_can_pci_mmap_wc()		0
+#endif
+
 #ifndef pci_root_bus_fwnode
 #define pci_root_bus_fwnode(bus)	NULL
 #endif
-- 
2.9.3
