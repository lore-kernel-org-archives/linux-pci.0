Return-Path: <SRS0=+3kZ=UK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA6C43218
	for <linux-pci@archiver.kernel.org>; Tue, 11 Jun 2019 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9859F205ED
	for <linux-pci@archiver.kernel.org>; Tue, 11 Jun 2019 14:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbfFKOOU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:14:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390181AbfFKOOU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 10:14:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 648B6F9D4FA004DE7CD0;
        Tue, 11 Jun 2019 22:14:17 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 11 Jun 2019 22:14:07 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>
CC:     <linux-pci@vger.kernel.org>, <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>, <will.deacon@arm.com>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 3/3] lib: logic_pio: Fix up a print
Date:   Tue, 11 Jun 2019 22:12:54 +0800
Message-ID: <1560262374-67875-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For the print in logic_pio_trans_cpuaddr(), don't cast the value
to unsigned long long, and just print the resource_size_t type directly.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 47d24f428908..030708ce7bb6 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
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

