Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:15912 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab3H1Lxd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 07:53:33 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MS8004BVP140NI0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 28 Aug 2013 20:53:31 +0900 (KST)
From: Seungwon Jeon <tgih.jun@samsung.com>
To: linux-pci@vger.kernel.org
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>
Subject: [PATCH 1/3] PCI: dw_pcie: amend I/O access functions
Date: Wed, 28 Aug 2013 20:53:30 +0900
Message-id: <001c01cea3e5$37716660$a6543320$%jun@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This changes puts the 'dbi_base' into dw_pcie_readl_rc/
dw_pcie_writel_rc. So usage of these funcions doesn't
need to consider I/O base adddress anymore.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/pci/host/pcie-designware.c |  135 +++++++++++++++---------------------
 1 files changed, 55 insertions(+), 80 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 77b0c25..c10e9ac 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -99,22 +99,20 @@ int cfg_write(void __iomem *addr, int where, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static inline void dw_pcie_readl_rc(struct pcie_port *pp,
-				void __iomem *dbi_addr, u32 *val)
+static inline void dw_pcie_readl_rc(struct pcie_port *pp, u32 reg, u32 *val)
 {
 	if (pp->ops->readl_rc)
-		pp->ops->readl_rc(pp, dbi_addr, val);
+		pp->ops->readl_rc(pp, pp->dbi_base + reg, val);
 	else
-		*val = readl(dbi_addr);
+		*val = readl(pp->dbi_base + reg);
 }
 
-static inline void dw_pcie_writel_rc(struct pcie_port *pp,
-				u32 val, void __iomem *dbi_addr)
+static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
 {
 	if (pp->ops->writel_rc)
-		pp->ops->writel_rc(pp, val, dbi_addr);
+		pp->ops->writel_rc(pp, val, pp->dbi_base + reg);
 	else
-		writel(val, dbi_addr);
+		writel(val, pp->dbi_base + reg);
 }
 
 int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
@@ -251,86 +249,64 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
 {
-	u32 val;
-	void __iomem *dbi_base = pp->dbi_base;
-
 	/* Program viewport 0 : OUTBOUND : CFG0 */
-	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, pp->cfg0_base, dbi_base + PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->cfg0_base >> 32),
-			dbi_base + PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
+			  PCIE_ATU_VIEWPORT);
+	dw_pcie_writel_rc(pp, pp->cfg0_base, PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, (pp->cfg0_base >> 32), PCIE_ATU_UPPER_BASE);
 	dw_pcie_writel_rc(pp, pp->cfg0_base + pp->config.cfg0_size - 1,
-			dbi_base + PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, busdev, dbi_base + PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
-	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG0, dbi_base + PCIE_ATU_CR1);
-	val = PCIE_ATU_ENABLE;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
+			  PCIE_ATU_LIMIT);
+	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
+	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
+	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG0, PCIE_ATU_CR1);
+	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
 }
 
 static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
 {
-	u32 val;
-	void __iomem *dbi_base = pp->dbi_base;
-
 	/* Program viewport 1 : OUTBOUND : CFG1 */
-	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, dbi_base + PCIE_ATU_CR1);
-	val = PCIE_ATU_ENABLE;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
-	dw_pcie_writel_rc(pp, pp->cfg1_base, dbi_base + PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->cfg1_base >> 32),
-			dbi_base + PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
+			  PCIE_ATU_VIEWPORT);
+	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
+	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+	dw_pcie_writel_rc(pp, pp->cfg1_base, PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, (pp->cfg1_base >> 32), PCIE_ATU_UPPER_BASE);
 	dw_pcie_writel_rc(pp, pp->cfg1_base + pp->config.cfg1_size - 1,
-			dbi_base + PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, busdev, dbi_base + PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
+			  PCIE_ATU_LIMIT);
+	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
+	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
 }
 
 static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
 {
-	u32 val;
-	void __iomem *dbi_base = pp->dbi_base;
-
 	/* Program viewport 0 : OUTBOUND : MEM */
-	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, dbi_base + PCIE_ATU_CR1);
-	val = PCIE_ATU_ENABLE;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
-	dw_pcie_writel_rc(pp, pp->mem_base, dbi_base + PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->mem_base >> 32),
-			dbi_base + PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
+			  PCIE_ATU_VIEWPORT);
+	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
+	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+	dw_pcie_writel_rc(pp, pp->mem_base, PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, (pp->mem_base >> 32), PCIE_ATU_UPPER_BASE);
 	dw_pcie_writel_rc(pp, pp->mem_base + pp->config.mem_size - 1,
-			dbi_base + PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, pp->config.mem_bus_addr,
-			dbi_base + PCIE_ATU_LOWER_TARGET);
+			  PCIE_ATU_LIMIT);
+	dw_pcie_writel_rc(pp, pp->config.mem_bus_addr, PCIE_ATU_LOWER_TARGET);
 	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.mem_bus_addr),
