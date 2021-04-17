Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A9C433ED
	for <linux-pci@archiver.kernel.org>; Sat, 17 Apr 2021 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DF361152
	for <linux-pci@archiver.kernel.org>; Sat, 17 Apr 2021 10:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhDQKUc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 17 Apr 2021 06:20:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17358 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbhDQKU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Apr 2021 06:20:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FMptC6F5dz7vcd;
        Sat, 17 Apr 2021 18:17:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 17 Apr 2021 18:19:51 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <gregkh@linuxfoundation.org>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH RESEND 4/4] MAINTAINERS: Add maintainer for HiSilicon PTT driver
Date:   Sat, 17 Apr 2021 18:17:11 +0800
Message-ID: <1618654631-42454-5-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainer for driver and documentation of HiSilicon PTT device.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fdc513..647f0bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8084,6 +8084,13 @@ W:	http://www.hisilicon.com
 F:	Documentation/admin-guide/perf/hisi-pmu.rst
 F:	drivers/perf/hisilicon
 
+HISILICON PTT DRIVER
+M:	Yicong Yang <yangyicong@hisilicon.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/trace/hisi-ptt.rst
+F:	drivers/hwtracing/hisilicon/
+
 HISILICON QM AND ZIP Controller DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.8.1

