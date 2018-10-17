Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C90ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC14B21526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yrevcPds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC14B21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJQPiz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:38:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52912 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQPiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:38:55 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7gDKw052298;
        Wed, 17 Oct 2018 02:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762133;
        bh=aIWECn7gGDwTU+WA2PGT3h1/IWT5Yz9oSBMzs0OKbVQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yrevcPds7N2v9wPap3lJn3wxwONGJuX48NbgdsEmiAPrz2ml/oktf+MAeAzhaaWGF
         hrWw8kdGMcZ3vfQT1Lm/lVOG2AV/4SNYRoLJnQz0dLwyFoqiAGPKLmfFJaVy1WO99y
         dlfzqpy3SiC0NhGeo52yoHlMNRH2nxdeibGXYUt4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7gDQp008975;
        Wed, 17 Oct 2018 02:42:13 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:13 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:12 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgST009413;
        Wed, 17 Oct 2018 02:42:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 08/21] PCI: keystone: Use uniform function naming convention
Date:   Wed, 17 Oct 2018 13:11:01 +0530
Message-ID: <20181017074114.28239-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional change. Some function names begin with ks_dw_pcie_*
and some function names begin with ks_pcie_*. Modify it so that
all function names begin with ks_pcie_*.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 221 +++++++++++-----------
 1 file changed, 111 insertions(+), 110 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 926e345dc965..e2045b5d2af2 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -118,7 +118,7 @@ static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
 	*bit_pos = offset >> 3;
 }
 
-static phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
+static phys_addr_t ks_pcie_get_msi_addr(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -126,17 +126,18 @@ static phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 	return ks_pcie->app.start + MSI_IRQ;
 }
 
-static u32 ks_dw_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
+static u32 ks_pcie_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
 {
 	return readl(ks_pcie->va_app_base + offset);
 }
 
-static void ks_dw_app_writel(struct keystone_pcie *ks_pcie, u32 offset, u32 val)
+static void ks_pcie_app_writel(struct keystone_pcie *ks_pcie, u32 offset,
+			       u32 val)
 {
 	writel(val, ks_pcie->va_app_base + offset);
 }
 
-static void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
+static void ks_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -144,7 +145,7 @@ static void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 	u32 pending, vector;
 	int src, virq;
 
-	pending = ks_dw_app_readl(ks_pcie, MSI0_IRQ_STATUS + (offset << 4));
+	pending = ks_pcie_app_readl(ks_pcie, MSI0_IRQ_STATUS + (offset << 4));
 
 	/*
 	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
@@ -161,7 +162,7 @@ static void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 	}
 }
 
-static void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
+static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 {
 	u32 reg_offset, bit_pos;
 	struct keystone_pcie *ks_pcie;
@@ -171,55 +172,55 @@ static void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 	ks_pcie = to_keystone_pcie(pci);
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
 
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
-			 BIT(bit_pos));
-	ks_dw_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
+	ks_pcie_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
+			   BIT(bit_pos));
+	ks_pcie_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
 }
 
-static void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
+static void ks_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 {
 	u32 reg_offset, bit_pos;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
-			 BIT(bit_pos));
+	ks_pcie_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
+			   BIT(bit_pos));
 }
 
-static void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
+static void ks_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 {
 	u32 reg_offset, bit_pos;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
-			 BIT(bit_pos));
+	ks_pcie_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
+			   BIT(bit_pos));
 }
 
-static int ks_dw_pcie_msi_host_init(struct pcie_port *pp)
+static int ks_pcie_msi_host_init(struct pcie_port *pp)
 {
 	return dw_pcie_allocate_domains(pp);
 }
 
-static void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
+static void ks_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
 {
 	int i;
 
 	for (i = 0; i < PCI_NUM_INTX; i++)
-		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
+		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
 }
 
-static void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
-					 int offset)
+static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
+				      int offset)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
 	u32 pending;
 	int virq;
 
-	pending = ks_dw_app_readl(ks_pcie, IRQ_STATUS + (offset << 4));
+	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS + (offset << 4));
 
 	if (BIT(0) & pending) {
 		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
@@ -228,19 +229,19 @@ static void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 	}
 
 	/* EOI the INTx interrupt */
