Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940962AbcJGQ3l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:41 -0400
Subject: [PATCH 7/9] PCI: xilinx-nwl: Swap order of nwl_bridge_writel()
 reg/val arguments
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:29:36 -0500
Message-ID: <20161007162936.24137.60172.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of nwl_bridge_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |  107 +++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 2c72c73..2403865 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -186,12 +186,12 @@ struct nwl_pcie {
 	struct irq_domain *legacy_irq_domain;
 };
 
-static inline u32 nwl_bridge_readl(struct nwl_pcie *nwl, u32 off)
+static u32 nwl_bridge_readl(struct nwl_pcie *nwl, u32 off)
 {
 	return readl(nwl->breg_base + off);
 }
 
-static inline void nwl_bridge_writel(struct nwl_pcie *nwl, u32 val, u32 off)
+static void nwl_bridge_writel(struct nwl_pcie *nwl, u32 off, u32 val)
 {
 	writel(val, nwl->breg_base + off);
 }
@@ -327,7 +327,7 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 		dev_info(nwl->dev, "Link Bandwidth Management Status bit set\n");
 
 	/* Clear misc interrupt status */
-	nwl_bridge_writel(nwl, misc_stat, MSGF_MISC_STATUS);
+	nwl_bridge_writel(nwl, MSGF_MISC_STATUS, misc_stat);
 
 	return IRQ_HANDLED;
 }
@@ -367,7 +367,7 @@ static void nwl_pcie_handle_msi_irq(struct nwl_pcie *nwl, u32 status_reg)
 
 	while ((status = nwl_bridge_readl(nwl, status_reg)) != 0) {
 		for_each_set_bit(bit, &status, 32) {
-			nwl_bridge_writel(nwl, 1 << bit, status_reg);
+			nwl_bridge_writel(nwl, status_reg, 1 << bit);
 			virq = irq_find_mapping(msi->dev_domain, bit);
 			if (virq)
 				generic_handle_irq(virq);
@@ -585,40 +585,43 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *nwl, struct pci_bus *bus)
 	}
 
 	/* Enable MSII */
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, I_MSII_CONTROL) |
-			  MSII_ENABLE, I_MSII_CONTROL);
+	nwl_bridge_writel(nwl, I_MSII_CONTROL,
+			  nwl_bridge_readl(nwl, I_MSII_CONTROL) |
+				MSII_ENABLE);
 
 	/* Enable MSII status */
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, I_MSII_CONTROL) |
-			  MSII_STATUS_ENABLE, I_MSII_CONTROL);
+	nwl_bridge_writel(nwl, I_MSII_CONTROL,
+			  nwl_bridge_readl(nwl, I_MSII_CONTROL) |
+				MSII_STATUS_ENABLE);
 
 	/* setup AFI/FPCI range */
 	base = nwl->phys_pcie_reg_base;
-	nwl_bridge_writel(nwl, lower_32_bits(base), I_MSII_BASE_LO);
-	nwl_bridge_writel(nwl, upper_32_bits(base), I_MSII_BASE_HI);
+	nwl_bridge_writel(nwl, I_MSII_BASE_LO, lower_32_bits(base));
+	nwl_bridge_writel(nwl, I_MSII_BASE_HI, upper_32_bits(base));
 
 	/*
 	 * For high range MSI interrupts: disable, clear any pending,
 	 * and enable
 	 */
-	nwl_bridge_writel(nwl, (u32)~MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
+	nwl_bridge_writel(nwl, MSGF_MSI_MASK_HI, (u32)~MSGF_MSI_SR_HI_MASK);
 
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl,  MSGF_MSI_STATUS_HI) &
-			  MSGF_MSI_SR_HI_MASK, MSGF_MSI_STATUS_HI);
+	nwl_bridge_writel(nwl, MSGF_MSI_STATUS_HI,
+			  nwl_bridge_readl(nwl,  MSGF_MSI_STATUS_HI) &
+				MSGF_MSI_SR_HI_MASK);
 
-	nwl_bridge_writel(nwl, MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
+	nwl_bridge_writel(nwl, MSGF_MSI_MASK_HI, MSGF_MSI_SR_HI_MASK);
 
 	/*
 	 * For low range MSI interrupts: disable, clear any pending,
 	 * and enable
 	 */
-	nwl_bridge_writel(nwl, (u32)~MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
+	nwl_bridge_writel(nwl, MSGF_MSI_MASK_LO, (u32)~MSGF_MSI_SR_LO_MASK);
 
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, MSGF_MSI_STATUS_LO) &
-			  MSGF_MSI_SR_LO_MASK, MSGF_MSI_STATUS_LO);
-
-	nwl_bridge_writel(nwl, MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
+	nwl_bridge_writel(nwl, MSGF_MSI_STATUS_LO,
+			  nwl_bridge_readl(nwl, MSGF_MSI_STATUS_LO) &
+				MSGF_MSI_SR_LO_MASK);
 
+	nwl_bridge_writel(nwl, MSGF_MSI_MASK_LO, MSGF_MSI_SR_LO_MASK);
 	return 0;
 err:
 	kfree(msi->bitmap);
@@ -639,25 +642,26 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *nwl)
 	}
 
 	/* Write bridge_off to breg base */
