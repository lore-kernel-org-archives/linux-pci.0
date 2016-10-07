Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938862AbcJGQZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:25:09 -0400
Subject: [PATCH 03/10] PCI: rcar: Swap order of rcar_writel() reg/val
 arguments
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:25:04 -0500
Message-ID: <20161007162503.23279.93059.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of rcar_writel() arguments to match the "dev, pos, val" order
used by pci_write_config_word() and other drivers.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |   90 +++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 145b54d..cd777e8 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -157,8 +157,8 @@ static unsigned long rcar_readl(struct rcar_pcie *rcar, unsigned long reg)
 	return readl(rcar->base + reg);
 }
 
-static void rcar_writel(struct rcar_pcie *rcar, unsigned long val,
-			unsigned long reg)
+static void rcar_writel(struct rcar_pcie *rcar, unsigned long reg,
+			unsigned long val)
 {
 	writel(val, rcar->base + reg);
 }
@@ -175,7 +175,7 @@ static void rcar_rmw32(struct rcar_pcie *rcar, int where, u32 mask, u32 data)
 
 	val &= ~(mask << shift);
 	val |= data << shift;
-	rcar_writel(rcar, val, where & ~3);
+	rcar_writel(rcar, where & ~3, val);
 }
 
 static u32 rcar_read_conf(struct rcar_pcie *rcar, int where)
@@ -224,7 +224,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *rcar,
 			if (pci_is_root_bus(bus) && (reg == PCI_PRIMARY_BUS))
 				rcar->root_bus_nr = *data & 0xff;
 
-			rcar_writel(rcar, *data, PCICONF(index));
+			rcar_writel(rcar, PCICONF(index), *data);
 		}
 
 		return PCIBIOS_SUCCESSFUL;