-	ks_dw_app_writel(ks_pcie, IRQ_EOI, offset);
+	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
 }
 
-static void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
+static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
-	ks_dw_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
+	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
 }
 
-static irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
+static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 {
 	u32 status;
 
-	status = ks_dw_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
 	if (!status)
 		return IRQ_NONE;
 
@@ -249,83 +250,83 @@ static irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 			status);
 
 	/* Ack the IRQ; status bits are RW1C */
-	ks_dw_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
+	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
 	return IRQ_HANDLED;
 }
 
-static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
+static void ks_pcie_ack_legacy_irq(struct irq_data *d)
 {
 }
 
-static void ks_dw_pcie_mask_legacy_irq(struct irq_data *d)
+static void ks_pcie_mask_legacy_irq(struct irq_data *d)
 {
 }
 
-static void ks_dw_pcie_unmask_legacy_irq(struct irq_data *d)
+static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
 {
 }
 
-static struct irq_chip ks_dw_pcie_legacy_irq_chip = {
+static struct irq_chip ks_pcie_legacy_irq_chip = {
 	.name = "Keystone-PCI-Legacy-IRQ",
-	.irq_ack = ks_dw_pcie_ack_legacy_irq,
-	.irq_mask = ks_dw_pcie_mask_legacy_irq,
-	.irq_unmask = ks_dw_pcie_unmask_legacy_irq,
+	.irq_ack = ks_pcie_ack_legacy_irq,
+	.irq_mask = ks_pcie_mask_legacy_irq,
+	.irq_unmask = ks_pcie_unmask_legacy_irq,
 };
 
-static int ks_dw_pcie_init_legacy_irq_map(struct irq_domain *d,
-					  unsigned int irq,
-					  irq_hw_number_t hw_irq)
+static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
+				       unsigned int irq,
+				       irq_hw_number_t hw_irq)
 {
-	irq_set_chip_and_handler(irq, &ks_dw_pcie_legacy_irq_chip,
+	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
 				 handle_level_irq);
 	irq_set_chip_data(irq, d->host_data);
 
 	return 0;
 }
 
-static const struct irq_domain_ops ks_dw_pcie_legacy_irq_domain_ops = {
-	.map = ks_dw_pcie_init_legacy_irq_map,
+static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
+	.map = ks_pcie_init_legacy_irq_map,
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
 /**
- * ks_dw_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
+ * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
  * registers
  *
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
  */
-static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
+static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
 
 	do {
-		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	} while (!(val & DBI_CS2_EN_VAL));
 }
 
 /**
- * ks_dw_pcie_clear_dbi_mode() - Disable DBI mode
+ * ks_pcie_clear_dbi_mode() - Disable DBI mode
  *
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
  */
-static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
+static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
 
 	do {
-		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	} while (val & DBI_CS2_EN_VAL);
 }
 
-static void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
+static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -334,26 +335,26 @@ static void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	u32 val;
 
 	/* Disable BARs for inbound access */
-	ks_dw_pcie_set_dbi_mode(ks_pcie);
+	ks_pcie_set_dbi_mode(ks_pcie);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
-	ks_dw_pcie_clear_dbi_mode(ks_pcie);
+	ks_pcie_clear_dbi_mode(ks_pcie);
 
 	/* Set outbound translation size per window division */
-	ks_dw_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
+	ks_pcie_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
 
 	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
 
 	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
 	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
