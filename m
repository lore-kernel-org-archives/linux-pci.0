Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59342 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab3IQFZ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2013 01:25:58 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT900FU18EDUF10@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 17 Sep 2013 14:25:49 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>,
	linux-pci@vger.kernel.org, 'Stephen Warren' <swarren@nvidia.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH V2 1/3] PCI: tegra: add missing __iomem annotation
Date: Tue, 17 Sep 2013 14:25:49 +0900
Message-id: <001a01ceb366$5e9481b0$1bbd8510$%han@samsung.com>
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


