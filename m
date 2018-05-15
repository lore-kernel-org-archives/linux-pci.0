Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()
Date: Tue, 15 May 2018 11:07:05 +0200
Message-Id: <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

of_pci_get_host_bridge_resources() allocates the resource structures it
fills dynamically, but none of its callers care to release them so far.
Rather than requiring everyone to do this explicitly, convert the
existing function to a managed version.

CC: Jingoo Han <jingoohan1@gmail.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/host/pci-aardvark.c        |  2 +-
 drivers/pci/host/pci-ftpci100.c        |  2 +-
 drivers/pci/host/pci-v3-semi.c         |  2 +-
 drivers/pci/host/pci-versatile.c       |  2 +-
 drivers/pci/host/pci-xgene.c           |  2 +-
 drivers/pci/host/pcie-altera.c         |  2 +-
 drivers/pci/host/pcie-iproc-platform.c |  2 +-
 drivers/pci/host/pcie-rcar.c           |  2 +-
 drivers/pci/host/pcie-rockchip.c       |  2 +-
 drivers/pci/host/pcie-xilinx-nwl.c     |  2 +-
 drivers/pci/host/pcie-xilinx.c         |  2 +-
 drivers/pci/of.c                       | 30 ++++++++++++------------------
 include/linux/of_pci.h                 |  4 ++--
 14 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 5a535690b7b5..a8f6ab54b4c0 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -342,7 +342,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;
 
-	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 					&bridge->windows, &pp->io_base);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 39d8fc2a8a76..1e048dd806dc 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -827,7 +827,7 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 
 	INIT_LIST_HEAD(&pcie->resources);
 
-	err = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 						    &pcie->resources, &iobase);
 	if (err)
 		return err;
diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 5c176f806fe5..87748eaeaaed 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -476,7 +476,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 						    &res, &io_base);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/host/pci-v3-semi.c
index f3f39935ac2f..167bf6f6b378 100644
--- a/drivers/pci/host/pci-v3-semi.c
+++ b/drivers/pci/host/pci-v3-semi.c
@@ -791,7 +791,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(v3->config_base))
 		return PTR_ERR(v3->config_base);
 
-	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
 						    &io_base);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index ef33ec0a9e1b..ff2cd12b3978 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -67,7 +67,7 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
 	resource_size_t iobase;
 	struct resource_entry *win, *tmp;
 
-	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, res, &iobase);
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, res, &iobase);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 88e9a6d315b3..7b3ed6e34b6c 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -632,7 +632,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
 						    &iobase);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 61802e55a00c..49410c7ba0cc 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -490,7 +490,7 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
 	struct device *dev = &pcie->pdev->dev;
 	struct resource_entry *win;
 
-	err = of_pci_get_host_bridge_resources(dev, 0, 0xff
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff
 						    &pcie->resources, NULL);
 	if (err)
 		return err;
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index cec0130326c9..99c2022813e4 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -99,7 +99,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		pcie->phy = NULL;
 	}
 
-	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
+	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
 						    &iobase);
 	if (ret) {
 		dev_err(dev, "unable to get PCI host bridge resources\n");
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 4c1787e021fd..6eb36c924983 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1070,7 +1070,7 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 	resource_size_t iobase;
 	struct resource_entry *win, *tmp;
 
-	err = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 						    &pci->resources, &iobase);
 	if (err)
 		return err;
diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index abac972f0dc2..27b97fcddf15 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1560,7 +1560,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_deinit_port;
 
-	err = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 						    &res, &io_base);
 	if (err)
 		goto err_remove_irq_domain;
diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 6aea997cd21b..64df768c795c 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -854,7 +854,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
 						    &iobase);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index fa5e44a480a4..88c96e5669e0 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -643,7 +643,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
 						    &iobase);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 4f21514cb4e4..b06585a1da75 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -244,7 +244,8 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
 #if defined(CONFIG_OF_ADDRESS)
 /**
- * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
+ * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
+ *                                           host bridge resources from DT
  * @dev: host bridge device
  * @busno: bus number associated with the bridge root bus
  * @bus_max: maximum number of buses for this bridge
@@ -253,8 +254,6 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * address for the start of the I/O range. Can be NULL if the caller doesn't
  * expect I/O ranges to be present in the device tree.
  *
- * It is the caller's job to free the @resources list.
- *
  * This function will parse the "ranges" property of a PCI host bridge device
  * node and setup the resource mapping based on its content. It is expected
  * that the property conforms with the Power ePAPR document.
@@ -262,12 +261,11 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * It returns zero if the range parsing has been successful or a standard error
  * value if it failed.
  */
-int of_pci_get_host_bridge_resources(struct device *dev,
+int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
 	struct device_node *dev_node = dev->of_node;
-	struct resource_entry *window;
 	struct resource *res;
 	struct resource *bus_range;
 	struct of_pci_range range;
@@ -278,7 +276,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 	if (io_base)
 		*io_base = (resource_size_t)OF_BAD_ADDR;
 
-	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
+	bus_range = devm_kzalloc(dev, sizeof(*bus_range), GFP_KERNEL);
 	if (!bus_range)
 		return -ENOMEM;
 
@@ -300,7 +298,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 	/* Check for ranges property */
 	err = of_pci_range_parser_init(&parser, dev_node);
 	if (err)
-		goto parse_failed;
+		goto failed;
 
 	dev_dbg(dev, "Parsing ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
@@ -322,15 +320,15 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
 			continue;
 
-		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+		res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
 		if (!res) {
 			err = -ENOMEM;
-			goto parse_failed;
+			goto failed;
 		}
 
 		err = of_pci_range_to_resource(&range, dev_node, res);
 		if (err) {
-			kfree(res);
+			devm_kfree(dev, res);
 			continue;
 		}
 
@@ -340,7 +338,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 					"I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
 					dev_node);
 				err = -EINVAL;
-				goto conversion_failed;
+				goto failed;
 			}
 			if (*io_base != (resource_size_t)OF_BAD_ADDR)
 				dev_warn(dev,
@@ -354,15 +352,11 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 
 	return 0;
 
-conversion_failed:
-	kfree(res);
-parse_failed:
-	resource_list_for_each_entry(window, resources)
-		kfree(window->res);
+failed:
 	pci_free_resource_list(resources);
 	return err;
 }
-EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
 #endif /* CONFIG_OF_ADDRESS */
 
 /**
@@ -606,7 +600,7 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 	struct resource_entry *win, *tmp;
 
 	INIT_LIST_HEAD(resources);
-	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
 						    &iobase);
 	if (err)
 		return err;
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index e6684c68cb94..fa4463a52900 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -71,11 +71,11 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-int of_pci_get_host_bridge_resources(struct device *dev,
+int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
 #else
-static inline int of_pci_get_host_bridge_resources(struct device *dev,
+static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
-- 
2.13.6
