Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1144C433ED
	for <linux-pci@archiver.kernel.org>; Thu, 15 Apr 2021 08:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FCE611AD
	for <linux-pci@archiver.kernel.org>; Thu, 15 Apr 2021 08:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhDOIbF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:31:05 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:37696 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231251AbhDOIbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 04:31:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UVdbOP7_1618475423;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVdbOP7_1618475423)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 16:30:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] PCI: shpchp: remove unused function
Date:   Thu, 15 Apr 2021 16:30:22 +0800
Message-Id: <1618475422-96531-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following clang warning:

drivers/pci/hotplug/shpchp_hpc.c:177:20: warning: unused function
'shpc_writeb' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/pci/hotplug/shpchp_hpc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index db04728..9e3b277 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -174,11 +174,6 @@ static inline u8 shpc_readb(struct controller *ctrl, int reg)
 	return readb(ctrl->creg + reg);
 }
 
-static inline void shpc_writeb(struct controller *ctrl, int reg, u8 val)
-{
-	writeb(val, ctrl->creg + reg);
-}
-
 static inline u16 shpc_readw(struct controller *ctrl, int reg)
 {
 	return readw(ctrl->creg + reg);
-- 
1.8.3.1

