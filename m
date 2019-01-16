Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC45BC43614
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2E220859
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VH4QuoSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbfAPKO3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:14:29 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:45182 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389390AbfAPKO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 05:14:28 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2D10724E2263;
        Wed, 16 Jan 2019 02:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547633668; bh=mw08ioxvdBx7ztoRI5hZgZJRyBTRuxxWmApHeJHKhV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VH4QuoSVNbCaVv+N71wBna4JLQhyRoyzQ2w9tleFHy1X/EMoCTstcYBORTSlvFxFk
         kCLfENsFfsDAe61gT5uPp/swqY0kYIA3KZRrM8cOaVCFDL85KzNzmb1yKevoBNwBLQ
         0l0R0Mbg3bvzb/U1+WmHZmZlTGYD3KyvARxtFUpCQmhmybBcC3gUzPL6ppt/c5MQx3
         WPe77B9KqPAO1Kue98N+pOgaiQq5gmygEMDLzUts3KOdEGXHLXorRbq77qpiB9EVpv
         6Fh7FsfwpuwzIsz/ps2mjnyK9t3Y5lAW9MiXwUiRFfyTHthRiNNdNxkZwL+1Fv8rcZ
         N2Fp9hx+883yA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id C5A044D90;
        Wed, 16 Jan 2019 02:14:27 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 682373F68F;
        Wed, 16 Jan 2019 11:14:26 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 6/9] PCI: dwc: Replace variable name from data to d on dw_pcie_irq_domain_free()
Date:   Wed, 16 Jan 2019 11:14:19 +0100
Message-Id: <c36df9974ebcf32bc212c30de3d062bd686e9bb7.1547631485.git.gustavo.pimentel@synopsys.com>
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
functions.

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a59fc17e..768e16a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -255,13 +255,13 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 static void dw_pcie_irq_domain_free(struct irq_domain *domain,
 				    unsigned int virq, unsigned int nr_irqs)
 {
-	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
-	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	bitmap_release_region(pp->msi_irq_in_use, data->hwirq,
+	bitmap_release_region(pp->msi_irq_in_use, d->hwirq,
 			      order_base_2(nr_irqs));
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
-- 
2.7.4

