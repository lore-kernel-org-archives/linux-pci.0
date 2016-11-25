Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32907 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbcKYK5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 05:57:43 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 06/10] PCI: tegra: Implement PCA enable workaround
Date: Fri, 25 Nov 2016 11:57:14 +0100
Message-Id: <20161125105718.3866-6-thierry.reding@gmail.com>
In-Reply-To: <20161125105718.3866-1-thierry.reding@gmail.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Tegra210's PCIe controller has a bug that requires the PCA (performance
counter) feature to be enabled. If this isn't done, accesses to device
configuration space will hang the chip for tens of seconds. Implement
the workaround.

Based on commit 514e19138af2 ("pci: tegra: implement PCA enable
workaround") from U-Boot by Stephen Warren <swarren@nvidia.com>.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index d5206fa53353..4bfaac6d3582 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -188,6 +188,9 @@
 #define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
+#define RP_VEND_CTL2 0x00000fa8
+#define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
+
 #define RP_PRIV_MISC	0x00000fe0
 #define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT (0xe << 0)
 #define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT (0xf << 0)
@@ -252,6 +255,7 @@ struct tegra_pcie_soc {
 	bool has_intr_prsnt_sense;
 	bool has_cml_clk;
 	bool has_gen2;
+	bool force_pca_enable;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -556,6 +560,12 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 	afi_writel(port->pcie, value, ctrl);
 
 	tegra_pcie_port_reset(port);
+
+	if (soc->force_pca_enable) {
+		value = readl(port->base + RP_VEND_CTL2);
+		value |= RP_VEND_CTL2_PCA_ENABLE;
+		writel(value, port->base + RP_VEND_CTL2);
+	}
 }
 
 static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
@@ -2046,6 +2056,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_intr_prsnt_sense = false,
 	.has_cml_clk = false,
 	.has_gen2 = false,
+	.force_pca_enable = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2060,6 +2071,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_intr_prsnt_sense = true,
 	.has_cml_clk = true,
 	.has_gen2 = false,
+	.force_pca_enable = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2073,6 +2085,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_intr_prsnt_sense = true,
 	.has_cml_clk = true,
 	.has_gen2 = true,
+	.force_pca_enable = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.10.2

