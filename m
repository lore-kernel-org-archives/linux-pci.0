Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F024C64EAD
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 14:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA6B2064E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 14:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NcPc1y6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA6B2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJIVZo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:25:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIVZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 17:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m+bR1rsVrnkqWOIPOQyUq+kFbq6Dp4R28e003NWU9Is=; b=NcPc1y6sBh/KqfA0po7C6nRccs
        PqhZTfd7cDjnw5LjiBPDFXODTfaYyqXZQ7aADxnCyBRAL78oupGi50Xecs/Y6mu6XgcL/T+4NsaGz
        LkgRjJWDBZ1bRuyXkgVeXkRL77jinRjjFUN+UmLRkIDQvPl9ZiLf8l14dnZJiqCvedO8VgQ9mudyF
        mP2VdXP9zxFGli9dgcSoETo7dU2JWOUI1SbcUPmUuXwjLsOIC6wmcg0CqsIlKRAtdXOT1ns1FZfHi
        I5AdzpWlCrf9y71QXYJ9zFZfvkL5hNf1IoFnYVvo8DZ9A/tPbmbElkvSLmEsEHh25+XBlE1PFcfxH
        swgeOqWg==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9sgZ-00069B-UJ; Tue, 09 Oct 2018 14:08:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: remove DMA unmap wrappers
Date:   Tue,  9 Oct 2018 16:08:22 +0200
Message-Id: <20181009140824.18667-2-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009140824.18667-1-hch@lst.de>
References: <20181009140824.18667-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only some of these were still used by the cxgb4 driver, and that despite
the fact that the driver otherwise uses the generic DMA API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/hw/cxgb4/qp.c | 10 +++++-----
 drivers/infiniband/hw/cxgb4/t4.h |  2 +-
 include/linux/pci-dma.h          | 12 ------------
 include/linux/pci.h              |  1 -
 4 files changed, 6 insertions(+), 19 deletions(-)
 delete mode 100644 include/linux/pci-dma.h

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 347fe18b1a41..62d6f197ec0b 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -99,7 +99,7 @@ static void dealloc_oc_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
 static void dealloc_host_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
 {
 	dma_free_coherent(&(rdev->lldi.pdev->dev), sq->memsize, sq->queue,
-			  pci_unmap_addr(sq, mapping));
+			  dma_unmap_addr(sq, mapping));
 }
 
 static void dealloc_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
@@ -132,7 +132,7 @@ static int alloc_host_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
 	if (!sq->queue)
 		return -ENOMEM;
 	sq->phys_addr = virt_to_phys(sq->queue);
-	pci_unmap_addr_set(sq, mapping, sq->dma_addr);
+	dma_unmap_addr_set(sq, mapping, sq->dma_addr);
 	return 0;
 }
 
@@ -2521,7 +2521,7 @@ static void free_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
 
 	dma_free_coherent(&rdev->lldi.pdev->dev,
 			  wq->memsize, wq->queue,
-			pci_unmap_addr(wq, mapping));
+			dma_unmap_addr(wq, mapping));
 	c4iw_rqtpool_free(rdev, wq->rqt_hwaddr, wq->rqt_size);
 	kfree(wq->sw_rq);
 	c4iw_put_qpid(rdev, wq->qid, uctx);
@@ -2570,7 +2570,7 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
 		goto err_free_rqtpool;
 
 	memset(wq->queue, 0, wq->memsize);
-	pci_unmap_addr_set(wq, mapping, wq->dma_addr);
+	dma_unmap_addr_set(wq, mapping, wq->dma_addr);
 
 	wq->bar2_va = c4iw_bar2_addrs(rdev, wq->qid, T4_BAR2_QTYPE_EGRESS,
 				      &wq->bar2_qid,
@@ -2649,7 +2649,7 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
 err_free_queue:
 	dma_free_coherent(&rdev->lldi.pdev->dev,
 			  wq->memsize, wq->queue,
-			pci_unmap_addr(wq, mapping));
+			dma_unmap_addr(wq, mapping));
 err_free_rqtpool:
 	c4iw_rqtpool_free(rdev, wq->rqt_hwaddr, wq->rqt_size);
 err_free_pending_wrs:
diff --git a/drivers/infiniband/hw/cxgb4/t4.h b/drivers/infiniband/hw/cxgb4/t4.h
index e42021fd6fd6..fff6d48d262f 100644
--- a/drivers/infiniband/hw/cxgb4/t4.h
+++ b/drivers/infiniband/hw/cxgb4/t4.h
@@ -397,7 +397,7 @@ struct t4_srq_pending_wr {
 struct t4_srq {
 	union t4_recv_wr *queue;
 	dma_addr_t dma_addr;
-	DECLARE_PCI_UNMAP_ADDR(mapping);
+	DEFINE_DMA_UNMAP_ADDR(mapping);
 	struct t4_swrqe *sw_rq;
 	void __iomem *bar2_va;
 	u64 bar2_pa;
diff --git a/include/linux/pci-dma.h b/include/linux/pci-dma.h
deleted file mode 100644
index 0f7aa7353ca3..000000000000
--- a/include/linux/pci-dma.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PCI_DMA_H
-#define _LINUX_PCI_DMA_H
-
-#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME) DEFINE_DMA_UNMAP_ADDR(ADDR_NAME);
-#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)   DEFINE_DMA_UNMAP_LEN(LEN_NAME);
-#define pci_unmap_addr             dma_unmap_addr
-#define pci_unmap_addr_set         dma_unmap_addr_set
-#define pci_unmap_len              dma_unmap_len
-#define pci_unmap_len_set          dma_unmap_len_set
-
-#endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828f9f25..e938e80e59c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1342,7 +1342,6 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
-#include <linux/pci-dma.h>
 #include <linux/dmapool.h>
 
 #define	pci_pool dma_pool
-- 
2.19.0

