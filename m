Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755138AbcJLNxg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:53:36 -0400
Subject: [PATCH v2 4/6] PCI: keystone: Pass keystone_pcie, not va_app_base,
 to DBI functions
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:53:32 -0500
Message-ID: <20161012135332.29306.77819.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of passing ks_pcie->va_app_base to DBI mode functions,
pass the struct keystone_pcie.  This will allow them to use register
accessors.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index dae68a2..1de39af 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -325,15 +325,15 @@ static const struct irq_domain_ops ks_dw_pcie_legacy_irq_domain_ops = {
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
  */
-static void ks_dw_pcie_set_dbi_mode(void __iomem *reg_virt)
+static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
-	writel(DBI_CS2_EN_VAL | readl(reg_virt + CMD_STATUS),
-	       reg_virt + CMD_STATUS);
+	writel(DBI_CS2_EN_VAL | readl(ks_pcie->va_app_base + CMD_STATUS),
+	       ks_pcie->va_app_base + CMD_STATUS);
 
 	do {
-		val = readl(reg_virt + CMD_STATUS);
+		val = readl(ks_pcie->va_app_base + CMD_STATUS);
 	} while (!(val & DBI_CS2_EN_VAL));
 }
 
@@ -343,15 +343,15 @@ static void ks_dw_pcie_set_dbi_mode(void __iomem *reg_virt)
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
  */
-static void ks_dw_pcie_clear_dbi_mode(void __iomem *reg_virt)
+static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
-	writel(~DBI_CS2_EN_VAL & readl(reg_virt + CMD_STATUS),
-		     reg_virt + CMD_STATUS);
+	writel(~DBI_CS2_EN_VAL & readl(ks_pcie->va_app_base + CMD_STATUS),
+		     ks_pcie->va_app_base + CMD_STATUS);
 
 	do {
-		val = readl(reg_virt + CMD_STATUS);
+		val = readl(ks_pcie->va_app_base + CMD_STATUS);
 	} while (val & DBI_CS2_EN_VAL);
 }
 
@@ -362,10 +362,10 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	int i, tr_size;
 
 	/* Disable BARs for inbound access */
-	ks_dw_pcie_set_dbi_mode(ks_pcie->va_app_base);
+	ks_dw_pcie_set_dbi_mode(ks_pcie);
 	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0);
 	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0);
-	ks_dw_pcie_clear_dbi_mode(ks_pcie->va_app_base);
+	ks_dw_pcie_clear_dbi_mode(ks_pcie);
 
 	/* Set outbound translation size per window division */
 	writel(CFG_PCIM_WIN_SZ_IDX & 0x7, ks_pcie->va_app_base + OB_SIZE);
@@ -459,13 +459,13 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
 
 	/* Configure and set up BAR0 */
-	ks_dw_pcie_set_dbi_mode(ks_pcie->va_app_base);
+	ks_dw_pcie_set_dbi_mode(ks_pcie);
 
 	/* Enable BAR0 */
 	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 1);
 	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, SZ_4K - 1);
 
-	ks_dw_pcie_clear_dbi_mode(ks_pcie->va_app_base);
+	ks_dw_pcie_clear_dbi_mode(ks_pcie);
 
 	 /*
 	  * For BAR0, just setting bus address for inbound writes (MSI) should

