Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17867 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdJ3N7o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 09:59:44 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 05/12] PCI: tegra: Program UPHY electrical settings in Tegra210
Date: Mon, 30 Oct 2017 19:27:16 +0530
Message-ID: <1509371843-22931-6-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

UPHY electrical programming guidelines are documented in Tegra210 TRM.
Program these electrical settings for proper eye diagram in all link
speeds.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* Added shift operation for readability
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 97 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 46896aaab81d..c862facfd6e9 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -184,6 +184,32 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
+#define RP_ECTL_2_R1	0xe84
+#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
+
+#define RP_ECTL_4_R1	0xe8c
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT	16
+
+#define RP_ECTL_5_R1	0xe90
+#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+
+#define RP_ECTL_6_R1	0xe94
+#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+
+#define RP_ECTL_2_R2	0xea4
+#define  RP_ECTL_2_R2_RX_CTLE_1C_MASK		0xffff
+
+#define RP_ECTL_4_R2	0xeac
+#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT	16
+
+#define RP_ECTL_5_R2	0xeb0
+#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+
+#define RP_ECTL_6_R2	0xeb4
+#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+
 #define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
@@ -254,6 +280,14 @@ struct tegra_pcie_soc {
 	u32 tx_ref_sel;
 	u32 pads_refclk_cfg0;
 	u32 pads_refclk_cfg1;
+	u32 rp_ectl_2_r1;
+	u32 rp_ectl_4_r1;
+	u32 rp_ectl_5_r1;
+	u32 rp_ectl_6_r1;
+	u32 rp_ectl_2_r2;
+	u32 rp_ectl_4_r2;
+	u32 rp_ectl_5_r2;
+	u32 rp_ectl_6_r2;
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
@@ -261,6 +295,7 @@ struct tegra_pcie_soc {
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
+	bool program_ectl_settings;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -2058,6 +2093,52 @@ static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
 		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
 }
 
+static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
+{
+	unsigned long value;
+	const struct tegra_pcie_soc *soc = port->pcie->soc;
+
+	value = readl(port->base + RP_ECTL_2_R1);
+	value &= ~RP_ECTL_2_R1_RX_CTLE_1C_MASK;
+	value |= soc->rp_ectl_2_r1;
+	writel(value, port->base + RP_ECTL_2_R1);
+
+	value = readl(port->base + RP_ECTL_4_R1);
+	value &= ~RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK;
+	value |= (soc->rp_ectl_4_r1 << RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT);
+	writel(value, port->base + RP_ECTL_4_R1);
+
+	value = readl(port->base + RP_ECTL_5_R1);
+	value &= ~RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK;
+	value |= soc->rp_ectl_5_r1;
+	writel(value, port->base + RP_ECTL_5_R1);
+
+	value = readl(port->base + RP_ECTL_6_R1);
+	value &= ~RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK;
+	value |= soc->rp_ectl_6_r1;
+	writel(value, port->base + RP_ECTL_6_R1);
+
+	value = readl(port->base + RP_ECTL_2_R2);
+	value &= ~RP_ECTL_2_R2_RX_CTLE_1C_MASK;
+	value |= soc->rp_ectl_2_r2;
+	writel(value, port->base + RP_ECTL_2_R2);
+
+	value = readl(port->base + RP_ECTL_4_R2);
+	value &= ~RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK;
+	value |= (soc->rp_ectl_4_r2 << RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT);
+	writel(value, port->base + RP_ECTL_4_R2);
+
+	value = readl(port->base + RP_ECTL_5_R2);
+	value &= ~RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK;
+	value |= soc->rp_ectl_5_r2;
+	writel(value, port->base + RP_ECTL_5_R2);
+
+	value = readl(port->base + RP_ECTL_6_R2);
+	value &= ~RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK;
+	value |= soc->rp_ectl_6_r2;
+	writel(value, port->base + RP_ECTL_6_R2);
+}
+
 static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 {
 	unsigned long value;
@@ -2125,6 +2206,7 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct tegra_pcie_port *port, *tmp;
+	const struct tegra_pcie_soc *soc = pcie->soc;
 
 	tegra_pcie_apply_pad_settings(pcie);
 
@@ -2133,6 +2215,8 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 			 port->index, port->lanes);
 
 		tegra_pcie_port_enable(port);
+		if (soc->program_ectl_settings)
+			tegra_pcie_program_ectl_settings(port);
 		tegra_pcie_enable_rp_features(port);
 	}
 
@@ -2199,6 +2283,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.program_ectl_settings = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2215,6 +2300,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.program_ectl_settings = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2230,6 +2316,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.program_ectl_settings = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2238,6 +2325,14 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x90b890b8,
+	.rp_ectl_2_r1 = 0x0000000f,
+	.rp_ectl_4_r1 = 0x00000067,
+	.rp_ectl_5_r1 = 0x55010000,
+	.rp_ectl_6_r1 = 0x00000001,
+	.rp_ectl_2_r2 = 0x0000008f,
+	.rp_ectl_4_r2 = 0x000000c7,
+	.rp_ectl_5_r2 = 0x55010000,
+	.rp_ectl_6_r2 = 0x00000001,
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2245,6 +2340,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
+	.program_ectl_settings = true,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2261,6 +2357,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
+	.program_ectl_settings = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.1.4
