Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE51C282D9
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946E8218F0
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P+MH0E9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfAaSRQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:17:16 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:54738 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfAaSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:17:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 8727C24E1F11;
        Thu, 31 Jan 2019 10:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958635; bh=nds9Wsyh0OcJIngPG/I9ixlv/o0bm9GA23x9r/XamaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=P+MH0E9BkKQg9E9TRs1UJOub3kDVf/IqrH+cK8ME3beiJ+WsgAvGPBVDByMxAhxfp
         4ejqzEH9uswrzlJUiayXdUZNsNSrp11SsxGe3stAG53fuGKmS7ZLV28VlJ9fdSbBoE
         PoJwQENLSxhsgy6C8OlobVlZUIGmyu3bUZgZkMqnaRXCJO/mj8vRjz9/U+hGl3Ph1U
         y9vRqudMIUD2OiAkgdp+LQbAUQRhjt7P9RdxIFCCGr8Bb2A0tG45TilHY+uw59BHCU
         1IiHfwNJWpNsl3QLHxs6BwoW5lrSSUazfagwZ6dTKd+HnLGaeXQRn2KoFy4yWjMqj9
         q9Iz5PnADVjHA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4F890A00A2;
        Thu, 31 Jan 2019 18:17:15 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 11FA93CEEB;
        Thu, 31 Jan 2019 19:17:14 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 8/8] PCI: dwc: Replace bit rotation operation (1 << bit) by BIT(bit)
Date:   Thu, 31 Jan 2019 19:17:07 +0100
Message-Id: <6b48a7bb3cd30173acc5d09688fb82c691127087.1548958059.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace bit rotation operation (1 << bit) by BIT(bit), which simplifies
code reading.

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
Changes v1 -> v2:
 - No changes 

 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c550c4a..45ff5e4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -164,7 +164,7 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_mask[ctrl] |= (1 << bit);
+		pp->irq_mask[ctrl] |= BIT(bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
 				    pp->irq_mask[ctrl]);
 	}
@@ -187,7 +187,7 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_mask[ctrl] &= ~(1 << bit);
+		pp->irq_mask[ctrl] &= ~BIT(bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
 				    pp->irq_mask[ctrl]);
 	}
@@ -207,7 +207,7 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, BIT(bit));
 
 	if (pp->ops->msi_irq_ack)
 		pp->ops->msi_irq_ack(d->hwirq, pp);
-- 
2.7.4

