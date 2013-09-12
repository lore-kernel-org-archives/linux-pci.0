Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62870 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab3ILJcq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2013 05:32:46 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT000ABUAIKWP00@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Sep 2013 18:32:45 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>,
	linux-pci@vger.kernel.org, 'Stephen Warren' <swarren@nvidia.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 1/3] PCI: tegra: add missing __iomem annotation
Date: Thu, 12 Sep 2013 18:32:45 +0900
Message-id: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Added missing __iomem annotation in order to fix the following
sparse warnings:

drivers/pci/host/pci-tegra.c:411:41: warning: incorrect type in return expression (different address spaces)
drivers/pci/host/pci-tegra.c:411:41:    expected void [noderef] <asn:2>*
drivers/pci/host/pci-tegra.c:411:41:    got void *addr
drivers/pci/host/pci-tegra.c:419:25: warning: incorrect type in return expression (different address spaces)
drivers/pci/host/pci-tegra.c:419:25:    expected void [noderef] <asn:2>*
drivers/pci/host/pci-tegra.c:419:25:    got void *addr

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-tegra.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 2e9888a..7c4f38d 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -408,7 +408,7 @@ static void __iomem *tegra_pcie_bus_map(struct tegra_pcie *pcie,
 
 	list_for_each_entry(bus, &pcie->busses, list)
 		if (bus->nr == busnr)
-			return bus->area->addr;
+			return (void __iomem *)bus->area->addr;
 
 	bus = tegra_pcie_bus_alloc(pcie, busnr);
 	if (IS_ERR(bus))
@@ -416,7 +416,7 @@ static void __iomem *tegra_pcie_bus_map(struct tegra_pcie *pcie,
 
 	list_add_tail(&bus->list, &pcie->busses);
 
-	return bus->area->addr;
+	return (void __iomem *)bus->area->addr;
 }
 
 static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
-- 
1.7.10.4


