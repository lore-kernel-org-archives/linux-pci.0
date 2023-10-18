Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A71CDB474
	for <linux-pci@archiver.kernel.org>; Wed, 18 Oct 2023 01:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjJRBF7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Oct 2023 21:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJRBF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 21:05:58 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED26B0;
        Tue, 17 Oct 2023 18:05:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VuOo5c-_1697591152;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VuOo5c-_1697591152)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 09:05:53 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] PCI: Remove duplicated include in pci.c
Date:   Wed, 18 Oct 2023 09:05:51 +0800
Message-Id: <20231018010551.118071-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

./drivers/pci/pci.c: linux/bitfield.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6898
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5b70eefc38fc..92b8dafec0d9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -32,7 +32,6 @@
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
-#include <linux/bitfield.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
-- 
2.20.1.7.g153144c

