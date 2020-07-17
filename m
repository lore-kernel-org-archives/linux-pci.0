Return-Path: <SRS0=0+Fi=A4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B3C433E8
	for <linux-pci@archiver.kernel.org>; Fri, 17 Jul 2020 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB87520737
	for <linux-pci@archiver.kernel.org>; Fri, 17 Jul 2020 08:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGQIGH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:06:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbgGQIGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 04:06:07 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DD773C5387197067B19F;
        Fri, 17 Jul 2020 16:06:04 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 16:05:56 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] PCI/ASPM: add missing newline when printing parameter 'policy' by sysfs
Date:   Fri, 17 Jul 2020 15:59:25 +0800
Message-ID: <1594972765-10404-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When I cat ASPM parameter 'policy' by sysfs, it displays as follows.
It's better to add a newline for easy reading.

[root@localhost ~]# cat /sys/module/pcie_aspm/parameters/policy
[default] performance powersave powersupersave [root@localhost ~]#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/pcie/aspm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ff..253c30c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1182,6 +1182,7 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
 			cnt += sprintf(buffer + cnt, "[%s] ", policy_str[i]);
 		else
 			cnt += sprintf(buffer + cnt, "%s ", policy_str[i]);
+	cnt += sprintf(buffer + cnt, "\n");
 	return cnt;
 }
 
-- 
1.7.12.4

