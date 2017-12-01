Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14922 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdLAJVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Dec 2017 04:21:03 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <cyndis@kapsi.fi>, <thierry.reding@gmail.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 6/7] PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
Date: Fri, 1 Dec 2017 14:50:06 +0530
Message-ID: <1512120007-28088-7-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
References: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per PCIe r3.0, sec 5.3.3.2.1, PCIe root port shoould broadcast PME_Turn_Off
message before PCIe link goes to L2. PME_Turn_Off broadcast mechanism is
implemented in AFI module. Each Tegra PCIe root port has its own
PME_Turn_Off and PME_TO_Ack bitmap in AFI_PME register, program this
register to broadcast PME_Turn_Off message.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* no change in this patch
V3:
* add PME bitmap in soc data instead of using compatible string
* replace while loop with readl_poll_timeout() for polling
* commit log correction

 drivers/pci/host/pci-tegra.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 2c13f43e8450..bc532c0fd04f 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -155,6 +156,8 @@
 #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
 #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
 
+#define AFI_PCIE_PME		0xf0
+
 #define AFI_PCIE_CONFIG					0x0f8
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
@@ -315,6 +318,7 @@
 #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
 
 #define LINK_RETRAIN_TIMEOUT 100000
+#define PME_ACK_TIMEOUT 10000
 
 struct tegra_msi {
 	struct msi_controller chip;
@@ -342,6 +346,8 @@ struct tegra_pcie_soc {
 	u32 rp_ectl_4_r2;
 	u32 rp_ectl_5_r2;
 	u32 rp_ectl_6_r2;
+	u8 pme_turnoff_bit[3];
+	u8 pme_ack_bit[3];
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
@@ -1501,6 +1507,31 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 	return 0;
 }
 
+static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
+{
+	struct tegra_pcie *pcie = port->pcie;
+	const struct tegra_pcie_soc *soc = pcie->soc;
+	int err;
+	u32 val;
+
+	val = afi_readl(pcie, AFI_PCIE_PME);
+	val |= (0x1 << soc->pme_turnoff_bit[port->index]);
+	afi_writel(pcie, val, AFI_PCIE_PME);
+
+	err = readl_poll_timeout(pcie->afi + AFI_PCIE_PME, val,
+				 val & (0x1 << soc->pme_ack_bit[port->index]),
+				 1, PME_ACK_TIMEOUT);
+	if (err)
+		dev_err(pcie->dev, "PME Ack is not received on port: %d\n",
+			port->index);
+
+	usleep_range(10000, 11000);
+
+	val = afi_readl(pcie, AFI_PCIE_PME);
+	val &= ~(0x1 << soc->pme_turnoff_bit[port->index]);
+	afi_writel(pcie, val, AFI_PCIE_PME);
+}
+
 static int tegra_msi_alloc(struct tegra_msi *chip)
 {
 	int msi;
@@ -2477,6 +2508,8 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
 	.pads_refclk_cfg0 = 0xfa5cfa5c,
+	.pme_turnoff_bit = {0, 8},
+	.pme_ack_bit = {5, 10},
 	.has_pex_clkreq_en = false,
 	.has_pex_bias_ctrl = false,
 	.has_intr_prsnt_sense = false,
@@ -2502,6 +2535,8 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0xfa5cfa5c,
 	.pads_refclk_cfg1 = 0xfa5cfa5c,
+	.pme_turnoff_bit = {0, 8, 16},
+	.pme_ack_bit = {5, 10, 18},
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2526,6 +2561,8 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x44ac44ac,
+	.pme_turnoff_bit = {0, 8},
+	.pme_ack_bit = {5, 10},
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2550,6 +2587,8 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x90b890b8,
+	.pme_turnoff_bit = {0, 8},
+	.pme_ack_bit = {5, 10},
 	.rp_ectl_2_r1 = 0x0000000f,
 	.rp_ectl_4_r1 = 0x00000067,
 	.rp_ectl_5_r1 = 0x55010000,
@@ -2583,6 +2622,8 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x80b880b8,
 	.pads_refclk_cfg1 = 0x000480b8,
+	.pme_turnoff_bit = {0, 8, 12},
+	.pme_ack_bit = {5, 10, 14},
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2824,6 +2865,7 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct tegra_pcie_port *port, *tmp;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_pcie_debugfs_exit(pcie);
@@ -2831,6 +2873,8 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		tegra_pcie_pme_turnoff(port);
 	tegra_pcie_disable_ports(pcie);
 	tegra_pcie_free_resources(pcie);
 	tegra_pcie_disable_controller(pcie);
-- 
2.1.4