-			dbi_base + PCIE_ATU_UPPER_TARGET);
+			  PCIE_ATU_UPPER_TARGET);
 }
 
 static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
 {
-	u32 val;
-	void __iomem *dbi_base = pp->dbi_base;
-
 	/* Program viewport 1 : OUTBOUND : IO */
-	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, dbi_base + PCIE_ATU_CR1);
-	val = PCIE_ATU_ENABLE;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
-	dw_pcie_writel_rc(pp, pp->io_base, dbi_base + PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->io_base >> 32),
-			dbi_base + PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
+			  PCIE_ATU_VIEWPORT);
+	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
+	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+	dw_pcie_writel_rc(pp, pp->io_base, PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, (pp->io_base >> 32), PCIE_ATU_UPPER_BASE);
 	dw_pcie_writel_rc(pp, pp->io_base + pp->config.io_size - 1,
-			dbi_base + PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, pp->config.io_bus_addr,
-			dbi_base + PCIE_ATU_LOWER_TARGET);
+			  PCIE_ATU_LIMIT);
+	dw_pcie_writel_rc(pp, pp->config.io_bus_addr, PCIE_ATU_LOWER_TARGET);
 	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.io_bus_addr),
-			dbi_base + PCIE_ATU_UPPER_TARGET);
+			  PCIE_ATU_UPPER_TARGET);
 }
 
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
@@ -518,13 +494,12 @@ static struct hw_pci dw_pci = {
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	struct pcie_port_info *config = &pp->config;
-	void __iomem *dbi_base = pp->dbi_base;
 	u32 val;
 	u32 membase;
 	u32 memlimit;
 
 	/* set the number of lines as 4 */
-	dw_pcie_readl_rc(pp, dbi_base + PCIE_PORT_LINK_CONTROL, &val);
+	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
 	val &= ~PORT_LINK_MODE_MASK;
 	switch (pp->lanes) {
 	case 1:
@@ -537,10 +512,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		val |= PORT_LINK_MODE_4_LANES;
 		break;
 	}
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_PORT_LINK_CONTROL);
+	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
 
 	/* set link width speed control register */
-	dw_pcie_readl_rc(pp, dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL, &val);
+	dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, &val);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
 	switch (pp->lanes) {
 	case 1:
@@ -553,36 +528,36 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
 		break;
 	}
-	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
 
 	/* setup RC BARs */
-	dw_pcie_writel_rc(pp, 0x00000004, dbi_base + PCI_BASE_ADDRESS_0);
-	dw_pcie_writel_rc(pp, 0x00000004, dbi_base + PCI_BASE_ADDRESS_1);
+	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
+	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_1);
 
 	/* setup interrupt pins */
-	dw_pcie_readl_rc(pp, dbi_base + PCI_INTERRUPT_LINE, &val);
+	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCI_INTERRUPT_LINE);
+	dw_pcie_writel_rc(pp, val, PCI_INTERRUPT_LINE);
 
 	/* setup bus numbers */
-	dw_pcie_readl_rc(pp, dbi_base + PCI_PRIMARY_BUS, &val);
+	dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS, &val);
 	val &= 0xff000000;
 	val |= 0x00010100;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCI_PRIMARY_BUS);
+	dw_pcie_writel_rc(pp, val, PCI_PRIMARY_BUS);
 
 	/* setup memory base, memory limit */
 	membase = ((u32)pp->mem_base & 0xfff00000) >> 16;
 	memlimit = (config->mem_size + (u32)pp->mem_base) & 0xfff00000;
 	val = memlimit | membase;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCI_MEMORY_BASE);
+	dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
 
 	/* setup command register */
-	dw_pcie_readl_rc(pp, dbi_base + PCI_COMMAND, &val);
+	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
-	dw_pcie_writel_rc(pp, val, dbi_base + PCI_COMMAND);
+	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
 }
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
-- 
1.7.0.4


