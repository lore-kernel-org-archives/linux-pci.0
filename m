Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:57552 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbbETUmX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 16:42:23 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 16/16] ntb_transport: fix small code format issues
Date: Wed, 20 May 2015 11:41:17 -0400
Message-Id: <b90be5db558df08636a6c87e901a14a1184d7bfd.1432135632.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
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
index 237f76f..15d237c 100644
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
@@ -1158,8 +1158,8 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset,
 		goto err_wait;
 
 	device = chan->device;
-	pay_off = (size_t) offset & ~PAGE_MASK;
-	buff_off = (size_t) buf & ~PAGE_MASK;
+	pay_off = (size_t)offset & ~PAGE_MASK;
+	buff_off = (size_t)buf & ~PAGE_MASK;
 
 	if (!is_dma_copy_aligned(device, pay_off, buff_off, len))
 		goto err_wait;
@@ -1397,7 +1397,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	entry->tx_hdr = hdr;
 
 	iowrite32(entry->len, &hdr->len);
-	iowrite32((u32) qp->tx_pkts, &hdr->ver);
+	iowrite32((u32)qp->tx_pkts, &hdr->ver);
 
 	if (!chan)
 		goto err;
@@ -1407,8 +1407,8 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 
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

