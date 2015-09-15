Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:47751 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbbIOMoY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 08:44:24 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux@arm.linux.org.uk>, <thomas.petazzoni@free-electrons.com>,
	<gabriele.paoloni@huawei.com>, <lorenzo.pieralisi@arm.com>,
	<james.morse@arm.com>, <Liviu.Dudau@arm.com>,
	<jason@lakedaemon.net>, <robh@kernel.org>,
	<gabriel.fernandez@linaro.org>, <Minghuan.Lian@freescale.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <xuwei5@hisilicon.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v9 3/6] PCI: designware: Add ARM64 support
Date: Tue, 15 Sep 2015 20:49:18 +0800
Message-ID: <1442321361-174300-4-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com>
References: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
move related operations to dw_pcie_host_init.

This patch also try to use of_pci_get_host_bridge_resources for ARM32 and ARM64
according to the suggestion for Gabriele[1]

This patch reverts commit f4c55c5a3f7f ("PCI: designware: Program ATU with
untranslated address") based on 1/6 in this series. we delete *_mod_base in
pcie-designware. This was discussed in [2]

I have compiled the driver with multi_v7_defconfig. However, I don't have
ARM32 PCIe related board to do test. It will be appreciated if someone could
help to test it.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: James Morse <james.morse@arm.com>
Tested-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Tested-by: Minghuan Lian <Minghuan.Lian@freescale.com>

[1] http://www.spinics.net/lists/linux-pci/msg42194.html
[2] http://www.spinics.net/lists/arm-kernel/msg436779.html
---
 drivers/pci/host/pci-dra7xx.c      |  14 +--
 drivers/pci/host/pci-keystone-dw.c |   2 +-
 drivers/pci/host/pcie-designware.c | 238 ++++++++++++-------------------------
 drivers/pci/host/pcie-designware.h |  14 +--
 4 files changed, 90 insertions(+), 178 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index ebdffa0..b88c248 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -153,15 +153,15 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	dw_pcie_setup_rc(pp);
 
-	if (pp->io_mod_base)
-		pp->io_mod_base &= CPU_TO_BUS_ADDR;
+	if (pp->io_base)
+		pp->io_base &= CPU_TO_BUS_ADDR;
 
-	if (pp->mem_mod_base)
-		pp->mem_mod_base &= CPU_TO_BUS_ADDR;
+	if (pp->mem_base)
+		pp->mem_base &= CPU_TO_BUS_ADDR;
 
-	if (pp->cfg0_mod_base) {
-		pp->cfg0_mod_base &= CPU_TO_BUS_ADDR;
-		pp->cfg1_mod_base &= CPU_TO_BUS_ADDR;
+	if (pp->cfg0_base) {
+		pp->cfg0_base &= CPU_TO_BUS_ADDR;
+		pp->cfg1_base &= CPU_TO_BUS_ADDR;
 	}
 
 	dra7xx_pcie_establish_link(pp);
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index e71da99..8062ddb 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -322,7 +322,7 @@ static void ks_dw_pcie_clear_dbi_mode(void __iomem *reg_virt)
 void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
-	u32 start = pp->mem.start, end = pp->mem.end;
+	u32 start = pp->mem->start, end = pp->mem->end;
 	int i, tr_size;
 
 	/* Disable BARs for inbound access */
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 75338a6..8ef74da 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/hardirq.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -69,16 +70,7 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
-static struct hw_pci dw_pci;
-
-static unsigned long global_io_offset;
-
-static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
-{
-	BUG_ON(!sys->private_data);
-
-	return sys->private_data;
-}
+static struct pci_ops dw_pcie_ops;
 
 int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
 {
@@ -255,7 +247,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 {
 	int irq, pos0, i;
-	struct pcie_port *pp = sys_to_pcie(msi_desc_to_pci_sysdata(desc));
+	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(desc);
 
 	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
 				       order_base_2(no_irqs));
@@ -298,7 +290,7 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 {
 	int irq, pos;
 	struct msi_msg msg;
-	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
+	struct pcie_port *pp = pdev->bus->sysdata;
 
 	if (desc->msi_attrib.is_msix)
 		return -EINVAL;
@@ -327,7 +319,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct msi_desc *msi = irq_data_get_msi_desc(data);
-	struct pcie_port *pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
+	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
 
 	clear_irq_range(pp, irq, 1, data->hwirq);
 }
@@ -362,14 +354,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
 	struct platform_device *pdev = to_platform_device(pp->dev);
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
+	struct pci_bus *bus;
 	struct resource *cfg_res;
-	u32 val, ns;
-	const __be32 *addrp;
-	int i, index, ret;
-
-	ns = of_n_size_cells(np);
+	LIST_HEAD(res);
+	u32 val;
+	int i, ret;
+	struct resource_entry *win;
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -377,85 +367,60 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->cfg1_size = resource_size(cfg_res)/2;
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
-
-		/* Find the untranslated configuration space address */
-		index = of_property_match_string(np, "reg-names", "config");
-		addrp = of_get_address(np, index, NULL, NULL);
-		pp->cfg0_mod_base = of_read_number(addrp, ns);
-		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
 		dev_err(pp->dev, "missing *config* reg space\n");
 	}
 
-	if (of_pci_range_parser_init(&parser, np)) {
-		dev_err(pp->dev, "missing ranges property\n");
-		return -EINVAL;
-	}
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
+	if (ret)
+		return ret;
 
 	/* Get the I/O and memory ranges from DT */
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
-					   IO_SPACE_LIMIT,
-					   range.pci_addr + range.size
-					   + global_io_offset - 1);
-			pp->io_size = resource_size(&pp->io);
-			pp->io_bus_addr = range.pci_addr;
-			pp->io_base = range.cpu_addr;
-
-			/* Find the untranslated IO space address */
-			pp->io_mod_base = range.cpu_addr;
-		}
-		if (restype == IORESOURCE_MEM) {
-			of_pci_range_to_resource(&range, np, &pp->mem);
-			pp->mem.name = "MEM";
-			pp->mem_size = resource_size(&pp->mem);
-			pp->mem_bus_addr = range.pci_addr;
-
-			/* Find the untranslated MEM space address */
-			pp->mem_mod_base = range.cpu_addr;
-		}
-		if (restype == 0) {
-			of_pci_range_to_resource(&range, np, &pp->cfg);
-			pp->cfg0_size = resource_size(&pp->cfg)/2;
-			pp->cfg1_size = resource_size(&pp->cfg)/2;
-			pp->cfg0_base = pp->cfg.start;
-			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
-
-			/* Find the untranslated configuration space address */
-			pp->cfg0_mod_base = range.cpu_addr;
-			pp->cfg1_mod_base = pp->cfg0_mod_base +
-					    pp->cfg0_size;
+	resource_list_for_each_entry(win, &res) {
+		switch (resource_type(win->res)) {
+		case IORESOURCE_IO:
+			pp->io = win->res;
+			pp->io->name = "I/O";
+			pp->io_size = resource_size(pp->io);
+			pp->io_bus_addr = pp->io->start - win->offset;
+			ret = pci_remap_iospace(pp->io, pp->io_base);
+			if (ret) {
+				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
+					 ret, pp->io);
+				continue;
+			}
+			break;
+		case IORESOURCE_MEM:
+			pp->mem = win->res;
+			pp->mem->name = "MEM";
+			pp->mem_size = resource_size(pp->mem);
+			pp->mem_bus_addr = pp->mem->start - win->offset;
+			break;
+		case 0:
+			pp->cfg = win->res;
+			pp->cfg0_size = resource_size(pp->cfg)/2;
+			pp->cfg1_size = resource_size(pp->cfg)/2;
+			pp->cfg0_base = pp->cfg->start;
+			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
+			break;
+		case IORESOURCE_BUS:
+			pp->busn = win->res;
+			break;
+		default:
+			continue;
 		}
 	}
 
