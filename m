Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:10132 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbbJ2JZf (ORCPT
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
Subject: [PATCH v13 3/6] PCI: designware: Replace DT PCI ranges parse with of_pci_get_host_bridge_resources
Date: Thu, 29 Oct 2015 17:40:35 +0800
Message-ID: <1446111638-197070-4-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1446111638-197070-1-git-send-email-wangzhou1@hisilicon.com>
References: <1446111638-197070-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch uses the new of_pci_get_host_bridge_resources
API in place of the PCI OF DT parser

For reference see previous suggestions from Gabriele[1]

[1] http://www.spinics.net/lists/linux-pci/msg42194.html

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Tested-by: James Morse <james.morse@arm.com>
Tested-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Tested-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pci-keystone-dw.c |  2 +-
 drivers/pci/host/pcie-designware.c | 99 ++++++++++++++++++--------------------
 drivers/pci/host/pcie-designware.h | 12 ++---
 3 files changed, 53 insertions(+), 60 deletions(-)

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
index 4e2dcd4..089b6cf 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -362,11 +362,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
 	struct platform_device *pdev = to_platform_device(pp->dev);
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
 	struct resource *cfg_res;
 	u32 val;
 	int i, ret;
+	LIST_HEAD(res);
+	struct resource_entry *win;
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -378,65 +378,58 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
-			pp->io_base_tmp = range.cpu_addr;
-		}
-		if (restype == IORESOURCE_MEM) {
-			of_pci_range_to_resource(&range, np, &pp->mem);
-			pp->mem.name = "MEM";
-			pp->mem_size = resource_size(&pp->mem);
-			pp->mem_bus_addr = range.pci_addr;
+	resource_list_for_each_entry(win, &res) {
+		switch (resource_type(win->res)) {
+		case IORESOURCE_IO:
+			pp->io = win->res;
+			pp->io->name = "I/O";
+			pp->io_size = resource_size(pp->io);
+			pp->io_bus_addr = pp->io->start - win->offset;
+			pp->io->start = max_t(resource_size_t, PCIBIOS_MIN_IO,
+					      pp->io_bus_addr +
+					      global_io_offset);
+			pp->io->end = min_t(resource_size_t, IO_SPACE_LIMIT,
+					    pp->io_bus_addr + pp->io_size +
+					    global_io_offset - 1);
+			pp->io_base = pp->io->start;
+			pp->io_base_tmp = pp->io->start;
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
-		if (restype == 0) {
-			of_pci_range_to_resource(&range, np, &pp->cfg);
-			pp->cfg0_size = resource_size(&pp->cfg)/2;
-			pp->cfg1_size = resource_size(&pp->cfg)/2;
-			pp->cfg0_base = pp->cfg.start;
-			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
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
 	}
 
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
@@ -663,13 +656,13 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 		sys->io_offset = global_io_offset - pp->io_bus_addr;
 		pci_ioremap_io(global_io_offset, pp->io_base_tmp);
 		global_io_offset += SZ_64K;
-		pci_add_resource_offset(&sys->resources, &pp->io,
+		pci_add_resource_offset(&sys->resources, pp->io,
 					sys->io_offset);
 	}
 
-	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
-	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
-	pci_add_resource(&sys->resources, &pp->busn);
+	sys->mem_offset = pp->mem->start - pp->mem_bus_addr;
+	pci_add_resource_offset(&sys->resources, pp->mem, sys->mem_offset);
+	pci_add_resource(&sys->resources, pp->busn);
 
 	return 1;
 }
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 2dbf649..91a36f6 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -32,17 +32,17 @@ struct pcie_port {
 	u64			cfg1_base;
 	void __iomem		*va_cfg1_base;
 	u32			cfg1_size;
-	u64			io_base;
-	u64			io_base_tmp;
+	resource_size_t		io_base;
+	resource_size_t		io_base_tmp;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
 	u64			mem_base;
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

