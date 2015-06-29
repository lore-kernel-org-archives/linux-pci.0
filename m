Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:46703 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbF2Ouh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 10:50:37 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 3/9] NTB: Fix transport stats for multiple devices
Date: Mon, 29 Jun 2015 10:49:59 -0400
Message-Id: <1d24d41d6f61b4e06bf7097ea235adf4ca58c363.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Currently the debugfs does not have files for all NTB transport queue
pairs.  When there are multiple NTBs present in a system, the QP names
of the last transport clobber the names of previously added transport
QPs.  Only the last added QPs can be observed via debugfs.

Create a directory per NTB transport to associate the QPs with that
transport.  Name the directory the same as the PCI device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3c257f1d235f..30d8b52421ec 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -211,6 +211,8 @@ struct ntb_transport_ctx {
 	bool link_is_up;
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
+
+	struct dentry *debugfs_node_dir;
 };
 
 enum {
@@ -951,12 +953,12 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
-	if (nt_debugfs_dir) {
+	if (nt->debugfs_node_dir) {
 		char debugfs_name[4];
 
 		snprintf(debugfs_name, 4, "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
-						     nt_debugfs_dir);
+						     nt->debugfs_node_dir);
 
 		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
 							qp->debugfs_dir, qp,
@@ -1059,6 +1061,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		goto err2;
 	}
 
+	if (nt_debugfs_dir) {
+		nt->debugfs_node_dir =
+			debugfs_create_dir(pci_name(ndev->pdev), nt_debugfs_dir);
+	}
+
 	for (i = 0; i < qp_count; i++) {
 		rc = ntb_transport_init_queue(nt, i);
 		if (rc)
-- 
2.4.0.rc0.43.gcf8a8c6

