Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9097 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754158AbdKFSDO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2017 13:03:14 -0500
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <swarren@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>
Subject: [PATCH] PCI: tegra: limit MSI target address to 32-bit
Date: Mon, 6 Nov 2017 23:33:07 +0530
Message-ID: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

limits MSI target address to only 32-bit region to enable
some of the PCIe end points where only 32-bit MSIs
are supported work properly.
One example being Marvel SATA controller

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 1987fec1f126..03d3dcdd06c2 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	}
 
 	/* setup AFI/FPCI range */
-	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	msi->pages = __get_free_pages(GFP_DMA, 0);
 	msi->phys = virt_to_phys((void *)msi->pages);
 
 	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
-- 
2.7.4
