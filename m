Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwhop.emc.com ([168.159.213.141]:42466 "EHLO
	mailuogwhop.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbbETUmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 16:42:09 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 09/16] ntb_transport: differentiate link down messages
Date: Wed, 20 May 2015 11:41:10 -0400
Message-Id: <8693319310e9339213d519bf5634b8710f3ee5a2.1432135632.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The same message "qp%d: Link Down\n" was printed at two locations in
ntb_transport.  Change the messages so they are distinct.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 833f5b6..8a6db1a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -657,7 +657,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 		return;
 	}
 
-	dev_info(&pdev->dev, "qp %d: Link Down\n", qp->qp_num);
+	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
 	qp->link_is_up = false;
 
 	if (qp->event_handler)
@@ -1455,7 +1455,7 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
 		return;
 
 	qp->link_is_up = false;
-	dev_info(&pdev->dev, "qp %d: Link Down\n", qp->qp_num);
+	dev_info(&pdev->dev, "qp %d: Send Link Down\n", qp->qp_num);
 
 	for (i = 0; i < NTB_LINK_DOWN_TIMEOUT; i++) {
 		entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
-- 
2.4.0.rc0.43.gcf8a8c6

