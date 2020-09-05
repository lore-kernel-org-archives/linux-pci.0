Return-Path: <SRS0=GNfH=CO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24714C43461
	for <linux-pci@archiver.kernel.org>; Sat,  5 Sep 2020 02:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54EA20791
	for <linux-pci@archiver.kernel.org>; Sat,  5 Sep 2020 02:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIECt0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Sep 2020 22:49:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbgIECtZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 22:49:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68EEBEB0DB26FD01E358;
        Sat,  5 Sep 2020 10:49:21 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 10:49:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <bhelgaas@google.com>, <gcherian@marvell.com>,
        <guohanjun@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH] arm64: PCI: fix memleak when calling pci_iomap/unmap()
Date:   Sat, 5 Sep 2020 10:48:11 +0800
Message-ID: <20200905024811.74701-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

config GENERIC_IOMAP is disabled on arm64, so pci_iounmap() does
nothing, when we using pci_iomap/pci_iounmap(), it will lead to
memory leak. Implements pci_iounmap() for arm64 to fix this leak.

Fixes: 09a5723983e3 ("arm64: Use include/asm-generic/io.h")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/include/asm/io.h | 5 +++++
 arch/arm64/kernel/pci.c     | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ff50dd731852d..4d8da06ac295f 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -18,6 +18,11 @@
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
 
+#ifdef CONFIG_PCI
+struct pci_dev;
+#define pci_iounmap pci_iounmap
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
+#endif
 /*
  * Generic IO read/write.  These perform native-endian accesses.
  */
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c604..ddfa1c53def48 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -217,4 +217,9 @@ void pcibios_remove_bus(struct pci_bus *bus)
 	acpi_pci_remove_bus(bus);
 }
 
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iounmap);
 #endif
-- 
2.25.1

