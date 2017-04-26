Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [RFC/RFT PATCH 08/18] PCI: designware: Convert PCI scan API to
 pci_scan_root_bus_bridge()
Date: Wed, 26 Apr 2017 12:17:59 +0100
Message-Id: <20170426111809.19922-9-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge().

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
index 5ba3349..e43c21a 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -279,9 +279,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
 	int i, ret;
-	LIST_HEAD(res);
 	struct resource_entry *win, *tmp;
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
@@ -294,16 +294,21 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "missing *config* reg space\n");
 	}
 
-	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return  -ENOMEM;
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
@@ -397,19 +402,22 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
 
@@ -428,7 +436,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 
 error:
-	pci_free_resource_list(&res);
+	pci_free_host_bridge(bridge);
 	return ret;
 }
 
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
