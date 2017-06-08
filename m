Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbdFHOOT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:14:19 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
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
Subject: [RFT PATCH v2 22/42] PCI: xilinx-nwl: Convert PCI scan API to pci_scan_root_bus_bridge()
Date: Thu,  8 Jun 2017 15:13:22 +0100
Message-Id: <20170608141342.2018-23-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI xilinx-nwl host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 26e66e8..e8a5894 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -791,13 +791,16 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	struct nwl_pcie *pcie;
 	struct pci_bus *bus;
 	struct pci_bus *child;
+	struct pci_host_bridge *bridge;
 	int err;
 	resource_size_t iobase = 0;
 	LIST_HEAD(res);
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
-		return -ENOMEM;
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
+		return -ENODEV;
+
+	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
 	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
@@ -830,12 +833,11 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	bus = pci_create_root_bus(dev, pcie->root_busno,
-				  &nwl_pcie_ops, pcie, &res);
-	if (!bus) {
-		err = -ENOMEM;
-		goto error;
-	}
+	list_splice_init(&res, &bridge->windows);
+	bridge->dev.parent = dev;
+	bridge->sysdata = pcie;
+	bridge->busnr = pcie->root_busno;
+	bridge->ops = &nwl_pcie_ops;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie);
@@ -844,7 +846,13 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 			goto error;
 		}
 	}
-	pci_scan_child_bus(bus);
+
+	err = pci_scan_root_bus_bridge(bridge);
+	if (err)
+		goto error;
+
+	bus = bridge->bus;
+
 	pci_assign_unassigned_bus_resources(bus);
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
-- 
2.10.0
