Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:10166 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323AbbJ2JZf (ORCPT
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
Subject: [PATCH v13 2/6] PCI: designware: Remove *_mod_base
Date: Thu, 29 Oct 2015 17:40:34 +0800
Message-ID: <1446111638-197070-3-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1446111638-197070-1-git-send-email-wangzhou1@hisilicon.com>
References: <1446111638-197070-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch reverts commit f4c55c5a3f7f ("PCI: designware: Program ATU with
untranslated address") based on 1/6 in this series. we delete *_mod_base in
pcie-designware. This was discussed in [1]

dw_pcie_setup which is called in pci_common_init_dev uses io_base, however,
io_base had been modified in dra7xx_pcie_host_init in dw_pcie_host_init. So an
io_base_tmp is added in struct pcie_port to store original io_base value. It
will be deleted in "PCI: designware: Add ARM64 support" in which dw_pcie_setup
will be removed.

[1] http://www.spinics.net/lists/arm-kernel/msg436779.html

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: James Morse <james.morse@arm.com>
Tested-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Tested-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pci-dra7xx.c      |  8 ++++----
 drivers/pci/host/pcie-designware.c | 41 ++++++++++----------------------------
 drivers/pci/host/pcie-designware.h |  5 +----
 3 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 0b4847a..8c36880 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -153,10 +153,10 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	dw_pcie_setup_rc(pp);
 
-	pp->io_mod_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->mem_mod_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->cfg0_mod_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->cfg1_mod_base &= DRA7XX_CPU_TO_BUS_ADDR;
+	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
+	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
+	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
+	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
 
 	dra7xx_pcie_establish_link(pp);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 75338a6..4e2dcd4 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -365,11 +365,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	struct resource *cfg_res;
-	u32 val, ns;
-	const __be32 *addrp;
-	int i, index, ret;
-
-	ns = of_n_size_cells(np);
+	u32 val;
+	int i, ret;
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -377,12 +374,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
@@ -409,18 +400,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->io_size = resource_size(&pp->io);
 			pp->io_bus_addr = range.pci_addr;
 			pp->io_base = range.cpu_addr;
-
-			/* Find the untranslated IO space address */
-			pp->io_mod_base = range.cpu_addr;
+			pp->io_base_tmp = range.cpu_addr;
 		}
 		if (restype == IORESOURCE_MEM) {
 			of_pci_range_to_resource(&range, np, &pp->mem);
 			pp->mem.name = "MEM";
 			pp->mem_size = resource_size(&pp->mem);
 			pp->mem_bus_addr = range.pci_addr;
-
-			/* Find the untranslated MEM space address */
-			pp->mem_mod_base = range.cpu_addr;
 		}
 		if (restype == 0) {
 			of_pci_range_to_resource(&range, np, &pp->cfg);
@@ -428,11 +414,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->cfg1_size = resource_size(&pp->cfg)/2;
 			pp->cfg0_base = pp->cfg.start;
 			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
-
-			/* Find the untranslated configuration space address */
-			pp->cfg0_mod_base = range.cpu_addr;
-			pp->cfg1_mod_base = pp->cfg0_mod_base +
-					    pp->cfg0_size;
 		}
 	}
 
@@ -504,7 +485,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	if (!pp->ops->rd_other_conf)
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
+					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
@@ -542,12 +523,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
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
@@ -557,7 +538,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 
 	return ret;
@@ -577,12 +558,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
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
@@ -592,7 +573,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 
 	return ret;
@@ -680,7 +661,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 
 	if (global_io_offset < SZ_1M && pp->io_size > 0) {
 		sys->io_offset = global_io_offset - pp->io_bus_addr;
-		pci_ioremap_io(global_io_offset, pp->io_base);
+		pci_ioremap_io(global_io_offset, pp->io_base_tmp);
 		global_io_offset += SZ_64K;
 		pci_add_resource_offset(&sys->resources, &pp->io,
 					sys->io_offset);
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..2dbf649 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -27,19 +27,16 @@ struct pcie_port {
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
 	u64			io_base;
-	u64			io_mod_base;
+	u64			io_base_tmp;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
 	u64			mem_base;
-	u64			mem_mod_base;
 	phys_addr_t		mem_bus_addr;
 	u32			mem_size;
 	struct resource		cfg;
-- 
1.9.1