-		ks_dw_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
-		ks_dw_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
 		start += tr_size;
 	}
 
 	/* Enable OB translation */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
 }
 
 /**
@@ -394,13 +395,13 @@ static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
 	if (bus != 1)
 		regval |= BIT(24);
 
-	ks_dw_app_writel(ks_pcie, CFG_SETUP, regval);
+	ks_pcie_app_writel(ks_pcie, CFG_SETUP, regval);
 	return pp->va_cfg0_base;
 }
 
-static int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				    unsigned int devfn, int where, int size,
-				    u32 *val)
+static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				 unsigned int devfn, int where, int size,
+				 u32 *val)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -412,9 +413,9 @@ static int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return dw_pcie_read(addr + where, size, val);
 }
 
-static int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				    unsigned int devfn, int where, int size,
-				    u32 val)
+static int ks_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				 unsigned int devfn, int where, int size,
+				 u32 val)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -427,23 +428,23 @@ static int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 }
 
 /**
- * ks_dw_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
+ * ks_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
  *
  * This sets BAR0 to enable inbound access for MSI_IRQ register
  */
-static void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
+static void ks_pcie_v3_65_scan_bus(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	/* Configure and set up BAR0 */
-	ks_dw_pcie_set_dbi_mode(ks_pcie);
+	ks_pcie_set_dbi_mode(ks_pcie);
 
 	/* Enable BAR0 */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
 
-	ks_dw_pcie_clear_dbi_mode(ks_pcie);
+	ks_pcie_clear_dbi_mode(ks_pcie);
 
 	 /*
 	  * For BAR0, just setting bus address for inbound writes (MSI) should
@@ -453,9 +454,9 @@ static void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 }
 
 /**
- * ks_dw_pcie_link_up() - Check if link up
+ * ks_pcie_link_up() - Check if link up
  */
-static int ks_dw_pcie_link_up(struct dw_pcie *pci)
+static int ks_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
@@ -463,28 +464,28 @@ static int ks_dw_pcie_link_up(struct dw_pcie *pci)
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 
-static void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
+static void ks_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
 	/* Disable Link training */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
 
 	/* Initiate Link Training */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
 }
 
 /**
- * ks_dw_pcie_host_init() - initialize host for v3_65 dw hardware
+ * ks_pcie_dw_host_init() - initialize host for v3_65 dw hardware
  *
  * Ioremap the register resources, initialize legacy irq domain
  * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
  * PCI host controller.
  */
-static int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
+static int __init ks_pcie_dw_host_init(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -517,7 +518,7 @@ static int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
 	ks_pcie->legacy_irq_domain =
 			irq_domain_add_linear(ks_pcie->legacy_intc_np,
 					      PCI_NUM_INTX,
-					      &ks_dw_pcie_legacy_irq_domain_ops,
+					      &ks_pcie_legacy_irq_domain_ops,
 					      NULL);
 	if (!ks_pcie->legacy_irq_domain) {
 		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
@@ -527,7 +528,7 @@ static int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
 	return dw_pcie_host_init(pp);
 }
 
-static void quirk_limit_mrrs(struct pci_dev *dev)
+static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 	struct pci_dev *bridge;
@@ -568,7 +569,7 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 		}
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
 static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 {
@@ -580,7 +581,7 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 		return 0;
 	}
 
-	ks_dw_pcie_initiate_link_train(ks_pcie);
+	ks_pcie_initiate_link_train(ks_pcie);
 
 	/* check if the link is up or not */
 	if (!dw_pcie_wait_for_link(pci))
@@ -607,7 +608,7 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	 * ack operation.
 	 */
 	chained_irq_enter(chip, desc);
-	ks_dw_pcie_handle_msi_irq(ks_pcie, offset);
+	ks_pcie_handle_msi_irq(ks_pcie, offset);
 	chained_irq_exit(chip, desc);
 }
 
@@ -636,7 +637,7 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	 * ack operation.
 	 */
 	chained_irq_enter(chip, desc);
-	ks_dw_pcie_handle_legacy_irq(ks_pcie, irq_offset);
+	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
 	chained_irq_exit(chip, desc);
 }
 
@@ -708,7 +709,7 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
 						 ks_pcie_legacy_irq_handler,
 						 ks_pcie);
 	}
