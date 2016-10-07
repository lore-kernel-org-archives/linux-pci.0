Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938984AbcJGQ03 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:26:29 -0400
Subject: [PATCH 2/5] PCI: tegra: Swap order of afi_writel() reg/val arguments
To: Alexandre Courbot <gnurou@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:26:24 -0500
Message-ID: <20161007162624.23718.46538.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of afi_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-tegra.c |  133 +++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 6df5ed0..146b69f 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -327,13 +327,12 @@ static inline struct tegra_pcie *sys_to_pcie(struct pci_sys_data *sys)
 	return sys->private_data;
 }
 
-static inline void afi_writel(struct tegra_pcie *pcie, u32 value,
-			      unsigned long offset)
+static void afi_writel(struct tegra_pcie *pcie, unsigned long offset, u32 value)
 {
 	writel(value, pcie->afi + offset);
 }
 
-static inline u32 afi_readl(struct tegra_pcie *pcie, unsigned long offset)
+static u32 afi_readl(struct tegra_pcie *pcie, unsigned long offset)
 {
 	return readl(pcie->afi + offset);
 }
@@ -531,13 +530,13 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
 	/* pulse reset signal */
 	value = afi_readl(port->pcie, ctrl);
 	value &= ~AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	afi_writel(port->pcie, ctrl, value);
 
 	usleep_range(1000, 2000);
 
 	value = afi_readl(port->pcie, ctrl);
 	value |= AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	afi_writel(port->pcie, ctrl, value);
 }
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
@@ -555,7 +554,7 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 
 	value |= AFI_PEX_CTRL_OVERRIDE_EN;
 
-	afi_writel(port->pcie, value, ctrl);
+	afi_writel(port->pcie, ctrl, value);
 
 	tegra_pcie_port_reset(port);
 }
@@ -569,7 +568,7 @@ static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
 	/* assert port reset */
 	value = afi_readl(port->pcie, ctrl);
 	value &= ~AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	afi_writel(port->pcie, ctrl, value);
 
 	/* disable reference clock */
 	value = afi_readl(port->pcie, ctrl);
@@ -578,7 +577,7 @@ static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
 		value &= ~AFI_PEX_CTRL_CLKREQ_EN;
 
 	value &= ~AFI_PEX_CTRL_REFCLK_EN;
-	afi_writel(port->pcie, value, ctrl);
+	afi_writel(port->pcie, ctrl, value);
 }
 
 static void tegra_pcie_port_free(struct tegra_pcie_port *port)
@@ -676,7 +675,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 
 	code = afi_readl(pcie, AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
 	signature = afi_readl(pcie, AFI_INTR_SIGNATURE);
-	afi_writel(pcie, 0, AFI_INTR_CODE);
+	afi_writel(pcie, AFI_INTR_CODE, 0);
 
 	if (code == AFI_INTR_LEGACY)
 		return IRQ_NONE;
@@ -725,54 +724,54 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
 	fpci_bar = 0xfe100000;
 	size = resource_size(pcie->cs);
 	axi_address = pcie->cs->start;
-	afi_writel(pcie, axi_address, AFI_AXI_BAR0_START);
-	afi_writel(pcie, size >> 12, AFI_AXI_BAR0_SZ);
-	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR0);
+	afi_writel(pcie, AFI_AXI_BAR0_START, axi_address);
+	afi_writel(pcie, AFI_AXI_BAR0_SZ, size >> 12);
+	afi_writel(pcie, AFI_FPCI_BAR0, fpci_bar);
 
 	/* Bar 1: downstream IO bar */
 	fpci_bar = 0xfdfc0000;
 	size = resource_size(&pcie->io);
 	axi_address = pcie->io.start;
-	afi_writel(pcie, axi_address, AFI_AXI_BAR1_START);
-	afi_writel(pcie, size >> 12, AFI_AXI_BAR1_SZ);
-	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR1);
+	afi_writel(pcie, AFI_AXI_BAR1_START, axi_address);
+	afi_writel(pcie, AFI_AXI_BAR1_SZ, size >> 12);
+	afi_writel(pcie, AFI_FPCI_BAR1, fpci_bar);
 
 	/* Bar 2: prefetchable memory BAR */
 	fpci_bar = (((pcie->prefetch.start >> 12) & 0x0fffffff) << 4) | 0x1;
 	size = resource_size(&pcie->prefetch);
 	axi_address = pcie->prefetch.start;
-	afi_writel(pcie, axi_address, AFI_AXI_BAR2_START);
-	afi_writel(pcie, size >> 12, AFI_AXI_BAR2_SZ);
-	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR2);
+	afi_writel(pcie, AFI_AXI_BAR2_START, axi_address);
+	afi_writel(pcie, AFI_AXI_BAR2_SZ, size >> 12);
+	afi_writel(pcie, AFI_FPCI_BAR2, fpci_bar);
 
 	/* Bar 3: non prefetchable memory BAR */
 	fpci_bar = (((pcie->mem.start >> 12) & 0x0fffffff) << 4) | 0x1;
 	size = resource_size(&pcie->mem);
 	axi_address = pcie->mem.start;
