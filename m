Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB6BC6FD1C
	for <linux-pci@archiver.kernel.org>; Thu, 23 Mar 2023 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCWJQy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 Mar 2023 05:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjCWJQw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 05:16:52 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A27B1CF68;
        Thu, 23 Mar 2023 02:16:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VeTkQZk_1679563004;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VeTkQZk_1679563004)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 17:16:45 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     marek.vasut+renesas@gmail.com
Cc:     yoshihiro.shimoda.uh@renesas.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] PCI: rcar-gen2: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 23 Mar 2023 17:16:44 +0800
Message-Id: <20230323091644.91981-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pci/controller/pci-rcar-gen2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 839695791757..d29866485361 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -290,8 +290,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	priv = pci_host_bridge_priv(bridge);
 	bridge->sysdata = priv;
 
-	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(dev, cfg_res);
+	reg = devm_platform_get_and_ioremap_resource(pdev, 0, &cfg_res);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-- 
2.20.1.7.g153144c

