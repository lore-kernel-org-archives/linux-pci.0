Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16298 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3KRWzP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2013 17:55:15 -0500
From: Eric Brower <ebrower@nvidia.com>
To: <thierry.reding@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<swarren@wwwdotorg.org>, <linux-tegra@vger.kernel.org>,
	Eric Brower <ebrower@nvidia.com>
Subject: [PATCH] PCI: Disable Gen2 for Tegra20 and Tegra30
Date: Mon, 18 Nov 2013 14:55:06 -0800
Message-ID: <1384815306-3149-1-git-send-email-ebrower@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra20 and Tegra30 do not support gen2 PCIe, so correct the
register setting to disable it.

Signed-off-by: Eric Brower <ebrower@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 0afbbbc..b8ba2f7 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -805,7 +805,7 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 	afi_writel(pcie, value, AFI_PCIE_CONFIG);
 
 	value = afi_readl(pcie, AFI_FUSE);
-	value &= ~AFI_FUSE_PCIE_T0_GEN2_DIS;
+	value |= AFI_FUSE_PCIE_T0_GEN2_DIS;
 	afi_writel(pcie, value, AFI_FUSE);
 
 	/* initialize internal PHY, enable up to 16 PCIE lanes */
-- 
1.8.1.5

