Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D075C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 06:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164992073F
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 06:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfDOGm4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:42:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59107 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOGmx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 02:42:53 -0400
X-IronPort-AV: E=Sophos;i="5.60,352,1549954800"; 
   d="scan'208";a="31501915"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2019 23:42:52 -0700
Received: from AUSMBX2.microsemi.net (10.201.34.32) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 15 Apr
 2019 01:42:51 -0500
Received: from server1.microsemi.net (10.188.116.154) by ausmbx2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 15 Apr 2019 01:42:48 -0500
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>
Subject: [PATCH v2 2/2] switchtec: Fix unintended mask of MRPC event
Date:   Mon, 15 Apr 2019 22:41:42 +0800
Message-ID: <1555339302-31829-3-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
References: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When running application tool switchtec-user's `firmware update` and
`event wait` commands concurrently, sometimes the firmware update
speed reduced evidently.

It is because when the MRPC event happened right after MRPC event
occurrence check but before event mask loop reach to its header
register in event ISR, the MRPC event would be masked unintentionally.
Since there's no chance to enable it again except for a module reload,
all the following MRPC execution completion check will be deferred to
timeout.

Fix this bug by skipping the mask operation for MRPC event in event
ISR, same as what we already do for LINK event.

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/pci/switch/switchtec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 7df9a69..30f6e08 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1177,7 +1177,8 @@ static int mask_event(struct switchtec_dev *stdev, int eid, int idx)
 	if (!(hdr & SWITCHTEC_EVENT_OCCURRED && hdr & SWITCHTEC_EVENT_EN_IRQ))
 		return 0;
 
-	if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE)
+	if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE ||
+	    eid == SWITCHTEC_IOCTL_EVENT_MRPC_COMP)
 		return 0;
 
 	dev_dbg(&stdev->dev, "%s: %d %d %x\n", __func__, eid, idx, hdr);
-- 
2.7.4

