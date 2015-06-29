Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwhop.emc.com ([168.159.213.141]:58777 "EHLO
	mailuogwhop.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbbF2Ouk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 10:50:40 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 5/9] NTB: Fix oops in debugfs when transport is half-up
Date: Mon, 29 Jun 2015 10:50:01 -0400
Message-Id: <dc46fafa9893ffa92dad1a95fda17627dfff8c8a.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

When the remote side is not up, we do not have all the context for the
transport, and that causes NULL ptr access. Have the debugfs reads check
to see if transport is up before we make access.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 30d8b52421ec..1764bb2fd265 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -438,13 +438,17 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 	char *buf;
 	ssize_t ret, out_offset, out_count;
 
+	qp = filp->private_data;
+
+	if (!qp || !qp->link_is_up)
+		return 0;
+
 	out_count = 1000;
 
 	buf = kmalloc(out_count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	qp = filp->private_data;
 	out_offset = 0;
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "NTB QP stats\n");
-- 
2.4.0.rc0.43.gcf8a8c6

