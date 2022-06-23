Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F3C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 23 Jun 2022 08:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiFWIpo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 Jun 2022 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFWIpn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 04:45:43 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C270149249;
        Thu, 23 Jun 2022 01:45:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VHAqFao_1655973934;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VHAqFao_1655973934)
          by smtp.aliyun-inc.com;
          Thu, 23 Jun 2022 16:45:39 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kishon@ti.com
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] NTB: EPF: Fix missing error code in epf_ntb_bind()
Date:   Thu, 23 Jun 2022 16:45:31 +0800
Message-Id: <20220623084531.39837-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'ret'.

This was found by smatch:

drivers/pci/endpoint/functions/pci-epf-vntb.c:1317 epf_ntb_bind() warn: missing error code 'ret'.

Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ebf7e243eefa..8791638b9f48 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1314,6 +1314,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 
 	if (pci_register_driver(&vntb_pci_driver)) {
 		dev_err(dev, "failure register vntb pci driver\n");
+		ret = -EINVAL;
 		goto err_bar_alloc;
 	}
 
-- 
2.20.1.7.g153144c

