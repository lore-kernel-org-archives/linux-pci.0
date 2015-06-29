Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 6/9] NTB: Schedule to receive on QP link up
Date: Mon, 29 Jun 2015 10:50:02 -0400
Message-Id: <9d5704c1ad72160b8fda8d761cd7b923f10916bf.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Schedule to receive on QP link up, to make sure that the doorbell is
properly cleared for interrupts.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 1764bb2fd265..a040a4ee6f33 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -901,6 +901,8 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 		if (qp->event_handler)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
+
+		tasklet_schedule(&qp->rxc_db_work);
 	} else if (nt->link_is_up)
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
-- 
2.4.0.rc0.43.gcf8a8c6

