Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A53C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 08:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CAA20693
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 08:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfDOInQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:43:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfDOInQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 04:43:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 971DA8F003A36CA3514E;
        Mon, 15 Apr 2019 16:43:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Mon, 15 Apr 2019 16:43:07 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <wangzhou1@hisilicon.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci: fix warning for struct hisi_pcie_platform_ops
Date:   Mon, 15 Apr 2019 16:53:49 +0800
Message-ID: <20190415085349.161915-1-maowenan@huawei.com>
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

There is one warning exist while compiling drivers/pci/controller/dwc/pcie-hisi.c.
make allmodconfig ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
make C=2 drivers/pci/controller/dwc/pcie-hisi.o ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
drivers/pci/controller/dwc/pcie-hisi.c:365:21: warning: symbol 'hisi_pcie_platform_ops' was not declared. Should it be static?

Fixes: a2ec1996098("PCI: hisi: Add DT almost-ECAM support for Hip06/Hip07 host controllers")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/pci/controller/dwc/pcie-hisi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 6d9e1b2..11f5ff7 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -362,7 +362,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 	return 0;
 }
 
-struct pci_ecam_ops hisi_pcie_platform_ops = {
+static struct pci_ecam_ops hisi_pcie_platform_ops = {
 	.bus_shift    = 20,
 	.init         =  hisi_pcie_platform_init,
 	.pci_ops      = {
-- 
2.7.4

