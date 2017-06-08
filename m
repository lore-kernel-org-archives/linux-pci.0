Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdFHOOA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:14:00 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
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
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT PATCH v2 18/42] PCI: xilinx: Convert PCI scan API to pci_scan_root_bus_bridge()
Date: Thu,  8 Jun 2017 15:13:18 +0100
Message-Id: <20170608141342.2018-19-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI xilinx host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
CC: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 2fe2df5..761f048 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -633,6 +633,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct xilinx_pcie_port *port;
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	int err;
 	resource_size_t iobase = 0;
 	LIST_HEAD(res);
@@ -640,9 +641,11 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	if (!dev->of_node)
 		return -ENODEV;
 
-	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-	if (!port)
-		return -ENOMEM;
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
+	if (!bridge)
+		return -ENODEV;
+
+	port = pci_host_bridge_priv(bridge);
 
 	port->dev = dev;
 
@@ -671,17 +674,23 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto error;
 
-	bus = pci_create_root_bus(dev, 0, &xilinx_pcie_ops, port, &res);
-	if (!bus) {
-		err = -ENOMEM;
-		goto error;
-	}
+
+	list_splice_init(&res, &bridge->windows);
+	bridge->dev.parent = dev;
+	bridge->sysdata = port;
+	bridge->busnr = 0;
+	bridge->ops = &xilinx_pcie_ops;
 
 #ifdef CONFIG_PCI_MSI
 	xilinx_pcie_msi_chip.dev = dev;
-	bus->msi = &xilinx_pcie_msi_chip;
+	bridge->msi = &xilinx_pcie_msi_chip;
 #endif
-	pci_scan_child_bus(bus);
+	err = pci_scan_root_bus_bridge(bridge);
+	if (err < 0)
+		goto error;
+
+	bus = bridge->bus;
+
 	pci_assign_unassigned_bus_resources(bus);
 #ifndef CONFIG_MICROBLAZE
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-- 
2.10.0
