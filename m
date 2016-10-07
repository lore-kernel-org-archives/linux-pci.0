Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938918AbcJGQYV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:24:21 -0400
Subject: [PATCH 1/2] PCI: mvebu: Swap order of mvebu_writel() reg/val
 arguments
To: Jason Cooper <jason@lakedaemon.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:24:16 -0500
Message-ID: <20161007162416.23224.35628.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of mvebu_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c |   64 ++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 307f81d..9243dcd 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -157,12 +157,12 @@ struct mvebu_pcie_port {
 	u32 saved_pcie_stat;
 };
 
-static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
+static void mvebu_writel(struct mvebu_pcie_port *port, u32 reg, u32 val)
 {
 	writel(val, port->base + reg);
 }
 
-static inline u32 mvebu_readl(struct mvebu_pcie_port *port, u32 reg)
+static u32 mvebu_readl(struct mvebu_pcie_port *port, u32 reg)
 {
 	return readl(port->base + reg);
 }
@@ -184,7 +184,7 @@ static void mvebu_pcie_set_local_bus_nr(struct mvebu_pcie_port *port, int nr)
 	stat = mvebu_readl(port, PCIE_STAT_OFF);
 	stat &= ~PCIE_STAT_BUS;
 	stat |= nr << 8;
-	mvebu_writel(port, stat, PCIE_STAT_OFF);
+	mvebu_writel(port, PCIE_STAT_OFF, stat);
 }
 
 static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
@@ -194,7 +194,7 @@ static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 	stat = mvebu_readl(port, PCIE_STAT_OFF);
 	stat &= ~PCIE_STAT_DEV;
 	stat |= nr << 16;
-	mvebu_writel(port, stat, PCIE_STAT_OFF);
+	mvebu_writel(port, PCIE_STAT_OFF, stat);
 }
 
 /*
@@ -212,34 +212,33 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 	/* First, disable and clear BARs and windows. */
 	for (i = 1; i < 3; i++) {
-		mvebu_writel(port, 0, PCIE_BAR_CTRL_OFF(i));
-		mvebu_writel(port, 0, PCIE_BAR_LO_OFF(i));
-		mvebu_writel(port, 0, PCIE_BAR_HI_OFF(i));
+		mvebu_writel(port, PCIE_BAR_CTRL_OFF(i), 0);
+		mvebu_writel(port, PCIE_BAR_LO_OFF(i), 0);
+		mvebu_writel(port, PCIE_BAR_HI_OFF(i), 0);
 	}
 
 	for (i = 0; i < 5; i++) {
-		mvebu_writel(port, 0, PCIE_WIN04_CTRL_OFF(i));
-		mvebu_writel(port, 0, PCIE_WIN04_BASE_OFF(i));
-		mvebu_writel(port, 0, PCIE_WIN04_REMAP_OFF(i));
+		mvebu_writel(port, PCIE_WIN04_CTRL_OFF(i), 0);
+		mvebu_writel(port, PCIE_WIN04_BASE_OFF(i), 0);
+		mvebu_writel(port, PCIE_WIN04_REMAP_OFF(i), 0);
 	}
 
-	mvebu_writel(port, 0, PCIE_WIN5_CTRL_OFF);
-	mvebu_writel(port, 0, PCIE_WIN5_BASE_OFF);
-	mvebu_writel(port, 0, PCIE_WIN5_REMAP_OFF);
+	mvebu_writel(port, PCIE_WIN5_CTRL_OFF, 0);
+	mvebu_writel(port, PCIE_WIN5_BASE_OFF, 0);
+	mvebu_writel(port, PCIE_WIN5_REMAP_OFF, 0);
 
 	/* Setup windows for DDR banks.  Count total DDR size on the fly. */
 	size = 0;
 	for (i = 0; i < dram->num_cs; i++) {
 		const struct mbus_dram_window *cs = dram->cs + i;
 
-		mvebu_writel(port, cs->base & 0xffff0000,
-			     PCIE_WIN04_BASE_OFF(i));
-		mvebu_writel(port, 0, PCIE_WIN04_REMAP_OFF(i));
-		mvebu_writel(port,
+		mvebu_writel(port, PCIE_WIN04_BASE_OFF(i),
+			     cs->base & 0xffff0000);
+		mvebu_writel(port, PCIE_WIN04_REMAP_OFF(i), 0);
+		mvebu_writel(port, PCIE_WIN04_CTRL_OFF(i),
 			     ((cs->size - 1) & 0xffff0000) |
 			     (cs->mbus_attr << 8) |
-			     (dram->mbus_dram_target_id << 4) | 1,
-			     PCIE_WIN04_CTRL_OFF(i));
+			     (dram->mbus_dram_target_id << 4) | 1);
 
 		size += cs->size;
 	}
