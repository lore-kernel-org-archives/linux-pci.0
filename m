Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC7C10F0C
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E512177E
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfDDQAc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:00:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbfDDQAb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 12:00:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DBA45B9441FD9080D1A1;
        Fri,  5 Apr 2019 00:00:28 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Fri, 5 Apr 2019 00:00:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>
CC:     <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <bp@suse.de>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v3 4/4] lib: logic_pio: Fix up some prints
Date:   Fri, 5 Apr 2019 00:00:02 +0800
Message-ID: <1554393602-152448-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A print in find_io_range() is for a hex number, but doesn't prefix "0x".
Add the prefix, as is the norm.

In the case of the print in logic_pio_trans_cpuaddr(), don't cast the
value to unsigned long long, and just print the resource_size_t type
directly.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 3d8d986e9dcb..475d469c1a16 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -126,7 +126,7 @@ static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
 		if (in_range(pio, range->io_start, range->size))
 			return range;
 	}
-	pr_err("PIO entry token %lx invalid\n", pio);
+	pr_err("PIO entry token 0x%lx invalid\n", pio);
 	return NULL;
 }
 
@@ -186,8 +186,7 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 		if (in_range(addr, range->hw_start, range->size))
 			return addr - range->hw_start + range->io_start;
 	}
-	pr_err("addr %llx not registered in io_range_list\n",
-	       (unsigned long long) addr);
+	pr_err("addr %pa not registered in io_range_list\n",  &addr);
 	return ~0UL;
 }
 
-- 
2.17.1

