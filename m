Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15616 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdJaEXp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 00:23:45 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>, <rajatja@google.com>,
        <yinghai@kernel.org>, <david.daney@cavium.com>,
        <Julia.Lawall@lip6.fr>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>
Subject: [PATCH V2 4/4] PCI: tegra: fixups to avoid unnecessary wakeup from ASPM-L1.2
Date: Tue, 31 Oct 2017 09:52:49 +0530
Message-ID: <1509423769-10522-5-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1509423769-10522-1-git-send-email-vidyas@nvidia.com>
References: <1509423769-10522-1-git-send-email-vidyas@nvidia.com>
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

 drivers/pci/host/pci-tegra.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 08da67a82a2d..811209dedde2 100644
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
@@ -354,6 +356,7 @@ struct tegra_pcie_soc {
 	bool updateFC_threshold;
 	bool has_aspm_l1;
 	bool has_aspm_l1ss;
+	bool l1ss_rp_wake_fixup;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -2307,6 +2310,16 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
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
@@ -2464,6 +2477,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.updateFC_threshold = false,
 	.has_aspm_l1 = false,
 	.has_aspm_l1ss = false,
+	.l1ss_rp_wake_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2487,6 +2501,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.updateFC_threshold = false,
 	.has_aspm_l1 = true,
 	.has_aspm_l1ss = false,
+	.l1ss_rp_wake_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2509,6 +2524,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.updateFC_threshold = false,
 	.has_aspm_l1 = true,
 	.has_aspm_l1ss = false,
+	.l1ss_rp_wake_fixup = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2539,6 +2555,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.updateFC_threshold = true,
 	.has_aspm_l1 = true,
 	.has_aspm_l1ss = true,
+	.l1ss_rp_wake_fixup = true,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2562,6 +2579,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.updateFC_threshold = false,
 	.has_aspm_l1 = true,
 	.has_aspm_l1ss = true,
+	.l1ss_rp_wake_fixup = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.7.4
