Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18588 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbdJ3OAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 10:00:54 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 06/12] PCI: tegra: Enable opportunistic update FC and ACK
Date: Mon, 30 Oct 2017 19:27:17 +0530
Message-ID: <1509371843-22931-7-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch ensures that DL sends pending ACKs and update FC packets when
link is idle instead of waiting for timers to expire which improves PCIe
bandwidth.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* no change in this patch
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index c862facfd6e9..4562b0c113a8 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -211,7 +211,9 @@
 #define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
 
 #define RP_VEND_XP	0x00000f00
-#define  RP_VEND_XP_DL_UP	(1 << 30)
+#define  RP_VEND_XP_DL_UP			(1 << 30)
+#define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
+#define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
 
 #define RP_VEND_CTL1	0xf48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
@@ -2149,6 +2151,16 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	writel(value, port->base + RP_VEND_CTL1);
 }
 
+static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
+{
+	unsigned long value;
+
+	/* Optimal settings to enhance bandwidth */
+	value = readl(port->base + RP_VEND_XP);
+	value |= RP_VEND_XP_OPPORTUNISTIC_ACK;
+	value |= RP_VEND_XP_OPPORTUNISTIC_UPDATEFC;
+	writel(value, port->base + RP_VEND_XP);
+}
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
  * can result in the increase of the bootup time as there are big timeout
@@ -2218,6 +2230,7 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 		if (soc->program_ectl_settings)
 			tegra_pcie_program_ectl_settings(port);
 		tegra_pcie_enable_rp_features(port);
+		tegra_pcie_apply_sw_fixup(port);
 	}
 
 	/* take the PCIe interface module out of reset */
-- 
2.1.4
