Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941018AbcJGQgW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:36:22 -0400
Subject: [PATCH 1/5] PCI: xgene: Name private struct pointer "xgene"
 consistently
To: Duc Dang <dhdang@apm.com>, Tanmay Inamdar <tinamdar@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:27:58 -0500
Message-ID: <20161007162758.24026.43622.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "xgene", for struct xgene_pcie_port pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |  138 +++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index a81273c..ba26950 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -87,12 +87,12 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
  */
 static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
 {
-	struct xgene_pcie_port *port = bus->sysdata;
+	struct xgene_pcie_port *xgene = bus->sysdata;
 
 	if (bus->number >= (bus->primary + 1))
-		return port->cfg_base + AXI_EP_CFG_ACCESS;
+		return xgene->cfg_base + AXI_EP_CFG_ACCESS;
 
-	return port->cfg_base;
+	return xgene->cfg_base;
 }
 
 /*
@@ -101,7 +101,7 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
  */
 static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 {
-	struct xgene_pcie_port *port = bus->sysdata;
+	struct xgene_pcie_port *xgene = bus->sysdata;
 	unsigned int b, d, f;
 	u32 rtdid_val = 0;
 
@@ -112,9 +112,9 @@ static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 	if (!pci_is_root_bus(bus))
 		rtdid_val = (b << 8) | (d << 3) | f;
 
-	writel(rtdid_val, port->csr_base + RTDID);
+	writel(rtdid_val, xgene->csr_base + RTDID);
 	/* read the register back to ensure flush */
-	readl(port->csr_base + RTDID);
+	readl(xgene->csr_base + RTDID);
 }
 
 /*
@@ -148,7 +148,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
-	struct xgene_pcie_port *port = bus->sysdata;
+	struct xgene_pcie_port *xgene = bus->sysdata;
 
 	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
 	    PCIBIOS_SUCCESSFUL)
@@ -163,7 +163,7 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	 * causes the PCI core to retry the read until it times out.
 	 * Avoid this by not claiming to support CRS.
 	 */
-	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
+	if (pci_is_root_bus(bus) && (xgene->version == XGENE_PCIE_IP_VER_1) &&
 	    ((where & ~0x3) == ROOT_CAP_AND_CTRL))
 		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
 
@@ -205,65 +205,65 @@ static u64 xgene_pcie_set_ib_mask(void __iomem *csr_base, u32 addr,
 	return mask;
 }
 
