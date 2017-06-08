Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbdFHONa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:13:30 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
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
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT PATCH v2 12/42] PCI: designware: Convert PCI scan API to pci_scan_root_bus_bridge()
Date: Thu,  8 Jun 2017 15:13:12 +0100
Message-Id: <20170608141342.2018-13-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI designware host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 36 +++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 28ed32b..351a277 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -280,9 +280,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
 	int i, ret;
-	LIST_HEAD(res);
 	struct resource_entry *win, *tmp;
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
@@ -295,16 +295,21 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "missing *config* reg space\n");
 	}
 
-	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return -ENOMEM;
+
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff,
+					&bridge->windows, &pp->io_base);
 	if (ret)
 		return ret;
 
-	ret = devm_request_pci_bus_resources(dev, &res);
+	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
 		goto error;
 
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry_safe(win, tmp, &res) {
+	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
 		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
 			ret = pci_remap_iospace(win->res, pp->io_base);
@@ -400,19 +405,22 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->ops->host_init(pp);
 
 	pp->root_bus_nr = pp->busn->start;
+
+	bridge->dev.parent = dev;
+	bridge->sysdata = pp;
+	bridge->busnr = pp->root_bus_nr;
+	bridge->ops = &dw_pcie_ops;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		bus = pci_scan_root_bus_msi(dev, pp->root_bus_nr,
-					    &dw_pcie_ops, pp, &res,
-					    &dw_pcie_msi_chip);
+		bridge->msi = &dw_pcie_msi_chip;
 		dw_pcie_msi_chip.dev = dev;
-	} else
-		bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
-					pp, &res);
-	if (!bus) {
-		ret = -ENOMEM;
-		goto error;
 	}
 
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret)
+		goto error;
+
+	bus = bridge->bus;
+
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
@@ -431,7 +439,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 
 error:
-	pci_free_resource_list(&res);
+	pci_free_host_bridge(bridge);
 	return ret;
 }
 
-- 
2.10.0
