Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 8/9] NTB: Make the transport list in order of discovery
Date: Mon, 29 Jun 2015 10:50:04 -0400
Message-Id: <984e3923609c92e80045e86ea00d7f18225f74b7.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

The list should be added from the bottom and not the top in order to
ensure the transport is provided in the same order to clients as ntb
devices are discovered.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a040a4ee6f33..713be97be95f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -296,7 +296,7 @@ static LIST_HEAD(ntb_transport_list);
 
 static int ntb_bus_init(struct ntb_transport_ctx *nt)
 {
-	list_add(&nt->entry, &ntb_transport_list);
+	list_add_tail(&nt->entry, &ntb_transport_list);
 	return 0;
 }
 
-- 
2.4.0.rc0.43.gcf8a8c6

