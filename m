Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbdFHONk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:13:40 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
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
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT PATCH v2 14/42] PCI: rcar: Convert PCI scan API to pci_scan_root_bus_bridge()
Date: Thu,  8 Jun 2017 15:13:14 +0100
Message-Id: <20170608141342.2018-15-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI rcar host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>
---
 drivers/pci/host/pcie-rcar.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index cb07c45..8380274 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -450,28 +450,32 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 static int rcar_pcie_enable(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct pci_bus *bus, *child;
-	LIST_HEAD(res);
+	int ret;
 
 	/* Try setting 5 GT/s link speed */
 	rcar_pcie_force_speedup(pcie);
 
-	rcar_pcie_setup(&res, pcie);
+	rcar_pcie_setup(&bridge->windows, pcie);
 
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
+	bridge->dev.parent = dev;
+	bridge->sysdata = pcie;
+	bridge->busnr = pcie->root_bus_nr;
+	bridge->ops = &rcar_pcie_ops;
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bus = pci_scan_root_bus_msi(dev, pcie->root_bus_nr,
-				&rcar_pcie_ops, pcie, &res, &pcie->msi.chip);
-	else
-		bus = pci_scan_root_bus(dev, pcie->root_bus_nr,
-				&rcar_pcie_ops, pcie, &res);
+		bridge->msi = &pcie->msi.chip;
 
-	if (!bus) {
-		dev_err(dev, "Scanning rootbus failed");
-		return -ENODEV;
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0) {
+		kfree(bridge);
+		return ret;
 	}
 
+	bus = bridge->bus;
+
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 
 	pci_bus_size_bridges(bus);
@@ -1127,11 +1131,14 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	unsigned int data;
 	int err;
 	int (*hw_init_fn)(struct rcar_pcie *);
+	struct pci_host_bridge *bridge;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	bridge = pci_alloc_host_bridge(sizeof(*pcie));
+	if (!bridge)
 		return -ENOMEM;
 
+	pcie = pci_host_bridge_priv(bridge);
+
 	pcie->dev = dev;
 
 	INIT_LIST_HEAD(&pcie->resources);
@@ -1141,12 +1148,12 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	err = rcar_pcie_get_resources(pcie);
 	if (err < 0) {
 		dev_err(dev, "failed to request resources: %d\n", err);
-		return err;
+		goto err_free_bridge;
 	}
 
 	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
 	if (err)
-		return err;
+		goto err_free_bridge;
 
 	pm_runtime_enable(dev);
 	err = pm_runtime_get_sync(dev);
@@ -1183,6 +1190,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_bridge:
+	pci_free_host_bridge(bridge);
+
 err_pm_put:
 	pm_runtime_put(dev);
 
-- 
2.10.0
