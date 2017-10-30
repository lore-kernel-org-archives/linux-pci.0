Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3831 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbdJ3LGu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 07:06:50 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>, <rajatja@google.com>,
        <yinghai@kernel.org>, <david.daney@cavium.com>,
        <Julia.Lawall@lip6.fr>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>
Subject: [PATCH 3/4] PCI: tegra: Apply sw fixups to support ASPM-L1 Sub-States
Date: Mon, 30 Oct 2017 16:33:04 +0530
Message-ID: <1509361385-21224-4-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1509361385-21224-1-git-send-email-vidyas@nvidia.com>
References: <1509361385-21224-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Programs T_cmrt (Commmon Mode Restore Time) and T_pwr_on (Power On)
values to get them reflected in ASPM-L1 Sub-States capability registers
Also adjusts internal counter values according to 19.2 MHz clk_m value

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index e1526cc5d381..08da67a82a2d 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -40,6 +40,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/pci-aspm.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -191,6 +192,27 @@
 #define RP_PRIV_XP_DL	0x494
 #define  RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD	(0x1ff << 1)
 
+#define RP_L1_PM_SUBSTATES_CTL				0xC00
+#define RP_L1_PM_SUBSTATES_CTL_CM_RTIME_MASK		(0xFF << 8)
+#define RP_L1_PM_SUBSTATES_CTL_CM_RTIME_SHIFT		8
+#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_MASK		(0x3 << 16)
+#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_SHIFT		16
+#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_MASK		(0x1F << 19)
+#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_SHIFT		19
+#define RP_L1_PM_SUBSTATES_CTL_HIDE_CAP			(0x1 << 24)
+
+#define RP_L1_PM_SUBSTATES_1_CTL			0xC04
+#define RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK	0x1FFF
+#define RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY		0x26
+
+#define RP_L1_PM_SUBSTATES_2_CTL			0xC08
+#define RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY_MASK	0x1FFF
+#define RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY		0x4D
+#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_MASK	(0xFF << 13)
+#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND		(0x13 << 13)
+#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP_MASK	(0xF << 21)
+#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP	(0x2 << 21)
+
 #define RP_RX_HDR_LIMIT	0xe00
 #define  RP_RX_HDR_LIMIT_PW_MASK	(0xff << 8)
 #define  RP_RX_HDR_LIMIT_PW		(0x0e << 8)
@@ -331,6 +353,7 @@ struct tegra_pcie_soc {
 	bool program_deskew_time;
 	bool updateFC_threshold;
 	bool has_aspm_l1;
+	bool has_aspm_l1ss;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -423,6 +446,12 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
 	return readl(pcie->pads + offset);
 }
 
+u32 pcie_aspm_get_ltr_l_1_2_threshold(void)
+{
+	/* LTR L1.2 Threshold = 55us for all ports */
+	return ((0x37 << 16) | (0x02 << 29));
+}
+
 /*
  * The configuration space mapping on Tegra is somewhat similar to the ECAM
  * defined by PCIe. However it deviates a bit in how the 4 bits for extended
@@ -2262,6 +2291,37 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= RP_VEND_XP_UPDATE_FC_THRESHOLD_T210;
 		writel(value, port->base + RP_VEND_XP);
 	}
+
+	if (soc->has_aspm_l1ss) {
+		/* Set Common Mode Restore Time to 30us */
+		value = readl(port->base + RP_L1_PM_SUBSTATES_CTL);
+		value &= ~RP_L1_PM_SUBSTATES_CTL_CM_RTIME_MASK;
+		value |= (0x1E << RP_L1_PM_SUBSTATES_CTL_CM_RTIME_SHIFT);
+		writel(value, port->base + RP_L1_PM_SUBSTATES_CTL);
+
+		/* set T_Power_On to 70us */
+		value = readl(port->base + RP_L1_PM_SUBSTATES_CTL);
+		value &= ~(RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_MASK |
+			RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_MASK);
+		value |= (1 << RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_SHIFT) |
+			(7 << RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_SHIFT);
+		writel(value, port->base + RP_L1_PM_SUBSTATES_CTL);
+
+		/* Following is based on clk_m being 19.2 MHz */
+		value = readl(port->base + RP_L1_PM_SUBSTATES_1_CTL);
+		value &= ~RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK;
+		value |= RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY;
+		writel(value, port->base + RP_L1_PM_SUBSTATES_1_CTL);
+
+		value = readl(port->base + RP_L1_PM_SUBSTATES_2_CTL);
+		value &= ~RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY_MASK;
+		value |= RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY;
+		value &= ~RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_MASK;
+		value |= RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND;
+		value &= ~RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP_MASK;
+		value |= RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP;
+		writel(value, port->base + RP_L1_PM_SUBSTATES_2_CTL);
+	}
 }
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
@@ -2403,6 +2463,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
 	.has_aspm_l1 = false,
+	.has_aspm_l1ss = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2425,6 +2486,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
 	.has_aspm_l1 = true,
+	.has_aspm_l1ss = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2446,6 +2508,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
 	.has_aspm_l1 = true,
+	.has_aspm_l1ss = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2475,6 +2538,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_deskew_time = true,
 	.updateFC_threshold = true,
 	.has_aspm_l1 = true,
+	.has_aspm_l1ss = true,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2497,6 +2561,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
 	.has_aspm_l1 = true,
+	.has_aspm_l1ss = true,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.7.4
