Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22300C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB016218B0
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nkl+uwte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfCUKAv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:00:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38212 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfCUKAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 06:00:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LA0anR124608;
        Thu, 21 Mar 2019 05:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553162436;
        bh=QHmILlQcIRug/Y5hIBEnV70vTOUJsabXnR6CD5Gd4vk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nkl+uwtewMaT2Vbz570BWZGlvwlKzi3rD/k1dqWRMoFU59PQTvRNbjs9C+CwseaAI
         4egPDhNpiCjAleoCHVs2Ex202APlpFlp08pcwnfj2+RRxagdUAj4Bda9x8u4jwnQTz
         fedCX2UTU91eo90sVRiVC8JIIWuiSq6JgFOa/L2M=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LA0a8w093839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 05:00:36 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 05:00:36 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 05:00:36 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LA0KOA014903;
        Thu, 21 Mar 2019 05:00:33 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/8] PCI: keystone: Cleanup ks_pcie_msi_irq_handler
Date:   Thu, 21 Mar 2019 15:29:23 +0530
Message-ID: <20190321095927.7058-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321095927.7058-1-kishon@ti.com>
References: <20190321095927.7058-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ks_pcie_msi_irq_handler() invokes ks_pcie_handle_msi_irq() for handling
the interrupts.

Having two functions for handling the interrupt was used when keystone
PCIe driver was implemented using two files. But with
commit b492aca35c982011500377797d2 ("PCI: keystone: Merge
pci-keystone-dw.c and pci-keystone.c"), which merged the keystone PCIe
driver to use a single file, two functions for handling the
interrupt handler is not required.

Handle MSI interrupt in a single interrupt handler here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 64 ++++++++++-------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index fce25a0dcd08..39542f2c312b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -105,13 +105,6 @@ struct keystone_pcie {
 	struct resource		app;
 };
 
-static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
-					     u32 *bit_pos)
-{
-	*reg_offset = offset % 8;
-	*bit_pos = offset >> 3;
-}
-
 static phys_addr_t ks_pcie_get_msi_addr(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -131,31 +124,6 @@ static void ks_pcie_app_writel(struct keystone_pcie *ks_pcie, u32 offset,
 	writel(val, ks_pcie->va_app_base + offset);
 }
 
-static void ks_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	u32 pending, vector;
-	int src, virq;
-
-	pending = ks_pcie_app_readl(ks_pcie, MSI_IRQ_STATUS(offset));
-
-	/*
-	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
-	 * shows 1, 9, 17, 25 and so forth
-	 */
-	for (src = 0; src < 4; src++) {
-		if (BIT(src) & pending) {
-			vector = offset + (src << 3);
-			virq = irq_linear_revmap(pp->irq_domain, vector);
-			dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n",
-				src, vector, virq);
-			generic_handle_irq(virq);
-		}
-	}
-}
-
 static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 {
 	u32 reg_offset, bit_pos;
@@ -164,7 +132,9 @@ static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 
 	pci = to_dw_pcie_from_pp(pp);
 	ks_pcie = to_keystone_pcie(pci);
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
 
 	ks_pcie_app_writel(ks_pcie, MSI_IRQ_STATUS(reg_offset),
 			   BIT(bit_pos));
@@ -177,7 +147,9 @@ static void ks_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
+
 	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
 			   BIT(bit_pos));
 }
@@ -188,7 +160,9 @@ static void ks_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
+
 	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
 			   BIT(bit_pos));
 }
@@ -556,8 +530,10 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	u32 offset = irq - ks_pcie->msi_host_irq;
 	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	struct device *dev = pci->dev;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 vector, virq, reg, pos;
 
 	dev_dbg(dev, "%s, irq %d\n", __func__, irq);
 
@@ -567,7 +543,23 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	 * ack operation.
 	 */
 	chained_irq_enter(chip, desc);
-	ks_pcie_handle_msi_irq(ks_pcie, offset);
+
+	reg = ks_pcie_app_readl(ks_pcie, MSI_IRQ_STATUS(offset));
+	/*
+	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
+	 * shows 1, 9, 17, 25 and so forth
+	 */
+	for (pos = 0; pos < 4; pos++) {
+		if (!(reg & BIT(pos)))
+			continue;
+
+		vector = offset + (pos << 3);
+		virq = irq_linear_revmap(pp->irq_domain, vector);
+		dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n", pos, vector,
+			virq);
+		generic_handle_irq(virq);
+	}
+
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.17.1

