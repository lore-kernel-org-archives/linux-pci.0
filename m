Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5555 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdJ3EWn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 00:22:43 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 05/12] PCI: tegra: Program UPHY electrical settings in Tegra210
Date: Mon, 30 Oct 2017 09:48:56 +0530
Message-ID: <1509337143-25963-6-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509337143-25963-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509337143-25963-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

UPHY electrical programming guidelines are documented in Tegra210 TRM.
Program these electrical settings for proper eye diagram in all link
speeds.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 95 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 2a7665a9ce5b..51b7821646eb 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -184,6 +184,30 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
+#define RP_ECTL_2_R1	0xe84
+#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
+
+#define RP_ECTL_4_R1	0xe8c
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
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
+
+#define RP_ECTL_5_R2	0xeb0
+#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+
+#define RP_ECTL_6_R2	0xeb4
+#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+
 #define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
@@ -254,6 +278,14 @@ struct tegra_pcie_soc {
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
@@ -261,6 +293,7 @@ struct tegra_pcie_soc {
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
+	bool program_ectl_settings;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -2058,6 +2091,52 @@ static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
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
+	value |= soc->rp_ectl_4_r1;
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
+	value |= soc->rp_ectl_4_r2;
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
@@ -2125,6 +2204,7 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct tegra_pcie_port *port, *tmp;
+	const struct tegra_pcie_soc *soc = pcie->soc;
 
 	tegra_pcie_apply_pad_settings(pcie);
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
@@ -2132,6 +2212,8 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 			 port->index, port->lanes);
 
 		tegra_pcie_port_enable(port);
+		if (soc->program_ectl_settings)
+			tegra_pcie_program_ectl_settings(port);
 		tegra_pcie_enable_rp_features(port);
 	}
 
@@ -2198,6 +2280,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.program_ectl_settings = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2214,6 +2297,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.program_ectl_settings = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2229,6 +2313,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.program_ectl_settings = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2237,6 +2322,14 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x90b890b8,
+	.rp_ectl_2_r1 = 0x0000000f,
+	.rp_ectl_4_r1 = 0x00670000,
+	.rp_ectl_5_r1 = 0x55010000,
+	.rp_ectl_6_r1 = 0x00000001,
+	.rp_ectl_2_r2 = 0x0000008f,
+	.rp_ectl_4_r2 = 0x00c70000,
+	.rp_ectl_5_r2 = 0x55010000,
+	.rp_ectl_6_r2 = 0x00000001,
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2244,6 +2337,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
+	.program_ectl_settings = true,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2260,6 +2354,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
+	.program_ectl_settings = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.1.4
