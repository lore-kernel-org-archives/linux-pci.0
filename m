Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B2C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F862087C
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCNQzb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:55:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726737AbfCNQz0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Mar 2019 12:55:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AADDAB8322CF9B5AA775;
        Fri, 15 Mar 2019 00:55:22 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Mar 2019 00:55:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <arnd@arndb.de>, <lorenzo.pieralisi@arm.com>,
        <bp@suse.de>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 2/2] hwmon: (f71805f): Use request_region() in f71805f_init()
Date:   Fri, 15 Mar 2019 00:55:16 +0800
Message-ID: <1552582516-70855-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1552582516-70855-1-git-send-email-john.garry@huawei.com>
References: <1552582516-70855-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the driver does not call request_region() prior to
accessing IO port regions in f71805f_init(), so add it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/hwmon/f71805f.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 73c681162653..910082c7f184 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -1617,10 +1617,21 @@ static int __init f71805f_init(void)
 	int err;
 	unsigned short address;
 	struct f71805f_sio_data sio_data;
+	struct resource *res;
+	size_t size = 0x4e - 0x2e + SIO_REG_ADDR + 4;
+
+	/* Request the whole 0x2e - 0x4e region */
+	res = request_region(0x2e, size, "f71805f");
+	if (!res)
+		return -EBUSY;
 
 	if (f71805f_find(0x2e, &address, &sio_data)
-	 && f71805f_find(0x4e, &address, &sio_data))
+	 && f71805f_find(0x4e, &address, &sio_data)) {
+		release_region(0x2e, size);
 		return -ENODEV;
+	}
+
+	release_region(0x2e, size);
 
 	err = platform_driver_register(&f71805f_driver);
 	if (err)
-- 
2.17.1

