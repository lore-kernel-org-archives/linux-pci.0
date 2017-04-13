Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] nvme/pci: switch to pci_request_irq
Date: Thu, 13 Apr 2017 09:06:43 +0200
Message-Id: <20170413070643.32165-5-hch@lst.de>
In-Reply-To: <20170413070643.32165-1-hch@lst.de>
References: <20170413070643.32165-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd05fe88..925997127a6b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -117,7 +117,6 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 struct nvme_queue {
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
-	char irqname[24];	/* nvme4294967295-65535\0 */
 	spinlock_t q_lock;
 	struct nvme_command *sq_cmds;
 	struct nvme_command __iomem *sq_cmds_io;
@@ -204,11 +203,6 @@ static unsigned int nvme_cmd_size(struct nvme_dev *dev)
 		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
 }
 
-static int nvmeq_irq(struct nvme_queue *nvmeq)
-{
-	return pci_irq_vector(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector);
-}
-
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -962,7 +956,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
-	vector = nvmeq_irq(nvmeq);
+	vector = nvmeq->cq_vector;
 	nvmeq->dev->online_queues--;
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -970,7 +964,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q);
 
-	free_irq(vector, nvmeq);
+	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
 
 	return 0;
 }
@@ -1055,8 +1049,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
-	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
-			dev->ctrl.instance, qid);
 	spin_lock_init(&nvmeq->q_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
@@ -1079,12 +1071,16 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 
 static int queue_request_irq(struct nvme_queue *nvmeq)
 {
-	if (use_threaded_interrupts)
-		return request_threaded_irq(nvmeq_irq(nvmeq), nvme_irq_check,
-				nvme_irq, IRQF_SHARED, nvmeq->irqname, nvmeq);
-	else
-		return request_irq(nvmeq_irq(nvmeq), nvme_irq, IRQF_SHARED,
-				nvmeq->irqname, nvmeq);
+	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
+	int nr = nvmeq->dev->ctrl.instance;
+
+	if (use_threaded_interrupts) {
+		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
+				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+	} else {
+		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
+				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+	}
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -1440,7 +1436,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	}
 
 	/* Deregister the admin queue's interrupt */
-	free_irq(pci_irq_vector(pdev, 0), adminq);
+	pci_free_irq(pdev, 0, adminq);
 
 	/*
 	 * If we enable msix early due to not intx, disable it again before
-- 
2.11.0
