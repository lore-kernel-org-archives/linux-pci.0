Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17801 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdJ3N6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 09:58:54 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 04/12] PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
Date: Mon, 30 Oct 2017 19:27:15 +0530
Message-ID: <1509371843-22931-5-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Default root port settings hide AER capability. This patch enables the
advertisement of AER capability by root port.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* updated commit log
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index ed5e8acfdc32..46896aaab81d 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -187,6 +187,9 @@
 #define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
+#define RP_VEND_CTL1	0xf48
+#define  RP_VEND_CTL1_ERPT	(1 << 13)
+
 #define RP_VEND_CTL2 0x00000fa8
 #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
 
@@ -2055,6 +2058,16 @@ static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
 		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
 }
 
+static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
+{
+	unsigned long value;
+
+	/* Enable AER capability */
+	value = readl(port->base + RP_VEND_CTL1);
+	value |= RP_VEND_CTL1_ERPT;
+	writel(value, port->base + RP_VEND_CTL1);
+}
+
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
  * can result in the increase of the bootup time as there are big timeout
@@ -2120,6 +2133,7 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 			 port->index, port->lanes);
 
 		tegra_pcie_port_enable(port);
+		tegra_pcie_enable_rp_features(port);
 	}
 
 	/* take the PCIe interface module out of reset */
-- 
2.1.4
