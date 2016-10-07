Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938862AbcJGQYv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:24:51 -0400
Subject: [PATCH 01/10] PCI: rcar: Rename accessors
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:24:46 -0500
Message-ID: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename rcar_pci_read_reg() to rcar_readl() and rcar_pci_write_reg() to
rcar_writel() for consistency with other drivers.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |  142 ++++++++++++++++++++----------------------
 1 file changed, 68 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index e06b1d3..b6899c8 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -152,16 +152,15 @@ struct rcar_pcie {
 	struct			rcar_msi msi;
 };
 
-static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
-			       unsigned long reg)
+static unsigned long rcar_readl(struct rcar_pcie *pcie, unsigned long reg)
 {
-	writel(val, pcie->base + reg);
+	return readl(pcie->base + reg);
 }
 
-static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
-				       unsigned long reg)
+static void rcar_writel(struct rcar_pcie *pcie, unsigned long val,
+			unsigned long reg)
 {
-	return readl(pcie->base + reg);
+	writel(val, pcie->base + reg);
 }
 
 enum {
@@ -172,17 +171,17 @@ enum {
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
 	int shift = 8 * (where & 3);
-	u32 val = rcar_pci_read_reg(pcie, where & ~3);
+	u32 val = rcar_readl(pcie, where & ~3);
 
 	val &= ~(mask << shift);
 	val |= data << shift;
-	rcar_pci_write_reg(pcie, val, where & ~3);
+	rcar_writel(pcie, val, where & ~3);
 }
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
 	int shift = 8 * (where & 3);
-	u32 val = rcar_pci_read_reg(pcie, where & ~3);
+	u32 val = rcar_readl(pcie, where & ~3);
 
 	return val >> shift;
 }
@@ -219,13 +218,13 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 		if (access_type == RCAR_PCI_ACCESS_READ) {
-			*data = rcar_pci_read_reg(pcie, PCICONF(index));
+			*data = rcar_readl(pcie, PCICONF(index));
 		} else {
 			/* Keep an eye out for changes to the root bus number */
 			if (pci_is_root_bus(bus) && (reg == PCI_PRIMARY_BUS))
 				pcie->root_bus_nr = *data & 0xff;
 
-			rcar_pci_write_reg(pcie, *data, PCICONF(index));
+			rcar_writel(pcie, *data, PCICONF(index));
 		}
 
 		return PCIBIOS_SUCCESSFUL;
@@ -235,20 +234,20 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Clear errors */
-	rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
+	rcar_writel(pcie, rcar_readl(pcie, PCIEERRFR), PCIEERRFR);
 
 	/* Set the PIO address */
