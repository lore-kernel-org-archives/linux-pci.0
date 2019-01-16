Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB19C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96220859
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IykJU4Gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfAPKO2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:28 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33036 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389375AbfAPKO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:27 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 36FE710C1693;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633667; bh=IM7nXdcu0j9tzOpvJdjF/J4thqpNS6vBjWj5ntqlw3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=IykJU4Glx8WS0OI4TOXtRO7KDP6M7WZ/ix04lELFaRlTIclAaDa1Aar7u7RI9q2GJ
         arJ5LFN3KfXG3v4UbGodn/CdCPrzm4l5010qymXX5U2pnyioY380imy0z3CH1E/ezv
         KrthZtLGIrwql9yQdjq4ytpH2i2HxKuTRX+/1aQZVVGG9BUWs4GC2WX14KnxQHnvm8
         FGGK04I/FM3pqdgtmxulXaTDEQazlvjk3d4R3rY8myO7ciKYwp4O8xZods1gSsd2+a
         cx2UnexmOrXmvCMMdFe0JaHvynQGuLfUP927EHh3HpAqviFGTtAfhLsnjRH01CpAso
         2JAiC2QeGRQ3w==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0036D581D;
        Wed, 16 Jan 2019 02:14:26 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 3730A3F686;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 3/9] PCI: dwc: Replace variable name from data to d on dw_pci_bottom_mask/unmask()
Date:   Wed, 16 Jan 2019 11:14:16 +0100
Message-Id: <ab9e5de92e2c8c29ec1ee8b1303430c57fb937e5.1547631485.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace variable from data to d to maintain coherency between similar
functions, such as dw_msi_mask_irq() and dw_msi_unmask_irq().

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 721d60a..36e284c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -149,20 +149,20 @@ static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
 	return -EINVAL;
 }
 
-static void dw_pci_bottom_mask(struct irq_data *data)
+static void dw_pci_bottom_mask(struct irq_data *d)
 {
-	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	unsigned int res, bit, ctrl;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
 	if (pp->ops->msi_clear_irq) {
-		pp->ops->msi_clear_irq(pp, data->hwirq);
+		pp->ops->msi_clear_irq(pp, d->hwirq);
 	} else {
-		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+		ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
+		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 		pp->irq_status[ctrl] &= ~(1 << bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
@@ -172,20 +172,20 @@ static void dw_pci_bottom_mask(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
-static void dw_pci_bottom_unmask(struct irq_data *data)
+static void dw_pci_bottom_unmask(struct irq_data *d)
 {
-	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	unsigned int res, bit, ctrl;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
 	if (pp->ops->msi_set_irq) {
-		pp->ops->msi_set_irq(pp, data->hwirq);
+		pp->ops->msi_set_irq(pp, d->hwirq);
 	} else {
-		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+		ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
+		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 		pp->irq_status[ctrl] |= 1 << bit;
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-- 
2.7.4