-	afi_writel(pcie, axi_address, AFI_AXI_BAR3_START);
-	afi_writel(pcie, size >> 12, AFI_AXI_BAR3_SZ);
-	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR3);
+	afi_writel(pcie, AFI_AXI_BAR3_START, axi_address);
+	afi_writel(pcie, AFI_AXI_BAR3_SZ, size >> 12);
+	afi_writel(pcie, AFI_FPCI_BAR3, fpci_bar);
 
 	/* NULL out the remaining BARs as they are not used */
-	afi_writel(pcie, 0, AFI_AXI_BAR4_START);
-	afi_writel(pcie, 0, AFI_AXI_BAR4_SZ);
-	afi_writel(pcie, 0, AFI_FPCI_BAR4);
+	afi_writel(pcie, AFI_AXI_BAR4_START, 0);
+	afi_writel(pcie, AFI_AXI_BAR4_SZ, 0);
+	afi_writel(pcie, AFI_FPCI_BAR4, 0);
 
-	afi_writel(pcie, 0, AFI_AXI_BAR5_START);
-	afi_writel(pcie, 0, AFI_AXI_BAR5_SZ);
-	afi_writel(pcie, 0, AFI_FPCI_BAR5);
+	afi_writel(pcie, AFI_AXI_BAR5_START, 0);
+	afi_writel(pcie, AFI_AXI_BAR5_SZ, 0);
+	afi_writel(pcie, AFI_FPCI_BAR5, 0);
 
 	/* map all upstream transactions as uncached */
-	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
-	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
-	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
-	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
+	afi_writel(pcie, AFI_CACHE_BAR0_ST, 0);
+	afi_writel(pcie, AFI_CACHE_BAR0_SZ, 0);
+	afi_writel(pcie, AFI_CACHE_BAR1_ST, 0);
+	afi_writel(pcie, AFI_CACHE_BAR1_SZ, 0);
 
 	/* MSI translations are setup only when needed */
-	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
-	afi_writel(pcie, 0, AFI_MSI_BAR_SZ);
-	afi_writel(pcie, 0, AFI_MSI_AXI_BAR_ST);
-	afi_writel(pcie, 0, AFI_MSI_BAR_SZ);
+	afi_writel(pcie, AFI_MSI_FPCI_BAR_ST, 0);
+	afi_writel(pcie, AFI_MSI_BAR_SZ, 0);
+	afi_writel(pcie, AFI_MSI_AXI_BAR_ST, 0);
+	afi_writel(pcie, AFI_MSI_BAR_SZ, 0);
 }
 
 static int tegra_pcie_pll_wait(struct tegra_pcie *pcie, unsigned long timeout)
@@ -987,12 +986,12 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		value = afi_readl(pcie, AFI_PLLE_CONTROL);
 		value &= ~AFI_PLLE_CONTROL_BYPASS_PADS2PLLE_CONTROL;
 		value |= AFI_PLLE_CONTROL_PADS2PLLE_CONTROL_EN;
-		afi_writel(pcie, value, AFI_PLLE_CONTROL);
+		afi_writel(pcie, AFI_PLLE_CONTROL, value);
 	}
 
 	/* power down PCIe slot clock bias pad */
 	if (soc->has_pex_bias_ctrl)
-		afi_writel(pcie, 0, AFI_PEXBIAS_CTRL_0);
+		afi_writel(pcie, AFI_PEXBIAS_CTRL_0, 0);
 
 	/* configure mode and disable all ports */
 	value = afi_readl(pcie, AFI_PCIE_CONFIG);
@@ -1002,16 +1001,16 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 	list_for_each_entry(port, &pcie->ports, list)
 		value &= ~AFI_PCIE_CONFIG_PCIE_DISABLE(port->index);
 
-	afi_writel(pcie, value, AFI_PCIE_CONFIG);
+	afi_writel(pcie, AFI_PCIE_CONFIG, value);
 
 	if (soc->has_gen2) {
 		value = afi_readl(pcie, AFI_FUSE);
 		value &= ~AFI_FUSE_PCIE_T0_GEN2_DIS;
-		afi_writel(pcie, value, AFI_FUSE);
+		afi_writel(pcie, AFI_FUSE, value);
 	} else {
 		value = afi_readl(pcie, AFI_FUSE);
 		value |= AFI_FUSE_PCIE_T0_GEN2_DIS;
-		afi_writel(pcie, value, AFI_FUSE);
+		afi_writel(pcie, AFI_FUSE, value);
 	}
 
 	err = tegra_pcie_phy_power_on(pcie);
