Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <michals@xilinx.com>,
	<lorenzo.pieralisi@arm.com>, <paul.burton@imgtec.com>,
	<yinghai@kernel.org>, <wangyijing@huawei.com>, <robh@kernel.org>,
	<russell.joyce@york.ac.uk>, <sorenb@xilinx.com>,
	<jiang.liu@linux.intel.com>, <arnd@arndb.de>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>
CC: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Bharat Kumar Gogada" <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: [PATCH V3 1/5] PCI: xilinx: Removing xilinx_pcie_parse_and_add_res function
Date: Tue, 9 Feb 2016 16:11:54 +0530
Message-ID: <1455014518-8708-2-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1455014518-8708-1-git-send-email-bharatku@xilinx.com>
References: <1455014518-8708-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Removing xilinx_pcie_parse_and_add_res function replacing with
of_pci_get_host_bridge_resources API.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
---
Changes:
Removing xilinx_pcie_parse_and_add_res function and replacing it
with of_pci_get_host_bridge_resources kernel API which does the same.
---
 drivers/pci/host/pcie-xilinx.c | 107 ++---------------------------------------
 1 file changed, 5 insertions(+), 102 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 3c7a0d5..627878d 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -94,9 +94,6 @@
 /* Number of MSI IRQs */
 #define XILINX_NUM_MSI_IRQS		128
 
-/* Number of Memory Resources */
-#define XILINX_MAX_NUM_RESOURCES	3
-
 /**
  * struct xilinx_pcie_port - PCIe port information
  * @reg_base: IO Mapped Register Base
@@ -105,7 +102,6 @@
  * @root_busno: Root Bus number
  * @dev: Device pointer
  * @irq_domain: IRQ domain pointer
- * @bus_range: Bus range
  * @resources: Bus Resources
  */
 struct xilinx_pcie_port {
@@ -659,97 +655,6 @@ static struct pci_bus *xilinx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 }
 
 /**
- * xilinx_pcie_parse_and_add_res - Add resources by parsing ranges
- * @port: PCIe port information
- *
- * Return: '0' on success and error value on failure
- */
-static int xilinx_pcie_parse_and_add_res(struct xilinx_pcie_port *port)
-{
-	struct device *dev = port->dev;
-	struct device_node *node = dev->of_node;
-	struct resource *mem;
-	resource_size_t offset;
-	struct of_pci_range_parser parser;
-	struct of_pci_range range;
-	struct resource_entry *win;
-	int err = 0, mem_resno = 0;
-
-	/* Get the ranges */
-	if (of_pci_range_parser_init(&parser, node)) {
-		dev_err(dev, "missing \"ranges\" property\n");
-		return -EINVAL;
-	}
-
-	/* Parse the ranges and add the resources found to the list */
-	for_each_of_pci_range(&parser, &range) {
-
-		if (mem_resno >= XILINX_MAX_NUM_RESOURCES) {
-			dev_err(dev, "Maximum memory resources exceeded\n");
-			return -EINVAL;
-		}
-
-		mem = devm_kmalloc(dev, sizeof(*mem), GFP_KERNEL);
-		if (!mem) {
-			err = -ENOMEM;
-			goto free_resources;
-		}
-
-		of_pci_range_to_resource(&range, node, mem);
-
-		switch (mem->flags & IORESOURCE_TYPE_BITS) {
-		case IORESOURCE_MEM:
-			offset = range.cpu_addr - range.pci_addr;
-			mem_resno++;
-			break;
-		default:
-			err = -EINVAL;
-			break;
-		}
-
-		if (err < 0) {
-			dev_warn(dev, "Invalid resource found %pR\n", mem);
-			continue;
-		}
-
-		err = request_resource(&iomem_resource, mem);
-		if (err)
-			goto free_resources;
-
-		pci_add_resource_offset(&port->resources, mem, offset);
-	}
-
-	/* Get the bus range */
-	if (of_pci_parse_bus_range(node, &port->bus_range)) {
-		u32 val = pcie_read(port, XILINX_PCIE_REG_BIR);
-		u8 last;
-
-		last = (val & XILINX_PCIE_BIR_ECAM_SZ_MASK) >>
-			XILINX_PCIE_BIR_ECAM_SZ_SHIFT;
-
-		port->bus_range = (struct resource) {
-			.name	= node->name,
-			.start	= 0,
-			.end	= last,
-			.flags	= IORESOURCE_BUS,
-		};
-	}
-
-	/* Register bus resource */
-	pci_add_resource(&port->resources, &port->bus_range);
-
-	return 0;
-
-free_resources:
-	release_child_resources(&iomem_resource);
-	resource_list_for_each_entry(win, &port->resources)
-		devm_kfree(dev, win->res);
-	pci_free_resource_list(&port->resources);
-
-	return err;
-}
-
-/**
  * xilinx_pcie_parse_dt - Parse Device tree
  * @port: PCIe port information
  *
@@ -802,6 +707,8 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	struct hw_pci hw;
 	struct device *dev = &pdev->dev;
 	int err;
+	resource_size_t iobase = 0;
+	LIST_HEAD(res);
 
 	if (!dev->of_node)
 		return -ENODEV;
@@ -826,14 +733,10 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	/*
-	 * Parse PCI ranges, configuration bus range and
-	 * request their resources
-	 */
-	INIT_LIST_HEAD(&port->resources);
-	err = xilinx_pcie_parse_and_add_res(port);
+	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff, &res,
+					       &iobase);
 	if (err) {
-		dev_err(dev, "Failed adding resources\n");
+		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
 	}
 
-- 
2.1.1
