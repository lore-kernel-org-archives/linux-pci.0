Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938941AbcJGQ0h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:26:37 -0400
Subject: [PATCH 3/5] PCI: tegra: Swap order of pads_writel() reg/val
 arguments
To: Alexandre Courbot <gnurou@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:26:32 -0500
Message-ID: <20161007162632.23718.27618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of pads_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-tegra.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 146b69f..4b01893 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -337,13 +337,13 @@ static u32 afi_readl(struct tegra_pcie *pcie, unsigned long offset)
 	return readl(pcie->afi + offset);
 }
 
-static inline void pads_writel(struct tegra_pcie *pcie, u32 value,
-			       unsigned long offset)
+static void pads_writel(struct tegra_pcie *pcie, unsigned long offset,
+			u32 value)
 {
 	writel(value, pcie->pads + offset);
 }
 
-static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
+static u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
 {
 	return readl(pcie->pads + offset);
 }
@@ -797,12 +797,12 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 	int err;
 
 	/* initialize internal PHY, enable up to 16 PCIE lanes */
-	pads_writel(pcie, 0x0, PADS_CTL_SEL);
+	pads_writel(pcie, PADS_CTL_SEL, 0);
 
 	/* override IDDQ to 1 on all 4 lanes */
 	value = pads_readl(pcie, PADS_CTL);
 	value |= PADS_CTL_IDDQ_1L;
-	pads_writel(pcie, value, PADS_CTL);
+	pads_writel(pcie, PADS_CTL, value);
 
 	/*
 	 * Set up PHY PLL inputs select PLLE output as refclock,
@@ -811,19 +811,19 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 	value = pads_readl(pcie, soc->pads_pll_ctl);
 	value &= ~(PADS_PLL_CTL_REFCLK_MASK | PADS_PLL_CTL_TXCLKREF_MASK);
 	value |= PADS_PLL_CTL_REFCLK_INTERNAL_CML | soc->tx_ref_sel;
-	pads_writel(pcie, value, soc->pads_pll_ctl);
+	pads_writel(pcie, soc->pads_pll_ctl, value);
 
 	/* reset PLL */
 	value = pads_readl(pcie, soc->pads_pll_ctl);
 	value &= ~PADS_PLL_CTL_RST_B4SM;
-	pads_writel(pcie, value, soc->pads_pll_ctl);
+	pads_writel(pcie, soc->pads_pll_ctl, value);
 
 	usleep_range(20, 100);
 
 	/* take PLL out of reset  */
 	value = pads_readl(pcie, soc->pads_pll_ctl);
 	value |= PADS_PLL_CTL_RST_B4SM;
-	pads_writel(pcie, value, soc->pads_pll_ctl);
+	pads_writel(pcie, soc->pads_pll_ctl, value);
 
 	/* wait for the PLL to lock */
 	err = tegra_pcie_pll_wait(pcie, 500);
@@ -835,12 +835,12 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 	/* turn off IDDQ override */
 	value = pads_readl(pcie, PADS_CTL);
 	value &= ~PADS_CTL_IDDQ_1L;
-	pads_writel(pcie, value, PADS_CTL);
+	pads_writel(pcie, PADS_CTL, value);
 
 	/* enable TX/RX data */
 	value = pads_readl(pcie, PADS_CTL);
 	value |= PADS_CTL_TX_DATA_EN_1L | PADS_CTL_RX_DATA_EN_1L;
-	pads_writel(pcie, value, PADS_CTL);
+	pads_writel(pcie, PADS_CTL, value);
 
 	return 0;
 }
@@ -853,17 +853,17 @@ static int tegra_pcie_phy_disable(struct tegra_pcie *pcie)
 	/* disable TX/RX data */
 	value = pads_readl(pcie, PADS_CTL);
 	value &= ~(PADS_CTL_TX_DATA_EN_1L | PADS_CTL_RX_DATA_EN_1L);
-	pads_writel(pcie, value, PADS_CTL);
+	pads_writel(pcie, PADS_CTL, value);
 
 	/* override IDDQ */
 	value = pads_readl(pcie, PADS_CTL);
 	value |= PADS_CTL_IDDQ_1L;
-	pads_writel(pcie, value, PADS_CTL);
+	pads_writel(pcie, PADS_CTL, value);
 
 	/* reset PLL */
 	value = pads_readl(pcie, soc->pads_pll_ctl);
 	value &= ~PADS_PLL_CTL_RST_B4SM;
-	pads_writel(pcie, value, soc->pads_pll_ctl);
+	pads_writel(pcie, soc->pads_pll_ctl, value);
 
 	usleep_range(20, 100);
 
@@ -935,10 +935,10 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 	}
 
 	/* Configure the reference clock driver */
-	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
+	pads_writel(pcie, PADS_REFCLK_CFG0, soc->pads_refclk_cfg0);
 
 	if (soc->num_ports > 2)
-		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
+		pads_writel(pcie, PADS_REFCLK_CFG1, soc->pads_refclk_cfg1);
 
 	return 0;
 }

