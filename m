Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwhop.emc.com ([168.159.213.141]:59522 "EHLO
	mailuogwhop.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbbE0Uiv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 16:38:51 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH] NTB: Skip reading doorbell bits in callback
Date: Wed, 27 May 2015 11:37:49 -0400
Message-Id: <ccfb91d6e93eb0136b72e0454d697ae4e8101523.1432740351.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Avoid the penalty of ioread latency before doing useful work in the
doorbell callback.  Instead of reading the doorbell bits, assume the
bits are set, and always schedule the transport qp tasklets.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
Notes:
  This should theoretically improve the response time.  Experiments with
  netperf do not show any significant difference in either direction.

 drivers/ntb/ntb_transport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4c59f24cef2d..b70b6a30a0b5 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1922,12 +1922,11 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 {
 	struct ntb_transport_ctx *nt = data;
 	struct ntb_transport_qp *qp;
-	u64 db_mask, db_bits;
+	u64 db_bits;
 	unsigned int qp_num;
 
-	db_mask = (nt->qp_bitmap & ~nt->qp_bitmap_free &
+	db_bits = (nt->qp_bitmap & ~nt->qp_bitmap_free &
 		   ntb_db_vector_mask(nt->ndev, vector));
-	db_bits = db_mask & ntb_db_read(nt->ndev);
 
 	while (db_bits) {
 		qp_num = __ffs(db_bits);
-- 
2.4.0.rc0.43.gcf8a8c6

