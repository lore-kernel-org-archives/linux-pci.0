Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:52258 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933015AbbFIOpn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2015 10:45:43 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v3 16/18] NTB: Default to CPU memcpy for performance
Date: Tue,  9 Jun 2015 05:44:43 -0400
Message-Id: <5c88264b00edf231f515d4d03878a61946a7b3b7.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Disable DMA usage by default, since the CPU provides much better
performance with write combining.  Provide a module parameter to enable
DMA usage when offloading the memcpy is preferred.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 528ea0af6d54..ea237aeca28c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -88,6 +88,10 @@ static unsigned int copy_bytes = 1024;
 module_param(copy_bytes, uint, 0644);
 MODULE_PARM_DESC(copy_bytes, "Threshold under which NTB will use the CPU to copy instead of DMA");
 
+static bool use_dma;
+module_param(use_dma, bool, 0644);
+MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
+
 static struct dentry *nt_debugfs_dir;
 
 struct ntb_queue_entry {
@@ -1585,10 +1589,15 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	dma_cap_zero(dma_mask);
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
-	qp->dma_chan = dma_request_channel(dma_mask, ntb_dma_filter_fn,
-					   (void *)(unsigned long)node);
-	if (!qp->dma_chan)
-		dev_info(&pdev->dev, "Unable to allocate DMA channel, using CPU instead\n");
+	if (use_dma) {
+		qp->dma_chan = dma_request_channel(dma_mask, ntb_dma_filter_fn,
+						   (void *)(unsigned long)node);
+		if (!qp->dma_chan)
+			dev_info(&pdev->dev, "Unable to allocate DMA channel\n");
+	} else {
+		qp->dma_chan = NULL;
+	}
+	dev_dbg(&pdev->dev, "Using %s memcpy\n", qp->dma_chan ? "DMA" : "CPU");
 
 	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
-- 
2.4.0.rc0.43.gcf8a8c6

