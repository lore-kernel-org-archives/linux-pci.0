Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756646AbcJGQWr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:22:47 -0400
Subject: [PATCH 07/10] PCI: altera: Swap order of altera_cra_writel()
 reg/val arguments
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Fri, 07 Oct 2016 11:22:42 -0500
Message-ID: <20161007162242.22796.78962.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of altera_cra_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 06e05e9..bcc056b 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -97,8 +97,8 @@ static u32 altera_cra_readl(struct altera_pcie *altera, const u32 reg)
 	return readl_relaxed(altera->cra_base + reg);
 }
 
-static void altera_cra_writel(struct altera_pcie *altera, const u32 value,
-			      const u32 reg)
+static void altera_cra_writel(struct altera_pcie *altera, const u32 reg,
+			      const u32 value)
 {
 	writel_relaxed(value, altera->cra_base + reg);
 }
@@ -130,9 +130,9 @@ static bool altera_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
 static void tlp_write_tx(struct altera_pcie *altera,
 			 struct tlp_rp_regpair_t *tlp_rp_regdata)
 {
-	altera_cra_writel(altera, tlp_rp_regdata->reg0, RP_TX_REG0);
-	altera_cra_writel(altera, tlp_rp_regdata->reg1, RP_TX_REG1);
-	altera_cra_writel(altera, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
+	altera_cra_writel(altera, RP_TX_REG0, tlp_rp_regdata->reg0);
+	altera_cra_writel(altera, RP_TX_REG1, tlp_rp_regdata->reg1);
+	altera_cra_writel(altera, RP_TX_CNTRL, tlp_rp_regdata->ctrl);
 }
 
 static bool altera_pcie_valid_config(struct altera_pcie *altera,
@@ -477,7 +477,7 @@ static void altera_pcie_isr(struct irq_desc *desc)
 		& P2A_INT_STS_ALL) != 0) {
 		for_each_set_bit(bit, &status, INTX_NUM) {
 			/* clear interrupts */
-			altera_cra_writel(altera, 1 << bit, P2A_INT_STATUS);
+			altera_cra_writel(altera, P2A_INT_STATUS, 1 << bit);
 
 			virq = irq_find_mapping(altera->irq_domain, bit + 1);
 			if (virq)
@@ -604,9 +604,9 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* clear all interrupts */
-	altera_cra_writel(altera, P2A_INT_STS_ALL, P2A_INT_STATUS);
+	altera_cra_writel(altera, P2A_INT_STATUS, P2A_INT_STS_ALL);
 	/* enable all interrupts */
-	altera_cra_writel(altera, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
+	altera_cra_writel(altera, P2A_INT_ENABLE, P2A_INT_ENA_ALL);
 	altera_pcie_host_init(altera);
 
 	bus = pci_scan_root_bus(&pdev->dev, altera->root_bus_nr,