-	ks_dw_pcie_enable_legacy_irqs(ks_pcie);
+	ks_pcie_enable_legacy_irqs(ks_pcie);
 
 	/* MSI IRQ */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -720,7 +721,7 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
 	}
 
 	if (ks_pcie->error_irq > 0)
-		ks_dw_pcie_enable_error_irq(ks_pcie);
+		ks_pcie_enable_error_irq(ks_pcie);
 }
 
 /*
@@ -728,8 +729,8 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
  * bus error instead of returning 0xffffffff. This handler always returns 0
  * for this kind of faults.
  */
-static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
-				struct pt_regs *regs)
+static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
+			 struct pt_regs *regs)
 {
 	unsigned long instr = *(unsigned long *) instruction_pointer(regs);
 
@@ -751,7 +752,7 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	ks_pcie_establish_link(ks_pcie);
-	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
+	ks_pcie_setup_rc_app_regs(ks_pcie);
 	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
@@ -763,33 +764,33 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
 	 */
-	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
+	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
 
 	return 0;
 }
 
-static const struct dw_pcie_host_ops keystone_pcie_host_ops = {
-	.rd_other_conf = ks_dw_pcie_rd_other_conf,
-	.wr_other_conf = ks_dw_pcie_wr_other_conf,
+static const struct dw_pcie_host_ops ks_pcie_host_ops = {
+	.rd_other_conf = ks_pcie_rd_other_conf,
+	.wr_other_conf = ks_pcie_wr_other_conf,
 	.host_init = ks_pcie_host_init,
-	.msi_set_irq = ks_dw_pcie_msi_set_irq,
-	.msi_clear_irq = ks_dw_pcie_msi_clear_irq,
-	.get_msi_addr = ks_dw_pcie_get_msi_addr,
-	.msi_host_init = ks_dw_pcie_msi_host_init,
-	.msi_irq_ack = ks_dw_pcie_msi_irq_ack,
-	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
+	.msi_set_irq = ks_pcie_msi_set_irq,
+	.msi_clear_irq = ks_pcie_msi_clear_irq,
+	.get_msi_addr = ks_pcie_get_msi_addr,
+	.msi_host_init = ks_pcie_msi_host_init,
+	.msi_irq_ack = ks_pcie_msi_irq_ack,
+	.scan_bus = ks_pcie_v3_65_scan_bus,
 };
 
-static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
+static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
 {
 	struct keystone_pcie *ks_pcie = priv;
 
-	return ks_dw_pcie_handle_error_irq(ks_pcie);
+	return ks_pcie_handle_error_irq(ks_pcie);
 }
 
-static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
-			 struct platform_device *pdev)
+static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
+					struct platform_device *pdev)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -818,7 +819,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 	if (ks_pcie->error_irq <= 0)
 		dev_info(dev, "no error IRQ defined\n");
 	else {
-		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
+		ret = request_irq(ks_pcie->error_irq, ks_pcie_err_irq_handler,
 				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
 		if (ret < 0) {
 			dev_err(dev, "failed to request error IRQ %d\n",
@@ -827,8 +828,8 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 		}
 	}
 
-	pp->ops = &keystone_pcie_host_ops;
-	ret = ks_dw_pcie_host_init(ks_pcie);
+	pp->ops = &ks_pcie_host_ops;
+	ret = ks_pcie_dw_host_init(ks_pcie);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
 		return ret;
@@ -845,8 +846,8 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
-static const struct dw_pcie_ops dw_pcie_ops = {
-	.link_up = ks_dw_pcie_link_up,
+static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
+	.link_up = ks_pcie_link_up,
 };
 
 static int __exit ks_pcie_remove(struct platform_device *pdev)
@@ -877,7 +878,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
+	pci->ops = &ks_pcie_dw_pcie_ops;
 
 	ks_pcie->pci = pci;
 
@@ -912,7 +913,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = ks_add_pcie_port(ks_pcie, pdev);
+	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto fail_clk;
 
-- 
2.17.1

