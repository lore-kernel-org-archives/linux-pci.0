Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938862AbcJGQZB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:25:01 -0400
Subject: [PATCH 02/10] PCI: rcar: Name private struct pointer "rcar"
 consistently
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:24:54 -0500
Message-ID: <20161007162454.23279.54428.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "rcar", for struct rcar_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |  388 +++++++++++++++++++++---------------------
 1 file changed, 194 insertions(+), 194 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index b6899c8..145b54d 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -152,15 +152,15 @@ struct rcar_pcie {
 	struct			rcar_msi msi;
 };
 
-static unsigned long rcar_readl(struct rcar_pcie *pcie, unsigned long reg)
+static unsigned long rcar_readl(struct rcar_pcie *rcar, unsigned long reg)
 {
-	return readl(pcie->base + reg);
+	return readl(rcar->base + reg);
 }
 
-static void rcar_writel(struct rcar_pcie *pcie, unsigned long val,
+static void rcar_writel(struct rcar_pcie *rcar, unsigned long val,
 			unsigned long reg)
 {
-	writel(val, pcie->base + reg);
+	writel(val, rcar->base + reg);
 }
 
 enum {
@@ -168,26 +168,26 @@ enum {
 	RCAR_PCI_ACCESS_WRITE,
 };
 
-static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
+static void rcar_rmw32(struct rcar_pcie *rcar, int where, u32 mask, u32 data)
 {
 	int shift = 8 * (where & 3);
-	u32 val = rcar_readl(pcie, where & ~3);
+	u32 val = rcar_readl(rcar, where & ~3);
 
 	val &= ~(mask << shift);
 	val |= data << shift;
-	rcar_writel(pcie, val, where & ~3);
+	rcar_writel(rcar, val, where & ~3);
 }
 
-static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
+static u32 rcar_read_conf(struct rcar_pcie *rcar, int where)
 {
 	int shift = 8 * (where & 3);
-	u32 val = rcar_readl(pcie, where & ~3);
+	u32 val = rcar_readl(rcar, where & ~3);
 
 	return val >> shift;
 }
 
 /* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
-static int rcar_pcie_config_access(struct rcar_pcie *pcie,
+static int rcar_pcie_config_access(struct rcar_pcie *rcar,
 		unsigned char access_type, struct pci_bus *bus,
 		unsigned int devfn, int where, u32 *data)
 {
@@ -218,50 +218,50 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 		if (access_type == RCAR_PCI_ACCESS_READ) {
-			*data = rcar_readl(pcie, PCICONF(index));
+			*data = rcar_readl(rcar, PCICONF(index));
 		} else {
 			/* Keep an eye out for changes to the root bus number */
 			if (pci_is_root_bus(bus) && (reg == PCI_PRIMARY_BUS))
-				pcie->root_bus_nr = *data & 0xff;
+				rcar->root_bus_nr = *data & 0xff;
 
-			rcar_writel(pcie, *data, PCICONF(index));
+			rcar_writel(rcar, *data, PCICONF(index));
 		}
 
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	if (pcie->root_bus_nr < 0)
+	if (rcar->root_bus_nr < 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Clear errors */
-	rcar_writel(pcie, rcar_readl(pcie, PCIEERRFR), PCIEERRFR);
+	rcar_writel(rcar, rcar_readl(rcar, PCIEERRFR), PCIEERRFR);
 
 	/* Set the PIO address */
-	rcar_writel(pcie, PCIE_CONF_BUS(bus->number) |
+	rcar_writel(rcar, PCIE_CONF_BUS(bus->number) |
 		    PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
 
 	/* Enable the configuration access */
-	if (bus->parent->number == pcie->root_bus_nr)
-		rcar_writel(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
+	if (bus->parent->number == rcar->root_bus_nr)
+		rcar_writel(rcar, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
 	else
-		rcar_writel(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
+		rcar_writel(rcar, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
 
 	/* Check for errors */
-	if (rcar_readl(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
+	if (rcar_readl(rcar, PCIEERRFR) & UNSUPPORTED_REQUEST)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Check for master and target aborts */
-	if (rcar_read_conf(pcie, RCONF(PCI_STATUS)) &
+	if (rcar_read_conf(rcar, RCONF(PCI_STATUS)) &
 		(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (access_type == RCAR_PCI_ACCESS_READ)
-		*data = rcar_readl(pcie, PCIECDR);
+		*data = rcar_readl(rcar, PCIECDR);
 	else
-		rcar_writel(pcie, *data, PCIECDR);
+		rcar_writel(rcar, *data, PCIECDR);
 
 	/* Disable the configuration access */
-	rcar_writel(pcie, 0, PCIECCTLR);
+	rcar_writel(rcar, 0, PCIECCTLR);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -269,10 +269,10 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 			       int where, int size, u32 *val)
 {
-	struct rcar_pcie *pcie = bus->sysdata;
+	struct rcar_pcie *rcar = bus->sysdata;
 	int ret;
 
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
+	ret = rcar_pcie_config_access(rcar, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, val);
 	if (ret != PCIBIOS_SUCCESSFUL) {
 		*val = 0xffffffff;
@@ -294,11 +294,11 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
-	struct rcar_pcie *pcie = bus->sysdata;
+	struct rcar_pcie *rcar = bus->sysdata;
 	int shift, ret;
 	u32 data;
 
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
+	ret = rcar_pcie_config_access(rcar, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
@@ -317,7 +317,7 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 	} else
 		data = val;
 
-	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_WRITE,
+	ret = rcar_pcie_config_access(rcar, RCAR_PCI_ACCESS_WRITE,
 				      bus, devfn, where, &data);
 
 	return ret;
@@ -328,7 +328,7 @@ static struct pci_ops rcar_pcie_ops = {
 	.write	= rcar_pcie_write_conf,
 };
 
-static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
+static void rcar_pcie_setup_window(int win, struct rcar_pcie *rcar,
 				   struct resource *res)
 {
 	/* Setup PCIe address space mappings for each resource */
@@ -336,7 +336,7 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	resource_size_t res_start;
 	u32 mask;
 
-	rcar_writel(pcie, 0x00000000, PCIEPTCTLR(win));
+	rcar_writel(rcar, 0x00000000, PCIEPTCTLR(win));
 
 	/*
 	 * The PAMR mask is calculated in units of 128Bytes, which
@@ -344,22 +344,22 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	 */
 	size = resource_size(res);
 	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
-	rcar_writel(pcie, mask << 7, PCIEPAMR(win));
+	rcar_writel(rcar, mask << 7, PCIEPAMR(win));
 
 	if (res->flags & IORESOURCE_IO)
 		res_start = pci_pio_to_address(res->start);
 	else
 		res_start = res->start;
 
-	rcar_writel(pcie, upper_32_bits(res_start), PCIEPAUR(win));
-	rcar_writel(pcie, lower_32_bits(res_start) & ~0x7F, PCIEPALR(win));
+	rcar_writel(rcar, upper_32_bits(res_start), PCIEPAUR(win));
+	rcar_writel(rcar, lower_32_bits(res_start) & ~0x7F, PCIEPALR(win));
 
 	/* First resource is for IO */
 	mask = PAR_ENABLE;
 	if (res->flags & IORESOURCE_IO)
 		mask |= IO_SPACE;
 
-	rcar_writel(pcie, mask, PCIEPTCTLR(win));
+	rcar_writel(rcar, mask, PCIEPTCTLR(win));
 }
 
 static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
@@ -393,45 +393,45 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
 	return 1;
 }
 
-static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
+static void rcar_pcie_force_speedup(struct rcar_pcie *rcar)
 {
 	unsigned int timeout = 1000;
 	u32 macsr;
 
-	if ((rcar_readl(pcie, MACS2R) & LINK_SPEED) != LINK_SPEED_5_0GTS)
+	if ((rcar_readl(rcar, MACS2R) & LINK_SPEED) != LINK_SPEED_5_0GTS)
 		return;
 
-	if (rcar_readl(pcie, MACCTLR) & SPEED_CHANGE) {
-		dev_err(pcie->dev, "Speed change already in progress\n");
+	if (rcar_readl(rcar, MACCTLR) & SPEED_CHANGE) {
+		dev_err(rcar->dev, "Speed change already in progress\n");
 		return;
 	}
 
-	macsr = rcar_readl(pcie, MACSR);
+	macsr = rcar_readl(rcar, MACSR);
 	if ((macsr & LINK_SPEED) == LINK_SPEED_5_0GTS)
 		goto done;
 
 	/* Set target link speed to 5.0 GT/s */
-	rcar_rmw32(pcie, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
+	rcar_rmw32(rcar, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
 		   PCI_EXP_LNKSTA_CLS_5_0GB);
 
 	/* Set speed change reason as intentional factor */
-	rcar_rmw32(pcie, MACCGSPSETR, SPCNGRSN, 0);
+	rcar_rmw32(rcar, MACCGSPSETR, SPCNGRSN, 0);
 
 	/* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
 	if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
-		rcar_writel(pcie, macsr, MACSR);
+		rcar_writel(rcar, macsr, MACSR);
 
 	/* Start link speed change */
-	rcar_rmw32(pcie, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
+	rcar_rmw32(rcar, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
 
 	while (timeout--) {
-		macsr = rcar_readl(pcie, MACSR);
+		macsr = rcar_readl(rcar, MACSR);
 		if (macsr & SPCHGFIN) {
 			/* Clear the interrupt bits */
-			rcar_writel(pcie, macsr, MACSR);
+			rcar_writel(rcar, macsr, MACSR);
 
 			if (macsr & SPCHGFAIL)
-				dev_err(pcie->dev, "Speed change failed\n");
+				dev_err(rcar->dev, "Speed change failed\n");
 
 			goto done;
 		}
@@ -439,34 +439,34 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 		msleep(1);
 	};
 
-	dev_err(pcie->dev, "Speed change timed out\n");
+	dev_err(rcar->dev, "Speed change timed out\n");
 
 done:
-	dev_info(pcie->dev, "Current link speed is %s GT/s\n",
+	dev_info(rcar->dev, "Current link speed is %s GT/s\n",
 		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
 }
 
-static int rcar_pcie_enable(struct rcar_pcie *pcie)
+static int rcar_pcie_enable(struct rcar_pcie *rcar)
 {
 	struct pci_bus *bus, *child;
 	LIST_HEAD(res);
 
 	/* Try setting 5 GT/s link speed */
-	rcar_pcie_force_speedup(pcie);
+	rcar_pcie_force_speedup(rcar);
 
-	rcar_pcie_setup(&res, pcie);
+	rcar_pcie_setup(&res, rcar);
 
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bus = pci_scan_root_bus_msi(pcie->dev, pcie->root_bus_nr,
-				&rcar_pcie_ops, pcie, &res, &pcie->msi.chip);
+		bus = pci_scan_root_bus_msi(rcar->dev, rcar->root_bus_nr,
+				&rcar_pcie_ops, rcar, &res, &rcar->msi.chip);
 	else
-		bus = pci_scan_root_bus(pcie->dev, pcie->root_bus_nr,
-				&rcar_pcie_ops, pcie, &res);
+		bus = pci_scan_root_bus(rcar->dev, rcar->root_bus_nr,
+				&rcar_pcie_ops, rcar, &res);
 
 	if (!bus) {
-		dev_err(pcie->dev, "Scanning rootbus failed");
+		dev_err(rcar->dev, "Scanning rootbus failed");
 		return -ENODEV;
 	}
 
@@ -483,23 +483,23 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 	return 0;
 }
 
-static int phy_wait_for_ack(struct rcar_pcie *pcie)
+static int phy_wait_for_ack(struct rcar_pcie *rcar)
 {
 	unsigned int timeout = 100;
 
 	while (timeout--) {
-		if (rcar_readl(pcie, H1_PCIEPHYADRR) & PHY_ACK)
+		if (rcar_readl(rcar, H1_PCIEPHYADRR) & PHY_ACK)
 			return 0;
 
 		udelay(100);
 	}
 
-	dev_err(pcie->dev, "Access to PCIe phy timed out\n");
+	dev_err(rcar->dev, "Access to PCIe phy timed out\n");
 
 	return -ETIMEDOUT;
 }
 
-static void phy_write_reg(struct rcar_pcie *pcie,
+static void phy_write_reg(struct rcar_pcie *rcar,
 				 unsigned int rate, unsigned int addr,
 				 unsigned int lane, unsigned int data)
 {
@@ -511,26 +511,26 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 		((addr & 0xff) << ADR_POS);
 
 	/* Set write data */
-	rcar_writel(pcie, data, H1_PCIEPHYDOUTR);
-	rcar_writel(pcie, phyaddr, H1_PCIEPHYADRR);
+	rcar_writel(rcar, data, H1_PCIEPHYDOUTR);
+	rcar_writel(rcar, phyaddr, H1_PCIEPHYADRR);
 
 	/* Ignore errors as they will be dealt with if the data link is down */
-	phy_wait_for_ack(pcie);
+	phy_wait_for_ack(rcar);
 
 	/* Clear command */
-	rcar_writel(pcie, 0, H1_PCIEPHYDOUTR);
-	rcar_writel(pcie, 0, H1_PCIEPHYADRR);
+	rcar_writel(rcar, 0, H1_PCIEPHYDOUTR);
+	rcar_writel(rcar, 0, H1_PCIEPHYADRR);
 
 	/* Ignore errors as they will be dealt with if the data link is down */
-	phy_wait_for_ack(pcie);
+	phy_wait_for_ack(rcar);
 }
 
-static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
+static int rcar_pcie_wait_for_dl(struct rcar_pcie *rcar)
 {
 	unsigned int timeout = 10;
 
 	while (timeout--) {
-		if ((rcar_readl(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
+		if ((rcar_readl(rcar, PCIETSTR) & DATA_LINK_ACTIVE))
 			return 0;
 
 		msleep(5);
@@ -539,95 +539,95 @@ static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
-static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
+static int rcar_pcie_hw_init(struct rcar_pcie *rcar)
 {
 	int err;
 
 	/* Begin initialization */
-	rcar_writel(pcie, 0, PCIETCTLR);
+	rcar_writel(rcar, 0, PCIETCTLR);
 
 	/* Set mode */
-	rcar_writel(pcie, 1, PCIEMSR);
+	rcar_writel(rcar, 1, PCIEMSR);
 
 	/*
 	 * Initial header for port config space is type 1, set the device
 	 * class to match. Hardware takes care of propagating the IDSETR
 	 * settings, so there is no need to bother with a quirk.
 	 */
-	rcar_writel(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
+	rcar_writel(rcar, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
 
 	/*
 	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
 	 * they aren't used, to avoid bridge being detected as broken.
 	 */
-	rcar_rmw32(pcie, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
-	rcar_rmw32(pcie, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
+	rcar_rmw32(rcar, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
+	rcar_rmw32(rcar, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
 
 	/* Initialize default capabilities. */
-	rcar_rmw32(pcie, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_FLAGS),
+	rcar_rmw32(rcar, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
+	rcar_rmw32(rcar, REXPCAP(PCI_EXP_FLAGS),
 		PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
-	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
+	rcar_rmw32(rcar, RCONF(PCI_HEADER_TYPE), 0x7f,
 		PCI_HEADER_TYPE_BRIDGE);
 
 	/* Enable data link layer active state reporting */
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_DLLLARC,
+	rcar_rmw32(rcar, REXPCAP(PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_DLLLARC,
 		PCI_EXP_LNKCAP_DLLLARC);
 
 	/* Write out the physical slot number = 0 */
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
+	rcar_rmw32(rcar, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
 
 	/* Set the completion timer timeout to the maximum 50ms. */
-	rcar_rmw32(pcie, TLCTLR + 1, 0x3f, 50);
+	rcar_rmw32(rcar, TLCTLR + 1, 0x3f, 50);
 
 	/* Terminate list of capabilities (Next Capability Offset=0) */
-	rcar_rmw32(pcie, RVCCAP(0), 0xfff00000, 0);
+	rcar_rmw32(rcar, RVCCAP(0), 0xfff00000, 0);
 
 	/* Enable MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_writel(pcie, 0x801f0000, PCIEMSITXR);
+		rcar_writel(rcar, 0x801f0000, PCIEMSITXR);
 
 	/* Finish initialization - establish a PCI Express link */
-	rcar_writel(pcie, CFINIT, PCIETCTLR);
+	rcar_writel(rcar, CFINIT, PCIETCTLR);
 
 	/* This will timeout if we don't have a link. */
-	err = rcar_pcie_wait_for_dl(pcie);
+	err = rcar_pcie_wait_for_dl(rcar);
 	if (err)
 		return err;
 
 	/* Enable INTx interrupts */
-	rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
+	rcar_rmw32(rcar, PCIEINTXR, 0, 0xF << 8);
 
 	wmb();
 
 	return 0;
 }
 
-static int rcar_pcie_hw_init_h1(struct rcar_pcie *pcie)
+static int rcar_pcie_hw_init_h1(struct rcar_pcie *rcar)
 {
 	unsigned int timeout = 10;
 
 	/* Initialize the phy */
-	phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
-	phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
-	phy_write_reg(pcie, 0, 0x43, 0x1, 0x00210188);
-	phy_write_reg(pcie, 1, 0x43, 0x1, 0x00210188);
-	phy_write_reg(pcie, 0, 0x44, 0x1, 0x015C0014);
-	phy_write_reg(pcie, 1, 0x44, 0x1, 0x015C0014);
-	phy_write_reg(pcie, 1, 0x4C, 0x1, 0x786174A0);
-	phy_write_reg(pcie, 1, 0x4D, 0x1, 0x048000BB);
-	phy_write_reg(pcie, 0, 0x51, 0x1, 0x079EC062);
-	phy_write_reg(pcie, 0, 0x52, 0x1, 0x20000000);
-	phy_write_reg(pcie, 1, 0x52, 0x1, 0x20000000);
-	phy_write_reg(pcie, 1, 0x56, 0x1, 0x00003806);
-
-	phy_write_reg(pcie, 0, 0x60, 0x1, 0x004B03A5);
-	phy_write_reg(pcie, 0, 0x64, 0x1, 0x3F0F1F0F);
-	phy_write_reg(pcie, 0, 0x66, 0x1, 0x00008000);
+	phy_write_reg(rcar, 0, 0x42, 0x1, 0x0EC34191);
+	phy_write_reg(rcar, 1, 0x42, 0x1, 0x0EC34180);
+	phy_write_reg(rcar, 0, 0x43, 0x1, 0x00210188);
+	phy_write_reg(rcar, 1, 0x43, 0x1, 0x00210188);
+	phy_write_reg(rcar, 0, 0x44, 0x1, 0x015C0014);
+	phy_write_reg(rcar, 1, 0x44, 0x1, 0x015C0014);
+	phy_write_reg(rcar, 1, 0x4C, 0x1, 0x786174A0);
+	phy_write_reg(rcar, 1, 0x4D, 0x1, 0x048000BB);
+	phy_write_reg(rcar, 0, 0x51, 0x1, 0x079EC062);
+	phy_write_reg(rcar, 0, 0x52, 0x1, 0x20000000);
+	phy_write_reg(rcar, 1, 0x52, 0x1, 0x20000000);
+	phy_write_reg(rcar, 1, 0x56, 0x1, 0x00003806);
+
+	phy_write_reg(rcar, 0, 0x60, 0x1, 0x004B03A5);
+	phy_write_reg(rcar, 0, 0x64, 0x1, 0x3F0F1F0F);
+	phy_write_reg(rcar, 0, 0x66, 0x1, 0x00008000);
 
 	while (timeout--) {
-		if (rcar_readl(pcie, H1_PCIEPHYSR))
-			return rcar_pcie_hw_init(pcie);
+		if (rcar_readl(rcar, H1_PCIEPHYSR))
+			return rcar_pcie_hw_init(rcar);
 
 		msleep(5);
 	}
@@ -635,24 +635,24 @@ static int rcar_pcie_hw_init_h1(struct rcar_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
-static int rcar_pcie_hw_init_gen2(struct rcar_pcie *pcie)
+static int rcar_pcie_hw_init_gen2(struct rcar_pcie *rcar)
 {
 	/*
 	 * These settings come from the R-Car Series, 2nd Generation User's
 	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
 	 */
-	rcar_writel(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
-	rcar_writel(pcie, 0x00381203, GEN2_PCIEPHYDATA);
-	rcar_writel(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_writel(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+	rcar_writel(rcar, 0x000f0030, GEN2_PCIEPHYADDR);
+	rcar_writel(rcar, 0x00381203, GEN2_PCIEPHYDATA);
+	rcar_writel(rcar, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_writel(rcar, 0x00000006, GEN2_PCIEPHYCTRL);
 
-	rcar_writel(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
+	rcar_writel(rcar, 0x000f0054, GEN2_PCIEPHYADDR);
 	/* The following value is for DC connection, no termination resistor */
-	rcar_writel(pcie, 0x13802007, GEN2_PCIEPHYDATA);
-	rcar_writel(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_writel(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+	rcar_writel(rcar, 0x13802007, GEN2_PCIEPHYDATA);
+	rcar_writel(rcar, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_writel(rcar, 0x00000006, GEN2_PCIEPHYCTRL);
 
-	return rcar_pcie_hw_init(pcie);
+	return rcar_pcie_hw_init(rcar);
 }
 
 static int rcar_msi_alloc(struct rcar_msi *chip)
@@ -693,11 +693,11 @@ static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
 
 static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 {
-	struct rcar_pcie *pcie = data;
-	struct rcar_msi *msi = &pcie->msi;
+	struct rcar_pcie *rcar = data;
+	struct rcar_msi *msi = &rcar->msi;
 	unsigned long reg;
 
-	reg = rcar_readl(pcie, PCIEMSIFR);
+	reg = rcar_readl(rcar, PCIEMSIFR);
 
 	/* MSI & INTx share an interrupt - we only handle MSI here */
 	if (!reg)
@@ -708,21 +708,21 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		unsigned int irq;
 
 		/* clear the interrupt */
-		rcar_writel(pcie, 1 << index, PCIEMSIFR);
+		rcar_writel(rcar, 1 << index, PCIEMSIFR);
 
 		irq = irq_find_mapping(msi->domain, index);
 		if (irq) {
 			if (test_bit(index, msi->used))
 				generic_handle_irq(irq);
 			else
-				dev_info(pcie->dev, "unhandled MSI\n");
+				dev_info(rcar->dev, "unhandled MSI\n");
 		} else {
 			/* Unknown MSI, just clear it */
-			dev_dbg(pcie->dev, "unexpected MSI\n");
+			dev_dbg(rcar->dev, "unexpected MSI\n");
 		}
 
 		/* see if there's any more pending in this vector */
-		reg = rcar_readl(pcie, PCIEMSIFR);
+		reg = rcar_readl(rcar, PCIEMSIFR);
 	}
 
 	return IRQ_HANDLED;
@@ -732,7 +732,7 @@ static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 			      struct msi_desc *desc)
 {
 	struct rcar_msi *msi = to_rcar_msi(chip);
-	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
+	struct rcar_pcie *rcar = container_of(chip, struct rcar_pcie, msi.chip);
 	struct msi_msg msg;
 	unsigned int irq;
 	int hwirq;
@@ -749,8 +749,8 @@ static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 
 	irq_set_msi_desc(irq, desc);
 
-	msg.address_lo = rcar_readl(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_readl(pcie, PCIEMSIAUR);
+	msg.address_lo = rcar_readl(rcar, PCIEMSIALR) & ~MSIFE;
+	msg.address_hi = rcar_readl(rcar, PCIEMSIAUR);
 	msg.data = hwirq;
 
 	pci_write_msi_msg(irq, &msg);
@@ -761,7 +761,7 @@ static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 static int rcar_msi_setup_irqs(struct msi_controller *chip,
 			       struct pci_dev *pdev, int nvec, int type)
 {
-	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
+	struct rcar_pcie *rcar = container_of(chip, struct rcar_pcie, msi.chip);
 	struct rcar_msi *msi = to_rcar_msi(chip);
 	struct msi_desc *desc;
 	struct msi_msg msg;
@@ -801,8 +801,8 @@ static int rcar_msi_setup_irqs(struct msi_controller *chip,
 	desc->nvec_used = nvec;
 	desc->msi_attrib.multiple = order_base_2(nvec);
 
-	msg.address_lo = rcar_readl(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_readl(pcie, PCIEMSIAUR);
+	msg.address_lo = rcar_readl(rcar, PCIEMSIALR) & ~MSIFE;
+	msg.address_hi = rcar_readl(rcar, PCIEMSIAUR);
 	msg.data = hwirq;
 
 	pci_write_msi_msg(irq, &msg);
@@ -839,21 +839,21 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = rcar_msi_map,
 };
 
-static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
+static int rcar_pcie_enable_msi(struct rcar_pcie *rcar)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
-	struct rcar_msi *msi = &pcie->msi;
+	struct platform_device *pdev = to_platform_device(rcar->dev);
+	struct rcar_msi *msi = &rcar->msi;
 	unsigned long base;
 	int err, i;
 
 	mutex_init(&msi->lock);
 
-	msi->chip.dev = pcie->dev;
+	msi->chip.dev = rcar->dev;
 	msi->chip.setup_irq = rcar_msi_setup_irq;
 	msi->chip.setup_irqs = rcar_msi_setup_irqs;
 	msi->chip.teardown_irq = rcar_msi_teardown_irq;
 
-	msi->domain = irq_domain_add_linear(pcie->dev->of_node, INT_PCI_MSI_NR,
+	msi->domain = irq_domain_add_linear(rcar->dev->of_node, INT_PCI_MSI_NR,
 					    &msi_domain_ops, &msi->chip);
 	if (!msi->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
@@ -866,7 +866,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
 	err = devm_request_irq(&pdev->dev, msi->irq1, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, pcie);
+			       rcar_msi_irq_chip.name, rcar);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
 		goto err;
@@ -874,7 +874,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	err = devm_request_irq(&pdev->dev, msi->irq2, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, pcie);
+			       rcar_msi_irq_chip.name, rcar);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
 		goto err;
@@ -884,11 +884,11 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
 	base = virt_to_phys((void *)msi->pages);
 
-	rcar_writel(pcie, base | MSIFE, PCIEMSIALR);
-	rcar_writel(pcie, 0, PCIEMSIAUR);
+	rcar_writel(rcar, base | MSIFE, PCIEMSIALR);
+	rcar_writel(rcar, 0, PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
-	rcar_writel(pcie, 0xffffffff, PCIEMSIIER);
+	rcar_writel(rcar, 0xffffffff, PCIEMSIIER);
 
 	return 0;
 
@@ -898,7 +898,7 @@ err:
 }
 
 static int rcar_pcie_get_resources(struct platform_device *pdev,
-				   struct rcar_pcie *pcie)
+				   struct rcar_pcie *rcar)
 {
 	struct resource res;
 	int err, i;
@@ -907,56 +907,56 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
 	if (err)
 		return err;
 
-	pcie->base = devm_ioremap_resource(&pdev->dev, &res);
-	if (IS_ERR(pcie->base))
-		return PTR_ERR(pcie->base);
+	rcar->base = devm_ioremap_resource(&pdev->dev, &res);
+	if (IS_ERR(rcar->base))
+		return PTR_ERR(rcar->base);
 
-	pcie->clk = devm_clk_get(&pdev->dev, "pcie");
-	if (IS_ERR(pcie->clk)) {
-		dev_err(pcie->dev, "cannot get platform clock\n");
-		return PTR_ERR(pcie->clk);
+	rcar->clk = devm_clk_get(&pdev->dev, "pcie");
+	if (IS_ERR(rcar->clk)) {
+		dev_err(rcar->dev, "cannot get platform clock\n");
+		return PTR_ERR(rcar->clk);
 	}
-	err = clk_prepare_enable(pcie->clk);
+	err = clk_prepare_enable(rcar->clk);
 	if (err)
 		return err;
 
-	pcie->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
-	if (IS_ERR(pcie->bus_clk)) {
-		dev_err(pcie->dev, "cannot get pcie bus clock\n");
-		err = PTR_ERR(pcie->bus_clk);
+	rcar->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
+	if (IS_ERR(rcar->bus_clk)) {
+		dev_err(rcar->dev, "cannot get pcie bus clock\n");
+		err = PTR_ERR(rcar->bus_clk);
 		goto fail_clk;
 	}
-	err = clk_prepare_enable(pcie->bus_clk);
+	err = clk_prepare_enable(rcar->bus_clk);
 	if (err)
 		goto fail_clk;
 
 	i = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	if (!i) {
-		dev_err(pcie->dev, "cannot get platform resources for msi interrupt\n");
+		dev_err(rcar->dev, "cannot get platform resources for msi interrupt\n");
 		err = -ENOENT;
 		goto err_map_reg;
 	}
-	pcie->msi.irq1 = i;
+	rcar->msi.irq1 = i;
 
 	i = irq_of_parse_and_map(pdev->dev.of_node, 1);
 	if (!i) {
-		dev_err(pcie->dev, "cannot get platform resources for msi interrupt\n");
+		dev_err(rcar->dev, "cannot get platform resources for msi interrupt\n");
 		err = -ENOENT;
 		goto err_map_reg;
 	}
-	pcie->msi.irq2 = i;
+	rcar->msi.irq2 = i;
 
 	return 0;
 
 err_map_reg:
-	clk_disable_unprepare(pcie->bus_clk);
+	clk_disable_unprepare(rcar->bus_clk);
 fail_clk:
-	clk_disable_unprepare(pcie->clk);
+	clk_disable_unprepare(rcar->clk);
 
 	return err;
 }
 
-static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
+static int rcar_pcie_inbound_ranges(struct rcar_pcie *rcar,
 				    struct of_pci_range *range,
 				    int *index)
 {
@@ -995,20 +995,20 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
 		 */
-		rcar_writel(pcie, lower_32_bits(pci_addr), PCIEPRAR(idx));
-		rcar_writel(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
-		rcar_writel(pcie, lower_32_bits(mask) | flags, PCIELAMR(idx));
+		rcar_writel(rcar, lower_32_bits(pci_addr), PCIEPRAR(idx));
+		rcar_writel(rcar, lower_32_bits(cpu_addr), PCIELAR(idx));
+		rcar_writel(rcar, lower_32_bits(mask) | flags, PCIELAMR(idx));
 
-		rcar_writel(pcie, upper_32_bits(pci_addr), PCIEPRAR(idx + 1));
-		rcar_writel(pcie, upper_32_bits(cpu_addr), PCIELAR(idx + 1));
-		rcar_writel(pcie, 0, PCIELAMR(idx + 1));
+		rcar_writel(rcar, upper_32_bits(pci_addr), PCIEPRAR(idx + 1));
+		rcar_writel(rcar, upper_32_bits(cpu_addr), PCIELAR(idx + 1));
+		rcar_writel(rcar, 0, PCIELAMR(idx + 1));
 
 		pci_addr += size;
 		cpu_addr += size;
 		idx += 2;
 
 		if (idx > MAX_NR_INBOUND_MAPS) {
-			dev_err(pcie->dev, "Failed to map inbound regions!\n");
+			dev_err(rcar->dev, "Failed to map inbound regions!\n");
 			return -EINVAL;
 		}
 	}
@@ -1035,7 +1035,7 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 	return 0;
 }
 
-static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
+static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *rcar,
 					  struct device_node *np)
 {
 	struct of_pci_range range;
@@ -1050,10 +1050,10 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 	for_each_of_pci_range(&parser, &range) {
 		u64 end = range.cpu_addr + range.size - 1;
 
-		dev_dbg(pcie->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
+		dev_dbg(rcar->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
 			range.flags, range.cpu_addr, end, range.pci_addr);
 
-		err = rcar_pcie_inbound_ranges(pcie, &range, &index);
+		err = rcar_pcie_inbound_ranges(rcar, &range, &index);
 		if (err)
 			return err;
 	}
@@ -1073,24 +1073,24 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	{},
 };
 
-static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
+static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *rcar)
 {
 	int err;
-	struct device *dev = pci->dev;
+	struct device *dev = rcar->dev;
 	struct device_node *np = dev->of_node;
 	resource_size_t iobase;
 	struct resource_entry *win, *tmp;
 
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
+	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &rcar->resources,
 					       &iobase);
 	if (err)
 		return err;
 
-	err = devm_request_pci_bus_resources(dev, &pci->resources);
+	err = devm_request_pci_bus_resources(dev, &rcar->resources);
 	if (err)
 		goto out_release_res;
 
-	resource_list_for_each_entry_safe(win, tmp, &pci->resources) {
+	resource_list_for_each_entry_safe(win, tmp, &rcar->resources) {
 		struct resource *res = win->res;
 
 		if (resource_type(res) == IORESOURCE_IO) {
@@ -1107,64 +1107,64 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 	return 0;
 
 out_release_res:
-	pci_free_resource_list(&pci->resources);
+	pci_free_resource_list(&rcar->resources);
 	return err;
 }
 
 static int rcar_pcie_probe(struct platform_device *pdev)
 {
-	struct rcar_pcie *pcie;
+	struct rcar_pcie *rcar;
 	unsigned int data;
 	const struct of_device_id *of_id;
 	int err;
 	int (*hw_init_fn)(struct rcar_pcie *);
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	rcar = devm_kzalloc(&pdev->dev, sizeof(*rcar), GFP_KERNEL);
+	if (!rcar)
 		return -ENOMEM;
 
-	pcie->dev = &pdev->dev;
-	platform_set_drvdata(pdev, pcie);
+	rcar->dev = &pdev->dev;
+	platform_set_drvdata(pdev, rcar);
 
-	INIT_LIST_HEAD(&pcie->resources);
+	INIT_LIST_HEAD(&rcar->resources);
 
-	rcar_pcie_parse_request_of_pci_ranges(pcie);
+	rcar_pcie_parse_request_of_pci_ranges(rcar);
 
-	err = rcar_pcie_get_resources(pdev, pcie);
+	err = rcar_pcie_get_resources(pdev, rcar);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
 		return err;
 	}
 
-	err = rcar_pcie_parse_map_dma_ranges(pcie, pdev->dev.of_node);
+	err = rcar_pcie_parse_map_dma_ranges(rcar, pdev->dev.of_node);
 	if (err)
 		return err;
 
-	of_id = of_match_device(rcar_pcie_of_match, pcie->dev);
+	of_id = of_match_device(rcar_pcie_of_match, rcar->dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 	hw_init_fn = of_id->data;
 
-	pm_runtime_enable(pcie->dev);
-	err = pm_runtime_get_sync(pcie->dev);
+	pm_runtime_enable(rcar->dev);
+	err = pm_runtime_get_sync(rcar->dev);
 	if (err < 0) {
-		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
+		dev_err(rcar->dev, "pm_runtime_get_sync failed\n");
 		goto err_pm_disable;
 	}
 
 	/* Failure to get a link might just be that no cards are inserted */
-	err = hw_init_fn(pcie);
+	err = hw_init_fn(rcar);
 	if (err) {
 		dev_info(&pdev->dev, "PCIe link down\n");
 		err = 0;
 		goto err_pm_put;
 	}
 
-	data = rcar_readl(pcie, MACSR);
+	data = rcar_readl(rcar, MACSR);
 	dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		err = rcar_pcie_enable_msi(pcie);
+		err = rcar_pcie_enable_msi(rcar);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"failed to enable MSI support: %d\n",
@@ -1173,17 +1173,17 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = rcar_pcie_enable(pcie);
+	err = rcar_pcie_enable(rcar);
 	if (err)
 		goto err_pm_put;
 
 	return 0;
 
 err_pm_put:
-	pm_runtime_put(pcie->dev);
+	pm_runtime_put(rcar->dev);
 
 err_pm_disable:
-	pm_runtime_disable(pcie->dev);
+	pm_runtime_disable(rcar->dev);
 	return err;
 }
 