-	rcar_pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
-		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
+	rcar_writel(pcie, PCIE_CONF_BUS(bus->number) |
+		    PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
 
 	/* Enable the configuration access */
 	if (bus->parent->number == pcie->root_bus_nr)
-		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
+		rcar_writel(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
 	else
-		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
+		rcar_writel(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
 
 	/* Check for errors */
-	if (rcar_pci_read_reg(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
+	if (rcar_readl(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Check for master and target aborts */
@@ -257,12 +256,12 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (access_type == RCAR_PCI_ACCESS_READ)
-		*data = rcar_pci_read_reg(pcie, PCIECDR);
+		*data = rcar_readl(pcie, PCIECDR);
 	else
-		rcar_pci_write_reg(pcie, *data, PCIECDR);
+		rcar_writel(pcie, *data, PCIECDR);
 
 	/* Disable the configuration access */
-	rcar_pci_write_reg(pcie, 0, PCIECCTLR);
+	rcar_writel(pcie, 0, PCIECCTLR);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -337,7 +336,7 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	resource_size_t res_start;
 	u32 mask;
 
-	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
+	rcar_writel(pcie, 0x00000000, PCIEPTCTLR(win));
 
 	/*
 	 * The PAMR mask is calculated in units of 128Bytes, which
@@ -345,23 +344,22 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	 */
 	size = resource_size(res);
 	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
-	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
+	rcar_writel(pcie, mask << 7, PCIEPAMR(win));
 
 	if (res->flags & IORESOURCE_IO)
 		res_start = pci_pio_to_address(res->start);
 	else
 		res_start = res->start;
 
-	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
-	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
-			   PCIEPALR(win));
+	rcar_writel(pcie, upper_32_bits(res_start), PCIEPAUR(win));
+	rcar_writel(pcie, lower_32_bits(res_start) & ~0x7F, PCIEPALR(win));
 
 	/* First resource is for IO */
 	mask = PAR_ENABLE;
 	if (res->flags & IORESOURCE_IO)
 		mask |= IO_SPACE;
 
-	rcar_pci_write_reg(pcie, mask, PCIEPTCTLR(win));
+	rcar_writel(pcie, mask, PCIEPTCTLR(win));
 }
 
 static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
@@ -400,15 +398,15 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 	unsigned int timeout = 1000;
 	u32 macsr;
 
-	if ((rcar_pci_read_reg(pcie, MACS2R) & LINK_SPEED) != LINK_SPEED_5_0GTS)
+	if ((rcar_readl(pcie, MACS2R) & LINK_SPEED) != LINK_SPEED_5_0GTS)
 		return;
 
-	if (rcar_pci_read_reg(pcie, MACCTLR) & SPEED_CHANGE) {
+	if (rcar_readl(pcie, MACCTLR) & SPEED_CHANGE) {
 		dev_err(pcie->dev, "Speed change already in progress\n");
 		return;
 	}
 
-	macsr = rcar_pci_read_reg(pcie, MACSR);
+	macsr = rcar_readl(pcie, MACSR);
 	if ((macsr & LINK_SPEED) == LINK_SPEED_5_0GTS)
 		goto done;
 
@@ -421,16 +419,16 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 
 	/* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
 	if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
-		rcar_pci_write_reg(pcie, macsr, MACSR);
+		rcar_writel(pcie, macsr, MACSR);
 
 	/* Start link speed change */
 	rcar_rmw32(pcie, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
 
 	while (timeout--) {
-		macsr = rcar_pci_read_reg(pcie, MACSR);
+		macsr = rcar_readl(pcie, MACSR);
 		if (macsr & SPCHGFIN) {
 			/* Clear the interrupt bits */
-			rcar_pci_write_reg(pcie, macsr, MACSR);
+			rcar_writel(pcie, macsr, MACSR);
 
 			if (macsr & SPCHGFAIL)
 				dev_err(pcie->dev, "Speed change failed\n");
@@ -490,7 +488,7 @@ static int phy_wait_for_ack(struct rcar_pcie *pcie)
 	unsigned int timeout = 100;
 
 	while (timeout--) {
-		if (rcar_pci_read_reg(pcie, H1_PCIEPHYADRR) & PHY_ACK)
+		if (rcar_readl(pcie, H1_PCIEPHYADRR) & PHY_ACK)
 			return 0;
 
 		udelay(100);
@@ -513,15 +511,15 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 		((addr & 0xff) << ADR_POS);
 
 	/* Set write data */
-	rcar_pci_write_reg(pcie, data, H1_PCIEPHYDOUTR);
-	rcar_pci_write_reg(pcie, phyaddr, H1_PCIEPHYADRR);
+	rcar_writel(pcie, data, H1_PCIEPHYDOUTR);
+	rcar_writel(pcie, phyaddr, H1_PCIEPHYADRR);
 
 	/* Ignore errors as they will be dealt with if the data link is down */
 	phy_wait_for_ack(pcie);
 
 	/* Clear command */
-	rcar_pci_write_reg(pcie, 0, H1_PCIEPHYDOUTR);
-	rcar_pci_write_reg(pcie, 0, H1_PCIEPHYADRR);
+	rcar_writel(pcie, 0, H1_PCIEPHYDOUTR);
+	rcar_writel(pcie, 0, H1_PCIEPHYADRR);
 
 	/* Ignore errors as they will be dealt with if the data link is down */
 	phy_wait_for_ack(pcie);
@@ -532,7 +530,7 @@ static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
 	unsigned int timeout = 10;
 
 	while (timeout--) {
-		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
+		if ((rcar_readl(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
 			return 0;
 
 		msleep(5);
@@ -546,17 +544,17 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	int err;
 
 	/* Begin initialization */
-	rcar_pci_write_reg(pcie, 0, PCIETCTLR);
+	rcar_writel(pcie, 0, PCIETCTLR);
 
 	/* Set mode */
-	rcar_pci_write_reg(pcie, 1, PCIEMSR);
+	rcar_writel(pcie, 1, PCIEMSR);
 
 	/*
 	 * Initial header for port config space is type 1, set the device
 	 * class to match. Hardware takes care of propagating the IDSETR
 	 * settings, so there is no need to bother with a quirk.
 	 */
-	rcar_pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
+	rcar_writel(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
 
 	/*
 	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
@@ -587,10 +585,10 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 
 	/* Enable MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_pci_write_reg(pcie, 0x801f0000, PCIEMSITXR);
+		rcar_writel(pcie, 0x801f0000, PCIEMSITXR);
 
 	/* Finish initialization - establish a PCI Express link */
-	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
+	rcar_writel(pcie, CFINIT, PCIETCTLR);
 
 	/* This will timeout if we don't have a link. */
 	err = rcar_pcie_wait_for_dl(pcie);
@@ -628,7 +626,7 @@ static int rcar_pcie_hw_init_h1(struct rcar_pcie *pcie)
 	phy_write_reg(pcie, 0, 0x66, 0x1, 0x00008000);
 
 	while (timeout--) {
-		if (rcar_pci_read_reg(pcie, H1_PCIEPHYSR))
+		if (rcar_readl(pcie, H1_PCIEPHYSR))
 			return rcar_pcie_hw_init(pcie);
 
 		msleep(5);
@@ -643,16 +641,16 @@ static int rcar_pcie_hw_init_gen2(struct rcar_pcie *pcie)
 	 * These settings come from the R-Car Series, 2nd Generation User's
 	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
 	 */
-	rcar_pci_write_reg(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
-	rcar_pci_write_reg(pcie, 0x00381203, GEN2_PCIEPHYDATA);
-	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+	rcar_writel(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
+	rcar_writel(pcie, 0x00381203, GEN2_PCIEPHYDATA);
+	rcar_writel(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_writel(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
 
-	rcar_pci_write_reg(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
+	rcar_writel(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
 	/* The following value is for DC connection, no termination resistor */
-	rcar_pci_write_reg(pcie, 0x13802007, GEN2_PCIEPHYDATA);
-	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+	rcar_writel(pcie, 0x13802007, GEN2_PCIEPHYDATA);
+	rcar_writel(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_writel(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
 
 	return rcar_pcie_hw_init(pcie);
 }
@@ -699,7 +697,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 	struct rcar_msi *msi = &pcie->msi;
 	unsigned long reg;
 
-	reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
+	reg = rcar_readl(pcie, PCIEMSIFR);
 
 	/* MSI & INTx share an interrupt - we only handle MSI here */
 	if (!reg)
@@ -710,7 +708,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		unsigned int irq;
 
 		/* clear the interrupt */
-		rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
+		rcar_writel(pcie, 1 << index, PCIEMSIFR);
 
 		irq = irq_find_mapping(msi->domain, index);
 		if (irq) {
@@ -724,7 +722,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		}
 
 		/* see if there's any more pending in this vector */
-		reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
+		reg = rcar_readl(pcie, PCIEMSIFR);
 	}
 
 	return IRQ_HANDLED;
@@ -751,8 +749,8 @@ static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 
 	irq_set_msi_desc(irq, desc);
 
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
+	msg.address_lo = rcar_readl(pcie, PCIEMSIALR) & ~MSIFE;
+	msg.address_hi = rcar_readl(pcie, PCIEMSIAUR);
 	msg.data = hwirq;
 
 	pci_write_msi_msg(irq, &msg);
@@ -803,8 +801,8 @@ static int rcar_msi_setup_irqs(struct msi_controller *chip,
 	desc->nvec_used = nvec;
 	desc->msi_attrib.multiple = order_base_2(nvec);
 
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
+	msg.address_lo = rcar_readl(pcie, PCIEMSIALR) & ~MSIFE;
+	msg.address_hi = rcar_readl(pcie, PCIEMSIAUR);
 	msg.data = hwirq;
 
 	pci_write_msi_msg(irq, &msg);
@@ -886,11 +884,11 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
 	base = virt_to_phys((void *)msi->pages);
 
-	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
+	rcar_writel(pcie, base | MSIFE, PCIEMSIALR);
+	rcar_writel(pcie, 0, PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
+	rcar_writel(pcie, 0xffffffff, PCIEMSIIER);
 
 	return 0;
 
@@ -997,17 +995,13 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
 		 */
-		rcar_pci_write_reg(pcie, lower_32_bits(pci_addr),
-				   PCIEPRAR(idx));
-		rcar_pci_write_reg(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
-		rcar_pci_write_reg(pcie, lower_32_bits(mask) | flags,
-				   PCIELAMR(idx));
-
-		rcar_pci_write_reg(pcie, upper_32_bits(pci_addr),
-				   PCIEPRAR(idx + 1));
-		rcar_pci_write_reg(pcie, upper_32_bits(cpu_addr),
-				   PCIELAR(idx + 1));
-		rcar_pci_write_reg(pcie, 0, PCIELAMR(idx + 1));
+		rcar_writel(pcie, lower_32_bits(pci_addr), PCIEPRAR(idx));
+		rcar_writel(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
+		rcar_writel(pcie, lower_32_bits(mask) | flags, PCIELAMR(idx));
+
+		rcar_writel(pcie, upper_32_bits(pci_addr), PCIEPRAR(idx + 1));
+		rcar_writel(pcie, upper_32_bits(cpu_addr), PCIELAR(idx + 1));
+		rcar_writel(pcie, 0, PCIELAMR(idx + 1));
 
 		pci_addr += size;
 		cpu_addr += size;
@@ -1166,7 +1160,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		goto err_pm_put;
 	}
 
-	data = rcar_pci_read_reg(pcie, MACSR);
+	data = rcar_readl(pcie, MACSR);
 	dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {

