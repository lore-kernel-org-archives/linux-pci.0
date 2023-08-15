Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E2EC001DB
	for <linux-pci@archiver.kernel.org>; Tue, 15 Aug 2023 02:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjHOC2J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Aug 2023 22:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjHOC1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 22:27:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C117110F9
        for <linux-pci@vger.kernel.org>; Mon, 14 Aug 2023 19:27:48 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPw9M392WzTmLR;
        Tue, 15 Aug 2023 10:25:43 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 10:27:46 +0800
From:   Jialin Zhang <zhangjialin11@huawei.com>
To:     <bhelgaas@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>
CC:     <x86@kernel.org>, <linux-pci@vger.kernel.org>,
        <liwei391@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] x86/PCI: Use pci_dev_id() to simplify the code
Date:   Tue, 15 Aug 2023 10:24:40 +0800
Message-ID: <20230815022440.3513792-1-zhangjialin11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500021.china.huawei.com (7.185.36.109)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it mannually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
---
 arch/x86/pci/pcbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 4f15280732ed..fc05ec31cabf 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -412,7 +412,7 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
 		"1:"
 		: "=a" (ret)
 		: "0" (PCIBIOS_SET_PCI_HW_INT),
-		  "b" ((dev->bus->number << 8) | dev->devfn),
+		  "b" (pci_dev_id(dev)),
 		  "c" ((irq << 8) | (pin + 10)),
 		  "S" (&pci_indirect));
 	return !(ret & 0xff00);
-- 
2.25.1

