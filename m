Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 10/16] ntb_transport: don't advance rx on link down
Date: Wed, 20 May 2015 11:41:11 -0400
Message-Id: <5613ceb692dd7a5973d0b8d3269cc50a5b0721ee.1432135632.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On link down, don't advance RX index to the next entry.  The next entry
should never be valid after receiving the link down flag.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8a6db1a..9b4e240 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1211,8 +1211,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
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

