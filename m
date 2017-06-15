Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58938 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752269AbdFOUhs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 16:37:48 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 15 Jun 2017 14:37:27 -0600
Message-Id: <20170615203729.9009-12-logang@deltatee.com>
In-Reply-To: <20170615203729.9009-1-logang@deltatee.com>
References: <20170615203729.9009-1-logang@deltatee.com>
Subject: [RFC PATCH 11/13] switchtec_ntb: implement scratchpad registers
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Seeing there is no dedicated hardware for this, we simply add
these as entries in the shared memory window. Thus, we could support
any number of them but 128 seems like enough, for now.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/ntb/hw/mscc/switchtec_ntb.c | 65 +++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
index 53604c22be67..aabe20388695 100644
--- a/drivers/ntb/hw/mscc/switchtec_ntb.c
+++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
@@ -59,6 +59,7 @@ struct shared_mw {
 	u32 magic;
 	u32 link_sta;
 	u32 partition_id;
+	u32 spad[128];
 };
 
 #define MAX_DIRECT_MW ARRAY_SIZE(((struct ntb_ctrl_regs *)(0))->bar_entry)
@@ -453,21 +454,79 @@ static int switchtec_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 
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
 
+static u32 switchtec_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
+{
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (idx < 0 || idx >= ARRAY_SIZE(sndev->peer_shared->spad))
+		return 0;
+
+	if (!sndev->peer_shared)
+		return 0;
+
+	return ioread32(&sndev->peer_shared->spad[idx]);
+}
+
 static int switchtec_ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
 {
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (idx < 0 || idx >= ARRAY_SIZE(sndev->peer_shared->spad))
+		return -EINVAL;
+
+	if (!sndev->peer_shared)
+		return -EIO;
+
+	iowrite32(val, &sndev->peer_shared->spad[idx]);
+
+	return 0;
+}
+
+static int switchtec_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
+					phys_addr_t *spad_addr)
+{
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+	unsigned long offset;
+
+	offset = (unsigned long)&sndev->peer_shared->spad[idx] -
+		(unsigned long)sndev->stdev->mmio;
+
+	if (spad_addr)
+		*spad_addr = pci_resource_start(ntb->pdev, 0) + offset;
+
 	return 0;
 }
 
@@ -491,7 +550,9 @@ static const struct ntb_dev_ops switchtec_ntb_ops = {
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
