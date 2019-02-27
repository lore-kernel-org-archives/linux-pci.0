Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E596C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 04:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5629D218E2
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 04:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfB0ElH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:41:07 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:33722 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbfB0ElG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 23:41:06 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id C5986E7FC1E71E940983;
        Wed, 27 Feb 2019 12:41:03 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1R4er4r003758;
        Wed, 27 Feb 2019 12:40:53 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019022712411405-2029145 ;
          Wed, 27 Feb 2019 12:41:14 +0800 
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
Subject: [PATCH 7/8] PCI: mediatek: fix a leaked reference by adding missing of_node_put
Date:   Wed, 27 Feb 2019 12:40:42 +0800
Message-Id: <1551242443-27300-7-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-27 12:41:14,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-27 12:40:45,
        Serialize complete at 2019-02-27 12:40:45
X-MAIL: mse01.zte.com.cn x1R4er4r003758
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.
irq_domain_add_linear also calls of_node_get to increase refcount,
so irq_domain will not be affected when it is released.

Detected by coccinelle with the following warnings:
./drivers/pci/controller/pcie-mediatek.c:577:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.
./drivers/pci/controller/pcie-mediatek.c:583:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.
./drivers/pci/controller/pcie-mediatek.c:586:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pcie-mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 55e471c..e91716a 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -572,6 +572,7 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 
 	port->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						 &intx_domain_ops, port);
+	of_node_put(pcie_intc_node);
 	if (!port->irq_domain) {
 		dev_err(dev, "failed to get INTx IRQ domain\n");
 		return -ENODEV;
-- 
2.9.5

