Return-Path: <BATV+ebca6d033c7666f223e0+4638+infradead.org+hch@bombadil.srs.infradead.org>
Return-Path: <BATV+ebca6d033c7666f223e0+4638+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: helgaas@kernel.org
Cc: agordeev@redhat.com,
	pjw@netapp.com,
	axboe@fb.com,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: switch to use pci_alloc_irq_vectors
Date: Thu,  5 May 2016 16:04:56 +0200
Message-Id: <1462457096-19795-3-git-send-email-hch@lst.de>
In-Reply-To: <1462457096-19795-1-git-send-email-hch@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 87 +++++++++++++------------------------------------
 1 file changed, 22 insertions(+), 65 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4fd733f..0219965 100644
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
@@ -1055,7 +1059,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
-	vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
+	vector = nvmeq_irq(nvmeq);
 	nvmeq->dev->online_queues--;
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1063,7 +1067,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q);
 
-	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
 	return 0;
@@ -1182,11 +1185,11 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
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
@@ -1463,7 +1466,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int result, i, vecs, nr_io_queues, size;
+	int result, nr_io_queues, size;
 
 	nr_io_queues = num_possible_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1506,29 +1509,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
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
+	nr_io_queues = pci_alloc_irq_vectors(pdev, nr_io_queues, 0);
+	if (nr_io_queues <= 0)
+		return -EIO;
+	dev->max_qid = nr_io_queues;
 
 	/*
 	 * Should investigate if there's a performance win from allocating
@@ -1536,8 +1527,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * path to scale better, even if the receive path is limited by the
 	 * number of interrupts.
 	 */
-	nr_io_queues = vecs;
-	dev->max_qid = nr_io_queues;
 
 	result = queue_request_irq(dev, adminq, adminq->irqname);
 	if (result) {
@@ -1551,22 +1540,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
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
@@ -1574,7 +1547,6 @@ static void nvme_dev_scan(struct work_struct *work)
 	if (!dev->tagset.tags)
 		return;
 	nvme_scan_namespaces(&dev->ctrl);
-	nvme_set_irq_hints(dev);
 }
 
 static void nvme_del_queue_end(struct request *req, int error)
@@ -1713,15 +1685,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
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
+	result = pci_alloc_irq_vectors(pdev, 1, 0);
+	if (result < 0)
+		return result;
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
@@ -1763,10 +1729,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	if (pdev->msi_enabled)
-		pci_disable_msi(pdev);
-	else if (pdev->msix_enabled)
-		pci_disable_msix(pdev);
+	pci_free_irq_vectors(pdev);
 
 	if (pci_is_enabled(pdev)) {
 		pci_disable_pcie_error_reporting(pdev);
@@ -1835,7 +1798,6 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
-	kfree(dev->entry);
 	kfree(dev);
 }
 
@@ -2010,10 +1972,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -2056,7 +2014,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dev_unmap(dev);
  free:
 	kfree(dev->queues);
-	kfree(dev->entry);
 	kfree(dev);
 	return result;
 }
-- 
2.1.4
