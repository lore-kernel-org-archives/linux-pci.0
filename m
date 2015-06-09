Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v3 08/18] NTB: Reset transport QP link stats on down
Date: Tue,  9 Jun 2015 05:44:35 -0400
Message-Id: <fac6bc5f87a6c9c90e4e3177de3ad0c8cac75821.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reset the link stats when the link goes down.  In particular, the tx and
rx index and count must be reset, or else the tx side will be sending
packets to the rx side, where the rx side is not expecting them.  Reset
all the stats, to be consistent.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 0f86b60a0c0e..2efd1eae9a7c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -648,18 +648,37 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	return 0;
 }
 
+static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+{
+	qp->link_is_up = false;
+
+	qp->tx_index = 0;
+	qp->rx_index = 0;
+	qp->rx_bytes = 0;
+	qp->rx_pkts = 0;
+	qp->rx_ring_empty = 0;
+	qp->rx_err_no_buf = 0;
+	qp->rx_err_oflow = 0;
+	qp->rx_err_ver = 0;
+	qp->rx_memcpy = 0;
+	qp->rx_async = 0;
+	qp->tx_bytes = 0;
+	qp->tx_pkts = 0;
+	qp->tx_ring_full = 0;
+	qp->tx_err_no_buf = 0;
+	qp->tx_memcpy = 0;
+	qp->tx_async = 0;
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
 	struct pci_dev *pdev = nt->ndev->pdev;
 
-	if (qp->link_is_up) {
-		cancel_delayed_work_sync(&qp->link_work);
-		return;
-	}
-
 	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
-	qp->link_is_up = false;
+
+	cancel_delayed_work_sync(&qp->link_work);
+	ntb_qp_link_down_reset(qp);
 
 	if (qp->event_handler)
 		qp->event_handler(qp->cb_data, qp->link_is_up);
@@ -866,9 +885,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->qp_num = qp_num;
 	qp->transport = nt;
 	qp->ndev = nt->ndev;
-	qp->link_is_up = false;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
+	ntb_qp_link_down_reset(qp);
 
 	if (qp_count % mw_count && mw_num + 1 < qp_count / mw_count)
 		num_qps_mw = qp_count / mw_count + 1;
@@ -1468,7 +1487,6 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
 	if (!qp->link_is_up)
 		return;
 
-	qp->link_is_up = false;
 	dev_info(&pdev->dev, "qp %d: Send Link Down\n", qp->qp_num);
 
 	for (i = 0; i < NTB_LINK_DOWN_TIMEOUT; i++) {
@@ -1490,6 +1508,8 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
 	if (rc)
 		dev_err(&pdev->dev, "ntb: QP%d unable to send linkdown msg\n",
 			qp->qp_num);
+
+	ntb_qp_link_down_reset(qp);
 }
 
 /**
-- 
2.4.0.rc0.43.gcf8a8c6

