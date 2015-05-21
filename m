Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 15/17] NTB: Default to CPU memcpy for performance
Date: Thu, 21 May 2015 04:20:59 -0400
Message-Id: <f81e011a326e20b8ef0cb2c863f3ace4b0e23318.1432196075.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432192681.git.Allen.Hubbe@emc.com>
References: <cover.1432192681.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432196075.git.Allen.Hubbe@emc.com>
References: <cover.1432196075.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index 95252ea..9c266e1 100644
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
@@ -1571,10 +1575,15 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
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

