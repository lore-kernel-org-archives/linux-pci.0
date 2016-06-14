Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38507 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbcFNT7u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2016 15:59:50 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] nvme: remove the post_scan callout
Date: Tue, 14 Jun 2016 21:59:06 +0200
Message-Id: <1465934346-20648-14-git-send-email-hch@lst.de>
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No need now that we don't have to reverse engineer the irq affinity.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ---
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9d7cee4..b100cce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1627,9 +1627,6 @@ static void nvme_scan_work(struct work_struct *work)
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	mutex_unlock(&ctrl->namespaces_mutex);
 	kfree(id);
-
-	if (ctrl->ops->post_scan)
-		ctrl->ops->post_scan(ctrl);
 }
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 282421f..bb343b3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -150,7 +150,6 @@ struct nvme_ctrl_ops {
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
-	void (*post_scan)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
 };
 
-- 
2.1.4

