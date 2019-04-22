Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D916C282E1
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 06:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1935F20811
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 06:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfDVGo0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:44:26 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:3655 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDVGo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2019 02:44:26 -0400
X-IronPort-AV: E=Sophos;i="5.60,380,1549954800"; 
   d="scan'208";a="30574989"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2019 23:44:04 -0700
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 22 Apr
 2019 01:44:03 -0500
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 22 Apr
 2019 01:44:02 -0500
Received: from server1.microsemi.net (10.188.116.203) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 22 Apr 2019 01:43:59 -0500
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>,
        <kelvin.cao@microchip.com>
Subject: [PATCH 1/3] ntb_hw_switchtec: Remove redundant steps of switchtec_ntb_reinit_peer() function
Date:   Mon, 22 Apr 2019 22:42:56 +0800
Message-ID: <1555944178-1957-2-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555944178-1957-1-git-send-email-wesley.sheng@microchip.com>
References: <1555944178-1957-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joey Zhang <joey.zhang@microchip.com>

When a re-initialization is caused by a link event, the driver will
re-setup the shared memory window. But at that time, the shared memory
is still valid, and it's unnecessary to free, reallocate and then
initialize it again. We only need to reconfigure the hardware
registers. Remove the redundant steps from
switchtec_ntb_reinit_peer() function.

Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index d905d36..947ed0b 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1457,10 +1457,13 @@ static void switchtec_ntb_deinit_db_msg_irq(struct switchtec_ntb *sndev)
 
 static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
 {
-	dev_info(&sndev->stdev->dev, "peer reinitialized\n");
-	switchtec_ntb_deinit_shared_mw(sndev);
-	switchtec_ntb_init_mw(sndev);
-	return switchtec_ntb_init_shared_mw(sndev);
+	int rc;
+
+	dev_info(&sndev->stdev->dev, "reinitialize shared memory window\n");
+	rc = config_rsvd_lut_win(sndev, sndev->mmio_peer_ctrl, 0,
+				 sndev->self_partition,
+				 sndev->self_shared_dma);
+	return rc;
 }
 
 static int switchtec_ntb_add(struct device *dev,
-- 
2.7.4

