Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F312C433ED
	for <linux-pci@archiver.kernel.org>; Sat, 17 Apr 2021 11:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1784A611AC
	for <linux-pci@archiver.kernel.org>; Sat, 17 Apr 2021 11:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhDQLoX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 17 Apr 2021 07:44:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16598 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhDQLoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Apr 2021 07:44:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FMrl23Ljwz17Qn2;
        Sat, 17 Apr 2021 19:41:34 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Sat, 17 Apr 2021
 19:43:51 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <bhelgaas@google.com>
CC:     <alexander.deucher@amd.com>, <Prike.Liang@amd.com>,
        <chaitanya.kulkarni@wdc.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] PCI: remove unused variable rdev
Date:   Sat, 17 Apr 2021 19:42:58 +0800
Message-ID: <20210417114258.23640-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the build warning:

drivers/pci/quirks.c: In function ‘quirk_amd_nvme_fixup’:
drivers/pci/quirks.c:312:18: warning: unused variable ‘rdev’ [-Wunused-variable]
  struct pci_dev *rdev;
                  ^~~~

Fixes: 9597624ef606 ('nvme: put some AMD PCIE downstream NVME device to simple suspend/resume path')
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/pci/quirks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2e24dced699a..c86ede081534 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -309,8 +309,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopci
 
 static void quirk_amd_nvme_fixup(struct pci_dev *dev)
 {
-	struct pci_dev *rdev;
-
 	dev->dev_flags |= PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND;
 	pci_info(dev, "AMD simple suspend opt enabled\n");
 
-- 
2.17.1

