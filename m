Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:55966 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965316AbbFJOJQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2015 10:09:16 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v4 14/19] NTB: Use NUMA memory and DMA chan in transport
Date: Wed, 10 Jun 2015 05:08:19 -0400
Message-Id: <71dc91735cc89d01d4b5298556da0c8b5f9d0173.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allocate memory and request the DMA channel for the same NUMA node as
the NTB device.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 46 +++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8ce0bf67ac20..dc14ec81c43e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -346,6 +346,7 @@ int ntb_transport_register_client_dev(char *device_name)
 {
 	struct ntb_transport_client_dev *client_dev;
 	struct ntb_transport_ctx *nt;
+	int node;
 	int rc, i = 0;
 
 	if (list_empty(&ntb_transport_list))
@@ -354,8 +355,10 @@ int ntb_transport_register_client_dev(char *device_name)
 	list_for_each_entry(nt, &ntb_transport_list, entry) {
 		struct device *dev;
 
-		client_dev = kzalloc(sizeof(*client_dev),
-				     GFP_KERNEL);
+		node = dev_to_node(&nt->ndev->dev);
+
+		client_dev = kzalloc_node(sizeof(*client_dev),
+					  GFP_KERNEL, node);
 		if (!client_dev) {
 			rc = -ENOMEM;
 			goto err;
@@ -953,6 +956,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	struct ntb_transport_mw *mw;
 	unsigned int mw_count, qp_count;
 	u64 qp_bitmap;
+	int node;
 	int rc, i;
 
 	if (ntb_db_is_unsafe(ndev))
@@ -962,7 +966,9 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		dev_dbg(&ndev->dev,
 			"scratchpad is unsafe, proceed anyway...\n");
 
-	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
+	node = dev_to_node(&ndev->dev);
+
+	nt = kzalloc_node(sizeof(*nt), GFP_KERNEL, node);
 	if (!nt)
 		return -ENOMEM;
 
@@ -972,7 +978,8 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	nt->mw_count = mw_count;
 
-	nt->mw_vec = kcalloc(mw_count, sizeof(*nt->mw_vec), GFP_KERNEL);
+	nt->mw_vec = kzalloc_node(mw_count * sizeof(*nt->mw_vec),
+				  GFP_KERNEL, node);
 	if (!nt->mw_vec) {
 		rc = -ENOMEM;
 		goto err;
@@ -1012,7 +1019,8 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	nt->qp_bitmap = qp_bitmap;
 	nt->qp_bitmap_free = qp_bitmap;
 
-	nt->qp_vec = kcalloc(qp_count, sizeof(*nt->qp_vec), GFP_KERNEL);
+	nt->qp_vec = kzalloc_node(qp_count * sizeof(*nt->qp_vec),
+				  GFP_KERNEL, node);
 	if (!nt->qp_vec) {
 		rc = -ENOMEM;
 		goto err2;
@@ -1512,6 +1520,11 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
 	ntb_qp_link_down_reset(qp);
 }
 
+static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
+{
+	return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
+}
+
 /**
  * ntb_transport_create_queue - Create a new NTB transport layer queue
  * @rx_handler: receive callback function
@@ -1537,12 +1550,16 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	struct ntb_transport_qp *qp;
 	u64 qp_bit;
 	unsigned int free_queue;
+	dma_cap_mask_t dma_mask;
+	int node;
 	int i;
 
 	ndev = dev_ntb(client_dev->parent);
 	pdev = ndev->pdev;
 	nt = ndev->ctx;
 
+	node = dev_to_node(&ndev->dev);
+
 	free_queue = ffs(nt->qp_bitmap);
 	if (!free_queue)
 		goto err;
@@ -1560,15 +1577,16 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->tx_handler = handlers->tx_handler;
 	qp->event_handler = handlers->event_handler;
 
-	dmaengine_get();
-	qp->dma_chan = dma_find_channel(DMA_MEMCPY);
-	if (!qp->dma_chan) {
-		dmaengine_put();
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_MEMCPY, dma_mask);
+
+	qp->dma_chan = dma_request_channel(dma_mask, ntb_dma_filter_fn,
+					   (void *)(unsigned long)node);
+	if (!qp->dma_chan)
 		dev_info(&pdev->dev, "Unable to allocate DMA channel, using CPU instead\n");
-	}
 
 	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
-		entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
 		if (!entry)
 			goto err1;
 
@@ -1578,7 +1596,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	}
 
 	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
-		entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
 		if (!entry)
 			goto err2;
 
@@ -1601,7 +1619,7 @@ err1:
 	while ((entry = ntb_list_rm(&qp->ntb_rx_free_q_lock, &qp->rx_free_q)))
 		kfree(entry);
 	if (qp->dma_chan)
-		dmaengine_put();
+		dma_release_channel(qp->dma_chan);
 	nt->qp_bitmap_free |= qp_bit;
 err:
 	return NULL;
@@ -1638,7 +1656,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		 */
 		dma_sync_wait(chan, qp->last_cookie);
 		dmaengine_terminate_all(chan);
-		dmaengine_put();
+		dma_release_channel(chan);
 	}
 
 	qp_bit = BIT_ULL(qp->qp_num);
-- 
2.4.0.rc0.43.gcf8a8c6

