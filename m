Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AAFC282DA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28738218F0
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e7Ofv91y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfAaSRQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:17:16 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:54716 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfAaSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:17:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id ACB9F24E1F07;
        Thu, 31 Jan 2019 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958634; bh=C48zqzyWQ0HacQ3EaER0W8kVWMMM6ia235jrE4f0kH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=e7Ofv91yroHi1utwsMQpp8u+GN0JN/ocF9zNDuU3S6tAmI+kC1sK1eivu1ceqMJzk
         6Xn8zC4J8JPU6+oxrZoVxnLPoE5d/EJ7q6Z9JTsYGBAA5hOOfdVhHWiGUlEwoyZJvi
         Y48wvS0zNnYSZ4ewcrnD1eKEQV67CpCXoM/WQ06fROrZVUhDOOOdDw607bdoN+EL3E
         2+LYxYwODbTKkjCeodC+hh7DvhPGAF1ovoB+b7JNQJiJm3sLbVFOghIWpJcGVn5bkn
         U8yITumOcs3xiBAq9NyCaAz7jqtec9zXiVQ5GaZ5bis0RweT/jd31fzsN7zqezFZ7O
         UEPVb/SEc3FuQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 77DDAA0091;
        Thu, 31 Jan 2019 18:17:14 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id AC1DD3CED9;
        Thu, 31 Jan 2019 19:17:13 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 3/8] PCI: dwc: Rename variable name from data to d on dw_pci_bottom_mask/unmask()
Date:   Thu, 31 Jan 2019 19:17:02 +0100
Message-Id: <958f6df57e2c36d438686f730c90b485937a1ba1.1548958059.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename variable from data to d to maintain consistency between driver
functions, such as dw_msi_mask_irq() and dw_msi_unmask_irq().

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
Changes v1 -> v2:
 - Fix description terminology

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

