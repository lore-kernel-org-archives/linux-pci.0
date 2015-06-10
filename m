Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v4 08/19] NTB: Do not advance transport RX on link down
Date: Wed, 10 Jun 2015 05:08:13 -0400
Message-Id: <9bd941c6bdf4e540f44b02bb0b0eeb1d031bedf5.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On link down, don't advance RX index to the next entry.  The next entry
should never be valid after receiving the link down flag.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8d9b59f7fa07..0f86b60a0c0e 100644
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

