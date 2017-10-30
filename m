Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8362 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdJ3N7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 09:59:53 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 11/12] PCI: tegra: Increase the deskew retry time
Date: Mon, 30 Oct 2017 19:27:22 +0530
Message-ID: <1509371843-22931-12-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some times Gen2 to Gen1 link speed switching fails due to instability in
deskew logic on lane0 in Tegra210. Increase the deskew retry time to
resolve this issue.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* no change in this patch
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 3993e9221c96..b29329226e3d 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -224,6 +224,10 @@
 #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
 #define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
 
+#define RP_VEND_CTL0	0xf44
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
+
 #define RP_VEND_CTL1	0xf48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
 
@@ -318,6 +322,7 @@ struct tegra_pcie_soc {
 	bool program_ectl_settings;
 	bool update_clamp_threshold;
 	bool raw_violation_fixup;
+	bool program_deskew_time;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -2216,6 +2221,16 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
 		writel(value, port->base + RP_VEND_XP);
 	}
+
+	/* Tune deskew retry time to take care of Gen2 -> Gen1
+	 * link speed change error in corner cases
+	 */
+	if (soc->program_deskew_time) {
+		value = readl(port->base + RP_VEND_CTL0);
+		value &= ~RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK;
+		value |= RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
+		writel(value, port->base + RP_VEND_CTL0);
+	}
 }
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
@@ -2355,6 +2370,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
 	.raw_violation_fixup = false,
+	.program_deskew_time = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2374,6 +2390,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
 	.raw_violation_fixup = false,
+	.program_deskew_time = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2392,6 +2409,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_ectl_settings = false,
 	.update_clamp_threshold = true,
 	.raw_violation_fixup = true,
+	.program_deskew_time = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2418,6 +2436,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_ectl_settings = true,
 	.update_clamp_threshold = true,
 	.raw_violation_fixup = false,
+	.program_deskew_time = true,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2437,6 +2456,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
 	.raw_violation_fixup = false,
+	.program_deskew_time = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.1.4
