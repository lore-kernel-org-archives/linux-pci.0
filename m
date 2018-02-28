Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12808 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbeB1KBB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 05:01:01 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <cyndis@kapsi.fi>
CC: <jonathanh@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V9 2/3] PCI: tegra: Add loadable kernel module support
Date: Wed, 28 Feb 2018 15:30:33 +0530
Message-ID: <1519812034-11120-3-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1519812034-11120-1-git-send-email-mmaddireddy@nvidia.com>
References: <1519812034-11120-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement remove callback function for Tegra PCIe driver to add
loadable kernel module support.

Per PCIe r3.0, sec 5.3.3.2.1, PCIe root port should broadcast PME_Turn_Off
message before PCIe link goes to L2. PME_Turn_Off broadcast mechanism is
implemented in AFI module. Each Tegra PCIe root port has its own
PME_Turn_Off and PME_TO_Ack bitmap in AFI_PME register, program this
register to broadcast PME_Turn_Off message.

Once PME_TO_Ack is recieved driver will turn OFF PCIe clock, power gate
PCIe partition and turn OFF regulators.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>
---
V2:
* no change in this patch
V3:
* use tegra_pcie_debugfs_exit() helper function in tegra_pcie_debugfs_init()
V4:
* no change in this patch
V5:
* Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
rebased on linux-next
V6:
* no change in this patch
V7:
* no change in this patch
V8:
* Added new lines around conditional blocks
V9:
* Squash PME_Turn_Off patch on top this to have single working LKM patch

 drivers/pci/host/pci-tegra.c | 103 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index e68507f658d8..60b1d5e1cfa4 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -31,10 +31,12 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -152,6 +154,8 @@
 #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
 #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
 
+#define AFI_PCIE_PME		0xf0
+
 #define AFI_PCIE_CONFIG					0x0f8
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
@@ -232,6 +236,8 @@
 #define PADS_REFCLK_CFG_PREDI_SHIFT		8  /* 11:8 */
 #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
 
+#define PME_ACK_TIMEOUT 10000
+
 struct tegra_msi {
 	struct msi_controller chip;
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
@@ -243,8 +249,16 @@ struct tegra_msi {
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
@@ -1357,6 +1371,32 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
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
@@ -2102,8 +2142,14 @@ static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
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
@@ -2117,8 +2163,15 @@ static const struct tegra_pcie_soc tegra20_pcie = {
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
@@ -2135,6 +2188,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 
 static const struct tegra_pcie_soc tegra124_pcie = {
 	.num_ports = 2,
+	.ports = tegra20_pcie_ports,
 	.msi_base_shift = 8,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
@@ -2150,6 +2204,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 
 static const struct tegra_pcie_soc tegra210_pcie = {
 	.num_ports = 2,
+	.ports = tegra20_pcie_ports,
 	.msi_base_shift = 8,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
@@ -2163,8 +2218,15 @@ static const struct tegra_pcie_soc tegra210_pcie = {
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
@@ -2276,6 +2338,12 @@ static const struct file_operations tegra_pcie_ports_ops = {
 	.release = seq_release,
 };
 
+static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
+{
+	debugfs_remove_recursive(pcie->debugfs);
+	pcie->debugfs = NULL;
+}
+
 static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 {
 	struct dentry *file;
@@ -2292,8 +2360,7 @@ static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 	return 0;
 
 remove:
-	debugfs_remove_recursive(pcie->debugfs);
-	pcie->debugfs = NULL;
+	tegra_pcie_debugfs_exit(pcie);
 	return -ENOMEM;
 }
 
@@ -2311,6 +2378,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(host);
 	host->sysdata = pcie;
+	platform_set_drvdata(pdev, pcie);
 
 	pcie->soc = of_device_get_match_data(dev);
 	INIT_LIST_HEAD(&pcie->ports);
@@ -2388,6 +2456,33 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int tegra_pcie_remove(struct platform_device *pdev)
+{
+	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct tegra_pcie_port *port;
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		tegra_pcie_debugfs_exit(pcie);
+
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
+
+	list_for_each_entry(port, &pcie->ports, list)
+		tegra_pcie_pme_turnoff(port);
+
+	tegra_pcie_disable_ports(pcie);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_pcie_disable_msi(pcie);
+
+	tegra_pcie_free_resources(pcie);
+	tegra_pcie_disable_controller(pcie);
+	tegra_pcie_put_resources(pcie);
+
+	return 0;
+}
+
 static struct platform_driver tegra_pcie_driver = {
 	.driver = {
 		.name = "tegra-pcie",
@@ -2395,5 +2490,7 @@ static struct platform_driver tegra_pcie_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = tegra_pcie_probe,
+	.remove = tegra_pcie_remove,
 };
-builtin_platform_driver(tegra_pcie_driver);
+module_platform_driver(tegra_pcie_driver);
+MODULE_LICENSE("GPL");
-- 
2.1.4
