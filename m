Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31532C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E667222B6
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393449AbfBMRzD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:55:03 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54540 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391418AbfBMRzD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:55:03 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykN-0001z8-5M; Wed, 13 Feb 2019 10:55:01 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykL-0001y3-4A; Wed, 13 Feb 2019 10:54:57 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 13 Feb 2019 10:54:44 -0700
Message-Id: <20190213175454.7506-3-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, bhelgaas@google.com, joro@8bytes.org, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 02/12] NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Presently, when ntb_transport is used with DMA and the IOMMU turned on,
it fails with errors from the IOMMU such as:

  DMAR: DRHD: handling fault status reg 202
  DMAR: [DMA Write] Request device [00:04.0] fault addr
	381fc0340000 [fault reason 05] PTE Write access is not set

This is because ntb_transport does not map the BAR space with the IOMMU.

To fix this, we map the entire MW region for each QP after we assign
the DMA channel. This prevents needing an extra DMA map in the fast
path.

Link: https://lore.kernel.org/linux-pci/499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com/
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 drivers/ntb/ntb_transport.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3bfdb4562408..526b65afc16a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -144,7 +144,9 @@ struct ntb_transport_qp {
 	struct list_head tx_free_q;
 	spinlock_t ntb_tx_free_q_lock;
 	void __iomem *tx_mw;
-	dma_addr_t tx_mw_phys;
+	phys_addr_t tx_mw_phys;
+	size_t tx_mw_size;
+	dma_addr_t tx_mw_dma_addr;
 	unsigned int tx_index;
 	unsigned int tx_max_entry;
 	unsigned int tx_max_frame;
@@ -1049,6 +1051,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	tx_size = (unsigned int)mw_size / num_qps_mw;
 	qp_offset = tx_size * (qp_num / mw_count);
 
+	qp->tx_mw_size = tx_size;
 	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
 	if (!qp->tx_mw)
 		return -EINVAL;
@@ -1644,7 +1647,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 	dma_cookie_t cookie;
 
 	device = chan->device;
-	dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;
+	dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index;
 	buff_off = (size_t)buf & ~PAGE_MASK;
 	dest_off = (size_t)dest & ~PAGE_MASK;
 
@@ -1863,6 +1866,18 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		qp->rx_dma_chan = NULL;
 	}
 
+	if (qp->tx_dma_chan) {
+		qp->tx_mw_dma_addr =
+			dma_map_resource(qp->tx_dma_chan->device->dev,
+					 qp->tx_mw_phys, qp->tx_mw_size,
+					 DMA_FROM_DEVICE, 0);
+		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
+				      qp->tx_mw_dma_addr)) {
+			qp->tx_mw_dma_addr = 0;
+			goto err1;
+		}
+	}
+
 	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
 		qp->tx_dma_chan ? "DMA" : "CPU");
 
@@ -1904,6 +1919,10 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->rx_alloc_entry = 0;
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
 		kfree(entry);
+	if (qp->tx_mw_dma_addr)
+		dma_unmap_resource(qp->tx_dma_chan->device->dev,
+				   qp->tx_mw_dma_addr, qp->tx_mw_size,
+				   DMA_FROM_DEVICE, 0);
 	if (qp->tx_dma_chan)
 		dma_release_channel(qp->tx_dma_chan);
 	if (qp->rx_dma_chan)
@@ -1945,6 +1964,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		 */
 		dma_sync_wait(chan, qp->last_cookie);
 		dmaengine_terminate_all(chan);
+
+		dma_unmap_resource(chan->device->dev,
+				   qp->tx_mw_dma_addr, qp->tx_mw_size,
+				   DMA_FROM_DEVICE, 0);
+
 		dma_release_channel(chan);
 	}
 
-- 
2.19.0

