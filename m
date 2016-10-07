Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933163AbcJGQct (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:32:49 -0400
Subject: [PATCH 2/8] PCI: artpec6: Add register accessors
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Fri, 07 Oct 2016 11:32:45 -0500
Message-ID: <20161007163244.24751.48694.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device-specific register accessors for consistency across host
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-artpec6.c |   43 +++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index 55f69eb..6cfd7a5 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -65,6 +65,19 @@ struct artpec6_pcie {
 
 #define ARTPEC6_CPU_TO_BUS_ADDR		0x0fffffff
 
+static u32 artpec6_readl(struct artpec6_pcie *artpec6, u32 offset)
+{
+	u32 val;
+
+	regmap_read(artpec6->regmap, offset, &val);
+	return val;
+}
+
+static void artpec6_writel(struct artpec6_pcie *artpec6, u32 offset, u32 val)
+{
+	regmap_write(artpec6->regmap, offset, val);
+}
+
 static int artpec6_pcie_establish_link(struct pcie_port *pp)
 {
 	struct artpec6_pcie *artpec6 = to_artpec6_pcie(pp);
@@ -72,11 +85,11 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	unsigned int retries;
 
 	/* Hold DW core in reset */
-	regmap_read(artpec6->regmap, PCIECFG, &val);
+	val = artpec6_readl(artpec6, PCIECFG);
 	val |= PCIECFG_CORE_RESET_REQ;
-	regmap_write(artpec6->regmap, PCIECFG, val);
+	artpec6_writel(artpec6, PCIECFG, val);
 
-	regmap_read(artpec6->regmap, PCIECFG, &val);
+	val = artpec6_readl(artpec6, PCIECFG);
 	val |=  PCIECFG_RISRCREN |	/* Receiver term. 50 Ohm */
 		PCIECFG_MODE_TX_DRV_EN |
 		PCIECFG_CISRREN |	/* Reference clock term. 100 Ohm */
@@ -84,27 +97,27 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	val |= PCIECFG_REFCLK_ENABLE;
 	val &= ~PCIECFG_DBG_OEN;
 	val &= ~PCIECFG_CLKREQ_B;
-	regmap_write(artpec6->regmap, PCIECFG, val);
+	artpec6_writel(artpec6, PCIECFG, val);
 	usleep_range(5000, 6000);
 
-	regmap_read(artpec6->regmap, NOCCFG, &val);
+	val = artpec6_readl(artpec6, NOCCFG);
 	val |= NOCCFG_ENABLE_CLK_PCIE;
-	regmap_write(artpec6->regmap, NOCCFG, val);
+	artpec6_writel(artpec6, NOCCFG, val);
 	usleep_range(20, 30);
 
-	regmap_read(artpec6->regmap, PCIECFG, &val);
+	val = artpec6_readl(artpec6, PCIECFG);
 	val |= PCIECFG_PCLK_ENABLE | PCIECFG_PLL_ENABLE;
-	regmap_write(artpec6->regmap, PCIECFG, val);
+	artpec6_writel(artpec6, PCIECFG, val);
 	usleep_range(6000, 7000);
 
-	regmap_read(artpec6->regmap, NOCCFG, &val);
+	val = artpec6_readl(artpec6, NOCCFG);
 	val &= ~NOCCFG_POWER_PCIE_IDLEREQ;
-	regmap_write(artpec6->regmap, NOCCFG, val);
+	artpec6_writel(artpec6, NOCCFG, val);
 
 	retries = 50;
 	do {
 		usleep_range(1000, 2000);
-		regmap_read(artpec6->regmap, NOCCFG, &val);
+		val = artpec6_readl(artpec6, NOCCFG);
 		retries--;
 	} while (retries &&
 		(val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
@@ -117,9 +130,9 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	} while (retries && !(val & PHY_COSPLLLOCK));
 
 	/* Take DW core out of reset */
-	regmap_read(artpec6->regmap, PCIECFG, &val);
+	val = artpec6_readl(artpec6, PCIECFG);
 	val &= ~PCIECFG_CORE_RESET_REQ;
-	regmap_write(artpec6->regmap, PCIECFG, val);
+	artpec6_writel(artpec6, PCIECFG, val);
 	usleep_range(100, 200);
 
 	/*
@@ -137,9 +150,9 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	/* assert LTSSM enable */
-	regmap_read(artpec6->regmap, PCIECFG, &val);
+	val = artpec6_readl(artpec6, PCIECFG);
 	val |= PCIECFG_LTSSM_ENABLE;
-	regmap_write(artpec6->regmap, PCIECFG, val);
+	artpec6_writel(artpec6, PCIECFG, val);
 
 	/* check if the link is up or not */
 	if (!dw_pcie_wait_for_link(pp))

