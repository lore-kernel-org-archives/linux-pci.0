Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 4/8] PCI: Replace dev_node parameter of of_pci_get_host_bridge_resources with device
Date: Tue, 15 May 2018 07:58:12 +0200
Message-Id: <5f2226585c6af9920b266d0503e32042d4c9e440.1526363896.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Another step towards a managed version of
of_pci_get_host_bridge_resources(): Feed in the underlying device,
rather than just the OF node. This will allow to use managed resource
allocation internally later on.

CC: Jingoo Han <jingoohan1@gmail.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 2 +-
 drivers/pci/host/pci-aardvark.c        | 5 ++---
 drivers/pci/host/pci-ftpci100.c        | 4 ++--
 drivers/pci/host/pci-v3-semi.c         | 3 ++-
 drivers/pci/host/pci-versatile.c       | 3 +--
 drivers/pci/host/pci-xgene.c           | 3 ++-
 drivers/pci/host/pcie-altera.c         | 5 ++---
 drivers/pci/host/pcie-iproc-platform.c | 4 ++--
 drivers/pci/host/pcie-rcar.c           | 5 ++---
 drivers/pci/host/pcie-rockchip.c       | 4 ++--
 drivers/pci/host/pcie-xilinx-nwl.c     | 4 ++--
 drivers/pci/host/pcie-xilinx.c         | 4 ++--
 drivers/pci/of.c                       | 9 +++++----
 include/linux/of_pci.h                 | 4 ++--
 14 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 6c409079d514..5a535690b7b5 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -342,7 +342,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;
 
-	ret = of_pci_get_host_bridge_resources(np, 0, 0xff,
+	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff,
 					&bridge->windows, &pp->io_base);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 9abf549631b4..39d8fc2a8a76 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -822,14 +822,13 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 {
 	int err, res_valid = 0;
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct resource_entry *win, *tmp;
 	resource_size_t iobase;
 
 	INIT_LIST_HEAD(&pcie->resources);
 
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
-					       &iobase);
+	err = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+						    &pcie->resources, &iobase);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 5008fd87956a..5c176f806fe5 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -476,8 +476,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-	ret = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
-					       &res, &io_base);
+	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+						    &res, &io_base);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/host/pci-v3-semi.c
index 0a4dea796663..f3f39935ac2f 100644
--- a/drivers/pci/host/pci-v3-semi.c
+++ b/drivers/pci/host/pci-v3-semi.c
@@ -791,7 +791,8 @@ static int v3_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(v3->config_base))
 		return PTR_ERR(v3->config_base);
 
-	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &io_base);
+	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+						    &io_base);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 5b3876f5312b..ef33ec0a9e1b 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -64,11 +64,10 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
 						     struct list_head *res)
 {
 	int err, mem = 1, res_valid = 0;
-	struct device_node *np = dev->of_node;
 	resource_size_t iobase;
 	struct resource_entry *win, *tmp;
 
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, res, &iobase);
+	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, res, &iobase);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 0a0d7ee6d3c9..88e9a6d315b3 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -632,7 +632,8 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_pci_get_host_bridge_resources(dn, 0, 0xff, &res, &iobase);
+	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+						    &iobase);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index a6af62e0256d..61802e55a00c 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -488,11 +488,10 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
 {
 	int err, res_valid = 0;
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct resource_entry *win;
 
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
-					       NULL);
+	err = of_pci_get_host_bridge_resources(dev, 0, 0xff
+						    &pcie->resources, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index e764a2a2693c..cec0130326c9 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -99,8 +99,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		pcie->phy = NULL;
 	}
 
-	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &resources,
-					       &iobase);
+	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
+						    &iobase);
 	if (ret) {
 		dev_err(dev, "unable to get PCI host bridge resources\n");
 		return ret;
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 6ab28f29ac6a..4c1787e021fd 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1067,12 +1067,11 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 {
 	int err;
 	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
 	resource_size_t iobase;
 	struct resource_entry *win, *tmp;
 
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
-					       &iobase);
+	err = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+						    &pci->resources, &iobase);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index f1e8f97ea1fb..abac972f0dc2 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1560,8 +1560,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_deinit_port;
 
-	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
-					       &res, &io_base);
+	err = of_pci_get_host_bridge_resources(dev, 0, 0xff,
+						    &res, &io_base);
 	if (err)
 		goto err_remove_irq_domain;
 
diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 4839ae578711..6aea997cd21b 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -825,7 +825,6 @@ static const struct of_device_id nwl_pcie_of_match[] = {
 static int nwl_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
 	struct nwl_pcie *pcie;
 	struct pci_bus *bus;
 	struct pci_bus *child;
@@ -855,7 +854,8 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = of_pci_get_host_bridge_resources(node, 0, 0xff, &res, &iobase);
+	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+						    &iobase);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 0ad188effc09..fa5e44a480a4 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -643,8 +643,8 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff, &res,
-					       &iobase);
+	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+						    &iobase);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 8d4778ef5806..ac97491ba377 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -245,7 +245,7 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 #if defined(CONFIG_OF_ADDRESS)
 /**
  * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
- * @dev_node: device node of the host bridge having the range property
+ * @dev: host bridge device
  * @busno: bus number associated with the bridge root bus
  * @bus_max: maximum number of buses for this bridge
  * @resources: list where the range of resources will be added after DT parsing
@@ -262,10 +262,11 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * It returns zero if the range parsing has been successful or a standard error
  * value if it failed.
  */
-int of_pci_get_host_bridge_resources(struct device_node *dev_node,
+int of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
+	struct device_node *dev_node = dev->of_node;
 	struct resource_entry *window;
 	struct resource *res;
 	struct resource *bus_range;
@@ -599,12 +600,12 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 				    struct resource **bus_range)
 {
 	int err, res_valid = 0;
-	struct device_node *np = dev->of_node;
 	resource_size_t iobase;
 	struct resource_entry *win, *tmp;
 
 	INIT_LIST_HEAD(resources);
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
+	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
+						    &iobase);
 	if (err)
 		return err;
 
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 74eec1943ad2..e6684c68cb94 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -71,11 +71,11 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-int of_pci_get_host_bridge_resources(struct device_node *dev_node,
+int of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
 #else
-static inline int of_pci_get_host_bridge_resources(struct device_node *dev_node,
+static inline int of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
-- 
2.13.6
