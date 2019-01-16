Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27330C43612
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB63C208E4
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D82nbeIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389381AbfAPKO2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:28 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:33040 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389383AbfAPKO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:28 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 11A0210C1695;
        Wed, 16 Jan 2019 02:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633668; bh=uA6qbseqHwCa5BtKvSKzULlLoVbYiRGD1ednhCfc3O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=D82nbeIHhBV1veKezecnn6MB2cPBH98W79gMpuc/l48E5x/bMdKA3+8JI/XTdiSCk
         ItqO658K5c4tjIwexaNbyWUDr3l0zrxwJZi7lySKFq3F2k+DLXhtLZ+mEdiSx9WeiP
         gh1Yf5NB8N+QC8eEDQRtq2mD9dFkaRePaihkAAmvNxlHLo7W6G4CcF5tMh8DPMtxO5
         KL/XaKbTAV/ueyV6o9vnUD+LsBLahIArEgINv+DU9YW242HOquwCffrpaSAlzlb3+6
         eO/tIdWIXBJxjLN4HCwyUCyQa6Ub1hoMPNW1K0gnzJLzlkAJrjqZsSVukz/POhU17A
         OeF32MAwnKGAw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id D22465823;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 78DCE3F692;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 7/9] PCI: dwc: Improve code readability and simplifies mask/unmask operations
Date:   Wed, 16 Jan 2019 11:14:20 +0100
Message-Id: <eba21fed997cdf148bc03cb459c12d1a32a77a8f.1547631485.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Improve code readability and simplifies mask/unmask operations by
inverting the applied logic (no functional change is intended).

Replace variable name from irq_status to irq_mask, since its goal is to
keep track of which interuptions are mask or not.

Replace bit rotation operation (1 << bit) by BIT(bit), which simplifies
code reading.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 768e16a..d53e6f7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -164,9 +164,9 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_status[ctrl] &= ~(1 << bit);
+		pp->irq_mask[ctrl] |= BIT(bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    ~pp->irq_status[ctrl]);
+				    pp->irq_mask[ctrl]);
 	}
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
@@ -187,9 +187,9 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_status[ctrl] |= 1 << bit;
+		pp->irq_mask[ctrl] &= ~BIT(bit);
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

