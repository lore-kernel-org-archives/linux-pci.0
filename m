Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941219AbcJGQkw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:40:52 -0400
Subject: [PATCH 3/6] PCI: keystone: Pass keystone_pcie, not address,
 to DBI functions
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:40:43 -0500
Message-ID: <20161007164043.26090.78039.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of passing the application register base to DBI mode functions,
pass the struct keystone_pcie.  This will allow them to use register
accessors.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 5c67d54..aeb08e8 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -323,15 +323,15 @@ static const struct irq_domain_ops ks_dw_pcie_legacy_irq_domain_ops = {
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
  */
-static void ks_dw_pcie_set_dbi_mode(void __iomem *reg_virt)
+static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *keystone)
 {
 	u32 val;
 
-	writel(DBI_CS2_EN_VAL | readl(reg_virt + CMD_STATUS),
-	       reg_virt + CMD_STATUS);
+	writel(DBI_CS2_EN_VAL | readl(keystone->va_app_base + CMD_STATUS),
+	       keystone->va_app_base + CMD_STATUS);
 
 	do {
-		val = readl(reg_virt + CMD_STATUS);
+		val = readl(keystone->va_app_base + CMD_STATUS);
 	} while (!(val & DBI_CS2_EN_VAL));
 }
 
@@ -341,15 +341,15 @@ static void ks_dw_pcie_set_dbi_mode(void __iomem *reg_virt)
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
  */
-static void ks_dw_pcie_clear_dbi_mode(void __iomem *reg_virt)
+static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *keystone)
 {
 	u32 val;
 
-	writel(~DBI_CS2_EN_VAL & readl(reg_virt + CMD_STATUS),
-		     reg_virt + CMD_STATUS);
+	writel(~DBI_CS2_EN_VAL & readl(keystone->va_app_base + CMD_STATUS),
+		     keystone->va_app_base + CMD_STATUS);
 
 	do {
-		val = readl(reg_virt + CMD_STATUS);
+		val = readl(keystone->va_app_base + CMD_STATUS);
 	} while (val & DBI_CS2_EN_VAL);
 }
 
@@ -360,10 +360,10 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *keystone)
 	int i, tr_size;
 
 	/* Disable BARs for inbound access */
-	ks_dw_pcie_set_dbi_mode(keystone->va_app_base);
+	ks_dw_pcie_set_dbi_mode(keystone);
 	writel(0, pp->dbi_base + PCI_BASE_ADDRESS_0);
 	writel(0, pp->dbi_base + PCI_BASE_ADDRESS_1);
-	ks_dw_pcie_clear_dbi_mode(keystone->va_app_base);
+	ks_dw_pcie_clear_dbi_mode(keystone);
 
 	/* Set outbound translation size per window division */
 	writel(CFG_PCIM_WIN_SZ_IDX & 0x7, keystone->va_app_base + OB_SIZE);
@@ -457,13 +457,13 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	struct keystone_pcie *keystone = to_keystone_pcie(pp);
 
 	/* Configure and set up BAR0 */
-	ks_dw_pcie_set_dbi_mode(keystone->va_app_base);
+	ks_dw_pcie_set_dbi_mode(keystone);
 
 	/* Enable BAR0 */
 	writel(1, pp->dbi_base + PCI_BASE_ADDRESS_0);
 	writel(SZ_4K - 1, pp->dbi_base + PCI_BASE_ADDRESS_0);
 
-	ks_dw_pcie_clear_dbi_mode(keystone->va_app_base);
+	ks_dw_pcie_clear_dbi_mode(keystone);
 
 	 /*
 	  * For BAR0, just setting bus address for inbound writes (MSI) should

