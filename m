Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941219AbcJGQlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:41:01 -0400
Subject: [PATCH 4/6] PCI: keystone: Add app register accessors
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:40:56 -0500
Message-ID: <20161007164056.26090.44464.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device-specific register accessors for consistency across host drivers.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |   73 +++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index aeb08e8..5be7cf4 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -88,13 +88,24 @@ phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 	return keystone->app.start + MSI_IRQ;
 }
 
+static u32 ks_dw_app_readl(struct keystone_pcie *keystone, u32 offset)
+{
+	return readl(keystone->va_app_base + offset);
+}
+
+static void ks_dw_app_writel(struct keystone_pcie *keystone, u32 offset,
+				u32 val)
+{
+	writel(val, keystone->va_app_base + offset);
+}
+
 void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *keystone, int offset)
 {
 	struct pcie_port *pp = &keystone->pp;
 	u32 pending, vector;
 	int src, virq;
 
-	pending = readl(keystone->va_app_base + MSI0_IRQ_STATUS + (offset << 4));
+	pending = ks_dw_app_readl(keystone, MSI0_IRQ_STATUS + (offset << 4));
 
 	/*
 	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
@@ -124,9 +135,9 @@ static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
 
-	writel(BIT(bit_pos),
-	       keystone->va_app_base + MSI0_IRQ_STATUS + (reg_offset << 4));
-	writel(reg_offset + MSI_IRQ_OFFSET, keystone->va_app_base + IRQ_EOI);
+	ks_dw_app_writel(keystone, MSI0_IRQ_STATUS + (reg_offset << 4),
+			 BIT(bit_pos));
+	ks_dw_app_writel(keystone, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
 }
 
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
@@ -135,8 +146,8 @@ void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 	struct keystone_pcie *keystone = to_keystone_pcie(pp);
 
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	writel(BIT(bit_pos),
-	       keystone->va_app_base + MSI0_IRQ_ENABLE_SET + (reg_offset << 4));
+	ks_dw_app_writel(keystone, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
+			 BIT(bit_pos));
 }
 
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
@@ -145,8 +156,8 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 	struct keystone_pcie *keystone = to_keystone_pcie(pp);
 
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	writel(BIT(bit_pos),
-	       keystone->va_app_base + MSI0_IRQ_ENABLE_CLR + (reg_offset << 4));
+	ks_dw_app_writel(keystone, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
+			 BIT(bit_pos));
 }
 
 static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
@@ -237,7 +248,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *keystone)
 	int i;
 
 	for (i = 0; i < MAX_LEGACY_IRQS; i++)
-		writel(0x1, keystone->va_app_base + IRQ_ENABLE_SET + (i << 4));
+		ks_dw_app_writel(keystone, IRQ_ENABLE_SET + (i << 4), 0x1);
 }
 
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *keystone, int offset)
@@ -246,7 +257,7 @@ void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *keystone, int offset)
 	u32 pending;
 	int virq;
 
-	pending = readl(keystone->va_app_base + IRQ_STATUS + (offset << 4));
+	pending = ks_dw_app_readl(keystone, IRQ_STATUS + (offset << 4));
 
 	if (BIT(0) & pending) {
 		virq = irq_linear_revmap(keystone->legacy_irq_domain, offset);
@@ -256,20 +267,19 @@ void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *keystone, int offset)
 	}
 
 	/* EOI the INTx interrupt */
-	writel(offset, keystone->va_app_base + IRQ_EOI);
+	ks_dw_app_writel(keystone, IRQ_EOI, offset);
 }
 
 void ks_dw_pcie_enable_error_irq(struct keystone_pcie *keystone)
 {
-	writel(ERR_IRQ_ALL, keystone->va_app_base + ERR_IRQ_ENABLE_SET);
+	ks_dw_app_writel(keystone, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
 }
 
 irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *keystone)
 {
 	u32 status;
 
-	status = readl(keystone->va_app_base + ERR_IRQ_STATUS_RAW) &
-			    ERR_IRQ_ALL;
+	status = ks_dw_app_readl(keystone, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
 	if (!status)
 		return IRQ_NONE;
 
@@ -278,7 +288,7 @@ irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *keystone)
 			status);
 
 	/* Ack the IRQ; status bits are RW1C */
