Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1311 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdKLNSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Nov 2017 08:18:16 -0500
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <swarren@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>
Subject: [PATCH V3 3/3] PCI: tegra: Enable ASPM-L1 capability advertisement
Date: Sun, 12 Nov 2017 18:47:54 +0530
Message-ID: <1510492674-12786-4-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
References: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enables advertisement of ASPM-L1 support in capability
registers of applicable Tegra chips

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* no change in this patch

V3:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 29ee4bb0b7c6..fb61202ee60f 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -250,6 +250,9 @@
 #define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
 #define  RP_VEND_XP_UPDATE_FC_THRESHOLD_T210	(0x60 << 18)
 
+#define RP_VEND_XP1	0xf04
+#define RP_VEND_XP1_LINK_PVT_CTL_L1_ASPM_SUPPORT	BIT(21)
+
 #define RP_VEND_CTL0	0xf44
 #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
 #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
@@ -351,6 +354,7 @@ struct tegra_pcie_soc {
 	bool RAW_violation_fixup;
 	bool program_deskew_time;
 	bool updateFC_threshold;
+	bool has_aspm_l1;
 	bool has_aspm_l1ss;
 	bool l1ss_rp_wake_fixup;
 };
@@ -2214,6 +2218,13 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	value = readl(port->base + RP_VEND_CTL1);
 	value |= RP_VEND_CTL1_ERPT;
 	writel(value, port->base + RP_VEND_CTL1);
+
+	if (port->pcie->soc->has_aspm_l1) {
+		/* Advertise ASPM-L1 state capability*/
+		value = readl(port->base + RP_VEND_XP1);
+		value |= RP_VEND_XP1_LINK_PVT_CTL_L1_ASPM_SUPPORT;
+		writel(value, port->base + RP_VEND_XP1);
+	}
 }
 
 static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
@@ -2458,6 +2469,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.RAW_violation_fixup = false,
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
+	.has_aspm_l1 = false,
 	.has_aspm_l1ss = false,
 	.l1ss_rp_wake_fixup = false,
 };
@@ -2481,6 +2493,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.RAW_violation_fixup = false,
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
+	.has_aspm_l1 = true,
 	.has_aspm_l1ss = false,
 	.l1ss_rp_wake_fixup = false,
 };
@@ -2503,6 +2516,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.RAW_violation_fixup = true,
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
+	.has_aspm_l1 = true,
 	.has_aspm_l1ss = false,
 	.l1ss_rp_wake_fixup = false,
 };
@@ -2533,6 +2547,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.RAW_violation_fixup = false,
 	.program_deskew_time = true,
 	.updateFC_threshold = true,
+	.has_aspm_l1 = true,
 	.has_aspm_l1ss = true,
 	.l1ss_rp_wake_fixup = true,
 };
@@ -2556,6 +2571,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.RAW_violation_fixup = false,
 	.program_deskew_time = false,
 	.updateFC_threshold = false,
+	.has_aspm_l1 = true,
 	.has_aspm_l1ss = true,
 	.l1ss_rp_wake_fixup = false,
 };
-- 
2.7.4
