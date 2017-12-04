Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56454 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754007AbdLDPJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 10:09:34 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/8] arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset
Date: Mon,  4 Dec 2017 16:09:01 +0100
Message-Id: <20171204150907.24345-3-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some devices may have a non-zero DMA offset, i.e an offset between the
DMA address and the physical address. Such an offset can be encoded
into the dma_pfn_offset field of "struct device", but the SuperH
implementation of the DMA mapping API does not observe this
information.

This commit fixes that by ensuring the DMA address is properly
calculated depending on this DMA offset.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/kernel/dma-nommu.c | 7 +++++--
 arch/sh/mm/consistent.c    | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 62b485107eae..178457d7620c 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -16,7 +16,8 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	dma_addr_t addr = page_to_phys(page) + offset;
+	dma_addr_t addr = page_to_phys(page) + offset
+		- PFN_PHYS(dev->dma_pfn_offset);
 
 	WARN_ON(size == 0);
 
@@ -36,12 +37,14 @@ static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 	WARN_ON(nents == 0 || sg[0].length == 0);
 
 	for_each_sg(sg, s, nents, i) {
+		dma_addr_t offset = PFN_PHYS(dev->dma_pfn_offset);
+
 		BUG_ON(!sg_page(s));
 
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 			sh_sync_dma_for_device(sg_virt(s), s->length, dir);
 
-		s->dma_address = sg_phys(s);
+		s->dma_address = sg_phys(s) - offset;
 		s->dma_length = s->length;
 	}
 
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 6ea3aab508f2..8ce98691d822 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -59,7 +59,7 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 
 	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
 
-	*dma_handle = virt_to_phys(ret);
+	*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
 
 	return ret_nocache;
 }
@@ -69,7 +69,7 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
 			       unsigned long attrs)
 {
 	int order = get_order(size);
-	unsigned long pfn = dma_handle >> PAGE_SHIFT;
+	unsigned long pfn = (dma_handle >> PAGE_SHIFT) + dev->dma_pfn_offset;
 	int k;
 
 	for (k = 0; k < (1 << order); k++)
-- 
2.13.6
