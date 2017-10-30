Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18606 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbdJ3OBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 10:01:04 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 12/12] PCI: tegra: Update flow control threshold in Tegra210
Date: Mon, 30 Oct 2017 19:27:23 +0530
Message-ID: <1509371843-22931-13-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Recommended update FC threshold in Tegra210 is 0x60 for best performance
of x1 link. Setting this to 0x60 provides the best balance between number
of UpdateFC and read data sent over the link.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* changed soc parameter name
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index b29329226e3d..812d32cfdd0e 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -223,6 +223,7 @@
 #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
 #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
 #define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
+#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_T210	(0x60 << 18)
 
 #define RP_VEND_CTL0	0xf44
 #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
@@ -323,6 +324,7 @@ struct tegra_pcie_soc {
 	bool update_clamp_threshold;
 	bool raw_violation_fixup;
 	bool program_deskew_time;
+	bool update_fc_threshold;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -2231,6 +2233,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
 		writel(value, port->base + RP_VEND_CTL0);
 	}
+
+	if (soc->update_fc_threshold) {
+		value = readl(port->base + RP_VEND_XP);
+		value &= ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
+		value |= RP_VEND_XP_UPDATE_FC_THRESHOLD_T210;
+		writel(value, port->base + RP_VEND_XP);
+	}
 }
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
@@ -2371,6 +2380,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.update_clamp_threshold = false,
 	.raw_violation_fixup = false,
 	.program_deskew_time = false,
+	.update_fc_threshold = false,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2391,6 +2401,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.update_clamp_threshold = false,
 	.raw_violation_fixup = false,
 	.program_deskew_time = false,
+	.update_fc_threshold = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2410,6 +2421,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.update_clamp_threshold = true,
 	.raw_violation_fixup = true,
 	.program_deskew_time = false,
+	.update_fc_threshold = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2437,6 +2449,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.update_clamp_threshold = true,
 	.raw_violation_fixup = false,
 	.program_deskew_time = true,
+	.update_fc_threshold = true,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2457,6 +2470,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.update_clamp_threshold = false,
 	.raw_violation_fixup = false,
 	.program_deskew_time = false,
+	.update_fc_threshold = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.1.4
