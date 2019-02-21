Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C612CC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE9020836
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QwIgfyjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfBUKUV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:20:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48200 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfBUKTC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 05:19:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LAIm5n124780;
        Thu, 21 Feb 2019 04:18:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550744328;
        bh=Z1JHg2Qq2FnL4xEwwPeYK1OkUFNj+u1JrItWYv+o0WU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QwIgfyjFNImjRWl+aQ3E+dEF1ntPS5Y9KIJNeTVLbbdqSnTT5y9X0Yd6SUwaDI6wU
         /ST78MA0ZUGqKtpNX38Z10JwOARnj/t45T0IGFgm0AWOnT+vqTZy2syV9UT4FXG82U
         a9r9qnr2VXf8w3xlC6h6qwTU+Dlhg+GpPSPnNMpI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LAIlLO052926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 04:18:48 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 04:18:47 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 04:18:47 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LAIORM022198;
        Thu, 21 Feb 2019 04:18:45 -0600
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
Subject: [PATCH v4 7/9] PCI: keystone: Use Keystone specific msi_irq_chip
Date:   Thu, 21 Feb 2019 15:45:16 +0530
Message-ID: <20190221101518.22604-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221101518.22604-1-kishon@ti.com>
References: <20190221101518.22604-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use Keystone specific msi_irq_chip to configure the MSI controller
logic in the PCIe keystone wrapper instead of using the default
Designware msi_irq chip (dw_pci_msi_bottom_irq_chip) with
callback functions for configuring the Keystone MSI controller.
This will help to remove Keystone specific callback functions
added in dw_pcie_host_ops.

Move the default msi_irq_chip assignment to dw_pcie_host_init since
platforms that doesn't use the default msi_irq_chip will assign
msi_irq_chip in msi_host_init() callback.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c     | 96 ++++++++++++++-----
 .../pci/controller/dwc/pcie-designware-host.c |  5 +-
 2 files changed, 74 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 16feab853a7b..88a60e1a1486 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -104,14 +104,6 @@ struct keystone_pcie {
 	struct resource		app;
 };
 
-static phys_addr_t ks_pcie_get_msi_addr(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	return ks_pcie->app.start + MSI_IRQ;
-}
-
 static u32 ks_pcie_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
 {
 	return readl(ks_pcie->va_app_base + offset);
@@ -123,11 +115,14 @@ static void ks_pcie_app_writel(struct keystone_pcie *ks_pcie, u32 offset,
 	writel(val, ks_pcie->va_app_base + offset);
 }
 
-static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
+static void ks_pcie_msi_irq_ack(struct irq_data *data)
 {
-	u32 reg_offset, bit_pos;
+	struct pcie_port *pp  = irq_data_get_irq_chip_data(data);
 	struct keystone_pcie *ks_pcie;
+	u32 irq = data->hwirq;
 	struct dw_pcie *pci;
+	u32 reg_offset;
+	u32 bit_pos;
 
 	pci = to_dw_pcie_from_pp(pp);
 	ks_pcie = to_keystone_pcie(pci);
@@ -140,34 +135,91 @@ static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 	ks_pcie_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
 }
 
-static void ks_pcie_msi_set_irq(struct pcie_port *pp, int irq)
+static void ks_pcie_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	u32 reg_offset, bit_pos;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct keystone_pcie *ks_pcie;
+	struct dw_pcie *pci;
+	u64 msi_target;
+
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
+
+	msi_target = ks_pcie->app.start + MSI_IRQ;
+	msg->address_lo = lower_32_bits(msi_target);
+	msg->address_hi = upper_32_bits(msi_target);
+	msg->data = data->hwirq;
+
+	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int ks_pcie_msi_set_affinity(struct irq_data *irq_data,
+				    const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static void ks_pcie_msi_mask(struct irq_data *data)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct keystone_pcie *ks_pcie;
+	u32 irq = data->hwirq;
+	struct dw_pcie *pci;
+	unsigned long flags;
+	u32 reg_offset;
+	u32 bit_pos;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
 
 	reg_offset = irq % 8;
 	bit_pos = irq >> 3;
 
-	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
 			   BIT(bit_pos));
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
-static void ks_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
+static void ks_pcie_msi_unmask(struct irq_data *data)
 {
-	u32 reg_offset, bit_pos;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct keystone_pcie *ks_pcie;
+	u32 irq = data->hwirq;
+	struct dw_pcie *pci;
+	unsigned long flags;
+	u32 reg_offset;
+	u32 bit_pos;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
 
 	reg_offset = irq % 8;
 	bit_pos = irq >> 3;
 
-	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
 			   BIT(bit_pos));
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
+static struct irq_chip ks_pcie_msi_irq_chip = {
+	.name = "KEYSTONE-PCI-MSI",
+	.irq_ack = ks_pcie_msi_irq_ack,
+	.irq_compose_msi_msg = ks_pcie_compose_msi_msg,
+	.irq_set_affinity = ks_pcie_msi_set_affinity,
+	.irq_mask = ks_pcie_msi_mask,
+	.irq_unmask = ks_pcie_msi_unmask,
+};
+
 static int ks_pcie_msi_host_init(struct pcie_port *pp)
 {
+	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
 	return dw_pcie_allocate_domains(pp);
 }
 
@@ -816,11 +868,7 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 	.rd_other_conf = ks_pcie_rd_other_conf,
 	.wr_other_conf = ks_pcie_wr_other_conf,
 	.host_init = ks_pcie_host_init,
-	.msi_set_irq = ks_pcie_msi_set_irq,
-	.msi_clear_irq = ks_pcie_msi_clear_irq,
-	.get_msi_addr = ks_pcie_get_msi_addr,
 	.msi_host_init = ks_pcie_msi_host_init,
-	.msi_irq_ack = ks_pcie_msi_irq_ack,
 	.scan_bus = ks_pcie_v3_65_scan_bus,
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 042de09b0451..72cfedce5af1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -277,9 +277,6 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
 
-	if (!pp->msi_irq_chip)
-		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
-
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
 	if (!pp->irq_domain) {
@@ -462,6 +459,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 
 		if (!pp->ops->msi_host_init) {
+			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
+
 			ret = dw_pcie_allocate_domains(pp);
 			if (ret)
 				goto error;
-- 
2.17.1

