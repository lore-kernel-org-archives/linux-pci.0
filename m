Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE490C282E1
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 06:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42F420811
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 06:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfDVGoK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:44:10 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:37746 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfDVGoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2019 02:44:10 -0400
X-IronPort-AV: E=Sophos;i="5.60,380,1549954800"; 
   d="scan'208";a="31972701"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2019 23:44:08 -0700
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 22 Apr
 2019 01:44:07 -0500
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 22 Apr
 2019 01:44:06 -0500
Received: from server1.microsemi.net (10.188.116.203) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 22 Apr 2019 01:44:03 -0500
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>,
        <kelvin.cao@microchip.com>
Subject: [PATCH 2/3] ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window for crosslink case
Date:   Mon, 22 Apr 2019 22:42:57 +0800
Message-ID: <1555944178-1957-3-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555944178-1957-1-git-send-email-wesley.sheng@microchip.com>
References: <1555944178-1957-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case of NTB crosslink topology, the setting of shared memory window in
the virtual partition doesn't reset on peer's reboot. So skip the
unnecessary re-setup of shared memory window for that case.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 947ed0b..6cf15c18 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1459,6 +1459,9 @@ static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
 {
 	int rc;
 
+	if (crosslink_is_enabled(sndev))
+		return 0;
+
 	dev_info(&sndev->stdev->dev, "reinitialize shared memory window\n");
 	rc = config_rsvd_lut_win(sndev, sndev->mmio_peer_ctrl, 0,
 				 sndev->self_partition,
-- 
2.7.4

