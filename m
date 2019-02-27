Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF95AC4360F
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 04:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8AD218D0
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 04:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfB0Ekx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:40:53 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:33144 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbfB0Ekx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 23:40:53 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7D76CE85EDBE605184E3;
        Wed, 27 Feb 2019 12:40:42 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1R4eaTr003644;
        Wed, 27 Feb 2019 12:40:36 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019022712405722-2029107 ;
          Wed, 27 Feb 2019 12:40:57 +0800 
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
Subject: [PATCH 2/8] PCI: uniphier: fix a leaked reference by adding missing of_node_put
Date:   Wed, 27 Feb 2019 12:40:37 +0800
Message-Id: <1551242443-27300-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-27 12:40:57,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-27 12:40:29,
        Serialize complete at 2019-02-27 12:40:29
X-MAIL: mse01.zte.com.cn x1R4eaTr003644
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.
irq_domain_add_linear also calls of_node_get to increase refcount,
so irq_domain will not be affected when it is released.

Detected by coccinelle with the following warnings:
./drivers/pci/controller/dwc/pcie-uniphier.c:283:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.
./drivers/pci/controller/dwc/pcie-uniphier.c:290:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.
./drivers/pci/controller/dwc/pcie-uniphier.c:296:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index d5dc402..3f30ee4 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -270,6 +270,7 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
 	struct device_node *np = pci->dev->of_node;
 	struct device_node *np_intc;
+	int ret = 0;
 
 	np_intc = of_get_child_by_name(np, "legacy-interrupt-controller");
 	if (!np_intc) {
@@ -280,20 +281,24 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 	pp->irq = irq_of_parse_and_map(np_intc, 0);
 	if (!pp->irq) {
 		dev_err(pci->dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_put_node;
 	}
 
 	priv->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
 						&uniphier_intx_domain_ops, pp);
 	if (!priv->legacy_irq_domain) {
 		dev_err(pci->dev, "Failed to get INTx domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	irq_set_chained_handler_and_data(pp->irq, uniphier_pcie_irq_handler,
 					 pp);
 
-	return 0;
+out_put_node:
+	of_node_put(np_intc);
+	return ret;
 }
 
 static int uniphier_pcie_host_init(struct pcie_port *pp)
-- 
2.9.5

