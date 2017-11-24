Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3887 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753880AbdKXPz0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 10:55:26 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 09/10] PCI: tegra: Broadcast PME_turn_Off message before link goes to L2
Date: Fri, 24 Nov 2017 21:23:19 +0530
Message-ID: <1511538800-8275-10-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per PCIe r3.0, sec 5.3.3.2.1, PCIe root port shoould broadcast PME_turn_Off
message before PCIe link goes to L2. PME_turn_Off broadcast mechanism is
implemented in AFI module. Each Tegra PCIe root port has its own
PME_turn_Off and PME_TO_Ack bitmap in AFI_PME register, program this
register to broadcast PME_turn_Off message.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 2ff1ac3aefc1..af999c650941 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -155,6 +155,8 @@
 #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
 #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
 
+#define AFI_PCIE_PME		0xf0
+
 #define AFI_PCIE_CONFIG					0x0f8
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
 #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
@@ -315,6 +317,7 @@
 #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
 
 #define LINK_RETRAIN_TIMEOUT 100000
+#define PME_ACK_TIMEOUT 10000
 
 struct tegra_msi {
 	struct msi_controller chip;
@@ -1483,6 +1486,76 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
 	return 0;
 }
 
+static inline u32 get_pme_turnoff_bitmap(struct tegra_pcie_port *port)
+{
+	struct device *dev = port->pcie->dev;
+	struct device_node *np = dev->of_node;
+	int ret = 0;
+
+	switch (port->index) {
+	case 0:
+		ret = 0;
+	case 1:
+		ret = 8;
+	case 2:
+		if (of_device_is_compatible(np, "nvidia,tegra30-pcie"))
+			ret = 16;
+		else
+			ret = 12;
+	}
+	return ret;
+}
+
+static inline u32 get_pme_ack_bitmap(struct tegra_pcie_port *port)
+{
+	struct device *dev = port->pcie->dev;
+	struct device_node *np = dev->of_node;
+	int ret = 0;
+
+	switch (port->index) {
+	case 0:
+		ret = 5;
+	case 1:
+		ret = 10;
+	case 2:
+		if (of_device_is_compatible(np, "nvidia,tegra30-pcie"))
+			ret = 18;
+		else
+			ret = 14;
+	}
+	return ret;
+}
+
+static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
+{
+	struct tegra_pcie *pcie = port->pcie;
+	ktime_t deadline;
+	unsigned int data;
+
+	data = afi_readl(pcie, AFI_PCIE_PME);
+	data |= (0x1 << get_pme_turnoff_bitmap(port));
+	afi_writel(pcie, data, AFI_PCIE_PME);
+
+	deadline = ktime_add_us(ktime_get(), PME_ACK_TIMEOUT);
+	do {
+		data = afi_readl(pcie, AFI_PCIE_PME);
+		data &= (0x1 << get_pme_ack_bitmap(port));
+		udelay(1);
+		if (ktime_after(ktime_get(), deadline))
+			break;
+	} while (!data);
+
+	if (data)
+		dev_err(pcie->dev, "PME Ack is not receieved on port: %d\n",
+			port->index);
+
+	usleep_range(10000, 11000);
+
+	data = afi_readl(pcie, AFI_PCIE_PME);
+	data &= ~(0x1 << get_pme_turnoff_bitmap(port));
+	afi_writel(pcie, data, AFI_PCIE_PME);
+}
+
 static int tegra_msi_alloc(struct tegra_msi *chip)
 {
 	int msi;
@@ -2808,6 +2881,7 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct tegra_pcie_port *port, *tmp;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_pcie_debugfs_exit(pcie);
@@ -2815,6 +2889,8 @@ static int tegra_pcie_remove(struct platform_device *pdev)
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