-	nwl_bridge_writel(nwl, lower_32_bits(nwl->phys_breg_base),
-			  E_BREG_BASE_LO);
-	nwl_bridge_writel(nwl, upper_32_bits(nwl->phys_breg_base),
-			  E_BREG_BASE_HI);
+	nwl_bridge_writel(nwl, E_BREG_BASE_LO,
+			  lower_32_bits(nwl->phys_breg_base));
+	nwl_bridge_writel(nwl, E_BREG_BASE_HI,
+			  upper_32_bits(nwl->phys_breg_base));
 
 	/* Enable BREG */
-	nwl_bridge_writel(nwl, ~BREG_ENABLE_FORCE & BREG_ENABLE,
-			  E_BREG_CONTROL);
+	nwl_bridge_writel(nwl, E_BREG_CONTROL,
+			  ~BREG_ENABLE_FORCE & BREG_ENABLE);
 
 	/* Disable DMA channel registers */
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, BRCFG_PCIE_RX0) |
-			  CFG_DMA_REG_BAR, BRCFG_PCIE_RX0);
+	nwl_bridge_writel(nwl, BRCFG_PCIE_RX0,
+			  nwl_bridge_readl(nwl, BRCFG_PCIE_RX0) |
+				CFG_DMA_REG_BAR);
 
 	/* Enable Ingress subtractive decode translation */
-	nwl_bridge_writel(nwl, SET_ISUB_CONTROL, I_ISUB_CONTROL);
+	nwl_bridge_writel(nwl, I_ISUB_CONTROL, SET_ISUB_CONTROL);
 
 	/* Enable msg filtering details */
-	nwl_bridge_writel(nwl, CFG_ENABLE_MSG_FILTER_MASK,
-			  BRCFG_PCIE_RX_MSG_FILTER);
+	nwl_bridge_writel(nwl, BRCFG_PCIE_RX_MSG_FILTER,
+			  CFG_ENABLE_MSG_FILTER_MASK);
 
 	err = nwl_wait_for_link(nwl);
 	if (err)
@@ -670,17 +674,18 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *nwl)
 	}
 
 	/* Enable ECAM */
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, E_ECAM_CONTROL) |
-			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
+	nwl_bridge_writel(nwl, E_ECAM_CONTROL,
+			  nwl_bridge_readl(nwl, E_ECAM_CONTROL) |
+				E_ECAM_CR_ENABLE);
 
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, E_ECAM_CONTROL) |
-			  (nwl->ecam_value << E_ECAM_SIZE_SHIFT),
-			  E_ECAM_CONTROL);
+	nwl_bridge_writel(nwl, E_ECAM_CONTROL,
+			  nwl_bridge_readl(nwl, E_ECAM_CONTROL) |
+				(nwl->ecam_value << E_ECAM_SIZE_SHIFT));
 
-	nwl_bridge_writel(nwl, lower_32_bits(nwl->phys_ecam_base),
-			  E_ECAM_BASE_LO);
-	nwl_bridge_writel(nwl, upper_32_bits(nwl->phys_ecam_base),
-			  E_ECAM_BASE_HI);
+	nwl_bridge_writel(nwl, E_ECAM_BASE_LO,
+			  lower_32_bits(nwl->phys_ecam_base));
+	nwl_bridge_writel(nwl, E_ECAM_BASE_HI,
+			  upper_32_bits(nwl->phys_ecam_base));
 
 	/* Get bus range */
 	ecam_val = nwl_bridge_readl(nwl, E_ECAM_CONTROL);
@@ -714,30 +719,32 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *nwl)
 	}
 
 	/* Disable all misc interrupts */
-	nwl_bridge_writel(nwl, (u32)~MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
+	nwl_bridge_writel(nwl, MSGF_MISC_MASK, (u32)~MSGF_MISC_SR_MASKALL);
 
 	/* Clear pending misc interrupts */
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, MSGF_MISC_STATUS) &
-			  MSGF_MISC_SR_MASKALL, MSGF_MISC_STATUS);
+	nwl_bridge_writel(nwl, MSGF_MISC_STATUS,
+			  nwl_bridge_readl(nwl, MSGF_MISC_STATUS) &
+				MSGF_MISC_SR_MASKALL);
 
 	/* Enable all misc interrupts */
-	nwl_bridge_writel(nwl, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
+	nwl_bridge_writel(nwl, MSGF_MISC_MASK, MSGF_MISC_SR_MASKALL);
 
 
 	/* Disable all legacy interrupts */
-	nwl_bridge_writel(nwl, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
+	nwl_bridge_writel(nwl, MSGF_LEG_MASK, (u32)~MSGF_LEG_SR_MASKALL);
 
 	/* Clear pending legacy interrupts */
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, MSGF_LEG_STATUS) &
-			  MSGF_LEG_SR_MASKALL, MSGF_LEG_STATUS);
+	nwl_bridge_writel(nwl, MSGF_LEG_STATUS,
+			  nwl_bridge_readl(nwl, MSGF_LEG_STATUS) &
+				MSGF_LEG_SR_MASKALL);
 
 	/* Enable all legacy interrupts */
-	nwl_bridge_writel(nwl, MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
+	nwl_bridge_writel(nwl, MSGF_LEG_MASK, MSGF_LEG_SR_MASKALL);
 
 	/* Enable the bridge config interrupt */
-	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, BRCFG_INTERRUPT) |
-			  BRCFG_INTERRUPT_MASK, BRCFG_INTERRUPT);
-
+	nwl_bridge_writel(nwl, BRCFG_INTERRUPT,
+			  nwl_bridge_readl(nwl, BRCFG_INTERRUPT) |
+				BRCFG_INTERRUPT_MASK);
 	return 0;
 }
 

