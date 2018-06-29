Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: mvebu: Convert to use pci_host_bridge directly
Date: Fri, 29 Jun 2018 11:10:06 +0200
Message-Id: <20180629091007.31069-3-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
References: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nadav Haklai <nadavh@marvell.com>, Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Rather than using the ARM-specific pci_common_init_dev() API, use the
pci_host_bridge logic directly.

Unfortunately, we can't use devm_of_pci_get_host_bridge_resources(),
because the DT binding for describing PCIe apertures for this PCI
controller is a bit special, and we cannot retrieve them from the
'ranges' property. Therefore, we still have some special code to
handle this.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 145 ++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 0e729bab14c0..6e801cef2c5f 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -71,6 +71,7 @@ struct mvebu_pcie {
 	struct platform_device *pdev;
 	struct mvebu_pcie_port *ports;
 	struct msi_controller *msi;
+	struct list_head resources;
 	struct resource io;
 	struct resource realio;
 	struct resource mem;
@@ -632,7 +633,7 @@ static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
 static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			      int where, int size, u32 val)
 {
-	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct mvebu_pcie *pcie = bus->sysdata;
 	struct mvebu_pcie_port *port;
 	int ret;
 
@@ -658,7 +659,7 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			      int size, u32 *val)
 {
-	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct mvebu_pcie *pcie = bus->sysdata;
 	struct mvebu_pcie_port *port;
 	int ret;
 
@@ -689,36 +690,6 @@ static struct pci_ops mvebu_pcie_ops = {
 	.write = mvebu_pcie_wr_conf,
 };
 
-static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
-{
-	struct mvebu_pcie *pcie = sys_to_pcie(sys);
-	int err, i;
-
-	pcie->mem.name = "PCI MEM";
-	pcie->realio.name = "PCI I/O";
-
-	if (resource_size(&pcie->realio) != 0)
-		pci_add_resource_offset(&sys->resources, &pcie->realio,
-					sys->io_offset);
-
-	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
-	pci_add_resource(&sys->resources, &pcie->busn);
-
-	err = devm_request_pci_bus_resources(&pcie->pdev->dev, &sys->resources);
-	if (err)
-		return 0;
-
-	for (i = 0; i < pcie->nports; i++) {
-		struct mvebu_pcie_port *port = &pcie->ports[i];
-
-		if (!port->base)
-			continue;
-		mvebu_pcie_setup_hw(port);
-	}
-
-	return 1;
-}
-
 static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 						 const struct resource *res,
 						 resource_size_t start,
@@ -749,26 +720,6 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 		return start;
 }
 
-static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
-{
-	struct hw_pci hw;
-
-	memset(&hw, 0, sizeof(hw));
-
-#ifdef CONFIG_PCI_MSI
-	hw.msi_ctrl = pcie->msi;
-#endif
-
-	hw.nr_controllers = 1;
-	hw.private_data   = (void **)&pcie;
-	hw.setup          = mvebu_pcie_setup;
-	hw.map_irq        = of_irq_parse_and_map_pci;
-	hw.ops            = &mvebu_pcie_ops;
-	hw.align_resource = mvebu_pcie_align_resource;
-
-	pci_common_init_dev(&pcie->pdev->dev, &hw);
-}
-
 /*
  * Looks up the list of register addresses encoded into the reg =
  * <...> property for one that matches the given port/lane. Once
@@ -1022,28 +973,38 @@ static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
 	clk_disable_unprepare(port->clk);
 }
 
-static int mvebu_pcie_probe(struct platform_device *pdev)
+/*
+ * We can't use devm_of_pci_get_host_bridge_resources() because we
+ * need to parse our special DT properties encoding the MEM and IO
+ * apertures.
+ */
+static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 {
-	struct device *dev = &pdev->dev;
-	struct mvebu_pcie *pcie;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
-	int num, i, ret;
+	int ret;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
-		return -ENOMEM;
+	INIT_LIST_HEAD(&pcie->resources);
 
-	pcie->pdev = pdev;
-	platform_set_drvdata(pdev, pcie);
+	/* Get the bus range */
+	ret = of_pci_parse_bus_range(np, &pcie->busn);
+	if (ret) {
+		dev_err(dev, "failed to parse bus-range property: %d\n", ret);
+		return ret;
+	}
+	pci_add_resource(&pcie->resources, &pcie->busn);
 
-	/* Get the PCIe memory and I/O aperture */
+	/* Get the PCIe memory aperture */
 	mvebu_mbus_get_pcie_mem_aperture(&pcie->mem);
 	if (resource_size(&pcie->mem) == 0) {
 		dev_err(dev, "invalid memory aperture size\n");
 		return -EINVAL;
 	}
 
+	pcie->mem.name = "PCI MEM";
+	pci_add_resource_offset(&pcie->resources, &pcie->mem, 0);
+
+	/* Get the PCIe IO aperture */
 	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
 
 	if (resource_size(&pcie->io) != 0) {
@@ -1055,12 +1016,42 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	} else
 		pcie->realio = pcie->io;
 
-	/* Get the bus range */
-	ret = of_pci_parse_bus_range(np, &pcie->busn);
-	if (ret) {
-		dev_err(dev, "failed to parse bus-range property: %d\n", ret);
+	pcie->realio.name = "PCI I/O";
+
+	if (resource_size(&pcie->realio) != 0)
+		pci_add_resource_offset(&pcie->resources, &pcie->realio, 0);
+
+	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
+	if (ret)
+		return 0;
+
+	ret = pci_remap_iospace(&pcie->realio, pcie->realio.start);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mvebu_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mvebu_pcie *pcie;
+	struct pci_host_bridge *bridge;
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int num, i, ret;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie = pci_host_bridge_priv(bridge);
+	pcie->pdev = pdev;
+	platform_set_drvdata(pdev, pcie);
+
+	ret = mvebu_pcie_parse_request_resources(pcie);
+	if (ret)
 		return ret;
-	}
 
 	num = of_get_available_child_count(np);
 
@@ -1104,18 +1095,24 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		mvebu_pcie_setup_hw(port);
 		mvebu_pcie_set_local_dev_nr(port, 1);
 		mvebu_pci_sw_bridge_init(port);
 	}
 
 	pcie->nports = i;
 
-	for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
-		pci_ioremap_io(i, pcie->io.start + i);
-
-	mvebu_pcie_enable(pcie);
-
-	return 0;
+	list_splice_init(&pcie->resources, &bridge->windows);
+	bridge->dev.parent = dev;
+	bridge->sysdata = pcie;
+	bridge->busnr = 0;
+	bridge->ops = &mvebu_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->align_resource = mvebu_pcie_align_resource;
+	bridge->msi = pcie->msi;
+
+	return pci_host_probe(bridge);
 }
 
 static const struct of_device_id mvebu_pcie_of_match_table[] = {
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
