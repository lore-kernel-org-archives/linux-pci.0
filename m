Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F1C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 22:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC0F2175B
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 22:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC0F2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbeKNI6K (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:58:10 -0500
Received: from foss.arm.com ([217.140.101.70]:35878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeKNI6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Nov 2018 03:58:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E728C15BF;
        Tue, 13 Nov 2018 14:57:47 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 857C23F718;
        Tue, 13 Nov 2018 14:57:47 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        faiz_abbas@ti.com, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/3] PCI: designware: Move interrupt acking into the proper callback
Date:   Tue, 13 Nov 2018 22:57:34 +0000
Message-Id: <20181113225734.8026-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113225734.8026-1-marc.zyngier@arm.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The write to the status register is really an ACK for the HW,
and should be treated as such by the driver. Let's move it to the
irq_ack callback, which will prevent people from moving it around
in order to paper over other bugs.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0a76948ed49e..f06e67c60593 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -99,9 +99,6 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 					       (i * MAX_MSI_IRQS_PER_CTRL) +
 					       pos);
 			generic_handle_irq(irq);
-			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
-						(i * MSI_REG_CTRL_BLOCK_SIZE),
-					    4, 1 << pos);
 			pos++;
 		}
 	}
@@ -200,14 +197,18 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
 
 static void dw_pci_bottom_ack(struct irq_data *d)
 {
-	struct msi_desc *msi = irq_data_get_msi_desc(d);
-	struct pcie_port *pp;
+	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
+	unsigned int res, bit, ctrl;
 	unsigned long flags;
 
-	pp = msi_desc_to_pci_sysdata(msi);
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
+
 	if (pp->ops->msi_irq_ack)
 		pp->ops->msi_irq_ack(d->hwirq, pp);
 
-- 
2.19.1

