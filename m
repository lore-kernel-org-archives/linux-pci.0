Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8587 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752501AbeA3FZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 00:25:06 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <cyndis@kapsi.fi>
CC: <jonathanh@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V7  3/4] PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
Date: Tue, 30 Jan 2018 10:54:10 +0530
Message-ID: <1517289851-14111-4-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
References: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
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
V4:
* no change in this patch
V5:
* Rebased on linux-next
V6:
* no change in this patch
V7:
* Per port soc data is added for pme bits
* list_for_each_entry_safe is changed to list_for_each_entry for pme turnoff

 drivers/pci/host/pci-tegra.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 981f126b14d6..feb5b961f737 100644
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
@@ -153,6 +154,8 @@
 #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
 #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
 
+#define AFI_PCIE_PME		0xf0
+
 #define AFI_PCIE_CONFIG					0x0f8
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
@@ -233,6 +236,8 @@
 #define PADS_REFCLK_CFG_PREDI_SHIFT		8  /* 11:8 */
 #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
 
+#define PME_ACK_TIMEOUT 10000
+
 struct tegra_msi {
 	struct msi_controller chip;
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
@@ -244,8 +249,16 @@ struct tegra_msi {
 };
 
 /* used to differentiate between Tegra SoC generations */
+struct tegra_pcie_port_soc {
+	struct {
+		u8 turnoff_bit;
+		u8 ack_bit;
+	} pme;
+};
+
 struct tegra_pcie_soc {
 	unsigned int num_ports;
+	const struct tegra_pcie_port_soc *ports;
 	unsigned int msi_base_shift;
 	u32 pads_pll_ctl;
 	u32 tx_ref_sel;
@@ -1358,6 +1371,32 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 	return 0;
 }
 
+static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
+{
+	struct tegra_pcie *pcie = port->pcie;
+	const struct tegra_pcie_soc *soc = pcie->soc;
+	int err;
+	u32 val;
+	u8 ack_bit;
+
+	val = afi_readl(pcie, AFI_PCIE_PME);
+	val |= (0x1 << soc->ports[port->index].pme.turnoff_bit);
+	afi_writel(pcie, val, AFI_PCIE_PME);
+
+	ack_bit = soc->ports[port->index].pme.ack_bit;
+	err = readl_poll_timeout(pcie->afi + AFI_PCIE_PME, val,
+				 val & (0x1 << ack_bit), 1, PME_ACK_TIMEOUT);
+	if (err)
+		dev_err(pcie->dev, "PME Ack is not received on port: %d\n",
+			port->index);
+
+	usleep_range(10000, 11000);
+
+	val = afi_readl(pcie, AFI_PCIE_PME);
+	val &= ~(0x1 << soc->ports[port->index].pme.turnoff_bit);
+	afi_writel(pcie, val, AFI_PCIE_PME);
+}
+
 static int tegra_msi_alloc(struct tegra_msi *chip)
 {
 	int msi;
@@ -2103,8 +2142,14 @@ static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
 	}
 }
 
+static const struct tegra_pcie_port_soc tegra20_pcie_ports[] = {
+	{ .pme.turnoff_bit = 0, .pme.ack_bit =  5 },
+	{ .pme.turnoff_bit = 8, .pme.ack_bit = 10 },
+};
+
 static const struct tegra_pcie_soc tegra20_pcie = {
 	.num_ports = 2,
+	.ports = tegra20_pcie_ports,
 	.msi_base_shift = 0,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
@@ -2118,8 +2163,15 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_uphy = true,
 };
 
+static const struct tegra_pcie_port_soc tegra30_pcie_ports[] = {
+	{ .pme.turnoff_bit =  0, .pme.ack_bit =  5 },
+	{ .pme.turnoff_bit =  8, .pme.ack_bit = 10 },
+	{ .pme.turnoff_bit = 16, .pme.ack_bit = 18 },
+};
+
 static const struct tegra_pcie_soc tegra30_pcie = {
 	.num_ports = 3,
+	.ports = tegra30_pcie_ports,
 	.msi_base_shift = 8,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
@@ -2136,6 +2188,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 
 static const struct tegra_pcie_soc tegra124_pcie = {
 	.num_ports = 2,
+	.ports = tegra20_pcie_ports,
 	.msi_base_shift = 8,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
@@ -2151,6 +2204,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 
 static const struct tegra_pcie_soc tegra210_pcie = {
 	.num_ports = 2,
+	.ports = tegra20_pcie_ports,
 	.msi_base_shift = 8,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
@@ -2164,8 +2218,15 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_uphy = true,
 };
 
+static const struct tegra_pcie_port_soc tegra186_pcie_ports[] = {
+	{ .pme.turnoff_bit =  0, .pme.ack_bit =  5 },
+	{ .pme.turnoff_bit =  8, .pme.ack_bit = 10 },
+	{ .pme.turnoff_bit = 12, .pme.ack_bit = 14 },
+};
+
 static const struct tegra_pcie_soc tegra186_pcie = {
 	.num_ports = 3,
+	.ports = tegra186_pcie_ports,
 	.msi_base_shift = 8,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
@@ -2399,11 +2460,14 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct tegra_pcie_port *port;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_pcie_debugfs_exit(pcie);
 	pci_stop_root_bus(host->bus);
 	pci_remove_root_bus(host->bus);
+	list_for_each_entry(port, &pcie->ports, list)
+		tegra_pcie_pme_turnoff(port);
 	tegra_pcie_disable_ports(pcie);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
-- 
2.1.4
