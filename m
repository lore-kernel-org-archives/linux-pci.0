Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594BBC43444
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF9920840
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BTW/mPCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfAPKO3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:29 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:45172 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389375AbfAPKO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:28 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1872724E2259;
        Wed, 16 Jan 2019 02:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633668; bh=zBbEca9vdoJAdE7AVVJbN/oEIAIRuQ1gyNHI5CHtSTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BTW/mPCcd+LXZu19Xl7bh1+d4e03euYZCeoqnI3Q3182V2zzyi1pcYi+vUiv6MZuM
         5m5yk/y/hVgw3RmIAFLW57avVJz+Lhw3VVL7E7rvgvXpyOqZivD3MW26bHUDR8VuYb
         IjlZ4OhBKe/2+nEgH+FRQwX52+IjHYuZLCSCMgqfFLpdvz3JC0QhgGh1299w4shnSm
         hr4etLYh+NkrA7MBV276dQBAwcsHOLBkBWQ7A79GHb8qNS4NJFfCwFOJed3SbhjGui
         2BAvssmMUW29i5AFL8bApZUTGUis5WkuSBftvpGbYf6MMDJV5PXVYFg4/DOWfgiNTe
         9Sw85lGUHCHgQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id DAA954E51;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 89E563F695;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 8/9] PCI: dwc: Replace bit rotation operation (1 << bit) by BIT(bit)
Date:   Wed, 16 Jan 2019 11:14:21 +0100
Message-Id: <5fa56ef3a032c2b18201f8aa846b458833e1914c.1547631485.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
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
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d53e6f7..45ff5e4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -207,7 +207,7 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, BIT(bit));
 
 	if (pp->ops->msi_irq_ack)
 		pp->ops->msi_irq_ack(d->hwirq, pp);
-- 
2.7.4

