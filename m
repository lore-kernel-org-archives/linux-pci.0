Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEEBC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 04:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA288218E2
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 04:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfB0ElE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:41:04 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:33594 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbfB0ElD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 23:41:03 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id EC684EE095B8F1DF705A;
        Wed, 27 Feb 2019 12:41:00 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1R4eoKe003741;
        Wed, 27 Feb 2019 12:40:50 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019022712411163-2029141 ;
          Wed, 27 Feb 2019 12:41:11 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     benh@kernel.crashing.org
Cc:     paulus@samba.org, mpe@ellerman.id.au, tyreld@linux.vnet.ibm.com,
        bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryder.lee@mediatek.com, lorenzo.pieralisi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        thomas.petazzoni@bootlin.com, shawn.lin@rock-chips.com,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        hayashi.kunihiko@socionext.com, yamada.masahiro@socionext.com,
        kishon@ti.com, linux-omap@vger.kernel.org, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 6/8] PCI: iproc: fix a leaked reference by adding missing of_node_put
Date:   Wed, 27 Feb 2019 12:40:41 +0800
Message-Id: <1551242443-27300-6-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-27 12:41:11,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-27 12:40:43,
        Serialize complete at 2019-02-27 12:40:43
X-MAIL: mse01.zte.com.cn x1R4eoKe003741
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.
iproc_msi_init also calls of_node_get to increase refcount
(proc_msi_init -> iproc_msi_alloc_domains -> pci_msi_create_irq_domain
-> msi_create_irq_domain -> irq_domain_create_linear -> __irq_domain_add),
so irq_domain will not be affected when it is released.

Detected by coccinelle with the following warnings:
./drivers/pci/controller/pcie-iproc.c:1323:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1299, but without a corresponding object release within this function.
./drivers/pci/controller/pcie-iproc.c:1330:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1299, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/pcie-iproc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..9998c5c 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1320,14 +1320,18 @@ static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
 	if (pcie->need_msi_steer) {
 		ret = iproc_pcie_msi_steer(pcie, msi_node);
 		if (ret)
-			return ret;
+			goto out_put_node;
 	}
 
 	/*
 	 * If another MSI controller is being used, the call below should fail
 	 * but that is okay
 	 */
-	return iproc_msi_init(pcie, msi_node);
+	ret = iproc_msi_init(pcie, msi_node);
+
+out_put_node:
+	of_node_put(msi_node);
+	return ret;
 }
 
 static void iproc_pcie_msi_disable(struct iproc_pcie *pcie)
-- 
2.9.5