-	ret = of_pci_parse_bus_range(np, &pp->busn);
-	if (ret < 0) {
-		pp->busn.name = np->name;
-		pp->busn.start = 0;
-		pp->busn.end = 0xff;
-		pp->busn.flags = IORESOURCE_BUS;
-		dev_dbg(pp->dev, "failed to parse bus-range property: %d, using default %pR\n",
-			ret, &pp->busn);
-	}
-
 	if (!pp->dbi_base) {
-		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
-					resource_size(&pp->cfg));
+		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
+					resource_size(pp->cfg));
 		if (!pp->dbi_base) {
 			dev_err(pp->dev, "error with ioremap\n");
 			return -ENOMEM;
 		}
 	}
 
-	pp->mem_base = pp->mem.start;
+	pp->mem_base = pp->mem->start;
 
 	if (!pp->va_cfg0_base) {
 		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
@@ -504,7 +469,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	if (!pp->ops->rd_other_conf)
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
+					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
@@ -516,14 +481,28 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 
-#ifdef CONFIG_PCI_MSI
-	dw_pcie_msi_chip.dev = pp->dev;
-#endif
+	pp->root_bus_nr = pp->busn->start;
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
+					    &dw_pcie_ops, pp, &res,
+					    &dw_pcie_msi_chip);
+		dw_pcie_msi_chip.dev = pp->dev;
+	} else
+		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
+					pp, &res);
+	if (!bus)
+		return -ENOMEM;
 
