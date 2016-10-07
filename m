Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754560AbcJGQ3U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:20 -0400
Subject: [PATCH 4/5] PCI: xgene: Add local struct device pointers
To: Duc Dang <dhdang@apm.com>, Tanmay Inamdar <tinamdar@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:28:23 -0500
Message-ID: <20161007162822.24026.21756.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162758.24026.43622.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162758.24026.43622.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |   47 +++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 77e5ac0..ec55f12 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -232,17 +232,18 @@ static void xgene_pcie_linkup(struct xgene_pcie_port *xgene,
 
 static int xgene_pcie_init_port(struct xgene_pcie_port *xgene)
 {
+	struct device *dev = xgene->dev;
 	int rc;
 
-	xgene->clk = clk_get(xgene->dev, NULL);
+	xgene->clk = clk_get(dev, NULL);
 	if (IS_ERR(xgene->clk)) {
-		dev_err(xgene->dev, "clock not available\n");
+		dev_err(dev, "clock not available\n");
 		return -ENODEV;
 	}
 
 	rc = clk_prepare_enable(xgene->clk);
 	if (rc) {
-		dev_err(xgene->dev, "clock enable failed\n");
+		dev_err(dev, "clock enable failed\n");
 		return rc;
 	}
 
@@ -252,15 +253,16 @@ static int xgene_pcie_init_port(struct xgene_pcie_port *xgene)
 static int xgene_pcie_map_reg(struct xgene_pcie_port *xgene,
 			      struct platform_device *pdev)
 {
+	struct device *dev = xgene->dev;
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
-	xgene->csr_base = devm_ioremap_resource(xgene->dev, res);
+	xgene->csr_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(xgene->csr_base))
 		return PTR_ERR(xgene->csr_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
-	xgene->cfg_base = devm_ioremap_resource(xgene->dev, res);
+	xgene->cfg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(xgene->cfg_base))
 		return PTR_ERR(xgene->cfg_base);
 	xgene->cfg_addr = res->start;
@@ -272,6 +274,7 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *xgene,
 				    struct resource *res, u32 offset,
 				    u64 cpu_addr, u64 pci_addr)
 {
+	struct device *dev = xgene->dev;
 	resource_size_t size = resource_size(res);
 	u64 restype = resource_type(res);
 	u64 mask = 0;
@@ -288,7 +291,7 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *xgene,
 	if (size >= min_size)
 		mask = ~(size - 1) | flag;
 	else
-		dev_warn(xgene->dev, "res size 0x%llx less than minimum 0x%x\n",
+		dev_warn(dev, "res size 0x%llx less than minimum 0x%x\n",
 			 (u64)size, min_size);
 
 	xgene_writel(xgene, offset, lower_32_bits(cpu_addr));
@@ -310,15 +313,15 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *xgene,
 				 struct list_head *res,
 				 resource_size_t io_base)
 {
-	struct resource_entry *window;
 	struct device *dev = xgene->dev;
+	struct resource_entry *window;
 	int ret;
 
 	resource_list_for_each_entry(window, res) {
 		struct resource *res = window->res;
 		u64 restype = resource_type(res);
 
-		dev_dbg(xgene->dev, "%pR\n", res);
+		dev_dbg(dev, "%pR\n", res);
 
 		switch (restype) {
 		case IORESOURCE_IO:
@@ -388,6 +391,7 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *xgene,
 				    struct of_pci_range *range, u8 *ib_reg_mask)
 {
+	struct device *dev = xgene->dev;
 	void __iomem *cfg_base = xgene->cfg_base;
 	void *bar_addr;
 	u32 pim_reg;
@@ -401,7 +405,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *xgene,
 
 	region = xgene_pcie_select_ib_reg(ib_reg_mask, range->size);
 	if (region < 0) {
-		dev_warn(xgene->dev, "invalid pcie dma-range config\n");
+		dev_warn(dev, "invalid pcie dma-range config\n");
 		return;
 	}
 
@@ -454,10 +458,10 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 
 static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *xgene)
 {
+	struct device *dev = xgene->dev;
 	struct device_node *np = xgene->node;
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
-	struct device *dev = xgene->dev;
 	u8 ib_reg_mask = 0;
 
 	if (pci_dma_range_parser_init(&parser, np)) {
@@ -469,7 +473,7 @@ static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *xgene)
 	for_each_of_pci_range(&parser, &range) {
 		u64 end = range.cpu_addr + range.size - 1;
 
-		dev_dbg(xgene->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
+		dev_dbg(dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
 			range.flags, range.cpu_addr, end, range.pci_addr);
 		xgene_pcie_setup_ib_reg(xgene, &range, &ib_reg_mask);
 	}
@@ -489,6 +493,7 @@ static int xgene_pcie_setup(struct xgene_pcie_port *xgene,
 			    struct list_head *res,
 			    resource_size_t io_base)
 {
+	struct device *dev = xgene->dev;
 	u32 val, lanes = 0, speed = 0;
 	int ret;
 
@@ -508,27 +513,28 @@ static int xgene_pcie_setup(struct xgene_pcie_port *xgene,
 
 	xgene_pcie_linkup(xgene, &lanes, &speed);
 	if (!xgene->link_up)
-		dev_info(xgene->dev, "(rc) link down\n");
+		dev_info(dev, "(rc) link down\n");
 	else
-		dev_info(xgene->dev, "(rc) x%d gen-%d link up\n",
-				lanes, speed + 1);
+		dev_info(dev, "(rc) x%d gen-%d link up\n", lanes, speed + 1);
 	return 0;
 }
 
 static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 {
-	struct device_node *dn = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct xgene_pcie_port *xgene;
+	struct device_node *dn = dev->of_node;
 	resource_size_t iobase = 0;
 	struct pci_bus *bus;
 	int ret;
 	LIST_HEAD(res);
 
-	xgene = devm_kzalloc(&pdev->dev, sizeof(*xgene), GFP_KERNEL);
+	xgene = devm_kzalloc(dev, sizeof(*xgene), GFP_KERNEL);
 	if (!xgene)
 		return -ENOMEM;
-	xgene->node = of_node_get(pdev->dev.of_node);
-	xgene->dev = &pdev->dev;
+
+	xgene->node = of_node_get(dn);
+	xgene->dev = dev;
 
 	xgene->version = XGENE_PCIE_IP_VER_UNKN;
 	if (of_device_is_compatible(xgene->node, "apm,xgene-pcie"))
@@ -546,7 +552,7 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_request_pci_bus_resources(&pdev->dev, &res);
+	ret = devm_request_pci_bus_resources(dev, &res);
 	if (ret)
 		goto error;
 
@@ -554,8 +560,7 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	bus = pci_create_root_bus(&pdev->dev, 0,
-					&xgene_pcie_ops, xgene, &res);
+	bus = pci_create_root_bus(dev, 0, &xgene_pcie_ops, xgene, &res);
 	if (!bus) {
 		ret = -ENOMEM;
 		goto error;