@@ -234,17 +234,17 @@ static int rcar_pcie_config_access(struct rcar_pcie *rcar,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Clear errors */
-	rcar_writel(rcar, rcar_readl(rcar, PCIEERRFR), PCIEERRFR);
+	rcar_writel(rcar, PCIEERRFR, rcar_readl(rcar, PCIEERRFR));
 
 	/* Set the PIO address */
-	rcar_writel(rcar, PCIE_CONF_BUS(bus->number) |
-		    PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
+	rcar_writel(rcar, PCIECAR, PCIE_CONF_BUS(bus->number) |
+		    PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg);
 
 	/* Enable the configuration access */
 	if (bus->parent->number == rcar->root_bus_nr)
-		rcar_writel(rcar, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
+		rcar_writel(rcar, PCIECCTLR, CONFIG_SEND_ENABLE | TYPE0);
 	else
-		rcar_writel(rcar, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
+		rcar_writel(rcar, PCIECCTLR, CONFIG_SEND_ENABLE | TYPE1);
 
 	/* Check for errors */
 	if (rcar_readl(rcar, PCIEERRFR) & UNSUPPORTED_REQUEST)
@@ -258,10 +258,10 @@ static int rcar_pcie_config_access(struct rcar_pcie *rcar,
 	if (access_type == RCAR_PCI_ACCESS_READ)
 		*data = rcar_readl(rcar, PCIECDR);
 	else
-		rcar_writel(rcar, *data, PCIECDR);
+		rcar_writel(rcar, PCIECDR, *data);
 
 	/* Disable the configuration access */
-	rcar_writel(rcar, 0, PCIECCTLR);
+	rcar_writel(rcar, PCIECCTLR, 0);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -336,7 +336,7 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *rcar,
 	resource_size_t res_start;
 	u32 mask;
 
-	rcar_writel(rcar, 0x00000000, PCIEPTCTLR(win));
+	rcar_writel(rcar, PCIEPTCTLR(win), 0x00000000);
 
 	/*
 	 * The PAMR mask is calculated in units of 128Bytes, which
@@ -344,22 +344,22 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *rcar,
 	 */
 	size = resource_size(res);
 	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
-	rcar_writel(rcar, mask << 7, PCIEPAMR(win));
+	rcar_writel(rcar, PCIEPAMR(win), mask << 7);
 
 	if (res->flags & IORESOURCE_IO)
 		res_start = pci_pio_to_address(res->start);
 	else
 		res_start = res->start;
 
-	rcar_writel(rcar, upper_32_bits(res_start), PCIEPAUR(win));
-	rcar_writel(rcar, lower_32_bits(res_start) & ~0x7F, PCIEPALR(win));
+	rcar_writel(rcar, PCIEPAUR(win), upper_32_bits(res_start));
+	rcar_writel(rcar, PCIEPALR(win), lower_32_bits(res_start) & ~0x7F);
 
 	/* First resource is for IO */
 	mask = PAR_ENABLE;
 	if (res->flags & IORESOURCE_IO)
 		mask |= IO_SPACE;
 
-	rcar_writel(rcar, mask, PCIEPTCTLR(win));
+	rcar_writel(rcar, PCIEPTCTLR(win), mask);
 }
 
 static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
@@ -419,7 +419,7 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *rcar)
 
 	/* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
 	if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
-		rcar_writel(rcar, macsr, MACSR);
+		rcar_writel(rcar, MACSR, macsr);
 
 	/* Start link speed change */
 	rcar_rmw32(rcar, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
@@ -428,7 +428,7 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *rcar)
 		macsr = rcar_readl(rcar, MACSR);
 		if (macsr & SPCHGFIN) {
 			/* Clear the interrupt bits */
-			rcar_writel(rcar, macsr, MACSR);
+			rcar_writel(rcar, MACSR, macsr);
 
 			if (macsr & SPCHGFAIL)
 				dev_err(rcar->dev, "Speed change failed\n");
@@ -511,15 +511,15 @@ static void phy_write_reg(struct rcar_pcie *rcar,
 		((addr & 0xff) << ADR_POS);
 
 	/* Set write data */
-	rcar_writel(rcar, data, H1_PCIEPHYDOUTR);
-	rcar_writel(rcar, phyaddr, H1_PCIEPHYADRR);
+	rcar_writel(rcar, H1_PCIEPHYDOUTR, data);
+	rcar_writel(rcar, H1_PCIEPHYADRR, phyaddr);
 
 	/* Ignore errors as they will be dealt with if the data link is down */
 	phy_wait_for_ack(rcar);
 
 	/* Clear command */
-	rcar_writel(rcar, 0, H1_PCIEPHYDOUTR);
-	rcar_writel(rcar, 0, H1_PCIEPHYADRR);
+	rcar_writel(rcar, H1_PCIEPHYDOUTR, 0);
+	rcar_writel(rcar, H1_PCIEPHYADRR, 0);
 
 	/* Ignore errors as they will be dealt with if the data link is down */
 	phy_wait_for_ack(rcar);
@@ -544,17 +544,17 @@ static int rcar_pcie_hw_init(struct rcar_pcie *rcar)
 	int err;
 
 	/* Begin initialization */
-	rcar_writel(rcar, 0, PCIETCTLR);
+	rcar_writel(rcar, PCIETCTLR, 0);
 
 	/* Set mode */
-	rcar_writel(rcar, 1, PCIEMSR);
+	rcar_writel(rcar, PCIEMSR, 1);
 
 	/*
 	 * Initial header for port config space is type 1, set the device
 	 * class to match. Hardware takes care of propagating the IDSETR
 	 * settings, so there is no need to bother with a quirk.
 	 */
-	rcar_writel(rcar, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
+	rcar_writel(rcar, IDSETR1, PCI_CLASS_BRIDGE_PCI << 16);
 
 	/*
 	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
@@ -585,10 +585,10 @@ static int rcar_pcie_hw_init(struct rcar_pcie *rcar)
 
 	/* Enable MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_writel(rcar, 0x801f0000, PCIEMSITXR);
+		rcar_writel(rcar, PCIEMSITXR, 0x801f0000);
 
 	/* Finish initialization - establish a PCI Express link */
-	rcar_writel(rcar, CFINIT, PCIETCTLR);
+	rcar_writel(rcar, PCIETCTLR, CFINIT);
 
 	/* This will timeout if we don't have a link. */
 	err = rcar_pcie_wait_for_dl(rcar);
@@ -641,16 +641,16 @@ static int rcar_pcie_hw_init_gen2(struct rcar_pcie *rcar)
 	 * These settings come from the R-Car Series, 2nd Generation User's
 	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
 	 */
-	rcar_writel(rcar, 0x000f0030, GEN2_PCIEPHYADDR);
-	rcar_writel(rcar, 0x00381203, GEN2_PCIEPHYDATA);
-	rcar_writel(rcar, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_writel(rcar, 0x00000006, GEN2_PCIEPHYCTRL);
+	rcar_writel(rcar, GEN2_PCIEPHYADDR, 0x000f0030);
+	rcar_writel(rcar, GEN2_PCIEPHYDATA, 0x00381203);
+	rcar_writel(rcar, GEN2_PCIEPHYCTRL, 0x00000001);
+	rcar_writel(rcar, GEN2_PCIEPHYCTRL, 0x00000006);
 
-	rcar_writel(rcar, 0x000f0054, GEN2_PCIEPHYADDR);
+	rcar_writel(rcar, GEN2_PCIEPHYADDR, 0x000f0054);
 	/* The following value is for DC connection, no termination resistor */
-	rcar_writel(rcar, 0x13802007, GEN2_PCIEPHYDATA);
-	rcar_writel(rcar, 0x00000001, GEN2_PCIEPHYCTRL);
-	rcar_writel(rcar, 0x00000006, GEN2_PCIEPHYCTRL);
+	rcar_writel(rcar, GEN2_PCIEPHYDATA, 0x13802007);
+	rcar_writel(rcar, GEN2_PCIEPHYCTRL, 0x00000001);
+	rcar_writel(rcar, GEN2_PCIEPHYCTRL, 0x00000006);
 
 	return rcar_pcie_hw_init(rcar);
 }
@@ -708,7 +708,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		unsigned int irq;
 
 		/* clear the interrupt */
-		rcar_writel(rcar, 1 << index, PCIEMSIFR);
+		rcar_writel(rcar, PCIEMSIFR, 1 << index);
 
 		irq = irq_find_mapping(msi->domain, index);
 		if (irq) {
@@ -884,11 +884,11 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *rcar)
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
 	base = virt_to_phys((void *)msi->pages);
 
-	rcar_writel(rcar, base | MSIFE, PCIEMSIALR);
-	rcar_writel(rcar, 0, PCIEMSIAUR);
+	rcar_writel(rcar, PCIEMSIALR, base | MSIFE);
+	rcar_writel(rcar, PCIEMSIAUR, 0);
 
 	/* enable all MSI interrupts */
-	rcar_writel(rcar, 0xffffffff, PCIEMSIIER);
+	rcar_writel(rcar, PCIEMSIIER, 0xffffffff);
 
 	return 0;
 
@@ -995,13 +995,13 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *rcar,
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
 		 */
-		rcar_writel(rcar, lower_32_bits(pci_addr), PCIEPRAR(idx));
-		rcar_writel(rcar, lower_32_bits(cpu_addr), PCIELAR(idx));
-		rcar_writel(rcar, lower_32_bits(mask) | flags, PCIELAMR(idx));
+		rcar_writel(rcar, PCIEPRAR(idx), lower_32_bits(pci_addr));
+		rcar_writel(rcar, PCIELAR(idx), lower_32_bits(cpu_addr));
+		rcar_writel(rcar, PCIELAMR(idx), lower_32_bits(mask) | flags);
 
-		rcar_writel(rcar, upper_32_bits(pci_addr), PCIEPRAR(idx + 1));
-		rcar_writel(rcar, upper_32_bits(cpu_addr), PCIELAR(idx + 1));
-		rcar_writel(rcar, 0, PCIELAMR(idx + 1));
+		rcar_writel(rcar, PCIEPRAR(idx + 1), upper_32_bits(pci_addr));
+		rcar_writel(rcar, PCIELAR(idx + 1), upper_32_bits(cpu_addr));
+		rcar_writel(rcar, PCIELAMR(idx + 1), 0);
 
 		pci_addr += size;
 		cpu_addr += size;

