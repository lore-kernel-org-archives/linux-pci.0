Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbdFHOOO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:14:14 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT PATCH v2 21/42] PCI: rockchip: Convert PCI scan API to pci_scan_root_bus_bridge()
Date: Thu,  8 Jun 2017 15:13:21 +0100
Message-Id: <20170608141342.2018-22-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI rockchip host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/host/pcie-rockchip.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 0e020b6..cae5a6d 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1284,6 +1284,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip;
 	struct device *dev = &pdev->dev;
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	struct resource_entry *win;
 	resource_size_t io_base;
 	struct resource	*mem;
@@ -1295,10 +1296,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (!dev->of_node)
 		return -ENODEV;
 
-	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
-	if (!rockchip)
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rockchip));
+	if (!bridge)
 		return -ENOMEM;
 
+	rockchip = pci_host_bridge_priv(bridge);
+
 	platform_set_drvdata(pdev, rockchip);
 	rockchip->dev = dev;
 
@@ -1396,11 +1399,18 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		goto err_free_res;
 	}
 
-	bus = pci_scan_root_bus(&pdev->dev, 0, &rockchip_pcie_ops, rockchip, &res);
-	if (!bus) {
-		err = -ENOMEM;
+	list_splice_init(&res, &bridge->windows);
+	bridge->dev.parent = &pdev->dev;
+	bridge->sysdata = rockchip;
+	bridge->busnr = 0;
+	bridge->ops = &rockchip_pcie_ops;
+
+	err = pci_scan_root_bus_bridge(bridge);
+	if (!err)
 		goto err_free_res;
-	}
+
+	bus = bridge->bus;
+
 	rockchip->root_bus = bus;
 
 	pci_bus_size_bridges(bus);
-- 
2.10.0
