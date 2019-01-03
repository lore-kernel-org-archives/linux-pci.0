Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A1CC43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 22:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E2B21872
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 22:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfACWwv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:52:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:45205 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfACWwu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 17:52:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 14:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="307303389"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2019 14:52:49 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/4] nvme-pci: Distribute io queue types after creation
Date:   Thu,  3 Jan 2019 15:50:31 -0700
Message-Id: <20190103225033.11249-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190103225033.11249-1-keith.busch@intel.com>
References: <20190103225033.11249-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dev->io_queues types were set based on the results of the nvme set
feature "number of queues" and the IRQ allocation. This result does not
mean we're going to successfully allocate and create those IO queues,
though. A failure there will cause blk-mq to have NULL hctx's because the
map's nr_hw_queues accounts for more queues than were actually created.

Adjust the io_queue types after we've created them when we have less than
originally desired.

Fixes: 3b6592f70ad7b ("nvme: utilize two queue maps, one for reads and one for writes")
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98332d0a80f0..1481bb6d9c42 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1733,6 +1733,30 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	return result;
 }
 
+static void nvme_distribute_queues(struct nvme_dev *dev, unsigned int io_queues)
+{
+	unsigned int irq_queues, this_p_queues = dev->io_queues[HCTX_TYPE_POLL],
+		     this_w_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
+
+	if (!io_queues) {
+		dev->io_queues[HCTX_TYPE_POLL] = 0;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = 0;
+		dev->io_queues[HCTX_TYPE_READ] = 0;
+		return;
+	}
+
+	if (this_p_queues >= io_queues)
+		this_p_queues = io_queues - 1;
+	irq_queues = io_queues - this_p_queues;
+
+	if (this_w_queues > irq_queues)
+		this_w_queues = irq_queues;
+
+	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
+	dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
+	dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
+}
+
 static int nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i, max, rw_queues;
@@ -1761,6 +1785,13 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 			break;
 	}
 
+	/*
+	 * If we've created less than expected io queues, redistribute the
+	 * dev->io_queues[] types accordingly.
+	 */
+	if (dev->online_queues - 1 != dev->max_qid)
+		nvme_distribute_queues(dev, dev->online_queues - 1);
+
 	/*
 	 * Ignore failing Create SQ/CQ commands, we can continue with less
 	 * than the desired amount of queues, and even a controller without
@@ -2185,11 +2216,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	result = max(result - 1, 1);
 	dev->max_qid = result + dev->io_queues[HCTX_TYPE_POLL];
 
-	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
-					dev->io_queues[HCTX_TYPE_DEFAULT],
-					dev->io_queues[HCTX_TYPE_READ],
-					dev->io_queues[HCTX_TYPE_POLL]);
-
 	/*
 	 * Should investigate if there's a performance win from allocating
 	 * more queues than interrupt vectors; it might allow the submission
@@ -2203,7 +2229,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		return result;
 	}
 	set_bit(NVMEQ_ENABLED, &adminq->flags);
-	return nvme_create_io_queues(dev);
+	result = nvme_create_io_queues(dev);
+
+	if (!result)
+		dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
+					dev->io_queues[HCTX_TYPE_DEFAULT],
+					dev->io_queues[HCTX_TYPE_READ],
+					dev->io_queues[HCTX_TYPE_POLL]);
+	return result;
+
 }
 
 static void nvme_del_queue_end(struct request *req, blk_status_t error)
-- 
2.14.4

