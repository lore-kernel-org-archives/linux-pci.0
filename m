Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 16/17] NTB: Fix small code format issues in transport
Date: Thu, 21 May 2015 04:21:00 -0400
Message-Id: <ee2b7f7ac2925a435342f8bb2e020e5c06057683.1432196075.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432192681.git.Allen.Hubbe@emc.com>
References: <cover.1432192681.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432196075.git.Allen.Hubbe@emc.com>
References: <cover.1432196075.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix code format issues detected by checkpatch.pl.  Fix one spelling
error, and some unnecessary whitespace after cast operators.  I did not
add the comments for spinlocks, which checkpatch still reports as
missing.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9c266e1..f8f2fda 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -97,7 +97,7 @@ static struct dentry *nt_debugfs_dir;
 struct ntb_queue_entry {
 	/* ntb_queue list reference */
 	struct list_head entry;
-	/* pointers to data to be transfered */
+	/* pointers to data to be transferred */
 	void *cb_data;
 	void *buf;
 	unsigned int len;
@@ -1159,8 +1159,8 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset,
 		goto err_wait;
 
 	device = chan->device;
-	pay_off = (size_t) offset & ~PAGE_MASK;
-	buff_off = (size_t) buf & ~PAGE_MASK;
+	pay_off = (size_t)offset & ~PAGE_MASK;
+	buff_off = (size_t)buf & ~PAGE_MASK;
 
 	if (!is_dma_copy_aligned(device, pay_off, buff_off, len))
 		goto err_wait;
@@ -1398,7 +1398,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	entry->tx_hdr = hdr;
 
 	iowrite32(entry->len, &hdr->len);
-	iowrite32((u32) qp->tx_pkts, &hdr->ver);
+	iowrite32((u32)qp->tx_pkts, &hdr->ver);
 
 	if (!chan)
 		goto err;
@@ -1408,8 +1408,8 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 
 	device = chan->device;
 	dest = qp->tx_mw_phys + qp->tx_max_frame * qp->tx_index;
-	buff_off = (size_t) buf & ~PAGE_MASK;
-	dest_off = (size_t) dest & ~PAGE_MASK;
+	buff_off = (size_t)buf & ~PAGE_MASK;
+	dest_off = (size_t)dest & ~PAGE_MASK;
 
 	if (!is_dma_copy_aligned(device, buff_off, dest_off, len))
 		goto err;
-- 
2.4.0.rc0.43.gcf8a8c6

