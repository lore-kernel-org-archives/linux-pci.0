Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <michals@xilinx.com>,
	<lorenzo.pieralisi@arm.com>, <yinghai@kernel.org>,
	<wangyijing@huawei.com>, <robh@kernel.org>,
	<russell.joyce@york.ac.uk>, <sorenb@xilinx.com>,
	<jiang.liu@linux.intel.com>, <arnd@arndb.de>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>
CC: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Bharat Kumar Gogada" <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: [PATCH 2/5] PCI: xilinx: Removing struct hw_irq structure.
Date: Tue, 12 Jan 2016 10:56:36 +0530
Message-ID: <1452576399-1513-3-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1452576399-1513-1-git-send-email-bharatku@xilinx.com>
References: <1452576399-1513-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Removing struct hw_irq and adding generic PCI core API's.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
---
Changes:
Removing architecure dependecy structure struct hw_irq which is ARM 32-bit
specific structure, and adding generic PCI core API's to register to
PCI subsytem.
Removing funtions which are not being used with generic API's.
---
 drivers/pci/host/pcie-xilinx.c | 80 +++++++++---------------------------------
 1 file changed, 16 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 588e568..3e3757f 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -117,11 +117,6 @@ struct xilinx_pcie_port {
 
 static DECLARE_BITMAP(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
 
-static inline struct xilinx_pcie_port *sys_to_pcie(struct pci_sys_data *sys)
-{
-	return sys->private_data;
-}
-
 static inline u32 pcie_read(struct xilinx_pcie_port *port, u32 reg)
 {
 	return readl(port->reg_base + reg);
@@ -163,7 +158,7 @@ static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
  */
 static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
-	struct xilinx_pcie_port *port = sys_to_pcie(bus->sysdata);
+	struct xilinx_pcie_port *port = bus->sysdata;
 
 	/* Check if link is up when trying to access downstream ports */
 	if (bus->number != port->root_busno)
@@ -196,7 +191,7 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
 					 unsigned int devfn, int where)
 {
-	struct xilinx_pcie_port *port = sys_to_pcie(bus->sysdata);
+	struct xilinx_pcie_port *port = bus->sysdata;
 	int relbus;
 
 	if (!xilinx_pcie_valid_device(bus, devfn))
@@ -228,7 +223,7 @@ static void xilinx_pcie_destroy_msi(unsigned int irq)
 
 	if (!test_bit(irq, msi_irq_in_use)) {
 		msi = irq_get_msi_desc(irq);
-		port = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
+		port = msi_desc_to_pci_sysdata(msi);
 		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
 	} else {
 		clear_bit(irq, msi_irq_in_use);
@@ -277,7 +272,7 @@ static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
 				     struct pci_dev *pdev,
 				     struct msi_desc *desc)
 {
-	struct xilinx_pcie_port *port = sys_to_pcie(pdev->bus->sysdata);
+	struct xilinx_pcie_port *port = pdev->bus->sysdata;
 	unsigned int irq;
 	int hwirq;
 	struct msi_msg msg;
@@ -614,46 +609,6 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 }
 
 /**
- * xilinx_pcie_setup - Setup memory resources
- * @nr: Bus number
- * @sys: Per controller structure
- *
- * Return: '1' on success and error value on failure
- */
-static int xilinx_pcie_setup(int nr, struct pci_sys_data *sys)
-{
-	struct xilinx_pcie_port *port = sys_to_pcie(sys);
-
-	list_splice_init(&port->resources, &sys->resources);
-
-	return 1;
-}
-
-/**
- * xilinx_pcie_scan_bus - Scan PCIe bus for devices
- * @nr: Bus number
- * @sys: Per controller structure
- *
- * Return: Valid Bus pointer on success and NULL on failure
- */
-static struct pci_bus *xilinx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	struct xilinx_pcie_port *port = sys_to_pcie(sys);
-	struct pci_bus *bus;
-
-	port->root_busno = sys->busnr;
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bus = pci_scan_root_bus_msi(port->dev, sys->busnr,
-					    &xilinx_pcie_ops, sys,
-					    &sys->resources,
-					    &xilinx_pcie_msi_chip);
-	else
-		bus = pci_scan_root_bus(port->dev, sys->busnr,
-					&xilinx_pcie_ops, sys, &sys->resources);
-	return bus;
-}
-
  * xilinx_pcie_parse_dt - Parse Device tree
  * @port: PCIe port information
  *
@@ -703,8 +658,9 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 static int xilinx_pcie_probe(struct platform_device *pdev)
 {
 	struct xilinx_pcie_port *port;
-	struct hw_pci hw;
 	struct device *dev = &pdev->dev;
+	struct pci_bus *bus;
+
 	int err;
 	resource_size_t iobase = 0;
 	LIST_HEAD(res);
@@ -738,24 +694,20 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
 	}
-
-	platform_set_drvdata(pdev, port);
-
-	/* Register the device */
-	memset(&hw, 0, sizeof(hw));
-	hw = (struct hw_pci) {
-		.nr_controllers	= 1,
-		.private_data	= (void **)&port,
-		.setup		= xilinx_pcie_setup,
-		.map_irq	= of_irq_parse_and_map_pci,
-		.scan		= xilinx_pcie_scan_bus,
-		.ops		= &xilinx_pcie_ops,
-	};
+	bus = pci_create_root_bus(&pdev->dev, 0,
+				  &xilinx_pcie_ops, port, &res);
+	if (!bus)
+		return -ENOMEM;
 
 #ifdef CONFIG_PCI_MSI
 	xilinx_pcie_msi_chip.dev = port->dev;
+	bus->msi = &xilinx_pcie_msi_chip;
 #endif
-	pci_common_init_dev(dev, &hw);
+	pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_bus_add_devices(bus);
+	platform_set_drvdata(pdev, port);
 
 	return 0;
 }
-- 
2.1.1