-static void xgene_pcie_linkup(struct xgene_pcie_port *port,
+static void xgene_pcie_linkup(struct xgene_pcie_port *xgene,
 				   u32 *lanes, u32 *speed)
 {
-	void __iomem *csr_base = port->csr_base;
+	void __iomem *csr_base = xgene->csr_base;
 	u32 val32;
 
-	port->link_up = false;
+	xgene->link_up = false;
 	val32 = readl(csr_base + PCIECORE_CTLANDSTATUS);
 	if (val32 & LINK_UP_MASK) {
-		port->link_up = true;
+		xgene->link_up = true;
 		*speed = PIPE_PHY_RATE_RD(val32);
 		val32 = readl(csr_base + BRIDGE_STATUS_0);
 		*lanes = val32 >> 26;
 	}
 }
 
-static int xgene_pcie_init_port(struct xgene_pcie_port *port)
+static int xgene_pcie_init_port(struct xgene_pcie_port *xgene)
 {
 	int rc;
 
-	port->clk = clk_get(port->dev, NULL);
-	if (IS_ERR(port->clk)) {
-		dev_err(port->dev, "clock not available\n");
+	xgene->clk = clk_get(xgene->dev, NULL);
+	if (IS_ERR(xgene->clk)) {
+		dev_err(xgene->dev, "clock not available\n");
 		return -ENODEV;
 	}
 
-	rc = clk_prepare_enable(port->clk);
+	rc = clk_prepare_enable(xgene->clk);
 	if (rc) {
-		dev_err(port->dev, "clock enable failed\n");
+		dev_err(xgene->dev, "clock enable failed\n");
 		return rc;
 	}
 
 	return 0;
 }
 
-static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
+static int xgene_pcie_map_reg(struct xgene_pcie_port *xgene,
 			      struct platform_device *pdev)
 {
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
-	port->csr_base = devm_ioremap_resource(port->dev, res);
-	if (IS_ERR(port->csr_base))
-		return PTR_ERR(port->csr_base);
+	xgene->csr_base = devm_ioremap_resource(xgene->dev, res);
+	if (IS_ERR(xgene->csr_base))
+		return PTR_ERR(xgene->csr_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
-	port->cfg_base = devm_ioremap_resource(port->dev, res);
-	if (IS_ERR(port->cfg_base))
-		return PTR_ERR(port->cfg_base);
-	port->cfg_addr = res->start;
+	xgene->cfg_base = devm_ioremap_resource(xgene->dev, res);
+	if (IS_ERR(xgene->cfg_base))
+		return PTR_ERR(xgene->cfg_base);
+	xgene->cfg_addr = res->start;
 
 	return 0;
 }
 
-static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
+static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *xgene,
 				    struct resource *res, u32 offset,
 				    u64 cpu_addr, u64 pci_addr)
 {
-	void __iomem *base = port->csr_base + offset;
+	void __iomem *base = xgene->csr_base + offset;
 	resource_size_t size = resource_size(res);
 	u64 restype = resource_type(res);
 	u64 mask = 0;
@@ -280,7 +280,7 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
 	if (size >= min_size)
 		mask = ~(size - 1) | flag;
 	else
-		dev_warn(port->dev, "res size 0x%llx less than minimum 0x%x\n",
+		dev_warn(xgene->dev, "res size 0x%llx less than minimum 0x%x\n",
 			 (u64)size, min_size);
 
 	writel(lower_32_bits(cpu_addr), base);
@@ -298,23 +298,23 @@ static void xgene_pcie_setup_cfg_reg(void __iomem *csr_base, u64 addr)
 	writel(EN_REG, csr_base + CFGCTL);
 }
 
-static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
+static int xgene_pcie_map_ranges(struct xgene_pcie_port *xgene,
 				 struct list_head *res,
 				 resource_size_t io_base)
 {
 	struct resource_entry *window;
-	struct device *dev = port->dev;
+	struct device *dev = xgene->dev;
 	int ret;
 
 	resource_list_for_each_entry(window, res) {
 		struct resource *res = window->res;
 		u64 restype = resource_type(res);
 
-		dev_dbg(port->dev, "%pR\n", res);
+		dev_dbg(xgene->dev, "%pR\n", res);
 
 		switch (restype) {
 		case IORESOURCE_IO:
-			xgene_pcie_setup_ob_reg(port, res, OMR3BARL, io_base,
+			xgene_pcie_setup_ob_reg(xgene, res, OMR3BARL, io_base,
 						res->start - window->offset);
 			ret = pci_remap_iospace(res, io_base);
 			if (ret < 0)
@@ -322,12 +322,12 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
 			break;
 		case IORESOURCE_MEM:
 			if (res->flags & IORESOURCE_PREFETCH)
-				xgene_pcie_setup_ob_reg(port, res, OMR2BARL,
+				xgene_pcie_setup_ob_reg(xgene, res, OMR2BARL,
 							res->start,
 							res->start -
 							window->offset);
 			else
-				xgene_pcie_setup_ob_reg(port, res, OMR1BARL,
+				xgene_pcie_setup_ob_reg(xgene, res, OMR1BARL,
 							res->start,
 							res->start -
 							window->offset);
@@ -339,7 +339,7 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
 			return -EINVAL;
 		}
 	}
-	xgene_pcie_setup_cfg_reg(port->csr_base, port->cfg_addr);
+	xgene_pcie_setup_cfg_reg(xgene->csr_base, xgene->cfg_addr);
 
 	return 0;
 }
@@ -376,11 +376,11 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 	return -EINVAL;
 }
 
-static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
+static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *xgene,
 				    struct of_pci_range *range, u8 *ib_reg_mask)
 {
-	void __iomem *csr_base = port->csr_base;
-	void __iomem *cfg_base = port->cfg_base;
+	void __iomem *csr_base = xgene->csr_base;
+	void __iomem *cfg_base = xgene->cfg_base;
 	void *bar_addr;
 	void *pim_addr;
 	u64 cpu_addr = range->cpu_addr;
@@ -393,7 +393,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 
 	region = xgene_pcie_select_ib_reg(ib_reg_mask, range->size);
 	if (region < 0) {
-		dev_warn(port->dev, "invalid pcie dma-range config\n");
+		dev_warn(xgene->dev, "invalid pcie dma-range config\n");
 		return;
 	}
 
@@ -446,12 +446,12 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 	return 0;
 }
 
-static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
+static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *xgene)
 {
-	struct device_node *np = port->node;
+	struct device_node *np = xgene->node;
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
-	struct device *dev = port->dev;
+	struct device *dev = xgene->dev;
 	u8 ib_reg_mask = 0;
 
 	if (pci_dma_range_parser_init(&parser, np)) {
@@ -463,48 +463,48 @@ static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 	for_each_of_pci_range(&parser, &range) {
 		u64 end = range.cpu_addr + range.size - 1;
 
-		dev_dbg(port->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
+		dev_dbg(xgene->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
 			range.flags, range.cpu_addr, end, range.pci_addr);
-		xgene_pcie_setup_ib_reg(port, &range, &ib_reg_mask);
+		xgene_pcie_setup_ib_reg(xgene, &range, &ib_reg_mask);
 	}
 	return 0;
 }
 
 /* clear BAR configuration which was done by firmware */
-static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
+static void xgene_pcie_clear_config(struct xgene_pcie_port *xgene)
 {
 	int i;
 
 	for (i = PIM1_1L; i <= CFGCTL; i += 4)
-		writel(0x0, port->csr_base + i);
+		writel(0x0, xgene->csr_base + i);
 }
 
-static int xgene_pcie_setup(struct xgene_pcie_port *port,
+static int xgene_pcie_setup(struct xgene_pcie_port *xgene,
 			    struct list_head *res,
 			    resource_size_t io_base)
 {
 	u32 val, lanes = 0, speed = 0;
 	int ret;
 
-	xgene_pcie_clear_config(port);
+	xgene_pcie_clear_config(xgene);
 
 	/* setup the vendor and device IDs correctly */
 	val = (XGENE_PCIE_DEVICEID << 16) | XGENE_PCIE_VENDORID;
-	writel(val, port->csr_base + BRIDGE_CFG_0);
+	writel(val, xgene->csr_base + BRIDGE_CFG_0);
 
-	ret = xgene_pcie_map_ranges(port, res, io_base);
+	ret = xgene_pcie_map_ranges(xgene, res, io_base);
 	if (ret)
 		return ret;
 
-	ret = xgene_pcie_parse_map_dma_ranges(port);
+	ret = xgene_pcie_parse_map_dma_ranges(xgene);
 	if (ret)
 		return ret;
 
-	xgene_pcie_linkup(port, &lanes, &speed);
-	if (!port->link_up)
-		dev_info(port->dev, "(rc) link down\n");
+	xgene_pcie_linkup(xgene, &lanes, &speed);
+	if (!xgene->link_up)
+		dev_info(xgene->dev, "(rc) link down\n");
 	else
-		dev_info(port->dev, "(rc) x%d gen-%d link up\n",
+		dev_info(xgene->dev, "(rc) x%d gen-%d link up\n",
 				lanes, speed + 1);
 	return 0;
 }
@@ -512,27 +512,27 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
 static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
-	struct xgene_pcie_port *port;
+	struct xgene_pcie_port *xgene;
 	resource_size_t iobase = 0;
 	struct pci_bus *bus;
 	int ret;
 	LIST_HEAD(res);
 
-	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
-	if (!port)
+	xgene = devm_kzalloc(&pdev->dev, sizeof(*xgene), GFP_KERNEL);
+	if (!xgene)
 		return -ENOMEM;
-	port->node = of_node_get(pdev->dev.of_node);
-	port->dev = &pdev->dev;
+	xgene->node = of_node_get(pdev->dev.of_node);
+	xgene->dev = &pdev->dev;
 
-	port->version = XGENE_PCIE_IP_VER_UNKN;
-	if (of_device_is_compatible(port->node, "apm,xgene-pcie"))
-		port->version = XGENE_PCIE_IP_VER_1;
+	xgene->version = XGENE_PCIE_IP_VER_UNKN;
+	if (of_device_is_compatible(xgene->node, "apm,xgene-pcie"))
+		xgene->version = XGENE_PCIE_IP_VER_1;
 
-	ret = xgene_pcie_map_reg(port, pdev);
+	ret = xgene_pcie_map_reg(xgene, pdev);
 	if (ret)
 		return ret;
 
-	ret = xgene_pcie_init_port(port);
+	ret = xgene_pcie_init_port(xgene);
 	if (ret)
 		return ret;
 
@@ -544,12 +544,12 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	ret = xgene_pcie_setup(port, &res, iobase);
+	ret = xgene_pcie_setup(xgene, &res, iobase);
 	if (ret)
 		goto error;
 
 	bus = pci_create_root_bus(&pdev->dev, 0,
-					&xgene_pcie_ops, port, &res);
+					&xgene_pcie_ops, xgene, &res);
 	if (!bus) {
 		ret = -ENOMEM;
 		goto error;
@@ -559,7 +559,7 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 
-	platform_set_drvdata(pdev, port);
+	platform_set_drvdata(pdev, xgene);
 	return 0;
 
 error:

