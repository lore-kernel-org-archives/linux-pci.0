Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8492 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbdJ3OAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 10:00:33 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 02/12] PCI: tegra: Move REFCLK pad settings out of phy_power_on()
Date: Mon, 30 Oct 2017 19:27:13 +0530
Message-ID: <1509371843-22931-3-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In Tegra186 PHY programming is done by BPMP-FW, so PHY calls are skipped
in driver. REFCLK pad settings are independent of PHY and should be
programmed by driver. So move REFCLK pad settings out of phy_power_on().
These pad settings improve REFCLK peak to peak amplitude.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* Corrected commit log
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index b41c60c7414c..068510b40c1a 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -910,7 +910,6 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
 static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct tegra_pcie_port *port;
 	int err;
 
@@ -936,12 +935,6 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 		}
 	}
 
-	/* Configure the reference clock driver */
-	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
-
-	if (soc->num_ports > 2)
-		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
-
 	return 0;
 }
 
@@ -2049,6 +2042,17 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 	return 0;
 }
 
+static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
+{
+	const struct tegra_pcie_soc *soc = pcie->soc;
+
+	/* Configure the reference clock driver */
+	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
+
+	if (soc->num_ports > 2)
+		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
+}
+
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
  * can result in the increase of the bootup time as there are big timeout
@@ -2107,6 +2111,8 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct tegra_pcie_port *port, *tmp;
 
+	tegra_pcie_apply_pad_settings(pcie);
+
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
 		dev_info(dev, "probing port %u, using %u lanes\n",
 			 port->index, port->lanes);
-- 
2.1.4
