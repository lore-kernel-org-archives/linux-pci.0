Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:56829 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbbAGP3v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jan 2015 10:29:51 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 3/3] drivers: pci: host: update the pcie designware driver to new range parsing API
Date: Wed,  7 Jan 2015 15:29:31 +0000
Message-Id: <1420644571-18928-4-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The new OF pci API of_pci_get_host_bridge_resources() implemented by:

'commit cbe4097f8ae699ebbdaf8c95 ("of/pci: Add support for parsing PCI host bridge resources from DT")'

and subsequent changes allow to parse PCI DT ranges in a generic way
through a new API that can be used to consolidate the DT range parsing for
all PCIe controllers in the kernel that are configured through DT.

This patch updates the PCIe designware driver in order for it to use the
new OF range parsing API and remove driver specific parsing code.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/host/pcie-designware.c | 145 +++++++++++++++++--------------------
 drivers/pci/host/pcie-designware.h |   5 +-
 2 files changed, 69 insertions(+), 81 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index df781cd..95cce40 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -69,8 +69,6 @@
 
 static struct hw_pci dw_pci;
 
-static unsigned long global_io_offset;
-
 static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
 {
 	BUG_ON(!sys->private_data);
@@ -343,18 +341,21 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
 	struct platform_device *pdev = to_platform_device(pp->dev);
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
 	struct resource *cfg_res;
-	u32 val, na, ns;
+	u32 val, na;
 	const __be32 *addrp;
 	int i, index, ret;
+	resource_size_t io_base;
+	struct pci_host_bridge_window *win;
+	struct of_pci_resource *of_pci_res;
 
-	/* Find the address cell size and the number of cells in order to get
-	 * the untranslated address.
+	/*
+	 * Find the address cell size (ie must be 3 for DT PCI addresses) to
+	 * get the untranslated address.
 	 */
 	of_property_read_u32(np, "#address-cells", &na);
-	ns = of_n_size_cells(np);
+
+	INIT_LIST_HEAD(&pp->resources);
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -366,84 +367,79 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 		/* Find the untranslated configuration space address */
 		index = of_property_match_string(np, "reg-names", "config");
 		addrp = of_get_address(np, index, NULL, NULL);
-		pp->cfg0_mod_base = of_read_number(addrp, ns);
+		pp->cfg0_mod_base = of_read_number(addrp, of_n_addr_cells(np));
 		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
 	} else {
 		dev_err(pp->dev, "missing *config* reg space\n");
 	}
 
-	if (of_pci_range_parser_init(&parser, np)) {
-		dev_err(pp->dev, "missing ranges property\n");
-		return -EINVAL;
-	}
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &pp->resources,
+					       &io_base);
+	if (ret)
+		return ret;
 
