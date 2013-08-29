Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51530 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab3H2MgR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 08:36:17 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSA00023LO58XL0@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 29 Aug 2013 21:36:11 +0900 (KST)
From: Seungwon Jeon <tgih.jun@samsung.com>
To: linux-pci@vger.kernel.org
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, 'Jason Cooper' <jason@lakedaemon.net>,
	'Bjorn Helgaas' <bhelgaas@google.com>
References: <001e01cea3e5$410cf6d0$c326e470$%jun@samsung.com>
 <20130828141417.139ad2b0@skate>
In-reply-to: <20130828141417.139ad2b0@skate>
Subject: [PATCH v2 3/3] PCI: mvebu: add wrapped I/O access functions
Date: Thu, 29 Aug 2013 21:36:10 +0900
Message-id: <001a01cea4b4$5754b200$05fe1600$%jun@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=Windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

read/write operation for I/O mem is wrapped with hiding
base address inside in order to simplify the usage.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Changes in v2:
 - Only 32-bit accessors are kept.

 drivers/pci/host/pci-mvebu.c |   97 ++++++++++++++++++++++++------------------
 1 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index d66530e..8dcd7e6 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -141,29 +141,39 @@ struct mvebu_pcie_port {
 	size_t iowin_size;
 };
 
+static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
+{
+	writel(val, port->base + reg);
+}
+
+static inline u32 mvebu_readl(struct mvebu_pcie_port *port, u32 reg)
+{
+	return readl(port->base + reg);
+}
+
 static bool mvebu_pcie_link_up(struct mvebu_pcie_port *port)
 {
-	return !(readl(port->base + PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
+	return !(mvebu_readl(port, PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
 }
 
 static void mvebu_pcie_set_local_bus_nr(struct mvebu_pcie_port *port, int nr)
 {
 	u32 stat;
 
-	stat = readl(port->base + PCIE_STAT_OFF);
+	stat = mvebu_readl(port, PCIE_STAT_OFF);
 	stat &= ~PCIE_STAT_BUS;
 	stat |= nr << 8;
-	writel(stat, port->base + PCIE_STAT_OFF);
+	mvebu_writel(port, stat, PCIE_STAT_OFF);
 }
 
 static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 {
 	u32 stat;
 
-	stat = readl(port->base + PCIE_STAT_OFF);
+	stat = mvebu_readl(port, PCIE_STAT_OFF);
 	stat &= ~PCIE_STAT_DEV;
 	stat |= nr << 16;
-	writel(stat, port->base + PCIE_STAT_OFF);
+	mvebu_writel(port, stat, PCIE_STAT_OFF);
 }
 
 /*
@@ -181,33 +191,34 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 	/* First, disable and clear BARs and windows. */
 	for (i = 1; i < 3; i++) {
-		writel(0, port->base + PCIE_BAR_CTRL_OFF(i));
-		writel(0, port->base + PCIE_BAR_LO_OFF(i));
-		writel(0, port->base + PCIE_BAR_HI_OFF(i));
+		mvebu_writel(port, 0, PCIE_BAR_CTRL_OFF(i));
+		mvebu_writel(port, 0, PCIE_BAR_LO_OFF(i));
+		mvebu_writel(port, 0, PCIE_BAR_HI_OFF(i));
 	}
 
 	for (i = 0; i < 5; i++) {
-		writel(0, port->base + PCIE_WIN04_CTRL_OFF(i));
-		writel(0, port->base + PCIE_WIN04_BASE_OFF(i));
-		writel(0, port->base + PCIE_WIN04_REMAP_OFF(i));
+		mvebu_writel(port, 0, PCIE_WIN04_CTRL_OFF(i));
+		mvebu_writel(port, 0, PCIE_WIN04_BASE_OFF(i));
+		mvebu_writel(port, 0, PCIE_WIN04_REMAP_OFF(i));
 	}
 
-	writel(0, port->base + PCIE_WIN5_CTRL_OFF);
-	writel(0, port->base + PCIE_WIN5_BASE_OFF);
-	writel(0, port->base + PCIE_WIN5_REMAP_OFF);
+	mvebu_writel(port, 0, PCIE_WIN5_CTRL_OFF);
+	mvebu_writel(port, 0, PCIE_WIN5_BASE_OFF);
+	mvebu_writel(port, 0, PCIE_WIN5_REMAP_OFF);
 
 	/* Setup windows for DDR banks.  Count total DDR size on the fly. */
 	size = 0;
 	for (i = 0; i < dram->num_cs; i++) {
 		const struct mbus_dram_window *cs = dram->cs + i;
 
-		writel(cs->base & 0xffff0000,
-		       port->base + PCIE_WIN04_BASE_OFF(i));
-		writel(0, port->base + PCIE_WIN04_REMAP_OFF(i));
-		writel(((cs->size - 1) & 0xffff0000) |
-			(cs->mbus_attr << 8) |
-			(dram->mbus_dram_target_id << 4) | 1,
-		       port->base + PCIE_WIN04_CTRL_OFF(i));
+		mvebu_writel(port, cs->base & 0xffff0000,
+			     PCIE_WIN04_BASE_OFF(i));
+		mvebu_writel(port, 0, PCIE_WIN04_REMAP_OFF(i));
+		mvebu_writel(port,
+			     ((cs->size - 1) & 0xffff0000) |
+			     (cs->mbus_attr << 8) |
+			     (dram->mbus_dram_target_id << 4) | 1,
+			     PCIE_WIN04_CTRL_OFF(i));
 
 		size += cs->size;
 	}
@@ -217,41 +228,40 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 		size = 1 << fls(size);
 
 	/* Setup BAR[1] to all DRAM banks. */
-	writel(dram->cs[0].base, port->base + PCIE_BAR_LO_OFF(1));
-	writel(0, port->base + PCIE_BAR_HI_OFF(1));
-	writel(((size - 1) & 0xffff0000) | 1,
-	       port->base + PCIE_BAR_CTRL_OFF(1));
+	mvebu_writel(port, dram->cs[0].base, PCIE_BAR_LO_OFF(1));
+	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
+	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
+		     PCIE_BAR_CTRL_OFF(1));
 }
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u16 cmd;
-	u32 mask;
+	u32 cmd, mask;
 
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
 
 	/* Master + slave enable. */
-	cmd = readw(port->base + PCIE_CMD_OFF);
+	cmd = mvebu_readl(port, PCIE_CMD_OFF);
 	cmd |= PCI_COMMAND_IO;
 	cmd |= PCI_COMMAND_MEMORY;
 	cmd |= PCI_COMMAND_MASTER;
-	writew(cmd, port->base + PCIE_CMD_OFF);
+	mvebu_writel(port, cmd, PCIE_CMD_OFF);
 
 	/* Enable interrupt lines A-D. */
-	mask = readl(port->base + PCIE_MASK_OFF);
+	mask = mvebu_readl(port, PCIE_MASK_OFF);
 	mask |= PCIE_MASK_ENABLE_INTS;
-	writel(mask, port->base + PCIE_MASK_OFF);
+	mvebu_writel(port, mask, PCIE_MASK_OFF);
 }
 
 static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
 				 struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 *val)
 {
-	writel(PCIE_CONF_ADDR(bus->number, devfn, where),
-	       port->base + PCIE_CONF_ADDR_OFF);
+	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
+		     PCIE_CONF_ADDR_OFF);
 