@@ -249,10 +248,9 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 		size = 1 << fls(size);
 
 	/* Setup BAR[1] to all DRAM banks. */
-	mvebu_writel(port, dram->cs[0].base, PCIE_BAR_LO_OFF(1));
-	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
-	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
-		     PCIE_BAR_CTRL_OFF(1));
+	mvebu_writel(port, PCIE_BAR_LO_OFF(1), dram->cs[0].base);
+	mvebu_writel(port, PCIE_BAR_HI_OFF(1), 0);
+	mvebu_writel(port, PCIE_BAR_CTRL_OFF(1), ((size - 1) & 0xffff0000) | 1);
 }
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
@@ -267,12 +265,12 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	cmd |= PCI_COMMAND_IO;
 	cmd |= PCI_COMMAND_MEMORY;
 	cmd |= PCI_COMMAND_MASTER;
-	mvebu_writel(port, cmd, PCIE_CMD_OFF);
+	mvebu_writel(port, PCIE_CMD_OFF, cmd);
 
 	/* Enable interrupt lines A-D. */
 	mask = mvebu_readl(port, PCIE_MASK_OFF);
 	mask |= PCIE_MASK_ENABLE_INTS;
-	mvebu_writel(port, mask, PCIE_MASK_OFF);
+	mvebu_writel(port, PCIE_MASK_OFF, mask);
 }
 
 static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
@@ -281,8 +279,8 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
 {
 	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
 
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-		     PCIE_CONF_ADDR_OFF);
+	mvebu_writel(port, PCIE_CONF_ADDR_OFF,
+		     PCIE_CONF_ADDR(bus->number, devfn, where));
 
 	switch (size) {
 	case 1:
@@ -305,8 +303,8 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 {
 	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
 
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-		     PCIE_CONF_ADDR_OFF);
+	mvebu_writel(port, PCIE_CONF_ADDR_OFF,
+		     PCIE_CONF_ADDR(bus->number, devfn, where));
 
 	switch (size) {
 	case 1:
@@ -717,7 +715,7 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 		if (mask == 0xffff0000)
 			value &= 0xffff;
 
-		mvebu_writel(port, value, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL);
+		mvebu_writel(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL, value);
 		break;
 
 	case PCISWCAP_EXP_LNKCTL:
@@ -738,11 +736,11 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 		if (mask == 0xffff0000)
 			value &= 0xffff;
 
-		mvebu_writel(port, value, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
+		mvebu_writel(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL, value);
 		break;
 
 	case PCISWCAP_EXP_RTSTA:
-		mvebu_writel(port, value, PCIE_RC_RTSTA);
+		mvebu_writel(port, PCIE_RC_RTSTA, value);
 		break;
 
 	default:
@@ -1025,7 +1023,7 @@ static int mvebu_pcie_resume(struct device *dev)
 	pcie = dev_get_drvdata(dev);
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = pcie->ports + i;
-		mvebu_writel(port, port->saved_pcie_stat, PCIE_STAT_OFF);
+		mvebu_writel(port, PCIE_STAT_OFF, port->saved_pcie_stat);
 		mvebu_pcie_setup_hw(port);
 	}
 