@@ -1026,7 +1025,7 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 	/* finally enable PCIe */
 	value = afi_readl(pcie, AFI_CONFIGURATION);
 	value |= AFI_CONFIGURATION_EN_FPCI;
-	afi_writel(pcie, value, AFI_CONFIGURATION);
+	afi_writel(pcie, AFI_CONFIGURATION, value);
 
 	value = AFI_INTR_EN_INI_SLVERR | AFI_INTR_EN_INI_DECERR |
 		AFI_INTR_EN_TGT_SLVERR | AFI_INTR_EN_TGT_DECERR |
@@ -1035,14 +1034,14 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 	if (soc->has_intr_prsnt_sense)
 		value |= AFI_INTR_EN_PRSNT_SENSE;
 
-	afi_writel(pcie, value, AFI_AFI_INTR_ENABLE);
-	afi_writel(pcie, 0xffffffff, AFI_SM_INTR_ENABLE);
+	afi_writel(pcie, AFI_AFI_INTR_ENABLE, value);
+	afi_writel(pcie, AFI_SM_INTR_ENABLE, 0xffffffff);
 
 	/* don't enable MSI for now, only when needed */
-	afi_writel(pcie, AFI_INTR_MASK_INT_MASK, AFI_INTR_MASK);
+	afi_writel(pcie, AFI_INTR_MASK, AFI_INTR_MASK_INT_MASK);
 
 	/* disable all exceptions */
-	afi_writel(pcie, 0, AFI_FPCI_ERROR_MASKS);
+	afi_writel(pcie, AFI_FPCI_ERROR_MASKS, 0);
 
 	return 0;
 }
@@ -1396,7 +1395,7 @@ static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
 			unsigned int irq;
 
 			/* clear the interrupt */
-			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
+			afi_writel(pcie, AFI_MSI_VEC0 + i * 4, 1 << offset);
 
 			irq = irq_find_mapping(msi->domain, index);
 			if (irq) {
@@ -1527,25 +1526,25 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
 	base = virt_to_phys((void *)msi->pages);
 
-	afi_writel(pcie, base >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
-	afi_writel(pcie, base, AFI_MSI_AXI_BAR_ST);
+	afi_writel(pcie, AFI_MSI_FPCI_BAR_ST, base >> soc->msi_base_shift);
+	afi_writel(pcie, AFI_MSI_AXI_BAR_ST, base);
 	/* this register is in 4K increments */
-	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
+	afi_writel(pcie, AFI_MSI_BAR_SZ, 1);
 
 	/* enable all MSI vectors */
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC0);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC1);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC2);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC3);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC4);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC5);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC6);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC7);
+	afi_writel(pcie, AFI_MSI_EN_VEC0, 0xffffffff);
+	afi_writel(pcie, AFI_MSI_EN_VEC1, 0xffffffff);
+	afi_writel(pcie, AFI_MSI_EN_VEC2, 0xffffffff);
+	afi_writel(pcie, AFI_MSI_EN_VEC3, 0xffffffff);
+	afi_writel(pcie, AFI_MSI_EN_VEC4, 0xffffffff);
+	afi_writel(pcie, AFI_MSI_EN_VEC5, 0xffffffff);
+	afi_writel(pcie, AFI_MSI_EN_VEC6, 0xffffffff);
+	afi_writel(pcie, AFI_MSI_EN_VEC7, 0xffffffff);
 
 	/* and unmask the MSI interrupt */
 	reg = afi_readl(pcie, AFI_INTR_MASK);
 	reg |= AFI_INTR_MASK_MSI_MASK;
-	afi_writel(pcie, reg, AFI_INTR_MASK);
+	afi_writel(pcie, AFI_INTR_MASK, reg);
 
 	return 0;
 
@@ -1563,17 +1562,17 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
 	/* mask the MSI interrupt */
 	value = afi_readl(pcie, AFI_INTR_MASK);
 	value &= ~AFI_INTR_MASK_MSI_MASK;
-	afi_writel(pcie, value, AFI_INTR_MASK);
+	afi_writel(pcie, AFI_INTR_MASK, value);
 
 	/* disable all MSI vectors */
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC0);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC1);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC2);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC3);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC4);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC5);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC6);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC7);
+	afi_writel(pcie, AFI_MSI_EN_VEC0, 0);
+	afi_writel(pcie, AFI_MSI_EN_VEC1, 0);
+	afi_writel(pcie, AFI_MSI_EN_VEC2, 0);
+	afi_writel(pcie, AFI_MSI_EN_VEC3, 0);
+	afi_writel(pcie, AFI_MSI_EN_VEC4, 0);
+	afi_writel(pcie, AFI_MSI_EN_VEC5, 0);
+	afi_writel(pcie, AFI_MSI_EN_VEC6, 0);
+	afi_writel(pcie, AFI_MSI_EN_VEC7, 0);
 
 	free_pages(msi->pages, 0);
 

