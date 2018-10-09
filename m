Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92C7C64EB8
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9E42064E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 14:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/7TqKDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9E42064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJIVZv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:25:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIVZv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 17:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WKgIT9tymBbrhzG3gP1OCRQx4U/R/XsE3ss4+r4qnTk=; b=s/7TqKDmN0OP/a9ZRyZjLXPE7m
        2UsCVKF/9YzF2m6+/y1QRozHW1tkjM0J95p67fS/UTQYAgkPuiR3HAjmxQ8SFPIaLvvJs1MlW4ErQ
        S6lb4lRcpHPsc5eCH6mGTxQnuJR2ldLqltxlc7MQ9oULDhnFC13tTmEo3uHicNHsawdAQbxMo/cvx
        ycKzpkRarUq4IJ/P2CfTQCMM8+J5j+wJoQS8Kh8wTIvcvucHMIzuKWmRhRTBpjyoD1z2lw+ty+9vI
        uaPv3WXGyrnEL6bNzGXypOp4KjsEQk1sSqhWsWFl1gDbgGCOuN9JEfnmBE62CQEjGgySlli9V06vN
        dEhq0clA==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9sgg-0006Bf-1M; Tue, 09 Oct 2018 14:08:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: remove pci_set_dma_max_seg_size
Date:   Tue,  9 Oct 2018 16:08:24 +0200
Message-Id: <20181009140824.18667-4-hch@lst.de>
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

The few callers can just use dma_set_max_seg_size directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/sata_inic162x.c    | 2 +-
 drivers/block/rsxx/core.c      | 2 +-
 drivers/pci/probe.c            | 2 +-
 drivers/s390/net/ism_drv.c     | 2 +-
 drivers/scsi/aacraid/linit.c   | 2 +-
 include/linux/pci-dma-compat.h | 9 ---------
 6 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 9b6d7930d1c7..e0bcf9b2dab0 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -873,7 +873,7 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * like others but it will lock up the whole machine HARD if
 	 * 65536 byte PRD entry is fed. Reduce maximum segment size.
 	 */
-	rc = pci_set_dma_max_seg_size(pdev, 65536 - 512);
+	rc = dma_set_max_seg_size(&pdev->dev, 65536 - 512);
 	if (rc) {
 		dev_err(&pdev->dev, "failed to set the maximum segment size\n");
 		return rc;
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index f2c631ce793c..37df486c7c3c 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -780,7 +780,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 		goto failed_enable;
 
 	pci_set_master(dev);
-	pci_set_dma_max_seg_size(dev, RSXX_HW_BLK_SIZE);
+	dma_set_max_seg_size(&dev->dev, RSXX_HW_BLK_SIZE);
 
 	st = pci_set_dma_mask(dev, DMA_BIT_MASK(64));
 	if (st) {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fc6340d76814..f97513b3d030 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2397,7 +2397,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
 
-	pci_set_dma_max_seg_size(dev, 65536);
+	dma_set_max_seg_size(&dev->dev, 65536);
 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
 
 	/* Fix up broken headers */
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 8688c0fff761..f96ec68af2e5 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -516,7 +516,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_unmap;
 
 	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
-	pci_set_dma_max_seg_size(pdev, SZ_1M);
+	dma_set_max_seg_size(&pdev->dev, SZ_1M);
 	pci_set_master(pdev);
 
 	ism->smcd = smcd_alloc_dev(&pdev->dev, dev_name(&pdev->dev), &ism_ops,
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 04443577d48b..53eb2e9569b9 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1747,7 +1747,7 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		shost->max_sectors = (shost->sg_tablesize * 8) + 112;
 	}
 
-	error = pci_set_dma_max_seg_size(pdev,
+	error = dma_set_max_seg_size(&pdev->dev,
 		(aac->adapter_info.options & AAC_OPT_NEW_COMM) ?
 			(shost->max_sectors << 9) : 65536);
 	if (error)
diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
index 558a109ab497..cb1adf0b78a9 100644
--- a/include/linux/pci-dma-compat.h
+++ b/include/linux/pci-dma-compat.h
@@ -119,20 +119,11 @@ static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 {
 	return dma_set_coherent_mask(&dev->dev, mask);
 }
-
-static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
-					   unsigned int size)
-{
-	return dma_set_max_seg_size(&dev->dev, size);
-}
 #else
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 { return -EIO; }
 static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 { return -EIO; }
-static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
-					   unsigned int size)
-{ return -EIO; }
 #endif
 
 #endif
-- 
2.19.0

