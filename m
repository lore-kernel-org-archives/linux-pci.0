Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbdDLM0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2017 08:26:19 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/27] pci: Add I/O BAR support to generic pci_mmap_resource_range()
Date: Wed, 12 Apr 2017 13:26:08 +0100
Message-Id: <3218f933294a1a10e6e741fa05b714ff07bbac31.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

This will need to call into an arch-provided pci_iobar_pfn() function.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/pci/mmap.c  | 11 +++++++----
 include/linux/pci.h |  4 ++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index 9ba720b..16e1d70 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -45,9 +45,6 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 {
 	unsigned long size;
 
-	if (mmap_state == pci_mmap_io)
-		return -EINVAL;
-
 	size = ((pci_resource_len(pdev, bar) - 1) >> PAGE_SHIFT) + 1;
 	if (vma->vm_pgoff + vma_pages(vma) > size)
 		return -EINVAL;
@@ -57,7 +54,13 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 	else
 		vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
 
-	vma->vm_pgoff += (pci_resource_start(pdev, bar) >> PAGE_SHIFT);
+	if (mmap_state == pci_mmap_io) {
+		int ret = pci_iobar_pfn(pdev, bar, vma);
+		if (ret)
+			return ret;
+	} else
+		vma->vm_pgoff += (pci_resource_start(pdev, bar) >> PAGE_SHIFT);
+
         vma->vm_ops = &pci_phys_vm_ops;
 
 	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ff1c818..0d40ddd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1648,8 +1648,12 @@ int pci_mmap_page_range(struct pci_dev *pdev, int bar,
 #ifndef arch_can_pci_mmap_wc
 #define arch_can_pci_mmap_wc()		0
 #endif
+
 #ifndef arch_can_pci_mmap_io
 #define arch_can_pci_mmap_io()		0
+#define pci_iobar_pfn(pdev, bar, vma) (-EINVAL)
+#else
+int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
 #endif
 
 #ifndef pci_root_bus_fwnode
-- 
2.9.3
