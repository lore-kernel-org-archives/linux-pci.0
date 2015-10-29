Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:10141 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbbJ2JZf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 05:25:35 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	<rmk+kernel@arm.linux.org.uk>,
	<thomas.petazzoni@free-electrons.com>,
	<gabriele.paoloni@huawei.com>, <lorenzo.pieralisi@arm.com>,
	<james.morse@arm.com>, <Liviu.Dudau@arm.com>,
	<jason@lakedaemon.net>, <robh@kernel.org>,
	<gabriel.fernandez@linaro.org>, <Minghuan.Lian@freescale.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liudongdong3@huawei.com>, <qiujiang@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v13 5/6] PCI: designware: Add ARM64 support
Date: Thu, 29 Oct 2015 17:40:37 +0800
Message-ID: <1446111638-197070-6-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1446111638-197070-1-git-send-email-wangzhou1@hisilicon.com>
References: <1446111638-197070-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
move related operations to dw_pcie_host_init.

As dw_pcie_setup is removed, we also remove io_base_tmp which was introduced
in "PCI: designware: Remove *_mod_base".

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: James Morse <james.morse@arm.com>
Tested-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Tested-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pcie-designware.c | 128 +++++++++++--------------------------
 drivers/pci/host/pcie-designware.h |   1 -
 2 files changed, 38 insertions(+), 91 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 089b6cf..1a6d3e1 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -69,16 +69,7 @@
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
@@ -255,7 +246,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 {
 	int irq, pos0, i;
-	struct pcie_port *pp = sys_to_pcie(msi_desc_to_pci_sysdata(desc));
+	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(desc);
 
 	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
 				       order_base_2(no_irqs));
@@ -298,7 +289,7 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 {
 	int irq, pos;
 	struct msi_msg msg;
-	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
+	struct pcie_port *pp = pdev->bus->sysdata;
 
 	if (desc->msi_attrib.is_msix)
 		return -EINVAL;
@@ -327,7 +318,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct msi_desc *msi = irq_data_get_msi_desc(data);
-	struct pcie_port *pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
+	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
 
 	clear_irq_range(pp, irq, 1, data->hwirq);
 }
@@ -362,6 +353,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
 	struct platform_device *pdev = to_platform_device(pp->dev);
+	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
 	u32 val;
 	int i, ret;
@@ -390,14 +382,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->io->name = "I/O";
 			pp->io_size = resource_size(pp->io);
 			pp->io_bus_addr = pp->io->start - win->offset;
-			pp->io->start = max_t(resource_size_t, PCIBIOS_MIN_IO,
-					      pp->io_bus_addr +
-					      global_io_offset);
-			pp->io->end = min_t(resource_size_t, IO_SPACE_LIMIT,
-					    pp->io_bus_addr + pp->io_size +
-					    global_io_offset - 1);
+			ret = pci_remap_iospace(pp->io, pp->io_base);
+			if (ret) {
+				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
+					 ret, pp->io);
+				continue;
+			}
 			pp->io_base = pp->io->start;
-			pp->io_base_tmp = pp->io->start;
 			break;
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
@@ -490,15 +481,35 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 
-#ifdef CONFIG_PCI_MSI
-	dw_pcie_msi_chip.dev = pp->dev;
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
+
+	if (pp->ops->scan_bus)
+		pp->ops->scan_bus(pp);
+
+#ifdef CONFIG_ARM
+	/* support old dtbs that incorrectly describe IRQs */
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 #endif
 
-	dw_pci.nr_controllers = 1;
-	dw_pci.private_data = (void **)&pp;
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
 
-	pci_common_init_dev(pp->dev, &dw_pci);
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
 
+	pci_bus_add_devices(bus);
 	return 0;
 }
 
@@ -598,7 +609,7 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
 static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
-	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
 	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
@@ -622,7 +633,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
-	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
 	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
@@ -646,69 +657,6 @@ static struct pci_ops dw_pcie_ops = {
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
-		pci_ioremap_io(global_io_offset, pp->io_base_tmp);
-		global_io_offset += SZ_64K;
-		pci_add_resource_offset(&sys->resources, pp->io,
-					sys->io_offset);
-	}
-
-	sys->mem_offset = pp->mem->start - pp->mem_bus_addr;
-	pci_add_resource_offset(&sys->resources, pp->mem, sys->mem_offset);
-	pci_add_resource(&sys->resources, pp->busn);
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
index 91a36f6..264c969 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -33,7 +33,6 @@ struct pcie_port {
 	void __iomem		*va_cfg1_base;
 	u32			cfg1_size;
 	resource_size_t		io_base;
-	resource_size_t		io_base_tmp;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
 	u64			mem_base;
-- 
1.9.1

