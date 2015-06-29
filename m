Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:48096 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbbF2P3o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 11:29:44 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 4/9] NTB: ntb_netdev not covering all receive errors
Date: Mon, 29 Jun 2015 11:28:53 -0400
Message-Id: <b102ae0f0209cfcd03f90b554857ce76d054ce5a.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <b9741f90ecfa33e97d8a6690ed357fd64f683b06.1435587291.git.Allen.Hubbe@emc.com>
References: <b9741f90ecfa33e97d8a6690ed357fd64f683b06.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

ntb_netdev is allowing the link to come up even when -ENOMEM is returned
from ntb_transport_rx_enqueue.  Fix to cover all possible errors.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ntb_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 7a0aeac00c24..4d4d4f19049d 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -257,7 +257,7 @@ static int ntb_netdev_open(struct net_device *ndev)
 
 		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
 					      ndev->mtu + ETH_HLEN);
-		if (rc == -EINVAL) {
+		if (rc) {
 			dev_kfree_skb(skb);
 			goto err;
 		}
-- 
2.4.0.rc0.43.gcf8a8c6

