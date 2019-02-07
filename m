Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A7C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 11:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3497621872
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 11:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t+H4kagr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfBGLcf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:32:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46074 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfBGLce (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2019 06:32:34 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BWLiQ030967;
        Thu, 7 Feb 2019 05:32:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549539141;
        bh=bMG5G9sG7SbqYDiuJSnVlAPFQXEkItTlVqc0PM19k0g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t+H4kagrAHeDiKrBGCxIPLHvvDv2dELqTQ4pDdGTXTyyhswtDHh5ZogaZIjdalhLe
         7kc18K7JYVvxagHNUQ7RF7eVwENMDCJPaPTRtJgXLb8ojqHxAHtWlLFWMqDgg5OXrq
         /EqA6XXlwW6l+Di97L+rs5++KLWWcfdFPkT4Kw8A=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BWLOV017119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 05:32:21 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:32:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:32:21 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BVxaq026282;
        Thu, 7 Feb 2019 05:32:18 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/9] PCI: dwc: Add support to use non default msi_irq_chip
Date:   Thu, 7 Feb 2019 16:39:21 +0530
Message-ID: <20190207110924.30716-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207110924.30716-1-kishon@ti.com>
References: <20190207110924.30716-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Platforms using Designware IP uses dw_pci_msi_bottom_irq_chip for
configuring the MSI controller logic within the Designware IP. However
certain platforms like Keystone (K2G) which uses Desingware IP has
it's own MSI controller logic. For handling such platforms,
the irqchip ops uses msi_irq_ack, msi_set_irq, msi_clear_irq callback
functions.

Add support to use different msi_irq_chip with default as
dw_pci_msi_bottom_irq_chip. This is in preparation to get rid off
msi_irq_ack, msi_set_irq, msi_clear_irq and other Keystone specific
dw_pcie_host_ops. This will also help to get rid of get_msi_addr and
get_msi_data ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 721d60a5d9e4..042de09b0451 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -245,7 +245,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, bit + i,
-				    &dw_pci_msi_bottom_irq_chip,
+				    pp->msi_irq_chip,
 				    pp, handle_edge_irq,
 				    NULL, NULL);
 
@@ -277,6 +277,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
 
+	if (!pp->msi_irq_chip)
+		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
+
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
 	if (!pp->irq_domain) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 1f56e6ae34ff..95e0c3c93f48 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -176,6 +176,7 @@ struct pcie_port {
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
+	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_status[MAX_MSI_CTRLS];
 	raw_spinlock_t		lock;
-- 
2.17.1