-	/* Get the I/O and memory ranges from DT */
-	for_each_of_pci_range(&parser, &range) {
-		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
-
-		if (restype == IORESOURCE_IO) {
-			of_pci_range_to_resource(&range, np, &pp->io);
-			pp->io.name = "I/O";
-			pp->io.start = max_t(resource_size_t,
-					     PCIBIOS_MIN_IO,
-					     range.pci_addr + global_io_offset);
-			pp->io.end = min_t(resource_size_t,
+	list_for_each_entry(win, &pp->resources, list) {
+		u64 pci_addr;
+		struct resource *res = win->res;
+
+		pci_addr = res->start - win->offset;
+		of_pci_res = container_of(res, struct of_pci_resource, res);
+
+		if (resource_type(res) == IORESOURCE_IO) {
+			res->name = "I/O";
+			res->start = max_t(resource_size_t, PCIBIOS_MIN_IO,
+					   pci_addr);
+			res->end = min_t(resource_size_t,
 					   IO_SPACE_LIMIT,
-					   range.pci_addr + range.size
-					   + global_io_offset - 1);
-			pp->io_size = resource_size(&pp->io);
-			pp->io_bus_addr = range.pci_addr;
-			pp->io_base = range.cpu_addr;
+					   pci_addr + resource_size(res) - 1);
+			pp->io_size = resource_size(res);
+			pp->io_bus_addr = pci_addr;
+			pp->io_base = io_base;
 
 			/* Find the untranslated IO space address */
-			pp->io_mod_base = of_read_number(parser.range -
-							 parser.np + na, ns);
+			pp->io_mod_base =
+				of_read_number(of_pci_res->parser.range + na,
+					       of_pci_res->parser.pna);
+			pci_remap_iospace(res, io_base);
 		}
-		if (restype == IORESOURCE_MEM) {
-			of_pci_range_to_resource(&range, np, &pp->mem);
-			pp->mem.name = "MEM";
-			pp->mem_size = resource_size(&pp->mem);
-			pp->mem_bus_addr = range.pci_addr;
+
+		if (resource_type(res) == IORESOURCE_MEM) {
+			res->name = "MEM";
+			pp->mem_size = resource_size(res);
+			pp->mem_bus_addr = pci_addr;
+			pp->mem_base = res->start;
 
 			/* Find the untranslated MEM space address */
-			pp->mem_mod_base = of_read_number(parser.range -
-							  parser.np + na, ns);
+			pp->mem_mod_base =
+				of_read_number(of_pci_res->parser.range + na,
+					       of_pci_res->parser.pna);
 		}
-		if (restype == 0) {
-			of_pci_range_to_resource(&range, np, &pp->cfg);
-			pp->cfg0_size = resource_size(&pp->cfg)/2;
-			pp->cfg1_size = resource_size(&pp->cfg)/2;
-			pp->cfg0_base = pp->cfg.start;
-			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
+
+		if (resource_type(res) == 0) {
+			pp->cfg0_size = resource_size(res)/2;
+			pp->cfg1_size = resource_size(res)/2;
+			pp->cfg0_base = res->start;
+			pp->cfg1_base = res->start + pp->cfg0_size;
 
 			/* Find the untranslated configuration space address */
-			pp->cfg0_mod_base = of_read_number(parser.range -
-							   parser.np + na, ns);
+			pp->cfg0_mod_base =
+				of_read_number(of_pci_res->parser.range + na,
+					       of_pci_res->parser.pna);
 			pp->cfg1_mod_base = pp->cfg0_mod_base +
 					    pp->cfg0_size;
-		}
-	}
-
-	ret = of_pci_parse_bus_range(np, &pp->busn);
-	if (ret < 0) {
-		pp->busn.name = np->name;
-		pp->busn.start = 0;
-		pp->busn.end = 0xff;
-		pp->busn.flags = IORESOURCE_BUS;
-		dev_dbg(pp->dev, "failed to parse bus-range property: %d, using default %pR\n",
-			ret, &pp->busn);
-	}
 
-	if (!pp->dbi_base) {
-		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
-					resource_size(&pp->cfg));
-		if (!pp->dbi_base) {
-			dev_err(pp->dev, "error with ioremap\n");
-			return -ENOMEM;
+			if (!pp->dbi_base) {
+				pp->dbi_base = devm_ioremap(pp->dev,
+						res->start,
+						resource_size(res));
+				if (!pp->dbi_base) {
+					dev_err(pp->dev, "error with ioremap\n");
+					return -ENOMEM;
+				}
+			}
 		}
-	}
 
-	pp->mem_base = pp->mem.start;
+	}
 
 	if (!pp->va_cfg0_base) {
 		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
@@ -704,20 +700,15 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct pcie_port *pp;
+	struct pci_host_bridge_window *win, *tmp;
 
 	pp = sys_to_pcie(sys);
+	/* remove the configuration aperture in case it is there */
+	list_for_each_entry_safe(win, tmp, &pp->resources, list)
+		if (!resource_type(win->res))
+			list_del(&win->list);
 
-	if (global_io_offset < SZ_1M && pp->io_size > 0) {
-		sys->io_offset = global_io_offset - pp->io_bus_addr;
-		pci_ioremap_io(global_io_offset, pp->io_base);
-		global_io_offset += SZ_64K;
-		pci_add_resource_offset(&sys->resources, &pp->io,
-					sys->io_offset);
-	}
-
-	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
-	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
-	pci_add_resource(&sys->resources, &pp->busn);
+	list_splice(&pp->resources, &sys->resources);
 
 	return 1;
 }
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..2479e9c 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -42,10 +42,7 @@ struct pcie_port {
 	u64			mem_mod_base;
 	phys_addr_t		mem_bus_addr;
 	u32			mem_size;
-	struct resource		cfg;
-	struct resource		io;
-	struct resource		mem;
-	struct resource		busn;
+	struct list_head	resources;
 	int			irq;
 	u32			lanes;
 	struct pcie_host_ops	*ops;
-- 
2.2.1

