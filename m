Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36560 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbaHPHXi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Aug 2014 03:23:38 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <jg1.han@samsung.com>, <mohit.kumar@st.com>
Cc: <linux-pci@vger.kernel.org>, Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH] PCIe: Designware: Extract struct pcie_port_info elements into struct pcie_port
Date: Sat, 16 Aug 2014 12:52:39 +0530
Message-ID: <67297b465f1b531aec9f290246698b23aa994381.1407906240.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

struct pcie_port_info elements are not containing any exclusive
information compared to other elements of struct pcie_port. So, keeping
a separate structure like struct pcie_port_info does not seem very
logical. Therefore remove this struct  and embed its elements directly
into struct pcie_port.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 drivers/pci/host/pcie-designware.c | 53 +++++++++++++++++++-------------------
 drivers/pci/host/pcie-designware.h | 16 +++++-------
 2 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 52bd3a143563..8b5237fe162f 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -435,16 +435,16 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
-		pp->config.cfg0_size = resource_size(cfg_res)/2;
-		pp->config.cfg1_size = resource_size(cfg_res)/2;
+		pp->cfg0_size = resource_size(cfg_res)/2;
+		pp->cfg1_size = resource_size(cfg_res)/2;
 		pp->cfg0_base = cfg_res->start;
-		pp->cfg1_base = cfg_res->start + pp->config.cfg0_size;
+		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 
 		/* Find the untranslated configuration space address */
 		index = of_property_match_string(np, "reg-names", "config");
 		addrp = of_get_address(np, index, false, false);
 		pp->cfg0_mod_base = of_read_number(addrp, ns);
-		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->config.cfg0_size;
+		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
 	} else {
 		dev_err(pp->dev, "missing *config* reg space\n");
 	}
@@ -467,8 +467,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 					   IO_SPACE_LIMIT,
 					   range.pci_addr + range.size
 					   + global_io_offset);
-			pp->config.io_size = resource_size(&pp->io);
-			pp->config.io_bus_addr = range.pci_addr;
+			pp->io_size = resource_size(&pp->io);
+			pp->io_bus_addr = range.pci_addr;
 			pp->io_base = range.cpu_addr;
 
 			/* Find the untranslated IO space address */
@@ -478,8 +478,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 		if (restype == IORESOURCE_MEM) {
 			of_pci_range_to_resource(&range, np, &pp->mem);
 			pp->mem.name = "MEM";
-			pp->config.mem_size = resource_size(&pp->mem);
-			pp->config.mem_bus_addr = range.pci_addr;
+			pp->mem_size = resource_size(&pp->mem);
+			pp->mem_bus_addr = range.pci_addr;
 
 			/* Find the untranslated MEM space address */
 			pp->mem_mod_base = of_read_number(parser.range -
@@ -487,16 +487,16 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 		}
 		if (restype == 0) {
 			of_pci_range_to_resource(&range, np, &pp->cfg);
-			pp->config.cfg0_size = resource_size(&pp->cfg)/2;
-			pp->config.cfg1_size = resource_size(&pp->cfg)/2;
+			pp->cfg0_size = resource_size(&pp->cfg)/2;
+			pp->cfg1_size = resource_size(&pp->cfg)/2;
 			pp->cfg0_base = pp->cfg.start;
-			pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
+			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
 
 			/* Find the untranslated configuration space address */
 			pp->cfg0_mod_base = of_read_number(parser.range -
 							   parser.np + na, ns);
 			pp->cfg1_mod_base = pp->cfg0_mod_base +
-					    pp->config.cfg0_size;
+					    pp->cfg0_size;
 		}
 	}
 
@@ -512,13 +512,13 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	pp->mem_base = pp->mem.start;
 
 	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
-					pp->config.cfg0_size);
+					pp->cfg0_size);
 	if (!pp->va_cfg0_base) {
 		dev_err(pp->dev, "error with ioremap in function\n");
 		return -ENOMEM;
 	}
 	pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
