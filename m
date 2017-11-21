Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Colin King <colin.king@canonical.com>
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NTB: switchtec_ntb: fix spelling mistake: "peforming" -> "performing"
Date: Tue, 21 Nov 2017 22:59:45 +0000
Message-Id: <20171121225945.29377-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index afe8ed6f3b23..d46d113210b5 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -172,7 +172,7 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
 
 	if (ps == status) {
 		dev_err(&sndev->stdev->dev,
-			"Timed out while peforming %s (%d). (%08x)",
+			"Timed out while performing %s (%d). (%08x)",
 			op_text[op], op,
 			ioread32(&ctl->partition_status));
 
-- 
2.14.1
