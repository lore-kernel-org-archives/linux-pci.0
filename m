Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17938 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932315AbdJ0TbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2017 15:31:12 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vidyas@nvidia.com>, <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 11/12] PCI: tegra: Increase the deskew retry time
Date: Sat, 28 Oct 2017 00:59:28 +0530
Message-ID: <1509132569-9398-12-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509132569-9398-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509132569-9398-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some times Gen2 to Gen1 link speed switching fails due to instability in
deskew logic on lane0 in Tegra210. Increase the deskew retry time to
resolve this issue.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 9680bf7d0a95..db1ce74ba64a 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -222,6 +222,10 @@
 #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
 #define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
 
+#define RP_VEND_CTL0	0xf44
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
+
 #define RP_VEND_CTL1	0xf48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
 
@@ -316,6 +320,7 @@ struct tegra_pcie_soc {
 	bool program_ectl_settings;
 	bool update_clamp_threshold;
 	bool RAW_violation_fixup;
+	bool program_deskew_time;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -2214,6 +2219,16 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
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
@@ -2352,6 +2367,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
 	.RAW_violation_fixup = false,
+	.program_deskew_time = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2371,6 +2387,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
 	.RAW_violation_fixup = false,
+	.program_deskew_time = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2389,6 +2406,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_ectl_settings = false,
 	.update_clamp_threshold = true,
 	.RAW_violation_fixup = true,
+	.program_deskew_time = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2415,6 +2433,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_ectl_settings = true,
 	.update_clamp_threshold = true,
 	.RAW_violation_fixup = false,
+	.program_deskew_time = true,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2434,6 +2453,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_ectl_settings = false,
 	.update_clamp_threshold = false,
 	.RAW_violation_fixup = false,
+	.program_deskew_time = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.1.4
