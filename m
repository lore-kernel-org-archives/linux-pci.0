Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DD4C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0A72184D
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 17:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfA2Rr5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfA2Rry (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 12:47:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7A34C079C49;
        Tue, 29 Jan 2019 17:47:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B23F35D97A;
        Tue, 29 Jan 2019 17:47:45 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 4/5] mm/hmm: add support for peer to peer to HMM device memory
Date:   Tue, 29 Jan 2019 12:47:27 -0500
Message-Id: <20190129174728.6430-5-jglisse@redhat.com>
In-Reply-To: <20190129174728.6430-1-jglisse@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 29 Jan 2019 17:47:53 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-pci@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org
---
 include/linux/hmm.h | 47 +++++++++++++++++++++++++++++++++
 mm/hmm.c            | 63 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 4a1454e3efba..7a3ac182cc48 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -710,6 +710,53 @@ struct hmm_devmem_ops {
 		     const struct page *page,
 		     unsigned int flags,
 		     pmd_t *pmdp);
+
+	/*
+	 * p2p_map() - map page for peer to peer between device
+	 * @devmem: device memory structure (see struct hmm_devmem)
+	 * @range: range of virtual address that is being mapped
+	 * @device: device the range is being map to
+	 * @addr: first virtual address in the range to consider
+	 * @pa: device address (where actual mapping is store)
+	 * Returns: number of page successfuly mapped, 0 otherwise
+	 *
+	 * Map page belonging to devmem to another device for peer to peer
+	 * access. Device can decide not to map in which case memory will
+	 * be migrated to main memory.
+	 *
+	 * Also there is no garantee that all the pages in the range does
+	 * belongs to the devmem so it is up to the function to check that
+	 * every single page does belong to devmem.
+	 *
+	 * Note for now we do not care about error exect error, so on failure
+	 * function should just return 0.
+	 */
+	long (*p2p_map)(struct hmm_devmem *devmem,
+			struct hmm_range *range,
+			struct device *device,
+			unsigned long addr,
+			dma_addr_t *pas);
+
+	/*
+	 * p2p_unmap() - unmap page from peer to peer between device
+	 * @devmem: device memory structure (see struct hmm_devmem)
+	 * @range: range of virtual address that is being mapped
+	 * @device: device the range is being map to
+	 * @addr: first virtual address in the range to consider
+	 * @pa: device address (where actual mapping is store)
+	 * Returns: number of page successfuly unmapped, 0 otherwise
+	 *
+	 * Unmap page belonging to devmem previously map with p2p_map().
+	 *
+	 * Note there is no garantee that all the pages in the range does
+	 * belongs to the devmem so it is up to the function to check that
+	 * every single page does belong to devmem.
+	 */
+	unsigned long (*p2p_unmap)(struct hmm_devmem *devmem,
+				   struct hmm_range *range,
+				   struct device *device,
+				   unsigned long addr,
+				   dma_addr_t *pas);
 };
 
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 1a444885404e..fd49b1e116d0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1193,16 +1193,19 @@ long hmm_range_dma_map(struct hmm_range *range,
 		       dma_addr_t *daddrs,
 		       bool block)
 {
-	unsigned long i, npages, mapped, page_size;
+	unsigned long i, npages, mapped, page_size, addr;
 	long ret;
 
+again:
 	ret = hmm_range_fault(range, block);
 	if (ret <= 0)
 		return ret ? ret : -EBUSY;
 
+	mapped = 0;
+	addr = range->start;
 	page_size = hmm_range_page_size(range);
 	npages = (range->end - range->start) >> range->page_shift;
-	for (i = 0, mapped = 0; i < npages; ++i) {
+	for (i = 0; i < npages; ++i, addr += page_size) {
 		enum dma_data_direction dir = DMA_FROM_DEVICE;
 		struct page *page;
 
@@ -1226,6 +1229,29 @@ long hmm_range_dma_map(struct hmm_range *range,
 			goto unmap;
 		}
 
+		if (is_device_private_page(page)) {
+			struct hmm_devmem *devmem = page->pgmap->data;
+
+			if (!devmem->ops->p2p_map || !devmem->ops->p2p_unmap) {
+				/* Fall-back to main memory. */
+				range->default_flags |=
+					range->flags[HMM_PFN_DEVICE_PRIVATE];
+				goto again;
+			}
+
+			ret = devmem->ops->p2p_map(devmem, range, device,
+						   addr, daddrs);
+			if (ret <= 0) {
+				/* Fall-back to main memory. */
+				range->default_flags |=
+					range->flags[HMM_PFN_DEVICE_PRIVATE];
+				goto again;
+			}
+			mapped += ret;
+			i += ret;
+			continue;
+		}
+
 		/* If it is read and write than map bi-directional. */
 		if (range->pfns[i] & range->values[HMM_PFN_WRITE])
 			dir = DMA_BIDIRECTIONAL;
@@ -1242,7 +1268,9 @@ long hmm_range_dma_map(struct hmm_range *range,
 	return mapped;
 
 unmap:
-	for (npages = i, i = 0; (i < npages) && mapped; ++i) {
+	npages = i;
+	addr = range->start;
+	for (i = 0; (i < npages) && mapped; ++i, addr += page_size) {
 		enum dma_data_direction dir = DMA_FROM_DEVICE;
 		struct page *page;
 
@@ -1253,6 +1281,18 @@ long hmm_range_dma_map(struct hmm_range *range,
 		if (dma_mapping_error(device, daddrs[i]))
 			continue;
 
+		if (is_device_private_page(page)) {
+			struct hmm_devmem *devmem = page->pgmap->data;
+			unsigned long inc;
+
+			inc = devmem->ops->p2p_unmap(devmem, range, device,
+						     addr, &daddrs[i]);
+			BUG_ON(inc > npages);
+			mapped += inc;
+			i += inc;
+			continue;
+		}
+
 		/* If it is read and write than map bi-directional. */
 		if (range->pfns[i] & range->values[HMM_PFN_WRITE])
 			dir = DMA_BIDIRECTIONAL;
@@ -1285,7 +1325,7 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 			 dma_addr_t *daddrs,
 			 bool dirty)
 {
-	unsigned long i, npages, page_size;
+	unsigned long i, npages, page_size, addr;
 	long cpages = 0;
 
 	/* Sanity check. */
@@ -1298,7 +1338,7 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 
 	page_size = hmm_range_page_size(range);
 	npages = (range->end - range->start) >> range->page_shift;
-	for (i = 0; i < npages; ++i) {
+	for (i = 0, addr = range->start; i < npages; ++i, addr += page_size) {
 		enum dma_data_direction dir = DMA_FROM_DEVICE;
 		struct page *page;
 
@@ -1318,6 +1358,19 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 				set_page_dirty(page);
 		}
 
+		if (is_device_private_page(page)) {
+			struct hmm_devmem *devmem = page->pgmap->data;
+			unsigned long ret;
+
+			BUG_ON(!devmem->ops->p2p_unmap);
+
+			ret = devmem->ops->p2p_unmap(devmem, range, device,
+						     addr, &daddrs[i]);
+			BUG_ON(ret > npages);
+			i += ret;
+			continue;
+		}
+
 		/* Unmap and clear pfns/dma address */
 		dma_unmap_page(device, daddrs[i], page_size, dir);
 		range->pfns[i] = range->values[HMM_PFN_NONE];
-- 
2.17.2

