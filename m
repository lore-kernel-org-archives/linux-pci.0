Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 10/17] NTB: Do not advance transport RX on link down
Date: Thu, 21 May 2015 04:20:54 -0400
Message-Id: <a7621c0356f7d6886f5f761f471fc3ede94704ed.1432196075.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432192681.git.Allen.Hubbe@emc.com>
References: <cover.1432192681.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432196075.git.Allen.Hubbe@emc.com>
References: <cover.1432196075.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On link down, don't advance RX index to the next entry.  The next entry
should never be valid after receiving the link down flag.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index e2d4258..6260016 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1212,8 +1212,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
 		ntb_qp_link_down(qp);
 		hdr->flags = 0;
-		iowrite32(qp->rx_index, &qp->rx_info->entry);
-		return 0;
+		return -EAGAIN;
 	}
 
 	if (hdr->ver != (u32)qp->rx_pkts) {
-- 
2.4.0.rc0.43.gcf8a8c6

