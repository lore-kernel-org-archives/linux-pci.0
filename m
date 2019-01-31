Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A8C282DB
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E70C218EA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iRRDqu6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfAaSRT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:17:19 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57876 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfAaSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:17:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 7EA1510C0DCE;
        Thu, 31 Jan 2019 10:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958635; bh=oic9lekNdFI5mMLdMQ8oPQPMAQunIlK3j/Kor3B/BBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iRRDqu6iW9ZMy7Ha3KUxGkW/wt9Kf1BDmeyctR5czVtuVIrqQX8l2ALVtyzfuNJv9
         Zr5w4RxYcRJzh/S4hCt6S3LKDi8tGabULdIK83xy0rKkVAKmyxcQutCy9WAmbvGGQT
         FY6NOBFy0IEWt9anuCPbJCTJKhrfG6N21h73IB3CT/ikwfoZMpMewj0iYN6Z4EiAcD
         L4m/PtWvAgUS5Xg/rAzy8QM9yRNS5IOB+kC6zjb/KjOdnVCycKR+mKtsJiQyn5cniL
         YbTwe1ZrNXXqya6jTg8CSidKdbUMgy/vTXueq1V88NuObkhuBRb8k5cZo7H7DYrZxm
         mnFQemTjXxJvA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 49686A009C;
        Thu, 31 Jan 2019 18:17:15 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id F2D893CEE7;
        Thu, 31 Jan 2019 19:17:13 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 7/8] PCI: dwc: Improve code readability and simplifies mask/unmask operations
Date:   Thu, 31 Jan 2019 19:17:06 +0100
Message-Id: <b51fbe8dc580748391a9c3ed8a504ff5792a1e45.1548958059.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Improve code readability and simplifies mask/unmask operations by
inverting the applied logic (no functional change is intended).

Replace variable name from irq_status to irq_mask, since its goal is to
keep track of which interruptions are mask or not.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
Changes v1 -> v2:
 - Move 2 bit rotation operation replacement to patch 8 

 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 768e16a..c550c4a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -164,9 +164,9 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_status[ctrl] &= ~(1 << bit);
+		pp->irq_mask[ctrl] |= (1 << bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    ~pp->irq_status[ctrl]);
+				    pp->irq_mask[ctrl]);
 	}
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
@@ -187,9 +187,9 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_status[ctrl] |= 1 << bit;
+		pp->irq_mask[ctrl] &= ~(1 << bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    ~pp->irq_status[ctrl]);
+				    pp->irq_mask[ctrl]);
 	}
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
@@ -665,13 +665,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	/* Initialize IRQ Status array */
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+		pp->irq_mask[ctrl] = ~0;
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
 					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, ~0);
+				    4, pp->irq_mask[ctrl]);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
 					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
 				    4, ~0);
-		pp->irq_status[ctrl] = 0;
 	}
 
 	/* Setup RC BARs */
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9943d8c..2790002 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -177,7 +177,7 @@ struct pcie_port {
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
 	u32			num_vectors;
-	u32			irq_status[MAX_MSI_CTRLS];
+	u32			irq_mask[MAX_MSI_CTRLS];
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
-- 
2.7.4

