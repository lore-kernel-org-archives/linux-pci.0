Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B2C43444
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 21:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C5C2070C
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 21:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfACVLs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:11:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:39360 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfACVLs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 16:11:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 13:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="103738168"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2019 13:11:47 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/4] nvme-pci: Use PCI to handle IRQ reduce and retry
Date:   Thu,  3 Jan 2019 14:09:54 -0700
Message-Id: <20190103210954.11129-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190103210954.11129-1-keith.busch@intel.com>
References: <20190103210954.11129-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Restore the previous error handling for vector allocation to the PCI core.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 77 ++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 56 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1481bb6d9c42..f3ef09a8e8f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2059,37 +2059,43 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
-static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
+static void nvme_calc_io_queues(struct irq_affinity *affd, unsigned int nvecs)
 {
+	struct nvme_dev *dev = affd->priv;
 	unsigned int this_w_queues = write_queues;
 
 	/*
 	 * Setup read/write queue split
 	 */
-	if (irq_queues == 1) {
+	if (nvecs == 1) {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
-		return;
+		goto set_sets;
 	}
 
 	/*
 	 * If 'write_queues' is set, ensure it leaves room for at least
 	 * one read queue
 	 */
-	if (this_w_queues >= irq_queues)
-		this_w_queues = irq_queues - 1;
+	if (this_w_queues >= nvecs - 1)
+		this_w_queues = nvecs - 1;
 
 	/*
 	 * If 'write_queues' is set to zero, reads and writes will share
 	 * a queue set.
 	 */
 	if (!this_w_queues) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = nvecs - 1;
 		dev->io_queues[HCTX_TYPE_READ] = 0;
 	} else {
 		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
-		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
+		dev->io_queues[HCTX_TYPE_READ] = nvecs - this_w_queues - 1;
 	}
+set_sets:
+	affd->sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
+	affd->sets[1] = dev->io_queues[HCTX_TYPE_READ];
+	if (!affd->sets[1])
+		affd->nr_sets = 1;
 }
 
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
@@ -2100,9 +2106,10 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.pre_vectors = 1,
 		.nr_sets = ARRAY_SIZE(irq_sets),
 		.sets = irq_sets,
+		.recalc_sets = nvme_calc_io_queues,
+		.priv = dev,
 	};
-	int result = 0;
-	unsigned int irq_queues, this_p_queues;
+	unsigned int nvecs, this_p_queues;
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one IO
@@ -2111,56 +2118,14 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	this_p_queues = poll_queues;
 	if (this_p_queues >= nr_io_queues) {
 		this_p_queues = nr_io_queues - 1;
-		irq_queues = 1;
+		nvecs = 2;
 	} else {
-		irq_queues = nr_io_queues - this_p_queues;
+		nvecs = nr_io_queues - this_p_queues + 1;
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
-
-	/*
-	 * For irq sets, we have to ask for minvec == maxvec. This passes
-	 * any reduction back to us, so we can adjust our queue counts and
-	 * IRQ vector needs.
-	 */
-	do {
-		nvme_calc_io_queues(dev, irq_queues);
-		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
-		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
-		if (!irq_sets[1])
-			affd.nr_sets = 1;
-
-		/*
-		 * If we got a failure and we're down to asking for just
-		 * 1 + 1 queues, just ask for a single vector. We'll share
-		 * that between the single IO queue and the admin queue.
-		 */
-		if (result >= 0 && irq_queues > 1)
-			irq_queues = irq_sets[0] + irq_sets[1] + 1;
-
-		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
-				irq_queues,
-				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
-
-		/*
-		 * Need to reduce our vec counts. If we get ENOSPC, the
-		 * platform should support mulitple vecs, we just need
-		 * to decrease our ask. If we get EINVAL, the platform
-		 * likely does not. Back down to ask for just one vector.
-		 */
-		if (result == -ENOSPC) {
-			irq_queues--;
-			if (!irq_queues)
-				return result;
-			continue;
-		} else if (result == -EINVAL) {
-			irq_queues = 1;
-			continue;
-		} else if (result <= 0)
-			return -EIO;
-		break;
-	} while (1);
-
-	return result;
+	nvme_calc_io_queues(&affd, nvecs);
+	return pci_alloc_irq_vectors_affinity(pdev, affd.pre_vectors, nvecs,
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
-- 
2.14.4

