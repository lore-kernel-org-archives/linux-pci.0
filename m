Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AFBC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEF92082E
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfDJPdM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:33:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6147 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730814AbfDJPdM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 11:33:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7811AC04346F639DDEFB;
        Wed, 10 Apr 2019 23:33:09 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 23:32:59 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <thomas.petazzoni@bootlin.com>, <jason@lakedaemon.net>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <gustavo.pimentel@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PCI: mvebu: Make mvebu_pci_bridge_emul_ops static
Date:   Wed, 10 Apr 2019 22:09:49 +0800
Message-ID: <20190410140949.26716-1-yuehaibing@huawei.com>
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

Fix sparse warning:

drivers/pci/controller/pci-mvebu.c:557:28: warning:
 symbol 'mvebu_pci_bridge_emul_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index d3a0419..ed032e9 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -554,7 +554,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	}
 }
 
-struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
+static struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
 	.write_base = mvebu_pci_bridge_emul_base_conf_write,
 	.read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
 	.write_pcie = mvebu_pci_bridge_emul_pcie_conf_write,
-- 
2.7.4