-	*val = readl(port->base + PCIE_CONF_DATA_OFF);
+	*val = mvebu_readl(port, PCIE_CONF_DATA_OFF);
 
 	if (size == 1)
 		*val = (*val >> (8 * (where & 3))) & 0xff;
@@ -265,21 +275,24 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 				 struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 val)
 {
-	int ret = PCIBIOS_SUCCESSFUL;
+	u32 _val, shift = 8 * (where & 3);
 
-	writel(PCIE_CONF_ADDR(bus->number, devfn, where),
-	       port->base + PCIE_CONF_ADDR_OFF);
+	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
+		     PCIE_CONF_ADDR_OFF);
+	_val = mvebu_readl(port, PCIE_CONF_DATA_OFF);
 
 	if (size == 4)
-		writel(val, port->base + PCIE_CONF_DATA_OFF);
+		_val = val;
 	else if (size == 2)
-		writew(val, port->base + PCIE_CONF_DATA_OFF + (where & 3));
+		_val = (_val & ~(0xffff << shift)) | ((val & 0xffff) << shift);
 	else if (size == 1)
-		writeb(val, port->base + PCIE_CONF_DATA_OFF + (where & 3));
+		_val = (_val & ~(0xff << shift)) | ((val & 0xff) << shift);
 	else
-		ret = PCIBIOS_BAD_REGISTER_NUMBER;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	return ret;
+	mvebu_writel(port, _val, PCIE_CONF_DATA_OFF);
+
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
-- 
1.7.0.4


