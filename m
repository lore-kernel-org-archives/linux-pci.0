Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44706 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbdLNNqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:46:00 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Saga <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 4/4] PCI: tegra: Remove artificial mapping restriction
Date: Thu, 14 Dec 2017 14:45:45 +0100
Message-Id: <20171214134545.11143-5-thierry.reding@gmail.com>
In-Reply-To: <20171214134545.11143-1-thierry.reding@gmail.com>
References: <20171214134545.11143-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The current code restricts the location of the 4 KiB configuration space
mapping region. This is unnecessary if the AFI_FPCI_BAR0 register is
used to move the 4 KiB window into the FPCI address map. Doing this will
allow all generations of Tegra to be handled in a unified way.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 46 +++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 7f8a81e17db6..2e7bea127120 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -257,7 +257,6 @@ struct tegra_pcie_soc {
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
-	bool use_4k_conf_space;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -274,7 +273,7 @@ struct tegra_pcie {
 	int irq;
 
 	struct list_head buses;
-	struct resource *cs;
+	struct resource cs;
 
 	struct resource io;
 	struct resource pio;
@@ -418,8 +417,6 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 	struct pci_host_bridge *host = pci_find_host_bridge(bus);
 	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
 	void __iomem *addr = NULL;
-	u32 val = 0;
-	u32 offset = 0;
 
 	if (bus->number == 0) {
 		unsigned int slot = PCI_SLOT(devfn);
@@ -432,11 +429,17 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 			}
 		}
 	} else {
+		unsigned int offset;
+		u32 base;
+
 		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
+
+		/* move 4 KiB window to offset within the FPCI region */
+		base = 0xfe100000 + ((offset & ~(SZ_4K - 1)) >> 8);
+		afi_writel(pcie, base, AFI_FPCI_BAR0);
+
+		/* move to correct offset within the 4 KiB page */
 		addr = pcie->cfg + (offset & (SZ_4K - 1));
-		val = offset & ~(SZ_4K - 1);
-		afi_writel(pcie, pcie->cs->start - val, AFI_AXI_BAR0_START);
-		afi_writel(pcie, (val + SZ_4K) >> 12, AFI_AXI_BAR0_SZ);
 	}
 
 	return addr;
@@ -689,8 +692,9 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
 	u32 fpci_bar, size, axi_address;
 
 	/* Bar 0: type 1 extended configuration space */
-	fpci_bar = 0xfe100000;
-	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR0);
+	size = resource_size(&pcie->cs);
+	afi_writel(pcie, pcie->cs.start, AFI_AXI_BAR0_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR0_SZ);
 
 	/* Bar 1: downstream IO bar */
 	fpci_bar = 0xfdfc0000;
@@ -1246,7 +1250,6 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *pads, *afi, *res;
 	const struct tegra_pcie_soc *soc = pcie->soc;
-	u32 axi_addr = 0;
 	int err;
 
 	err = tegra_pcie_clocks_get(pcie);
@@ -1296,18 +1299,14 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 		goto poweroff;
 	}
 
-	axi_addr = pcie->soc->use_4k_conf_space ?
-		   res->start : res->end - SZ_4K + 1;
-	pcie->cs = devm_request_mem_region(dev, axi_addr, SZ_4K, res->name);
-	if (!pcie->cs) {
-		err = -EADDRNOTAVAIL;
-		goto poweroff;
-	}
+	pcie->cs = *res;
 
-	pcie->cfg = devm_ioremap(dev, pcie->cs.start, SZ_4K);
-	if (!pcie->cfg) {
-		dev_err(pcie->dev, "failed to ioremap config space\n");
-		err = -EADDRNOTAVAIL;
+	/* constrain configuration space to 4 KiB */
+	pcie->cs.end = pcie->cs.start + SZ_4K - 1;
+
+	pcie->cfg = devm_ioremap_resource(dev, &pcie->cs);
+	if (IS_ERR(pcie->cfg)) {
+		err = PTR_ERR(pcie->cfg);
 		goto poweroff;
 	}
 
@@ -2120,7 +2119,6 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
-	.use_4k_conf_space = true,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2138,7 +2136,6 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
-	.use_4k_conf_space = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2155,7 +2152,6 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
-	.use_4k_conf_space = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2172,7 +2168,6 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
-	.use_4k_conf_space = false,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2190,7 +2185,6 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
-	.use_4k_conf_space = true,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.15.1
