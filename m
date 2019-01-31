Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC4DC3E8A4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1707218FD
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cLiHTy1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfAaSRQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:17:16 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:57874 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfAaSRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:17:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id C00AB10C13C9;
        Thu, 31 Jan 2019 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958634; bh=MHEBV+cRLfCDdw2seNu+PNX8XDHqkin7+hs0HNsedXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=cLiHTy1+K7fIYh9ugc6WLXnIWaFZWlOwmT3o8PwH5WPHNt1gZCwOnYuTUTZOz72YX
         NxcaJvyP3ob2JkVXGTqLfEisYGe+0dy2aCv71uWW7dDEPMCg4i9GzaNZNUVJPWdiwh
         KJpfteEQvhsBQsJREc1hgS3oOW8Ihh2G6rVHi8NstMyJ6zesSjssXZiYe6gwGGxm/x
         OwrotHZGKEYuubLYl0ov7FpJ3Z9CHn7kKl9UGVlTQ6ZV0zDeznTLcaRS8QlhXH69jn
         DDzdEQYEGuZ8VXRPomHzFAYz2okcoGFlGAcpkbpMHxgkOgzTKxVkSRNr4byL3neiP4
         CG4MLkirHc5Kg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8B006A0098;
        Thu, 31 Jan 2019 18:17:14 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id BD07C3CEDD;
        Thu, 31 Jan 2019 19:17:13 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2 4/8] PCI: dwc: Rename variable name from data to d on dw_pci_setup_msi_msg()
Date:   Thu, 31 Jan 2019 19:17:03 +0100
Message-Id: <da117fc8da4a0d5e509ac16401bef2a5ca84bbc2.1548958059.git.gustavo.pimentel@synopsys.com>
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
functions, such as dw_pci_setup_msi_msg().

No functional change is intended.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
Changes v1 -> v2:
 - Fix description terminology

drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 36e284c..0c6e19a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -120,9 +120,9 @@ static void dw_chained_msi_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
+static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	u64 msi_target;
 
@@ -135,12 +135,12 @@ static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_hi = upper_32_bits(msi_target);
 
 	if (pp->ops->get_msi_data)
-		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
+		msg->data = pp->ops->get_msi_data(pp, d->hwirq);
 	else
-		msg->data = data->hwirq;
+		msg->data = d->hwirq;
 
 	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
-		(int)data->hwirq, msg->address_hi, msg->address_lo);
+		(int)d->hwirq, msg->address_hi, msg->address_lo);
 }
 
 static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
-- 
2.7.4

