Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v2 14/17] NTB: Improve performance with write combining
Date: Thu, 21 May 2015 04:20:58 -0400
Message-Id: <0fd720f2c414bd0e444bac09bb82d58c1ffe2854.1432196075.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432192681.git.Allen.Hubbe@emc.com>
References: <cover.1432192681.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432196075.git.Allen.Hubbe@emc.com>
References: <cover.1432196075.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index 733c0ec..95252ea 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -58,6 +58,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/uaccess.h>
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
 
@@ -990,7 +991,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		if (rc)
 			goto err1;
 
-		mw->vbase = ioremap(mw->phys_addr, mw->phys_size);
+		mw->vbase = ioremap_wc(mw->phys_addr, mw->phys_size);
 		if (!mw->vbase) {
 			rc = -ENOMEM;
 			goto err1;
@@ -1361,7 +1362,11 @@ static void ntb_tx_copy_callback(void *data)
 
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

