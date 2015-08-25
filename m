Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:26944 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbHYJy1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 05:54:27 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux@arm.linux.org.uk>, <thomas.petazzoni@free-electrons.com>,
	<gabriele.paoloni@huawei.com>, <lorenzo.pieralisi@arm.com>,
	<james.morse@arm.com>, <Liviu.Dudau@arm.com>,
	<jason@lakedaemon.net>, <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <xuwei5@hisilicon.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v8 1/6] PCI: designware: move calculation of bus addresses to DRA7xx
Date: Tue, 25 Aug 2015 17:58:49 +0800
Message-ID: <1440496734-18417-2-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1440496734-18417-1-git-send-email-wangzhou1@hisilicon.com>
References: <1440496734-18417-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Commit f4c55c5a3f7f "PCI: designware: Program ATU with untranslated
address" added the calculation of PCI BUS addresses in designware,
storing them in new fields added in "struct pcie_port". This
calculation is done for every designware user even if is only
applicable to DRA7xx.
This patch moves the calculation of the bus addresses to the DRA7xx
driver and is needed to allow the rework of designware to use
the new DT parsing API.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pci-dra7xx.c      | 13 +++++++++++++
 drivers/pci/host/pcie-designware.c | 15 ++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 80db09e..18ae7ff 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -61,6 +61,7 @@
 
 #define	PCIECTRL_DRA7XX_CONF_PHY_CS			0x010C
 #define	LINK_UP						BIT(16)
+#define	CPU_TO_BUS_ADDR					0x0FFFFFFF
 
 struct dra7xx_pcie {
 	void __iomem		*base;
@@ -139,6 +140,18 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	dw_pcie_setup_rc(pp);
+
+	if (pp->io_mod_base)
+		pp->io_mod_base &= CPU_TO_BUS_ADDR;
+
+	if (pp->mem_mod_base)
+		pp->mem_mod_base &= CPU_TO_BUS_ADDR;
+
+	if (pp->cfg0_mod_base) {
+		pp->cfg0_mod_base &= CPU_TO_BUS_ADDR;
+		pp->cfg1_mod_base &= CPU_TO_BUS_ADDR;
+	}
+
 	dra7xx_pcie_establish_link(pp);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..c5d407c 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -366,14 +366,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	struct resource *cfg_res;
-	u32 val, na, ns;
+	u32 val, ns;
 	const __be32 *addrp;
 	int i, index, ret;
 
-	/* Find the address cell size and the number of cells in order to get
-	 * the untranslated address.
-	 */
-	of_property_read_u32(np, "#address-cells", &na);
 	ns = of_n_size_cells(np);
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
@@ -416,8 +412,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->io_base = range.cpu_addr;
 
 			/* Find the untranslated IO space address */
-			pp->io_mod_base = of_read_number(parser.range -
-							 parser.np + na, ns);
+			pp->io_mod_base = range.cpu_addr;
 		}
 		if (restype == IORESOURCE_MEM) {
 			of_pci_range_to_resource(&range, np, &pp->mem);
@@ -426,8 +421,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->mem_bus_addr = range.pci_addr;
 
 			/* Find the untranslated MEM space address */
-			pp->mem_mod_base = of_read_number(parser.range -
-							  parser.np + na, ns);
+			pp->mem_mod_base = range.cpu_addr;
 		}
 		if (restype == 0) {
 			of_pci_range_to_resource(&range, np, &pp->cfg);
@@ -437,8 +431,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
 
 			/* Find the untranslated configuration space address */
-			pp->cfg0_mod_base = of_read_number(parser.range -
-							   parser.np + na, ns);
+			pp->cfg0_mod_base = range.cpu_addr;
 			pp->cfg1_mod_base = pp->cfg0_mod_base +
 					    pp->cfg0_size;
 		}
-- 
1.9.1

