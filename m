Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726FCC10F14
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 03:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4AD217FA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 03:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDSDJc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:09:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfDSDJc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 23:09:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5AA5BE97BFE522D62D37;
        Fri, 19 Apr 2019 11:02:53 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Apr 2019
 11:02:45 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <kishon@ti.com>, <robh@kernel.org>, <l.stach@pengutronix.de>,
        <andrew.smirnov@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] PCI: keystone: Fix build error while only CONFIG_PCI_KEYSTONE is set
Date:   Fri, 19 Apr 2019 10:58:55 +0800
Message-ID: <20190419025855.40760-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

During randconfig builds, I occasionally run into an invalid configuration

drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_link_up':
pci-keystone.c:(.text+0x90): undefined reference to `__dw_pcie_read_dbi'
pci-keystone.c:(.text+0x90): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_read_dbi'
drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_v3_65_scan_bus':
pci-keystone.c:(.text+0x4f0): undefined reference to `__dw_pcie_write_dbi'
pci-keystone.c:(.text+0x4f0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_write_dbi'

while CONFIG_PCI_KEYSTONE is selected but CONFIG_PCIE_DW
is not set, the building failed like this. This patch
selects PCIE_DW to fix it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5709114f0a97 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b450ad2..641fa0f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -105,6 +105,7 @@ config PCIE_SPEAR13XX
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
 	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
+	select PCIE_DW
 	help
 	  Say Y here if you want to enable PCI controller support on Keystone
 	  SoCs. The PCI controller on Keystone is based on DesignWare hardware
-- 
2.7.4


