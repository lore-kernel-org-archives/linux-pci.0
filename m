Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16773 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeAIJUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jan 2018 04:20:35 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <cyndis@kapsi.fi>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe
Date: Tue, 9 Jan 2018 14:49:33 +0530
Message-ID: <1515489577-2197-4-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
References: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
V3:
* new patch in V3
V4:
* no change in this patch
V5:
* no change in this patch

 drivers/pci/host/pci-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index d790a26ad87e..e4b47ebc91fe 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2293,7 +2293,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	tegra_pcie_enable_ports(pcie);
 
-	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 	host->busnr = pcie->busn.start;
 	host->dev.parent = &pdev->dev;
 	host->ops = &tegra_pcie_ops;
-- 
2.1.4
