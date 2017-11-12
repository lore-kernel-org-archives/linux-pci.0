Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1873 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdKLNSG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Nov 2017 08:18:06 -0500
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <swarren@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>
Subject: [PATCH V3 2/3] PCI: tegra: fixups to avoid unnecessary wakeup from ASPM-L1.2
Date: Sun, 12 Nov 2017 18:47:53 +0530
Message-ID: <1510492674-12786-3-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
References: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

sets CLKREQ asserted delay to a higher value to avoid
unnecessary wake up from L1.2_ENTRY state for Tegra210

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* no change in this patch

V3:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 6d68f49f152e..29ee4bb0b7c6 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -204,6 +204,8 @@
 #define RP_L1_PM_SUBSTATES_1_CTL			0xC04
 #define RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK	0x1FFF
 #define RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY		0x26
+#define RP_L1SS_1_CTL_CLKREQ_ASSERTED_DLY_MASK		(0x1FF << 13)
+#define RP_L1SS_1_CTL_CLKREQ_ASSERTED_DLY		(0x27 << 13)
 
 #define RP_L1_PM_SUBSTATES_2_CTL			0xC08
 #define RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY_MASK	0x1FFF
@@ -350,6 +352,7 @@ struct tegra_pcie_soc {
 	bool program_deskew_time;
 	bool updateFC_threshold;
 	bool has_aspm_l1ss;
+	bool l1ss_rp_wake_fixup;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -2290,6 +2293,16 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 			(7 << RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_SHIFT);
 		writel(value, port->base + RP_L1_PM_SUBSTATES_CTL);
 
+		if (soc->l1ss_rp_wake_fixup) {
+			/* Set CLKREQ asserted delay greater than Power_Off
+			 * time (2us) to avoid RP wakeup in L1.2_ENTRY
+			 */
+			value = readl(port->base + RP_L1_PM_SUBSTATES_1_CTL);
+			value &= ~RP_L1SS_1_CTL_CLKREQ_ASSERTED_DLY_MASK;
+			value |= RP_L1SS_1_CTL_CLKREQ_ASSERTED_DLY;
+			writel(value, port->base + RP_L1_PM_SUBSTATES_1_CTL);
+		}
+
 		/* Following is based on clk_m being 19.2 MHz */
 		value = readl(port->base + RP_L1_PM_SUBSTATES_1_CTL);
 		value &= ~RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK;
@@ -2446,6 +2459,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
 	.has_aspm_l1ss = false,
+	.l1ss_rp_wake_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2468,6 +2482,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
 	.has_aspm_l1ss = false,
+	.l1ss_rp_wake_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2489,6 +2504,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
 	.has_aspm_l1ss = false,
+	.l1ss_rp_wake_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2518,6 +2534,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_deskew_time = true,
 	.updateFC_threshold = true,
 	.has_aspm_l1ss = true,
+	.l1ss_rp_wake_fixup = true,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2540,6 +2557,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
 	.has_aspm_l1ss = true,
+	.l1ss_rp_wake_fixup = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.7.4
