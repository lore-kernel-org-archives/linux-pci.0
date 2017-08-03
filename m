Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41653 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751987AbdHCSUK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:10 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  3 Aug 2017 12:19:52 -0600
Message-Id: <20170803181954.4154-14-logang@deltatee.com>
In-Reply-To: <20170803181954.4154-1-logang@deltatee.com>
References: <20170803181954.4154-1-logang@deltatee.com>
Subject: [PATCH v4 13/15] NTB: switchtec_ntb: Implement scratchpad registers
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Seeing there is no dedicated hardware for this, we simply add
these as entries in the shared memory window. Thus, we could support
any number of them but 128 seems like enough, for now.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 75 +++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 4a6125d2f305..205bd9481122 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -67,6 +67,7 @@ struct shared_mw {
 	u32 link_sta;
 	u32 partition_id;
 	u64 mw_sizes[MAX_MWS];
+	u32 spad[128];
 };
 
 #define MAX_DIRECT_MW ARRAY_SIZE(((struct ntb_ctrl_regs *)(0))->bar_entry)
@@ -455,22 +456,90 @@ static int switchtec_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 
 static int switchtec_ntb_spad_count(struct ntb_dev *ntb)
 {
-	return 0;
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	return ARRAY_SIZE(sndev->self_shared->spad);
 }
 
 static u32 switchtec_ntb_spad_read(struct ntb_dev *ntb, int idx)
 {
-	return 0;
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (idx < 0 || idx >= ARRAY_SIZE(sndev->self_shared->spad))
+		return 0;
+
+	if (!sndev->self_shared)
+		return 0;
+
+	return sndev->self_shared->spad[idx];
 }
 
 static int switchtec_ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
 {
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (idx < 0 || idx >= ARRAY_SIZE(sndev->self_shared->spad))
+		return -EINVAL;
+
+	if (!sndev->self_shared)
+		return -EIO;
+
+	sndev->self_shared->spad[idx] = val;
+
 	return 0;
 }
 
+static u32 switchtec_ntb_peer_spad_read(struct ntb_dev *ntb, int pidx,
+					int sidx)
+{
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (pidx != NTB_DEF_PEER_IDX)
+		return -EINVAL;
+
+	if (sidx < 0 || sidx >= ARRAY_SIZE(sndev->peer_shared->spad))
+		return 0;
+
+	if (!sndev->peer_shared)
+		return 0;
+
+	return ioread32(&sndev->peer_shared->spad[sidx]);
+}
+
 static int switchtec_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,
 					 int sidx, u32 val)
 {
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (pidx != NTB_DEF_PEER_IDX)
+		return -EINVAL;
+
+	if (sidx < 0 || sidx >= ARRAY_SIZE(sndev->peer_shared->spad))
+		return -EINVAL;
+
+	if (!sndev->peer_shared)
+		return -EIO;
+
+	iowrite32(val, &sndev->peer_shared->spad[sidx]);
+
+	return 0;
+}
+
+static int switchtec_ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx,
+					int sidx, phys_addr_t *spad_addr)
+{
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+	unsigned long offset;
+
+	if (pidx != NTB_DEF_PEER_IDX)
+		return -EINVAL;
+
+	offset = (unsigned long)&sndev->peer_shared->spad[sidx] -
+		(unsigned long)sndev->stdev->mmio;
+
+	if (spad_addr)
+		*spad_addr = pci_resource_start(ntb->pdev, 0) + offset;
+
 	return 0;
 }
 
@@ -496,7 +565,9 @@ static const struct ntb_dev_ops switchtec_ntb_ops = {
 	.spad_count		= switchtec_ntb_spad_count,
 	.spad_read		= switchtec_ntb_spad_read,
 	.spad_write		= switchtec_ntb_spad_write,
+	.peer_spad_read		= switchtec_ntb_peer_spad_read,
 	.peer_spad_write	= switchtec_ntb_peer_spad_write,
+	.peer_spad_addr		= switchtec_ntb_peer_spad_addr,
 };
 
 static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
-- 
2.11.0
