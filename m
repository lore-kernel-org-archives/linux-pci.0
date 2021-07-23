Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E449C4320E
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 03:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414F960ED6
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 03:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhGWCz4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Jul 2021 22:55:56 -0400
Received: from mx21.baidu.com ([220.181.3.85]:37746 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233621AbhGWCzz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 22:55:55 -0400
Received: from BJHW-Mail-Ex06.internal.baidu.com (unknown [10.127.64.16])
        by Forcepoint Email with ESMTPS id 63F56DD505479884EB6D;
        Fri, 23 Jul 2021 11:36:27 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex06.internal.baidu.com (10.127.64.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 23 Jul 2021 11:36:27 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 23 Jul 2021 11:36:26 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <kw@linux.com>, <bhelgaas@google.com>,
        <jonathan.derrick@intel.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v3 2/2] PCI: vmd: Make use of PCI_DEVICE_DATA() helper macro
Date:   Fri, 23 Jul 2021 11:36:18 +0800
Message-ID: <20210723033618.1025-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723033618.1025-1-caihuoqing@baidu.com>
References: <20210723033618.1025-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex06_2021-07-23 11:36:27:404
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We could make use of PCI_DEVICE_DATA() helper macro

v1->v2: *fix extra indent which for git-apply failure

v2->v3: *update the subject line from "function" to "macro"
	*add changelog to commit message

commit date: 7-23-2021 11:00

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/pci/controller/vmd.c | 38 ++++++++++++++++++------------------
 include/linux/pci_ids.h      |  2 ++
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e3fcdfec58b3..565681ed00a1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -859,25 +859,25 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
-	{0,}
+	{ PCI_DEVICE_DATA(INTEL, VMD_201D,
+			  VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) },
+	{ PCI_DEVICE_DATA(INTEL, VMD_28C0,
+			  VMD_FEAT_HAS_MEMBAR_SHADOW |
+			  VMD_FEAT_HAS_BUS_RESTRICTIONS |
+			  VMD_FEAT_CAN_BYPASS_MSI_REMAP) },
+	{ PCI_DEVICE_DATA(INTEL, VMD_467F,
+			  VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+			  VMD_FEAT_HAS_BUS_RESTRICTIONS |
+			  VMD_FEAT_OFFSET_FIRST_VECTOR) },
+	{ PCI_DEVICE_DATA(INTEL, VMD_4C3D,
+			  VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+			  VMD_FEAT_HAS_BUS_RESTRICTIONS |
+			  VMD_FEAT_OFFSET_FIRST_VECTOR) },
+	{ PCI_DEVICE_DATA(INTEL, VMD_9A0B,
+			  VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+			  VMD_FEAT_HAS_BUS_RESTRICTIONS |
+			  VMD_FEAT_OFFSET_FIRST_VECTOR) },
+	{ },
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4bac1831de80..d25552b5ae3e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2954,6 +2954,8 @@
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
+#define PCI_DEVICE_ID_INTEL_VMD_467F	0x467f
+#define PCI_DEVICE_ID_INTEL_VMD_4C3D	0x4c3d
 #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
 #define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
 #define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
-- 
2.25.1

