Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v4 07/19] NTB: Differentiate transport link down messages
Date: Wed, 10 Jun 2015 05:08:12 -0400
Message-Id: <e2fa2858d56a919d15e69b89d1bca82af1139bf2.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The same message "qp %d: Link Down\n" was printed at two locations in
ntb_transport.  Change the messages so they are distinct.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d9538e911df6..8d9b59f7fa07 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -658,7 +658,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 		return;
 	}
 
-	dev_info(&pdev->dev, "qp %d: Link Down\n", qp->qp_num);
+	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
 	qp->link_is_up = false;
 
 	if (qp->event_handler)
@@ -1470,7 +1470,7 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
 		return;
 
 	qp->link_is_up = false;
-	dev_info(&pdev->dev, "qp %d: Link Down\n", qp->qp_num);
+	dev_info(&pdev->dev, "qp %d: Send Link Down\n", qp->qp_num);
 
 	for (i = 0; i < NTB_LINK_DOWN_TIMEOUT; i++) {
 		entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
-- 
2.4.0.rc0.43.gcf8a8c6

