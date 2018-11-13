Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B5AC43610
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 22:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3DD2175B
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 22:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3DD2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeKNI6J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:58:09 -0500
Received: from foss.arm.com ([217.140.101.70]:35864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeKNI6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Nov 2018 03:58:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F7115BE;
        Tue, 13 Nov 2018 14:57:47 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BE893F718;
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
Subject: [PATCH 2/3] PCI: designware: Take lock when ACKing an interrupt
Date:   Tue, 13 Nov 2018 22:57:33 +0000
Message-Id: <20181113225734.8026-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113225734.8026-1-marc.zyngier@arm.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bizarrely, there is no lock taken in the irq_ack helper. This
puts the ack callback provided by a specific platform in a awkward
situation where there is no synchronization that would be expected
on other callback.

Introduce the required lock, giving some level of uniformity among
callbacks.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c3aa8b5fb51d..0a76948ed49e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -202,11 +202,16 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 {
 	struct msi_desc *msi = irq_data_get_msi_desc(d);
 	struct pcie_port *pp;
+	unsigned long flags;
 
 	pp = msi_desc_to_pci_sysdata(msi);
 
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	if (pp->ops->msi_irq_ack)
 		pp->ops->msi_irq_ack(d->hwirq, pp);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
-- 
2.19.1