-	dw_pci.nr_controllers = 1;
-	dw_pci.private_data = (void **)&pp;
+	if (pp->ops->scan_bus)
+		pp->ops->scan_bus(pp);
 
-	pci_common_init_dev(pp->dev, &dw_pci);
+#ifdef CONFIG_ARM
+	/* support old dtbs that incorrectly describe IRQs */
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+#endif
+
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
 
 	return 0;
 }
@@ -542,12 +521,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	if (bus->parent->number == pp->root_bus_nr) {
 		type = PCIE_ATU_TYPE_CFG0;
-		cpu_addr = pp->cfg0_mod_base;
+		cpu_addr = pp->cfg0_base;
 		cfg_size = pp->cfg0_size;
 		va_cfg_base = pp->va_cfg0_base;
 	} else {
 		type = PCIE_ATU_TYPE_CFG1;
-		cpu_addr = pp->cfg1_mod_base;
+		cpu_addr = pp->cfg1_base;
 		cfg_size = pp->cfg1_size;
 		va_cfg_base = pp->va_cfg1_base;
 	}
@@ -557,7 +536,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 
 	return ret;
@@ -577,12 +556,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	if (bus->parent->number == pp->root_bus_nr) {
 		type = PCIE_ATU_TYPE_CFG0;
-		cpu_addr = pp->cfg0_mod_base;
+		cpu_addr = pp->cfg0_base;
 		cfg_size = pp->cfg0_size;
 		va_cfg_base = pp->va_cfg0_base;
 	} else {
 		type = PCIE_ATU_TYPE_CFG1;
-		cpu_addr = pp->cfg1_mod_base;
+		cpu_addr = pp->cfg1_base;
 		cfg_size = pp->cfg1_size;
 		va_cfg_base = pp->va_cfg1_base;
 	}
@@ -592,7 +571,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 
 	return ret;
@@ -624,7 +603,7 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
 static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
-	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
 	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
@@ -648,7 +627,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
-	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
 	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
@@ -672,69 +651,6 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
-static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
-{
-	struct pcie_port *pp;
-
-	pp = sys_to_pcie(sys);
-
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
-
-	return 1;
-}
-
-static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	struct pci_bus *bus;
-	struct pcie_port *pp = sys_to_pcie(sys);
-
-	pp->root_bus_nr = sys->busnr;
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bus = pci_scan_root_bus_msi(pp->dev, sys->busnr, &dw_pcie_ops,
-					    sys, &sys->resources,
-					    &dw_pcie_msi_chip);
-	else
-		bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
-					sys, &sys->resources);
-
-	if (!bus)
-		return NULL;
-
-	if (bus && pp->ops->scan_bus)
-		pp->ops->scan_bus(pp);
-
-	return bus;
-}
-
-static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
-	int irq;
-
-	irq = of_irq_parse_and_map_pci(dev, slot, pin);
-	if (!irq)
-		irq = pp->irq;
-
-	return irq;
-}
-
-static struct hw_pci dw_pci = {
-	.setup		= dw_pcie_setup,
-	.scan		= dw_pcie_scan_bus,
-	.map_irq	= dw_pcie_map_irq,
-};
-
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..264c969 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -27,25 +27,21 @@ struct pcie_port {
 	u8			root_bus_nr;
 	void __iomem		*dbi_base;
 	u64			cfg0_base;
-	u64			cfg0_mod_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
 	u64			cfg1_base;
-	u64			cfg1_mod_base;
 	void __iomem		*va_cfg1_base;
 	u32			cfg1_size;
-	u64			io_base;
-	u64			io_mod_base;
+	resource_size_t		io_base;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
 	u64			mem_base;
-	u64			mem_mod_base;
 	phys_addr_t		mem_bus_addr;
 	u32			mem_size;
-	struct resource		cfg;
-	struct resource		io;
-	struct resource		mem;
-	struct resource		busn;
+	struct resource		*cfg;
+	struct resource		*io;
+	struct resource		*mem;
+	struct resource		*busn;
 	int			irq;
 	u32			lanes;
 	struct pcie_host_ops	*ops;
-- 
1.9.1

