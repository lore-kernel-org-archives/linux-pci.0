Return-Path: <SRS0=ePXr=BL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C9C433E0
	for <linux-pci@archiver.kernel.org>; Sat,  1 Aug 2020 07:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76DE206E9
	for <linux-pci@archiver.kernel.org>; Sat,  1 Aug 2020 07:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHAHoS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Aug 2020 03:44:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgHAHoR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Aug 2020 03:44:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58234792E216C851B367;
        Sat,  1 Aug 2020 15:44:14 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 1 Aug 2020 15:44:09 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <mj@ucw.cz>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH] lspci: Decode 10-Bit Tag Requester Enable
Date:   Sat, 1 Aug 2020 15:21:20 +0800
Message-ID: <1596266480-52789-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Decode 10-Bit Tag Requester Enable bit in Device Control 2 Register.

Sample output changes:

  - DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
  + DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 lib/header.h | 1 +
 ls-caps.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/header.h b/lib/header.h
index 472816e..eaf6517 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -898,6 +898,7 @@
 #define  PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP	0x0100	/* 64bit AtomicOp Completer Supported */
 #define  PCI_EXP_DEVCAP2_128BIT_CAS_COMP	0x0200	/* 128bit CAS Completer Supported */
 #define  PCI_EXP_DEV2_LTR		0x0400	/* LTR enabled */
+#define  PCI_EXP_DEV2_10BIT_TAG_REQ	0x1000 /* 10 Bit Tag Requester enabled */
 #define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
 #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
diff --git a/ls-caps.c b/ls-caps.c
index a09b0cf..d17cbad 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1134,10 +1134,11 @@ static void cap_express_dev2(struct device *d, int where, int type)
     }
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
-  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c OBFF %s,",
+  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c 10BitTagReq%c OBFF %s,",
 	cap_express_dev2_timeout_value(PCI_EXP_DEV2_TIMEOUT_VALUE(w)),
 	FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS),
 	FLAG(w, PCI_EXP_DEV2_LTR),
+	FLAG(w, PCI_EXP_DEV2_10BIT_TAG_REQ),
 	cap_express_devctl2_obff(PCI_EXP_DEV2_OBFF(w)));
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
     printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEV2_ARI));
-- 
1.9.1

