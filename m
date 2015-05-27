Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH] NTB: Reschedule long tasklets to avoid stalls
Date: Wed, 27 May 2015 07:26:10 -0400
Message-Id: <5666174a290c19906ba1deed99ce379699be2343.1432724735.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of looping in the tasklets to complete all the work, reschdule
the tasklets to finish the work later.  This allows the scheduler to
run, to avoid a stall.

Tasklets are added to each transport queue pair, replacing the tasklet
that was in the transport context.

The doorbell mask is not used in the interrupt path (the mask is still
used when queue pairs are allocated and freed - that is not changed).
Instead, when an interrupt arrives, the doorbell bit of the queue pair
is left set, to prevent further interrupts, and cleared when the queue
pair is done processing.  Care is taken to avoid missing an interrupt.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 72 +++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f8f2fdaba072..4c59f24cef2d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -151,6 +151,7 @@ struct ntb_transport_qp {
 	unsigned int rx_max_entry;
 	unsigned int rx_max_frame;
 	dma_cookie_t last_cookie;
+	struct tasklet_struct rxc_db_work;
 
 	void (*event_handler)(void *data, int status);
 	struct delayed_work link_work;
@@ -210,7 +211,6 @@ struct ntb_transport_ctx {
 	bool link_is_up;
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
-	struct tasklet_struct db_work;
 };
 
 enum {
@@ -246,7 +246,7 @@ enum {
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
-static void ntb_transport_doorbell_work(unsigned long data);
+static void ntb_transport_rxc_db(unsigned long data);
 static const struct ntb_ctx_ops ntb_transport_ops;
 static struct ntb_client ntb_transport_client;
 
@@ -949,6 +949,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	INIT_LIST_HEAD(&qp->rx_free_q);
 	INIT_LIST_HEAD(&qp->tx_free_q);
 
+	tasklet_init(&qp->rxc_db_work, ntb_transport_rxc_db,
+		     (unsigned long)qp);
+
 	return 0;
 }
 
@@ -1036,8 +1039,6 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
 	INIT_WORK(&nt->link_cleanup, ntb_transport_link_cleanup_work);
-	tasklet_init(&nt->db_work, ntb_transport_doorbell_work,
-		     (unsigned long)nt);
 
 	rc = ntb_set_ctx(ndev, nt, &ntb_transport_ops);
 	if (rc)
@@ -1078,7 +1079,6 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 	int i;
 
 	ntb_transport_link_cleanup(nt);
-	tasklet_disable(&nt->db_work);
 	cancel_work_sync(&nt->link_cleanup);
 	cancel_delayed_work_sync(&nt->link_work);
 
@@ -1316,13 +1316,13 @@ err:
 	return rc;
 }
 
-static int ntb_transport_rxc_db(void *data, int db_num)
+static void ntb_transport_rxc_db(unsigned long data)
 {
-	struct ntb_transport_qp *qp = data;
+	struct ntb_transport_qp *qp = (void *)data;
 	int rc, i;
 
 	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
-		__func__, db_num);
+		__func__, qp->qp_num);
 
 	/* Limit the number of packets processed in a single interrupt to
 	 * provide fairness to others
@@ -1336,7 +1336,21 @@ static int ntb_transport_rxc_db(void *data, int db_num)
 	if (qp->dma_chan)
 		dma_async_issue_pending(qp->dma_chan);
 
-	return i;
+	if (i == qp->rx_max_entry) {
+		/* there is more work to do */
+		tasklet_schedule(&qp->rxc_db_work);
+	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
+		/* the doorbell bit is set: clear it */
+		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
+		/* ntb_db_read ensures ntb_db_clear write is committed */
+		ntb_db_read(qp->ndev);
+
+		/* an interrupt may have arrived between finishing
+		 * ntb_process_rxc and clearing the doorbell bit:
+		 * there might be some more work to do.
+		 */
+		tasklet_schedule(&qp->rxc_db_work);
+	}
 }
 
 static void ntb_tx_copy_callback(void *data)
@@ -1662,6 +1676,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	qp_bit = BIT_ULL(qp->qp_num);
 
 	ntb_db_set_mask(qp->ndev, qp_bit);
+	tasklet_disable(&qp->rxc_db_work);
 
 	cancel_delayed_work_sync(&qp->link_work);
 
@@ -1903,46 +1918,25 @@ unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
-static void ntb_transport_doorbell_work(unsigned long data)
+static void ntb_transport_doorbell_callback(void *data, int vector)
 {
-	struct ntb_transport_ctx *nt = (void *)data;
+	struct ntb_transport_ctx *nt = data;
 	struct ntb_transport_qp *qp;
-	u64 db_mask, db_bits, db_again;
+	u64 db_mask, db_bits;
 	unsigned int qp_num;
-	int rc;
 
-	db_mask = nt->qp_bitmap & ~nt->qp_bitmap_free;
+	db_mask = (nt->qp_bitmap & ~nt->qp_bitmap_free &
+		   ntb_db_vector_mask(nt->ndev, vector));
 	db_bits = db_mask & ntb_db_read(nt->ndev);
 
 	while (db_bits) {
-		ntb_db_clear(nt->ndev, db_bits);
-		db_again = 0;
-
-		while (db_bits) {
-			qp_num = __ffs(db_bits);
-			qp = &nt->qp_vec[qp_num];
+		qp_num = __ffs(db_bits);
+		qp = &nt->qp_vec[qp_num];
 
-			rc = ntb_transport_rxc_db(qp, qp_num);
-			if (rc == qp->rx_max_entry)
-				db_again |= BIT_ULL(qp_num);
-
-			db_bits &= ~BIT_ULL(qp_num);
-		}
+		tasklet_schedule(&qp->rxc_db_work);
 
-		db_bits = db_mask & ntb_db_read(nt->ndev);
-		db_bits |= db_again;
+		db_bits &= ~BIT_ULL(qp_num);
 	}
-
-	ntb_db_clear_mask(nt->ndev, db_mask);
-}
-
-static void ntb_transport_doorbell_callback(void *data, int vector)
-{
-	struct ntb_transport_ctx *nt = data;
-
-	ntb_db_set_mask(nt->ndev, ntb_db_valid_mask(nt->ndev));
-
-	tasklet_schedule(&nt->db_work);
 }
 
 static const struct ntb_ctx_ops ntb_transport_ops = {
-- 
2.4.0.rc0.43.gcf8a8c6

