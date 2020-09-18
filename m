Return-Path: <SRS0=Geob=C3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FB4C43463
	for <linux-pci@archiver.kernel.org>; Fri, 18 Sep 2020 02:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D70235F8
	for <linux-pci@archiver.kernel.org>; Fri, 18 Sep 2020 02:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgIRCqS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:46:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728523AbgIRCqK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 22:46:10 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 93F1AEE62C376AEAFF42;
        Fri, 18 Sep 2020 10:46:08 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 10:45:57 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] PCI: iproc: use module_bcma_driver to simplify the code
Date:   Fri, 18 Sep 2020 11:08:29 +0800
Message-ID: <20200918030829.3946025-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

module_bcma_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/pci/controller/pcie-iproc-bcma.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index aa55b064f64d..56b8ee7bf330 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -94,18 +94,7 @@ static struct bcma_driver iproc_pcie_bcma_driver = {
 	.probe		= iproc_pcie_bcma_probe,
 	.remove		= iproc_pcie_bcma_remove,
 };
-
-static int __init iproc_pcie_bcma_init(void)
-{
-	return bcma_driver_register(&iproc_pcie_bcma_driver);
-}
-module_init(iproc_pcie_bcma_init);
-
-static void __exit iproc_pcie_bcma_exit(void)
-{
-	bcma_driver_unregister(&iproc_pcie_bcma_driver);
-}
-module_exit(iproc_pcie_bcma_exit);
+module_bcma_driver(iproc_pcie_bcma_driver);
 
 MODULE_AUTHOR("Hauke Mehrtens");
 MODULE_DESCRIPTION("Broadcom iProc PCIe BCMA driver");
-- 
2.25.1

