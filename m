Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48886 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbcDPBf6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2016 21:35:58 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] nvme: switch to use pci_alloc_irq_vectors
Date: Fri, 15 Apr 2016 18:35:52 -0700
Message-Id: <1460770552-31260-9-git-send-email-hch@lst.de>
In-Reply-To: <1460770552-31260-1-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 88 +++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 65 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ff3c8d7..82730bf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -89,7 +89,6 @@ struct nvme_dev {
 	unsigned max_qid;
 	int q_depth;
 	u32 db_stride;
-	struct msix_entry *entry;
 	void __iomem *bar;
 	struct work_struct reset_work;
 	struct work_struct scan_work;
@@ -209,6 +208,11 @@ static unsigned int nvme_cmd_size(struct nvme_dev *dev)
 		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
 }
 
+static int nvmeq_irq(struct nvme_queue *nvmeq)
+{
+	return to_pci_dev(nvmeq->dev->dev)->irqs[nvmeq->cq_vector];
+}
+
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -1016,7 +1020,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
-	vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
+	vector = nvmeq_irq(nvmeq);
 	nvmeq->dev->online_queues--;
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1024,7 +1028,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q);
 
-	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
 	return 0;
@@ -1135,11 +1138,11 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 							const char *name)
 {
 	if (use_threaded_interrupts)
-		return request_threaded_irq(dev->entry[nvmeq->cq_vector].vector,
-					nvme_irq_check, nvme_irq, IRQF_SHARED,
-					name, nvmeq);
-	return request_irq(dev->entry[nvmeq->cq_vector].vector, nvme_irq,
-				IRQF_SHARED, name, nvmeq);
+		return request_threaded_irq(nvmeq_irq(nvmeq), nvme_irq_check,
+				nvme_irq, IRQF_SHARED, name, nvmeq);
+	else
+		return request_irq(nvmeq_irq(nvmeq), nvme_irq, IRQF_SHARED,
+				name, nvmeq);
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -1438,7 +1441,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int result, i, vecs, nr_io_queues, size;
+	int result, nr_io_queues, size;
 
 	nr_io_queues = num_possible_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1481,29 +1484,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	}
 
 	/* Deregister the admin queue's interrupt */
-	free_irq(dev->entry[0].vector, adminq);
+	free_irq(pdev->irqs[0], adminq);
 
 	/*
 	 * If we enable msix early due to not intx, disable it again before
 	 * setting up the full range we need.
 	 */
-	if (pdev->msi_enabled)
-		pci_disable_msi(pdev);
-	else if (pdev->msix_enabled)
-		pci_disable_msix(pdev);
-
-	for (i = 0; i < nr_io_queues; i++)
-		dev->entry[i].entry = i;
-	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues);
-	if (vecs < 0) {
-		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues, 32));
-		if (vecs < 0) {
-			vecs = 1;
-		} else {
-			for (i = 0; i < vecs; i++)
-				dev->entry[i].vector = i + pdev->irq;
-		}
-	}
+	pci_free_irq_vectors(pdev);
+	nr_io_queues = pci_alloc_irq_vectors(pdev, nr_io_queues);
+	if (nr_io_queues <= 0)
+		return -EIO;
+	dev->max_qid = nr_io_queues;
 
 	/*
 	 * Should investigate if there's a performance win from allocating
@@ -1511,8 +1502,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * path to scale better, even if the receive path is limited by the
 	 * number of interrupts.
 	 */
-	nr_io_queues = vecs;
-	dev->max_qid = nr_io_queues;
 
 	result = queue_request_irq(dev, adminq, adminq->irqname);
 	if (result) {
@@ -1526,22 +1515,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
-static void nvme_set_irq_hints(struct nvme_dev *dev)
-{
-	struct nvme_queue *nvmeq;
-	int i;
-
-	for (i = 0; i < dev->online_queues; i++) {
-		nvmeq = dev->queues[i];
-
-		if (!nvmeq->tags || !(*nvmeq->tags))
-			continue;
-
-		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
-					blk_mq_tags_cpumask(*nvmeq->tags));
-	}
-}
-
 static void nvme_dev_scan(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work);
@@ -1549,7 +1522,6 @@ static void nvme_dev_scan(struct work_struct *work)
 	if (!dev->tagset.tags)
 		return;
 	nvme_scan_namespaces(&dev->ctrl);
-	nvme_set_irq_hints(dev);
 }
 
 static void nvme_del_queue_end(struct request *req, int error)
@@ -1654,6 +1626,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.cmd_size = nvme_cmd_size(dev);
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
+		dev->tagset.affinity_mask = dev->dev->irq_affinity;
 
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
@@ -1694,15 +1667,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
 	 * adjust this later.
 	 */
-	if (pci_enable_msix(pdev, dev->entry, 1)) {
-		pci_enable_msi(pdev);
-		dev->entry[0].vector = pdev->irq;
-	}
-
-	if (!dev->entry[0].vector) {
-		result = -ENODEV;
-		goto disable;
-	}
+	result = pci_alloc_irq_vectors(pdev, 1);
+	if (result < 0)
+		return result;
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
@@ -1744,10 +1711,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	if (pdev->msi_enabled)
-		pci_disable_msi(pdev);
-	else if (pdev->msix_enabled)
-		pci_disable_msix(pdev);
+	pci_free_irq_vectors(pdev);
 
 	if (pci_is_enabled(pdev)) {
 		pci_disable_pcie_error_reporting(pdev);
@@ -1816,7 +1780,6 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
-	kfree(dev->entry);
 	kfree(dev);
 }
 
@@ -1996,10 +1959,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return -ENOMEM;
-	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev->entry),
-							GFP_KERNEL, node);
-	if (!dev->entry)
-		goto free;
 	dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void *),
 							GFP_KERNEL, node);
 	if (!dev->queues)
@@ -2042,7 +2001,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dev_unmap(dev);
  free:
 	kfree(dev->queues);
-	kfree(dev->entry);
 	kfree(dev);
 	return result;
 }
-- 
2.1.4

