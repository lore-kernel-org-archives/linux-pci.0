Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990B0C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 10:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAB0214C5
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 10:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAB0214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeIZRJ1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:09:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbeIZRJ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 13:09:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3D3DB4B5CDEC3;
        Wed, 26 Sep 2018 18:56:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Wed, 26 Sep 2018 18:56:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kees Cook <keescook@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Frederick Lawler <fred@fredlawl.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-pci@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] PCI: hotplug: Remove set but not used variable 'physical_slot'
Date:   Wed, 26 Sep 2018 11:06:02 +0000
Message-ID: <1537959962-83251-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pci/hotplug/cpqphp_core.c: In function 'init_SERR':
drivers/pci/hotplug/cpqphp_core.c:124:5: warning:
 variable 'physical_slot' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/hotplug/cpqphp_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 95b7d60..16bbb18 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -121,7 +121,6 @@ static int init_SERR(struct controller *ctrl)
 {
 	u32 tempdword;
 	u32 number_of_slots;
-	u8 physical_slot;
 
 	if (!ctrl)
 		return 1;
@@ -131,7 +130,6 @@ static int init_SERR(struct controller *ctrl)
 	number_of_slots = readb(ctrl->hpc_reg + SLOT_MASK) & 0x0F;
 	/* Loop through slots */
 	while (number_of_slots) {
-		physical_slot = tempdword;
 		writeb(0, ctrl->hpc_reg + SLOT_SERR);
 		tempdword++;
 		number_of_slots--;

