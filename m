Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89291C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533C2218A3
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 17:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfA2Rrw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:47:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfA2Rrv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 12:47:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5443A7AE81;
        Tue, 29 Jan 2019 17:47:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D994D5D97E;
        Tue, 29 Jan 2019 17:47:47 +0000 (UTC)
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
Subject: [RFC PATCH 5/5] mm/hmm: add support for peer to peer to special device vma
Date:   Tue, 29 Jan 2019 12:47:28 -0500
Message-Id: <20190129174728.6430-6-jglisse@redhat.com>
In-Reply-To: <20190129174728.6430-1-jglisse@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Jan 2019 17:47:51 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Special device vma (mmap of a device file) can correspond to device
driver object that some device driver might want to share with other
device (giving access to). This add support for HMM to map those
special device vma if the owning device (exporter) allows it.

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
 include/linux/hmm.h |   6 ++
 mm/hmm.c            | 156 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 128 insertions(+), 34 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 7a3ac182cc48..98ebe9f52432 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -137,6 +137,7 @@ enum hmm_pfn_flag_e {
  *      result of vmf_insert_pfn() or vm_insert_page(). Therefore, it should not
  *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
  *      set and the pfn value is undefined.
+ * HMM_PFN_P2P: this entry have been map as P2P ie the dma address is valid
  *
  * Driver provide entry value for none entry, error entry and special entry,
  * driver can alias (ie use same value for error and special for instance). It
@@ -151,6 +152,7 @@ enum hmm_pfn_value_e {
 	HMM_PFN_ERROR,
 	HMM_PFN_NONE,
 	HMM_PFN_SPECIAL,
+	HMM_PFN_P2P,
 	HMM_PFN_VALUE_MAX
 };
 
@@ -250,6 +252,8 @@ static inline bool hmm_range_valid(struct hmm_range *range)
 static inline struct page *hmm_pfn_to_page(const struct hmm_range *range,
 					   uint64_t pfn)
 {
+	if (pfn == range->values[HMM_PFN_P2P])
+		return NULL;
 	if (pfn == range->values[HMM_PFN_NONE])
 		return NULL;
 	if (pfn == range->values[HMM_PFN_ERROR])
@@ -270,6 +274,8 @@ static inline struct page *hmm_pfn_to_page(const struct hmm_range *range,
 static inline unsigned long hmm_pfn_to_pfn(const struct hmm_range *range,
 					   uint64_t pfn)
 {
+	if (pfn == range->values[HMM_PFN_P2P])
+		return -1UL;
 	if (pfn == range->values[HMM_PFN_NONE])
 		return -1UL;
 	if (pfn == range->values[HMM_PFN_ERROR])
diff --git a/mm/hmm.c b/mm/hmm.c
index fd49b1e116d0..621a4f831483 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1058,37 +1058,36 @@ long hmm_range_snapshot(struct hmm_range *range)
 }
 EXPORT_SYMBOL(hmm_range_snapshot);
 
-/*
- * hmm_range_fault() - try to fault some address in a virtual address range
- * @range: range being faulted
- * @block: allow blocking on fault (if true it sleeps and do not drop mmap_sem)
- * Returns: 0 on success ortherwise:
- *      -EINVAL:
- *              Invalid argument
- *      -ENOMEM:
- *              Out of memory.
- *      -EPERM:
- *              Invalid permission (for instance asking for write and range
- *              is read only).
- *      -EAGAIN:
- *              If you need to retry and mmap_sem was drop. This can only
- *              happens if block argument is false.
- *      -EBUSY:
- *              If the the range is being invalidated and you should wait for
- *              invalidation to finish.
- *      -EFAULT:
- *              Invalid (ie either no valid vma or it is illegal to access that
- *              range), number of valid pages in range->pfns[] (from range start
- *              address).
- *
- * This is similar to a regular CPU page fault except that it will not trigger
- * any memory migration if the memory being faulted is not accessible by CPUs
- * and caller does not ask for migration.
- *
- * On error, for one virtual address in the range, the function will mark the
- * corresponding HMM pfn entry with an error flag.
- */
-long hmm_range_fault(struct hmm_range *range, bool block)
+static int hmm_vma_p2p_map(struct hmm_range *range, struct vm_area_struct *vma,
+			   unsigned long start, unsigned long end,
+			   struct device *device, dma_addr_t *pas)
+{
+	struct hmm_vma_walk hmm_vma_walk;
+	unsigned long npages, i;
+	bool fault, write;
+	uint64_t *pfns;
+	int ret;
+
+	i = (start - range->start) >> PAGE_SHIFT;
+	npages = (end - start) >> PAGE_SHIFT;
+	pfns = &range->pfns[i];
+	pas = &pas[i];
+
+	hmm_vma_walk.range = range;
+	hmm_vma_walk.fault = true;
+	hmm_range_need_fault(&hmm_vma_walk, pfns, npages,
+			        0, &fault, &write);
+
+	ret = vma->vm_ops->p2p_map(vma, device, start, end, pas, write);
+	for (i = 0; i < npages; ++i) {
+		pfns[i] = ret ? range->values[HMM_PFN_ERROR] :
+			  range->values[HMM_PFN_P2P];
+	}
+	return ret;
+}
+
+static long _hmm_range_fault(struct hmm_range *range, bool block,
+			     struct device *device, dma_addr_t *pas)
 {
 	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
 	unsigned long start = range->start, end;
@@ -1110,9 +1109,22 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 		}
 
 		vma = find_vma(hmm->mm, start);
-		if (vma == NULL || (vma->vm_flags & device_vma))
+		if (vma == NULL)
 			return -EFAULT;
 
+		end = min(range->end, vma->vm_end);
+		if (vma->vm_flags & device_vma) {
+			if (!device || !pas || !vma->vm_ops->p2p_map)
+				return -EFAULT;
+
+			ret = hmm_vma_p2p_map(range, vma, start,
+					      end, device, pas);
+			if (ret)
+				return ret;
+			start = end;
+			continue;
+		}
+
 		if (is_vm_hugetlb_page(vma)) {
 			struct hstate *h = hstate_vma(vma);
 
@@ -1142,7 +1154,6 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 		hmm_vma_walk.block = block;
 		hmm_vma_walk.range = range;
 		mm_walk.private = &hmm_vma_walk;
-		end = min(range->end, vma->vm_end);
 
 		mm_walk.vma = vma;
 		mm_walk.mm = vma->vm_mm;
@@ -1175,6 +1186,41 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 
 	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
+
+/*
+ * hmm_range_fault() - try to fault some address in a virtual address range
+ * @range: range being faulted
+ * @block: allow blocking on fault (if true it sleeps and do not drop mmap_sem)
+ * Returns: 0 on success ortherwise:
+ *      -EINVAL:
+ *              Invalid argument
+ *      -ENOMEM:
+ *              Out of memory.
+ *      -EPERM:
+ *              Invalid permission (for instance asking for write and range
+ *              is read only).
+ *      -EAGAIN:
+ *              If you need to retry and mmap_sem was drop. This can only
+ *              happens if block argument is false.
+ *      -EBUSY:
+ *              If the the range is being invalidated and you should wait for
+ *              invalidation to finish.
+ *      -EFAULT:
+ *              Invalid (ie either no valid vma or it is illegal to access that
+ *              range), number of valid pages in range->pfns[] (from range start
+ *              address).
+ *
+ * This is similar to a regular CPU page fault except that it will not trigger
+ * any memory migration if the memory being faulted is not accessible by CPUs
+ * and caller does not ask for migration.
+ *
+ * On error, for one virtual address in the range, the function will mark the
+ * corresponding HMM pfn entry with an error flag.
+ */
+long hmm_range_fault(struct hmm_range *range, bool block)
+{
+	return _hmm_range_fault(range, block, NULL, NULL);
+}
 EXPORT_SYMBOL(hmm_range_fault);
 
 /*
@@ -1197,7 +1243,7 @@ long hmm_range_dma_map(struct hmm_range *range,
 	long ret;
 
 again:
-	ret = hmm_range_fault(range, block);
+	ret = _hmm_range_fault(range, block, device, daddrs);
 	if (ret <= 0)
 		return ret ? ret : -EBUSY;
 
@@ -1209,6 +1255,11 @@ long hmm_range_dma_map(struct hmm_range *range,
 		enum dma_data_direction dir = DMA_FROM_DEVICE;
 		struct page *page;
 
+		if (range->pfns[i] == range->values[HMM_PFN_P2P]) {
+			mapped++;
+			continue;
+		}
+
 		/*
 		 * FIXME need to update DMA API to provide invalid DMA address
 		 * value instead of a function to test dma address value. This
@@ -1274,6 +1325,11 @@ long hmm_range_dma_map(struct hmm_range *range,
 		enum dma_data_direction dir = DMA_FROM_DEVICE;
 		struct page *page;
 
+		if (range->pfns[i] == range->values[HMM_PFN_P2P]) {
+			mapped--;
+			continue;
+		}
+
 		page = hmm_pfn_to_page(range, range->pfns[i]);
 		if (page == NULL)
 			continue;
@@ -1305,6 +1361,30 @@ long hmm_range_dma_map(struct hmm_range *range,
 }
 EXPORT_SYMBOL(hmm_range_dma_map);
 
+static unsigned long hmm_vma_p2p_unmap(struct hmm_range *range,
+				       struct vm_area_struct *vma,
+				       unsigned long start,
+				       struct device *device,
+				       dma_addr_t *pas)
+{
+	unsigned long end;
+
+	if (!vma) {
+		BUG();
+		return 1;
+	}
+
+	start &= PAGE_MASK;
+	if (start < vma->vm_start || start >= vma->vm_end) {
+		BUG();
+		return 1;
+	}
+
+	end = min(range->end, vma->vm_end);
+	vma->vm_ops->p2p_unmap(vma, device, start, end, pas);
+	return (end - start) >> PAGE_SHIFT;
+}
+
 /*
  * hmm_range_dma_unmap() - unmap range of that was map with hmm_range_dma_map()
  * @range: range being unmapped
@@ -1342,6 +1422,14 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 		enum dma_data_direction dir = DMA_FROM_DEVICE;
 		struct page *page;
 
+		if (range->pfns[i] == range->values[HMM_PFN_P2P]) {
+			BUG_ON(!vma);
+			cpages += hmm_vma_p2p_unmap(range, vma, addr,
+						    device, &daddrs[i]);
+			i += cpages - 1;
+			continue;
+		}
+
 		page = hmm_pfn_to_page(range, range->pfns[i]);
 		if (page == NULL)
 			continue;
-- 
2.17.2

