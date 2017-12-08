Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17392 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbdLHI6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 03:58:52 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <cyndis@kapsi.fi>, <thierry.reding@gmail.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe
Date: Fri, 8 Dec 2017 14:28:09 +0530
Message-ID: <1512723493-865-4-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Primary, secondary and subordinate default bus numbers are 0 in Tegra and
it is expecting SW to program these numbers in configration space.

pci_scan_bridge_extend() function programs these numbers in configuration
space if secondary & subordinate bus numbers are 0 or PCI_REASSIGN_ALL_BUS
flag is set. Since secondary & subordinate default bus numbers are 0,
PCI_REASSIGN_ALL_BUS flag can be removed for Tegra PCIe.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* new patch in V3
V4:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index a549c5899e26..0d91f1a3a6b4 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2604,7 +2604,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	tegra_pcie_enable_ports(pcie);
 
-	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 	host->busnr = pcie->busn.start;
 	host->dev.parent = &pdev->dev;
 	host->ops = &tegra_pcie_ops;
-- 
2.1.4
