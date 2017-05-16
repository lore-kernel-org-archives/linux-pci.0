Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36734 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdEPFWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2017 01:22:45 -0400
Received: by mail-wm0-f47.google.com with SMTP id u65so107985600wmu.1
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 22:22:40 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.pawandeep@gmail.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH v6 2/3] iommu/pci: reserve IOVA for PCI masters
Date: Tue, 16 May 2017 10:52:06 +0530
Message-Id: <1494912127-12890-3-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

this patch reserves the IOVA for PCI masters.
ARM64 based SOCs may have scattered memory banks.
such as iproc based SOC has

<0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
<0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
<0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
<0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */

but incoming PCI transcation addressing capability is limited
by host bridge, for example if max incoming window capability
is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.

to address this problem, iommu has to avoid allocating IOVA which
are reserved. which inturn does not allocate IOVA if it falls into hole.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 48d36ce..08764b0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -27,6 +27,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -171,8 +172,12 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct device_node *np = bridge->dev.parent->of_node;
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	int ret;
+	dma_addr_t tmp_dma_addr = 0, dma_addr;
+	LIST_HEAD(res);
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM &&
@@ -183,6 +188,36 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* PCI inbound memory reservation. */
+	ret = of_pci_get_dma_ranges(np, &res);
+	if (!ret) {
+		resource_list_for_each_entry(window, &res) {
+			struct resource *res_dma = window->res;
+
+			dma_addr = res_dma->start - window->offset;
+			if (tmp_dma_addr > dma_addr) {
+				pr_warn("PCI: failed to reserve iovas; ranges should be sorted\n");
+				return;
+			}
+			if (tmp_dma_addr != dma_addr) {
+				lo = iova_pfn(iovad, tmp_dma_addr);
+				hi = iova_pfn(iovad, dma_addr - 1);
+				reserve_iova(iovad, lo, hi);
+			}
+			tmp_dma_addr = window->res->end - window->offset;
+		}
+		/*
+		 * the last dma-range should honour based on the
+		 * 32/64-bit dma addresses.
+		 */
+		if (tmp_dma_addr < DMA_BIT_MASK(sizeof(dma_addr_t) * 8)) {
+			lo = iova_pfn(iovad, tmp_dma_addr);
+			hi = iova_pfn(iovad,
+				      DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1);
+			reserve_iova(iovad, lo, hi);
+		}
+	}
 }
 
 /**
-- 
1.9.1
