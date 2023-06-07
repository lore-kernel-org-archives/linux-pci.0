Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C25C7EE29
	for <linux-pci@archiver.kernel.org>; Wed,  7 Jun 2023 09:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjFGJfq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbjFGJf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 05:35:29 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E31720;
        Wed,  7 Jun 2023 02:35:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vka6Hhf_1686130515;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vka6Hhf_1686130515)
          by smtp.aliyun-inc.com;
          Wed, 07 Jun 2023 17:35:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mani@kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] PCI: endpoint: Remove redundant dev_err().
Date:   Wed,  7 Jun 2023 17:35:14 +0800
Message-Id: <20230607093514.104012-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

Eliminate the following warning:
./drivers/pci/endpoint/functions/pci-epf-mhi.c:362:2-9: line 362 is redundant because platform_get_irq_byname() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5449
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 1227f059ea12..371d6f80845e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -359,7 +359,6 @@ static int pci_epf_mhi_bind(struct pci_epf *epf)
 
 	ret = platform_get_irq_byname(pdev, "doorbell");
 	if (ret < 0) {
-		dev_err(dev, "Failed to get Doorbell IRQ\n");
 		iounmap(epf_mhi->mmio);
 		return ret;
 	}
-- 
2.20.1.7.g153144c

