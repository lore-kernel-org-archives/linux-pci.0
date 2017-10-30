Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14060 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdJ3EXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 00:23:13 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 08/12] PCI: tegra: Wait for DLLP to finish before entering L1 or L2
Date: Mon, 30 Oct 2017 09:48:59 +0530
Message-ID: <1509337143-25963-9-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1509337143-25963-1-git-send-email-mmaddireddy@nvidia.com>
References: <1509337143-25963-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Set required bit to have LTSSM wait for DLLP to finish before entering L1
or L2. This avoids truncation of PM messages which results in receiver
errors.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 75b408b32b8b..7f1e34e670d7 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -217,6 +217,9 @@
 #define RP_VEND_CTL1	0xf48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
 
+#define RP_VEND_XP_BIST	0xf4c
+#define  RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE	(1 << 28)
+
 #define RP_VEND_CTL2 0x00000fa8
 #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
 
@@ -2160,6 +2163,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 	value |= RP_VEND_XP_OPPORTUNISTIC_ACK;
 	value |= RP_VEND_XP_OPPORTUNISTIC_UPDATEFC;
 	writel(value, port->base + RP_VEND_XP);
+
+	/* LTSSM will wait for DLLP to finish before entering L1 or L2,
+	 * to avoid truncation of PM messages which results in receiver errors
+	 */
+	value = readl(port->base + RP_VEND_XP_BIST);
+	value |= RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
+	writel(value, port->base + RP_VEND_XP_BIST);
 }
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
-- 
2.1.4
