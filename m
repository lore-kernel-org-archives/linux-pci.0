Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0474C64EB8
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 14:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FD92064E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 14:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYX2Pzfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FD92064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJIVZs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:25:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIVZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 17:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xni0Ddeou7at7YYz79rJyNr1VlzWja5Wc23QW93EOwI=; b=WYX2PzfiwoeFszzGmEqEZffWoo
        nJif30RoYKrIYejz+NGw/lx7MiKlVtbajh/zog0oEeenDCqsbMrkBUE9muxn1q9iWkX0v8gNY9Aey
        vZr8d4+geWfhwtuPdoUwn+zpyWnIWYNRGEbRDtEVN5jS4kCdUS4McL0Fk9nA0G8/6GKC7QlBG7qtA
        uZ3dwQNX0Er0anQgJrrv0cIhqy24a/35tV7HY6rOOl8THXRmWvCTKynSuMSI8ggIqwRa7AiCa50GX
        JOAWZBVivgS6LsuyvAxec5LSPow98BGMGArq3n5r1+GMagBk7bSbc2W55NNBls6402UMsZqWsNnHI
        H2GHFw3g==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9sgc-0006AL-Vk; Tue, 09 Oct 2018 14:08:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: remove pci_set_dma_seg_boundary
Date:   Tue,  9 Oct 2018 16:08:23 +0200
Message-Id: <20181009140824.18667-3-hch@lst.de>
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

The two callers can just use dma_set_seg_boundary directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/probe.c            | 2 +-
 drivers/s390/net/ism_drv.c     | 2 +-
 include/linux/pci-dma-compat.h | 9 ---------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 201f9e5ff55c..fc6340d76814 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2398,7 +2398,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.coherent_dma_mask = 0xffffffffull;
 
 	pci_set_dma_max_seg_size(dev, 65536);
-	pci_set_dma_seg_boundary(dev, 0xffffffff);
+	dma_set_seg_boundary(&dev->dev, 0xffffffff);
 
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c0631895154e..8688c0fff761 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -515,7 +515,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_unmap;
 
-	pci_set_dma_seg_boundary(pdev, SZ_1M - 1);
+	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
 	pci_set_dma_max_seg_size(pdev, SZ_1M);
 	pci_set_master(pdev);
 
diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
index c3f1b44ade29..558a109ab497 100644
--- a/include/linux/pci-dma-compat.h
+++ b/include/linux/pci-dma-compat.h
@@ -125,12 +125,6 @@ static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
 {
 	return dma_set_max_seg_size(&dev->dev, size);
 }
-
-static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
-					   unsigned long mask)
-{
-	return dma_set_seg_boundary(&dev->dev, mask);
-}
 #else
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 { return -EIO; }
@@ -139,9 +133,6 @@ static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
 					   unsigned int size)
 { return -EIO; }
-static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
-					   unsigned long mask)
-{ return -EIO; }
 #endif
 
 #endif
-- 
2.19.0

