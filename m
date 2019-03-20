Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A67C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD18218A3
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCTSOZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:14:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbfCTSOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 14:14:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C98EF94934574973E31D;
        Thu, 21 Mar 2019 02:14:22 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Mar 2019 02:14:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>, <bp@suse.de>
CC:     <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linuxarm@huawei.com>, <agraf@suse.de>,
        <andy.shevchenko@gmail.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 3/3] lib: logic_pio: Make some prints explicitly hex
Date:   Thu, 21 Mar 2019 02:14:10 +0800
Message-ID: <1553105650-28012-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some prints in the code are for a hex number, but don't prefix "0x". Add
the prefix, as is the norm.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 026a4fb4b944..6b37cc79a0bf 100644
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
 
@@ -186,7 +186,7 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 		if (in_range(addr, range->hw_start, range->size))
 			return addr - range->hw_start + range->io_start;
 	}
-	pr_err("addr %llx not registered in io_range_list\n",
+	pr_err("addr 0x%llx not registered in io_range_list\n",
 	       (unsigned long long) addr);
 	return ~0UL;
 }
-- 
2.17.1

