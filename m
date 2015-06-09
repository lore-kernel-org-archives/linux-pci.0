Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwhop.emc.com ([168.159.213.141]:41889 "EHLO
	mailuogwhop.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933087AbbFIOpl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2015 10:45:41 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v3 15/18] NTB: Improve performance with write combining
Date: Tue,  9 Jun 2015 05:44:42 -0400
Message-Id: <bc5eb3dd58e308b06a3a7464627704210c175394.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Changing the memory window BAR mappings to write combining significantly
boosts the performance.  We will also use memcpy that utilizies
non-temporal store which showed performance improement when doing
non-cached memcpys.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index dc14ec81c43e..528ea0af6d54 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -58,6 +58,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/uaccess.h>
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
 
@@ -993,7 +994,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		if (rc)
 			goto err1;
 
-		mw->vbase = ioremap(mw->phys_addr, mw->phys_size);
+		mw->vbase = ioremap_wc(mw->phys_addr, mw->phys_size);
 		if (!mw->vbase) {
 			rc = -ENOMEM;
 			goto err1;
@@ -1375,7 +1376,11 @@ static void ntb_tx_copy_callback(void *data)
 
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
 {
-	memcpy_toio(offset, entry->buf, entry->len);
+	/*
+	 * Using non-temporal mov to improve performance on non-cached
+	 * writes. Even though we aren't actually copying from user space.
+	 */
+	__copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
 
 	/* Ensure that the data is fully copied out before setting the flags */
 	wmb();
-- 
2.4.0.rc0.43.gcf8a8c6

