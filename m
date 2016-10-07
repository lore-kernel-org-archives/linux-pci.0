Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936461AbcJGQWj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:22:39 -0400
Subject: [PATCH 06/10] PCI: altera: Rename CRA accessors
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Fri, 07 Oct 2016 11:22:34 -0500
Message-ID: <20161007162234.22796.55298.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename cra_readl() and cra_writel() to altera_cra_readl() and
altera_cra_writel() for consistency with other drivers.  Reorder them with
the read function first, followed by the write function.  Uninline them.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index d2c7f55..06e05e9 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -92,20 +92,20 @@ struct tlp_rp_regpair_t {
 	u32 reg1;
 };
 
-static inline void cra_writel(struct altera_pcie *altera, const u32 value,
-			      const u32 reg)
+static u32 altera_cra_readl(struct altera_pcie *altera, const u32 reg)
 {
-	writel_relaxed(value, altera->cra_base + reg);
+	return readl_relaxed(altera->cra_base + reg);
 }
 
-static inline u32 cra_readl(struct altera_pcie *altera, const u32 reg)
+static void altera_cra_writel(struct altera_pcie *altera, const u32 value,
+			      const u32 reg)
 {
-	return readl_relaxed(altera->cra_base + reg);
+	writel_relaxed(value, altera->cra_base + reg);
 }
 
 static bool altera_pcie_link_is_up(struct altera_pcie *altera)
 {
-	return !!((cra_readl(altera, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
+	return !!((altera_cra_readl(altera, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
 }
 
 /*
@@ -130,9 +130,9 @@ static bool altera_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
 static void tlp_write_tx(struct altera_pcie *altera,
 			 struct tlp_rp_regpair_t *tlp_rp_regdata)
 {
-	cra_writel(altera, tlp_rp_regdata->reg0, RP_TX_REG0);
-	cra_writel(altera, tlp_rp_regdata->reg1, RP_TX_REG1);
-	cra_writel(altera, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
+	altera_cra_writel(altera, tlp_rp_regdata->reg0, RP_TX_REG0);
+	altera_cra_writel(altera, tlp_rp_regdata->reg1, RP_TX_REG1);
+	altera_cra_writel(altera, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
 }
 
 static bool altera_pcie_valid_config(struct altera_pcie *altera,
@@ -164,10 +164,10 @@ static int tlp_read_packet(struct altera_pcie *altera, u32 *value)
 	 * payload.
 	 */
 	for (i = 0; i < TLP_LOOP; i++) {
-		ctrl = cra_readl(altera, RP_RXCPL_STATUS);
+		ctrl = altera_cra_readl(altera, RP_RXCPL_STATUS);
 		if ((ctrl & RP_RXCPL_SOP) || (ctrl & RP_RXCPL_EOP) || sop) {
-			reg0 = cra_readl(altera, RP_RXCPL_REG0);
-			reg1 = cra_readl(altera, RP_RXCPL_REG1);
+			reg0 = altera_cra_readl(altera, RP_RXCPL_REG0);
+			reg1 = altera_cra_readl(altera, RP_RXCPL_REG1);
 
 			if (ctrl & RP_RXCPL_SOP) {
 				sop = true;
@@ -473,11 +473,11 @@ static void altera_pcie_isr(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 	altera = irq_desc_get_handler_data(desc);
 
-	while ((status = cra_readl(altera, P2A_INT_STATUS)
+	while ((status = altera_cra_readl(altera, P2A_INT_STATUS)
 		& P2A_INT_STS_ALL) != 0) {
 		for_each_set_bit(bit, &status, INTX_NUM) {
 			/* clear interrupts */
-			cra_writel(altera, 1 << bit, P2A_INT_STATUS);
+			altera_cra_writel(altera, 1 << bit, P2A_INT_STATUS);
 
 			virq = irq_find_mapping(altera->irq_domain, bit + 1);
 			if (virq)
@@ -604,9 +604,9 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* clear all interrupts */
-	cra_writel(altera, P2A_INT_STS_ALL, P2A_INT_STATUS);
+	altera_cra_writel(altera, P2A_INT_STS_ALL, P2A_INT_STATUS);
 	/* enable all interrupts */
-	cra_writel(altera, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
+	altera_cra_writel(altera, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
 	altera_pcie_host_init(altera);
 
 	bus = pci_scan_root_bus(&pdev->dev, altera->root_bus_nr,

