Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53756 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab3H1Lxz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 07:53:55 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MS80022DP1N1QV0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 28 Aug 2013 20:53:48 +0900 (KST)
From: Seungwon Jeon <tgih.jun@samsung.com>
To: linux-pci@vger.kernel.org
Cc: 'Jason Cooper' <jason@lakedaemon.net>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 3/3] PCI: mvebu: add wrapped I/O access functions
Date: Wed, 28 Aug 2013 20:53:47 +0900
Message-id: <001e01cea3e5$410cf6d0$c326e470$%jun@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

read/write operation for I/O mem is wrapped with hiding
base address inside in order to simplify the usage.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/pci/host/pci-mvebu.c |  105 +++++++++++++++++++++++++++---------------
 1 files changed, 68 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index d66530e..db8b00b 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -141,29 +141,59 @@ struct mvebu_pcie_port {
 	size_t iowin_size;
 };
 
+static inline void mvebu_writeb(struct mvebu_pcie_port *port, u8 val, u32 reg)
+{
+	writeb(val, port->base + reg);
+}
+
+static inline u8 mvebu_readb(struct mvebu_pcie_port *port, u32 reg)
+{
+	return readb(port->base + reg);
+}
+
+static inline void mvebu_writew(struct mvebu_pcie_port *port, u16 val, u32 reg)
+{
+	writew(val, port->base + reg);
+}
+
+static inline u16 mvebu_readw(struct mvebu_pcie_port *port, u32 reg)
+{
+	return readw(port->base + reg);
+}
+
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
@@ -181,33 +211,34 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
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
@@ -217,10 +248,10 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
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
@@ -232,26 +263,26 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	mvebu_pcie_setup_wins(port);
 
 	/* Master + slave enable. */
-	cmd = readw(port->base + PCIE_CMD_OFF);
+	cmd = mvebu_readw(port, PCIE_CMD_OFF);
 	cmd |= PCI_COMMAND_IO;
 	cmd |= PCI_COMMAND_MEMORY;
 	cmd |= PCI_COMMAND_MASTER;
-	writew(cmd, port->base + PCIE_CMD_OFF);
+	mvebu_writew(port, cmd, PCIE_CMD_OFF);
 
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
@@ -267,15 +298,15 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 {
 	int ret = PCIBIOS_SUCCESSFUL;
 
-	writel(PCIE_CONF_ADDR(bus->number, devfn, where),
-	       port->base + PCIE_CONF_ADDR_OFF);
+	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
+		     PCIE_CONF_ADDR_OFF);
 
 	if (size == 4)
-		writel(val, port->base + PCIE_CONF_DATA_OFF);
+		mvebu_writel(port, val, PCIE_CONF_DATA_OFF);
 	else if (size == 2)
-		writew(val, port->base + PCIE_CONF_DATA_OFF + (where & 3));
+		mvebu_writew(port, val, PCIE_CONF_DATA_OFF + (where & 3));
 	else if (size == 1)
-		writeb(val, port->base + PCIE_CONF_DATA_OFF + (where & 3));
+		mvebu_writeb(port, val, PCIE_CONF_DATA_OFF + (where & 3));
 	else
 		ret = PCIBIOS_BAD_REGISTER_NUMBER;
 
-- 
1.7.0.4


