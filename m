Return-Path: <SRS0=VYo7=45=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AE2C10DCE
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8363C20663
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 14:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCLOMI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:12:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgCLOMI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 10:12:08 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08370A387A1824FBB9C2;
        Thu, 12 Mar 2020 22:11:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 22:11:44 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <paulus@samba.org>, <mpe@ellerman.id.au>, <tyreld@linux.ibm.com>,
        <bhelgaas@google.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] PCI: rpaphp: remove set but not used variable 'value'
Date:   Thu, 12 Mar 2020 22:04:12 +0800
Message-ID: <20200312140412.32373-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pci/hotplug/rpaphp_core.c: In function is_php_type:
drivers/pci/hotplug/rpaphp_core.c:291:16: warning:
	variable value set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index e408e40..5d871ef 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -288,11 +288,10 @@ EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
 
 static int is_php_type(char *drc_type)
 {
-	unsigned long value;
 	char *endptr;
 
 	/* PCI Hotplug nodes have an integer for drc_type */
-	value = simple_strtoul(drc_type, &endptr, 10);
+	simple_strtoul(drc_type, &endptr, 10);
 	if (endptr == drc_type)
 		return 0;
 
-- 
2.7.4

