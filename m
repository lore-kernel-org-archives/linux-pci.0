Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36020 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbcKYK5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 05:57:48 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 07/10] PCI: tegra: Add Tegra210 support
Date: Fri, 25 Nov 2016 11:57:15 +0100
Message-Id: <20161125105718.3866-7-thierry.reding@gmail.com>
In-Reply-To: <20161125105718.3866-1-thierry.reding@gmail.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The PCIe host controller found on Tegra X1 is very similar to its
predecessor on Tegra K1. A bug was introduced in the new revision that
is worked around by always enabling the performance counter, otherwise
accesses to configuration space will block for a number of seconds.

Changes in v4:
- use pgprot_device(PAGE_KERNEL) to increase portability

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 4bfaac6d3582..ed8a93f2bfb5 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -51,10 +51,6 @@
 #include <soc/tegra/cpuidle.h>
 #include <soc/tegra/pmc.h>
 
-#include <asm/mach/irq.h>
-#include <asm/mach/map.h>
-#include <asm/mach/pci.h>
-
 #define INT_PCI_MSI_NR (8 * 32)
 
 /* register definitions */
@@ -384,8 +380,7 @@ static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
 						   unsigned int busnr)
 {
 	struct device *dev = pcie->dev;
-	pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				 L_PTE_XN | L_PTE_MT_DEV_SHARED | L_PTE_SHARED);
+	pgprot_t prot = pgprot_device(PAGE_KERNEL);
 	phys_addr_t cs = pcie->cs->start;
 	struct tegra_pcie_bus *bus;
 	unsigned int i;
@@ -1612,7 +1607,8 @@ static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
 	struct device *dev = pcie->dev;
 	struct device_node *np = dev->of_node;
 
-	if (of_device_is_compatible(np, "nvidia,tegra124-pcie")) {
+	if (of_device_is_compatible(np, "nvidia,tegra124-pcie") ||
+	    of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
 		switch (lanes) {
 		case 0x0000104:
 			dev_info(dev, "4x1, 1x1 configuration\n");
@@ -1733,7 +1729,22 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 	struct device_node *np = dev->of_node;
 	unsigned int i = 0;
 
-	if (of_device_is_compatible(np, "nvidia,tegra124-pcie")) {
+	if (of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
+		pcie->num_supplies = 6;
+
+		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
+					      sizeof(*pcie->supplies),
+					      GFP_KERNEL);
+		if (!pcie->supplies)
+			return -ENOMEM;
+
+		pcie->supplies[i++].supply = "avdd-pll-uerefe";
+		pcie->supplies[i++].supply = "hvddio-pex";
+		pcie->supplies[i++].supply = "dvddio-pex";
+		pcie->supplies[i++].supply = "dvdd-pex-pll";
+		pcie->supplies[i++].supply = "hvdd-pex-pll-e";
+		pcie->supplies[i++].supply = "vddio-pex-ctl";
+	} else if (of_device_is_compatible(np, "nvidia,tegra124-pcie")) {
 		pcie->num_supplies = 7;
 
 		pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
@@ -2088,7 +2099,22 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.force_pca_enable = false,
 };
 
+static const struct tegra_pcie_soc tegra210_pcie = {
+	.num_ports = 2,
+	.msi_base_shift = 8,
+	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
+	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
+	.pads_refclk_cfg0 = 0x90b890b8,
+	.has_pex_clkreq_en = true,
+	.has_pex_bias_ctrl = true,
+	.has_intr_prsnt_sense = true,
+	.has_cml_clk = true,
+	.has_gen2 = true,
+	.force_pca_enable = true,
+};
+
 static const struct of_device_id tegra_pcie_of_match[] = {
+	{ .compatible = "nvidia,tegra210-pcie", .data = &tegra210_pcie },
 	{ .compatible = "nvidia,tegra124-pcie", .data = &tegra124_pcie },
 	{ .compatible = "nvidia,tegra30-pcie", .data = &tegra30_pcie },
 	{ .compatible = "nvidia,tegra20-pcie", .data = &tegra20_pcie },
-- 
2.10.2

