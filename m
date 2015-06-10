Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v4 16/19] NTB: Improve performance with write combining
Date: Wed, 10 Jun 2015 05:08:21 -0400
Message-Id: <be18922305674d3ae167969643b0c25fa3c1690b.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Changing the memory window BAR mappings to write combining significantly
boosts the performance.  We will also use memcpy that uses non-temporal
store, which showed performance improvement when doing non-cached
memcpys.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Added #ifdef ARCH_HAS_NOCACHE_UACCESS around
__copy_from_user_inatomic_nocache.

Following the example set by here:
https://lists.01.org/pipermail/linux-nvdimm/2015-June/001087.html

 drivers/ntb/ntb_transport.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index dc14ec81c43e..7a765d3230d8 100644
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
@@ -1375,7 +1376,15 @@ static void ntb_tx_copy_callback(void *data)
 
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
 {
+#ifdef ARCH_HAS_NOCACHE_UACCESS
+	/*
+	 * Using non-temporal mov to improve performance on non-cached
+	 * writes, even though we aren't actually copying from user space.
+	 */
+	__copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
+#else
 	memcpy_toio(offset, entry->buf, entry->len);
+#endif
 
 	/* Ensure that the data is fully copied out before setting the flags */
 	wmb();
-- 
2.4.0.rc0.43.gcf8a8c6

