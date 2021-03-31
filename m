Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376EAC433E0
	for <linux-pci@archiver.kernel.org>; Wed, 31 Mar 2021 08:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F173761962
	for <linux-pci@archiver.kernel.org>; Wed, 31 Mar 2021 08:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhCaIhk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:37:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15411 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhCaIhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 04:37:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9KQK4lLPzlWn4;
        Wed, 31 Mar 2021 16:35:37 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 16:37:16 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <kishon@ti.com>
Subject: [PATCH -next] PCI: endpoint: fix missing destroy_workqueue()
Date:   Wed, 31 Mar 2021 16:40:12 +0800
Message-ID: <20210331084012.2091010-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the missing destroy_workqueue() before return from
pci_epf_test_init() in the error handling case and add
destroy_workqueue() in pci_epf_test_exit().

Fixes: 349e7a85b25fa ("PCI: endpoint: functions: Add an EP function to test PCI")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 63d5f5c6e3e0..8e24b5e50e4b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -922,6 +922,7 @@ static int __init pci_epf_test_init(void)
 
 	ret = pci_epf_register_driver(&test_driver);
 	if (ret) {
+		destroy_workqueue(kpcitest_workqueue);
 		pr_err("Failed to register pci epf test driver --> %d\n", ret);
 		return ret;
 	}
@@ -932,6 +933,8 @@ module_init(pci_epf_test_init);
 
 static void __exit pci_epf_test_exit(void)
 {
+	if (kpcitest_workqueue)
+		destroy_workqueue(kpcitest_workqueue);
 	pci_epf_unregister_driver(&test_driver);
 }
 module_exit(pci_epf_test_exit);
-- 
2.25.1

