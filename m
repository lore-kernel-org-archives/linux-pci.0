Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8561 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbdJ3OBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 10:01:14 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 10/12] PCI: tegra: Add SW fixup for RAW violations
Date: Mon, 30 Oct 2017 19:27:21 +0530
Message-ID: <1509371843-22931-11-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The logic which blocks read requests till AFI gets ACK for all outstanding
MC writes does not behave correctly when number of outstanding write
becomes more than 32.

SW fixup to prevent this issue is to limit outstanding posted writes and
tweak updateFC timer threshold.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* changed soc parameter name
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 9f13e6fcc64e..3993e9221c96 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -185,6 +185,13 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
+#define RP_PRIV_XP_DL	0x494
+#define  RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD	(0x1ff << 1)
+
+#define RP_RX_HDR_LIMIT	0xe00
+#define  RP_RX_HDR_LIMIT_PW_MASK	(0xff << 8)
+#define  RP_RX_HDR_LIMIT_PW		(0x0e << 8)
+
 #define RP_ECTL_2_R1	0xe84
 #define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
 
@@ -215,6 +222,7 @@
 #define  RP_VEND_XP_DL_UP			(1 << 30)
 #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
 #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
+#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
 
 #define RP_VEND_CTL1	0xf48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
@@ -309,6 +317,7 @@ struct tegra_pcie_soc {
 	bool program_uphy;
 	bool program_ectl_settings;
 	bool update_clamp_threshold;
+	bool raw_violation_fixup;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -2191,6 +2200,22 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD;
 	}
 	writel(value, port->base + RP_PRIV_MISC);
+
+	/* Fixup for read after write violation in T124 & T132 platforms */
+	if (soc->raw_violation_fixup) {
+		value = readl(port->base + RP_RX_HDR_LIMIT);
+		value &= ~RP_RX_HDR_LIMIT_PW_MASK;
+		value |= RP_RX_HDR_LIMIT_PW;
+		writel(value, port->base + RP_RX_HDR_LIMIT);
+
+		value = readl(port->base + RP_PRIV_XP_DL);
+		value |= RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD;
+		writel(value, port->base + RP_PRIV_XP_DL);
+
+		value = readl(port->base + RP_VEND_XP);
+		value |= RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
+		writel(value, port->base + RP_VEND_XP);
+	}
 }
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
@@ -2329,6 +2354,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_uphy = true,
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
+	.raw_violation_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2347,6 +2373,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_uphy = true,
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
+	.raw_violation_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2364,6 +2391,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_uphy = true,
 	.program_ectl_settings = false,
 	.update_clamp_threshold = true,
+	.raw_violation_fixup = true,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2389,6 +2417,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_uphy = true,
 	.program_ectl_settings = true,
 	.update_clamp_threshold = true,
+	.raw_violation_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2407,6 +2436,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_uphy = false,
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
+	.raw_violation_fixup = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.1.4