-					pp->config.cfg1_size);
+					pp->cfg1_size);
 	if (!pp->va_cfg1_base) {
 		dev_err(pp->dev, "error with ioremap\n");
 		return -ENOMEM;
@@ -573,7 +573,7 @@ static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
 			  PCIE_ATU_VIEWPORT);
 	dw_pcie_writel_rc(pp, pp->cfg0_mod_base, PCIE_ATU_LOWER_BASE);
 	dw_pcie_writel_rc(pp, (pp->cfg0_mod_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->cfg0_mod_base + pp->config.cfg0_size - 1,
+	dw_pcie_writel_rc(pp, pp->cfg0_mod_base + pp->cfg0_size - 1,
 			  PCIE_ATU_LIMIT);
 	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
 	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
@@ -589,7 +589,7 @@ static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
 	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, pp->cfg1_mod_base, PCIE_ATU_LOWER_BASE);
 	dw_pcie_writel_rc(pp, (pp->cfg1_mod_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->cfg1_mod_base + pp->config.cfg1_size - 1,
+	dw_pcie_writel_rc(pp, pp->cfg1_mod_base + pp->cfg1_size - 1,
 			  PCIE_ATU_LIMIT);
 	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
 	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
@@ -604,10 +604,10 @@ static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
 	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, pp->mem_mod_base, PCIE_ATU_LOWER_BASE);
 	dw_pcie_writel_rc(pp, (pp->mem_mod_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->mem_mod_base + pp->config.mem_size - 1,
+	dw_pcie_writel_rc(pp, pp->mem_mod_base + pp->mem_size - 1,
 			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, pp->config.mem_bus_addr, PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.mem_bus_addr),
+	dw_pcie_writel_rc(pp, pp->mem_bus_addr, PCIE_ATU_LOWER_TARGET);
+	dw_pcie_writel_rc(pp, upper_32_bits(pp->mem_bus_addr),
 			  PCIE_ATU_UPPER_TARGET);
 	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
 }
@@ -620,10 +620,10 @@ static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
 	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, pp->io_mod_base, PCIE_ATU_LOWER_BASE);
 	dw_pcie_writel_rc(pp, (pp->io_mod_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->io_mod_base + pp->config.io_size - 1,
+	dw_pcie_writel_rc(pp, pp->io_mod_base + pp->io_size - 1,
 			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, pp->config.io_bus_addr, PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.io_bus_addr),
+	dw_pcie_writel_rc(pp, pp->io_bus_addr, PCIE_ATU_LOWER_TARGET);
+	dw_pcie_writel_rc(pp, upper_32_bits(pp->io_bus_addr),
 			  PCIE_ATU_UPPER_TARGET);
 	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
 }
@@ -771,15 +771,15 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (!pp)
 		return 0;
 
-	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
-		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
+	if (global_io_offset < SZ_1M && pp->io_size > 0) {
+		sys->io_offset = global_io_offset - pp->io_bus_addr;
 		pci_ioremap_io(global_io_offset, pp->io_base);
 		global_io_offset += SZ_64K;
 		pci_add_resource_offset(&sys->resources, &pp->io,
 					sys->io_offset);
 	}
 
-	sys->mem_offset = pp->mem.start - pp->config.mem_bus_addr;
+	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
 	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
 
 	return 1;
@@ -833,7 +833,6 @@ static struct hw_pci dw_pci = {
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
-	struct pcie_port_info *config = &pp->config;
 	u32 val;
 	u32 membase;
 	u32 memlimit;
@@ -888,7 +887,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	/* setup memory base, memory limit */
 	membase = ((u32)pp->mem_base & 0xfff00000) >> 16;
-	memlimit = (config->mem_size + (u32)pp->mem_base) & 0xfff00000;
+	memlimit = (pp->mem_size + (u32)pp->mem_base) & 0xfff00000;
 	val = memlimit | membase;
 	dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index daf81f922cda..80c1cd07c373 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -14,15 +14,6 @@
 #ifndef _PCIE_DESIGNWARE_H
 #define _PCIE_DESIGNWARE_H
 
-struct pcie_port_info {
-	u32		cfg0_size;
-	u32		cfg1_size;
-	u32		io_size;
-	u32		mem_size;
-	phys_addr_t	io_bus_addr;
-	phys_addr_t	mem_bus_addr;
-};
-
 /*
  * Maximum number of MSI IRQs can be 256 per controller. But keep
  * it 32 as of now. Probably we will never need more than 32. If needed,
@@ -38,17 +29,22 @@ struct pcie_port {
 	u64			cfg0_base;
 	u64			cfg0_mod_base;
 	void __iomem		*va_cfg0_base;
+	u32			cfg0_size;
 	u64			cfg1_base;
 	u64			cfg1_mod_base;
 	void __iomem		*va_cfg1_base;
+	u32			cfg1_size;
 	u64			io_base;
 	u64			io_mod_base;
+	phys_addr_t		io_bus_addr;
+	u32			io_size;
 	u64			mem_base;
 	u64			mem_mod_base;
+	phys_addr_t		mem_bus_addr;
+	u32			mem_size;
 	struct resource		cfg;
 	struct resource		io;
 	struct resource		mem;
-	struct pcie_port_info	config;
 	int			irq;
 	u32			lanes;
 	struct pcie_host_ops	*ops;
-- 
1.8.1.2