-	writel(status, keystone->va_app_base + ERR_IRQ_STATUS);
+	ks_dw_app_writel(keystone, ERR_IRQ_STATUS, status);
 	return IRQ_HANDLED;
 }
 
@@ -327,11 +337,11 @@ static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *keystone)
 {
 	u32 val;
 
-	writel(DBI_CS2_EN_VAL | readl(keystone->va_app_base + CMD_STATUS),
-	       keystone->va_app_base + CMD_STATUS);
+	val = ks_dw_app_readl(keystone, CMD_STATUS);
+	ks_dw_app_writel(keystone, CMD_STATUS, DBI_CS2_EN_VAL | val);
 
 	do {
-		val = readl(keystone->va_app_base + CMD_STATUS);
+		val = ks_dw_app_readl(keystone, CMD_STATUS);
 	} while (!(val & DBI_CS2_EN_VAL));
 }
 
@@ -345,11 +355,11 @@ static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *keystone)
 {
 	u32 val;
 
-	writel(~DBI_CS2_EN_VAL & readl(keystone->va_app_base + CMD_STATUS),
-		     keystone->va_app_base + CMD_STATUS);
+	val = ks_dw_app_readl(keystone, CMD_STATUS);
+	ks_dw_app_writel(keystone, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
 
 	do {
-		val = readl(keystone->va_app_base + CMD_STATUS);
+		val = ks_dw_app_readl(keystone, CMD_STATUS);
 	} while (val & DBI_CS2_EN_VAL);
 }
 
@@ -358,6 +368,7 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *keystone)
 	struct pcie_port *pp = &keystone->pp;
 	u32 start = pp->mem->start, end = pp->mem->end;
 	int i, tr_size;
+	u32 val;
 
 	/* Disable BARs for inbound access */
 	ks_dw_pcie_set_dbi_mode(keystone);
@@ -366,20 +377,20 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *keystone)
 	ks_dw_pcie_clear_dbi_mode(keystone);
 
 	/* Set outbound translation size per window division */
-	writel(CFG_PCIM_WIN_SZ_IDX & 0x7, keystone->va_app_base + OB_SIZE);
+	ks_dw_app_writel(keystone, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
 
 	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
 
 	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
 	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
-		writel(start | 1, keystone->va_app_base + OB_OFFSET_INDEX(i));
-		writel(0, keystone->va_app_base + OB_OFFSET_HI(i));
+		ks_dw_app_writel(keystone, OB_OFFSET_INDEX(i), start | 1);
+		ks_dw_app_writel(keystone, OB_OFFSET_HI(i), 0);
 		start += tr_size;
 	}
 
 	/* Enable OB translation */
-	writel(OB_XLAT_EN_VAL | readl(keystone->va_app_base + CMD_STATUS),
-	       keystone->va_app_base + CMD_STATUS);
+	val = ks_dw_app_readl(keystone, CMD_STATUS);
+	ks_dw_app_writel(keystone, CMD_STATUS, OB_XLAT_EN_VAL | val);
 }
 
 /**
@@ -419,7 +430,7 @@ static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *keystone, u8 bus,
 	if (bus != 1)
 		regval |= BIT(24);
 
-	writel(regval, keystone->va_app_base + CFG_SETUP);
+	ks_dw_app_writel(keystone, CFG_SETUP, regval);
 	return pp->va_cfg0_base;
 }
 
@@ -487,13 +498,13 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *keystone)
 	u32 val;
 
 	/* Disable Link training */
-	val = readl(keystone->va_app_base + CMD_STATUS);
+	val = ks_dw_app_readl(keystone, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
-	writel(LTSSM_EN_VAL | val,  keystone->va_app_base + CMD_STATUS);
+	ks_dw_app_writel(keystone, CMD_STATUS, LTSSM_EN_VAL | val);
 
 	/* Initiate Link Training */
-	val = readl(keystone->va_app_base + CMD_STATUS);
-	writel(LTSSM_EN_VAL | val,  keystone->va_app_base + CMD_STATUS);
+	val = ks_dw_app_readl(keystone, CMD_STATUS);
+	ks_dw_app_writel(keystone, CMD_STATUS, LTSSM_EN_VAL | val);
 }
 
 /**

