Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:14738 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbbJZLUv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2015 07:20:51 -0400
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
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liudongdong3@huawei.com>, <qiujiang@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v12 5/8] PCI: designware: Remove *_mod_base
Date: Mon, 26 Oct 2015 19:35:47 +0800
Message-ID: <1445859350-26375-6-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1445859350-26375-1-git-send-email-wangzhou1@hisilicon.com>
References: <1445859350-26375-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch reverts commit f4c55c5a3f7f ("PCI: designware: Program ATU with
untranslated address") based on 1/8 in this series. we delete *_mod_base in
pcie-designware. This was discussed in [1]

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
 drivers/pci/host/pcie-designware.c | 38 +++++++++-----------------------------
 drivers/pci/host/pcie-designware.h |  4 ----
 3 files changed, 13 insertions(+), 37 deletions(-)

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
index 0af1432..1615deb 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -355,26 +355,17 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct platform_device *pdev = to_platform_device(pp->dev);
 	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
-	u32 val, ns;
-	const __be32 *addrp;
-	int i, index, ret;
+	u32 val;
+	int i, ret;
 	LIST_HEAD(res);
 	struct resource_entry *win;
 
-	ns = of_n_size_cells(np);
-
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
 		pp->cfg0_size = resource_size(cfg_res)/2;
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
@@ -397,19 +388,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					 ret, pp->io);
 				continue;
 			}
-			pp->io_base = pp->io->start;
-
-			/* Find the untranslated IO space address */
-			pp->io_mod_base = pp->io->start;;
 			break;
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
 			pp->mem->name = "MEM";
 			pp->mem_size = resource_size(pp->mem);
 			pp->mem_bus_addr = pp->mem->start - win->offset;
-
-			/* Find the untranslated MEM space address */
-			pp->mem_mod_base = pp->mem->start;
 			break;
 		case 0:
 			pp->cfg = win->res;
@@ -417,10 +401,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->cfg1_size = resource_size(pp->cfg)/2;
 			pp->cfg0_base = pp->cfg->start;
 			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
-
-			/* Find the untranslated configuration space address */
-			pp->cfg0_mod_base = pp->cfg->start;
-			pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
 			break;
 		case IORESOURCE_BUS:
 			pp->busn = win->res;
@@ -488,7 +468,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	if (!pp->ops->rd_other_conf)
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
+					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
@@ -546,12 +526,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
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
@@ -561,7 +541,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 
 	return ret;
@@ -581,12 +561,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
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
@@ -596,7 +576,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 
 	return ret;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 41d137c..264c969 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -27,19 +27,15 @@ struct pcie_port {
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
-	u64			io_mod_base;
 	resource_size_t		io_base;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
 	u64			mem_base;
-	u64			mem_mod_base;
 	phys_addr_t		mem_bus_addr;
 	u32			mem_size;
 	struct resource		*cfg;
-- 
1.9.1

