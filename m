Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C362C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E10218EA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CAErLltm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfAaSRS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:17:18 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:54730 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfAaSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:17:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 797F824E1F10;
        Thu, 31 Jan 2019 10:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958635; bh=CGZYvWxb35cKSU6jbW6TR1beGKOeVpFcp+TIn2uyOL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CAErLltmtE0sjFcMO0vJP0ozbeVXrzDBp91yoIfofA/kdrjhK/kiXcRqV89pAfJoX
         xQkltk5H4dMaeommp2kSGoMdgMyQMgCenvi5ZozuD1u/bGa3sbZfUnbltN3YJW/alT
         oEPhkZ9olsCV3jH27LbDiV0s+5o+sufTMtQEquaN27f9W89sMv6lyTBc+TUasJH+8K
         Vi3V1OPZpvtmg3diz7QzyMb5Ye3S2EcAc+LIN/++KEWYCrXng0RvVmEjIK0ckmrS4v
         9z40inJ5ZjxQHOUzV078cmgI5GE9R6i9kdoNkgfOvRRINW2F9KFxidKainiWiLJRBl
         C3A78Z3JlTg/A==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 45D60A009B;
        Thu, 31 Jan 2019 18:17:15 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E1CC33CEE3;
        Thu, 31 Jan 2019 19:17:13 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 6/8] PCI: dwc: Rename variable name from data to d on dw_pcie_irq_domain_free()
Date:   Thu, 31 Jan 2019 19:17:05 +0100
Message-Id: <de1a82d8a69de62393c649c0289d10cd44368696.1548958059.git.gustavo.pimentel@synopsys.com>
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
functions.

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
Changes v1 -> v2:
 - Fix description terminology

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

