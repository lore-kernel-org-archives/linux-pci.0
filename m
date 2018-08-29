Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Rob Herring <robh@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] PCI: remove unnecessary check of device_type == pci
Date: Wed, 29 Aug 2018 13:34:40 -0500
Message-Id: <20180829183440.13601-1-robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org,
 Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>, Alan Douglas <adouglas@cadence.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

PCI host drivers have already matched on compatible strings, so checking
device_type is redundant. Also, device_type is considered deprecated for
FDT though we've still been requiring it for PCI hosts as it is useful
for finding PCI buses.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alan Douglas <adouglas@cadence.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-host-common.c   | 8 --------
 drivers/pci/controller/pcie-cadence-host.c | 7 -------
 drivers/pci/controller/pcie-mobiveil.c     | 7 -------
 drivers/pci/controller/pcie-xilinx-nwl.c   | 9 ---------
 drivers/pci/controller/pcie-xilinx.c       | 7 -------
 5 files changed, 38 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d8f10451f273..c742881b5061 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -58,9 +58,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops)
 {
-	const char *type;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
 	struct list_head resources;
@@ -70,12 +68,6 @@ int pci_host_common_probe(struct platform_device *pdev,
 	if (!bridge)
 		return -ENOMEM;
 
-	type = of_get_property(np, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
-
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index ec394f6a19c8..97e251090b4f 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -235,7 +235,6 @@ static int cdns_pcie_host_init(struct device *dev,
 
 static int cdns_pcie_host_probe(struct platform_device *pdev)
 {
-	const char *type;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
@@ -268,12 +267,6 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	rc->device_id = 0xffff;
 	of_property_read_u16(np, "device-id", &rc->device_id);
 
-	type = of_get_property(np, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
 	pcie->reg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->reg_base)) {
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a939e8d31735..77052a0712d0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -301,13 +301,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	struct platform_device *pdev = pcie->pdev;
 	struct device_node *node = dev->of_node;
 	struct resource *res;
-	const char *type;
-
-	type = of_get_property(node, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
 
 	/* map config resource */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index fb32840ce8e6..81538d77f790 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -777,16 +777,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 			     struct platform_device *pdev)
 {
 	struct device *dev = pcie->dev;
-	struct device_node *node = dev->of_node;
 	struct resource *res;
-	const char *type;
-
-	/* Check for device type */
-	type = of_get_property(node, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
 	pcie->breg_base = devm_ioremap_resource(dev, res);
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 7b1389d8e2a5..9bd1a35cd5d8 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -574,15 +574,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
 	struct resource regs;
-	const char *type;
 	int err;
 
-	type = of_get_property(node, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
-
 	err = of_address_to_resource(node, 0, &regs);
 	if (err) {
 		dev_err(dev, "missing \"reg\" property\n");
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
