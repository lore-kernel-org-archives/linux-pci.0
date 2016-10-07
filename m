Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940962AbcJGQ3e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:34 -0400
Subject: [PATCH 6/9] PCI: xilinx-nwl: Name private struct pointer "nwl"
 consistently
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:29:27 -0500
Message-ID: <20161007162927.24137.78281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "nwl", for struct nwl_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |  318 ++++++++++++++++++------------------
 1 file changed, 159 insertions(+), 159 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 67eae41..2c72c73 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -186,57 +186,57 @@ struct nwl_pcie {
 	struct irq_domain *legacy_irq_domain;
 };
 
-static inline u32 nwl_bridge_readl(struct nwl_pcie *pcie, u32 off)
+static inline u32 nwl_bridge_readl(struct nwl_pcie *nwl, u32 off)
 {
-	return readl(pcie->breg_base + off);
+	return readl(nwl->breg_base + off);
 }
 
-static inline void nwl_bridge_writel(struct nwl_pcie *pcie, u32 val, u32 off)
+static inline void nwl_bridge_writel(struct nwl_pcie *nwl, u32 val, u32 off)
 {
-	writel(val, pcie->breg_base + off);
+	writel(val, nwl->breg_base + off);
 }
 
-static bool nwl_pcie_link_up(struct nwl_pcie *pcie)
+static bool nwl_pcie_link_up(struct nwl_pcie *nwl)
 {
-	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PCIE_PHY_LINKUP_BIT)
+	if (readl(nwl->pcireg_base + PS_LINKUP_OFFSET) & PCIE_PHY_LINKUP_BIT)
 		return true;
 	return false;
 }
 
-static bool nwl_phy_link_up(struct nwl_pcie *pcie)
+static bool nwl_phy_link_up(struct nwl_pcie *nwl)
 {
-	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PHY_RDY_LINKUP_BIT)
+	if (readl(nwl->pcireg_base + PS_LINKUP_OFFSET) & PHY_RDY_LINKUP_BIT)
 		return true;
 	return false;
 }
 
-static int nwl_wait_for_link(struct nwl_pcie *pcie)
+static int nwl_wait_for_link(struct nwl_pcie *nwl)
 {
 	int retries;
 
 	/* check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (nwl_phy_link_up(pcie))
+		if (nwl_phy_link_up(nwl))
 			return 0;
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(pcie->dev, "PHY link never came up\n");
+	dev_err(nwl->dev, "PHY link never came up\n");
 	return -ETIMEDOUT;
 }
 
 static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
-	struct nwl_pcie *pcie = bus->sysdata;
+	struct nwl_pcie *nwl = bus->sysdata;
 
 	/* Check link before accessing downstream ports */
-	if (bus->number != pcie->root_busno) {
-		if (!nwl_pcie_link_up(pcie))
+	if (bus->number != nwl->root_busno) {
+		if (!nwl_pcie_link_up(nwl))
 			return false;
 	}
 
 	/* Only one device down on each root port */
-	if (bus->number == pcie->root_busno && devfn > 0)
+	if (bus->number == nwl->root_busno && devfn > 0)
 		return false;
 
 	return true;
@@ -255,7 +255,7 @@ static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 static void __iomem *nwl_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 				      int where)
 {
-	struct nwl_pcie *pcie = bus->sysdata;
+	struct nwl_pcie *nwl = bus->sysdata;
 	int relbus;
 
 	if (!nwl_pcie_valid_device(bus, devfn))
@@ -264,7 +264,7 @@ static void __iomem *nwl_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 	relbus = (bus->number << ECAM_BUS_LOC_SHIFT) |
 			(devfn << ECAM_DEV_LOC_SHIFT);
 
-	return pcie->ecam_base + relbus + where;
+	return nwl->ecam_base + relbus + where;
 }
 
 /* PCIe operations */
@@ -276,58 +276,58 @@ static struct pci_ops nwl_pcie_ops = {
 
 static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 {
-	struct nwl_pcie *pcie = data;
+	struct nwl_pcie *nwl = data;
 	u32 misc_stat;
 
 	/* Checking for misc interrupts */
-	misc_stat = nwl_bridge_readl(pcie, MSGF_MISC_STATUS) &
+	misc_stat = nwl_bridge_readl(nwl, MSGF_MISC_STATUS) &
 				     MSGF_MISC_SR_MASKALL;
 	if (!misc_stat)
 		return IRQ_NONE;
 
 	if (misc_stat & MSGF_MISC_SR_RXMSG_OVER)
-		dev_err(pcie->dev, "Received Message FIFO Overflow\n");
+		dev_err(nwl->dev, "Received Message FIFO Overflow\n");
 
 	if (misc_stat & MSGF_MISC_SR_SLAVE_ERR)
-		dev_err(pcie->dev, "Slave error\n");
+		dev_err(nwl->dev, "Slave error\n");
 
 	if (misc_stat & MSGF_MISC_SR_MASTER_ERR)
-		dev_err(pcie->dev, "Master error\n");
+		dev_err(nwl->dev, "Master error\n");
 
 	if (misc_stat & MSGF_MISC_SR_I_ADDR_ERR)
-		dev_err(pcie->dev,
+		dev_err(nwl->dev,
 			"In Misc Ingress address translation error\n");
 
 	if (misc_stat & MSGF_MISC_SR_E_ADDR_ERR)
-		dev_err(pcie->dev,
+		dev_err(nwl->dev,
 			"In Misc Egress address translation error\n");
 
 	if (misc_stat & MSGF_MISC_SR_FATAL_AER)
-		dev_err(pcie->dev, "Fatal Error in AER Capability\n");
+		dev_err(nwl->dev, "Fatal Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_NON_FATAL_AER)
-		dev_err(pcie->dev, "Non-Fatal Error in AER Capability\n");
+		dev_err(nwl->dev, "Non-Fatal Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_CORR_AER)
-		dev_err(pcie->dev, "Correctable Error in AER Capability\n");
+		dev_err(nwl->dev, "Correctable Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_UR_DETECT)
-		dev_err(pcie->dev, "Unsupported request Detected\n");
+		dev_err(nwl->dev, "Unsupported request Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_NON_FATAL_DEV)
-		dev_err(pcie->dev, "Non-Fatal Error Detected\n");
+		dev_err(nwl->dev, "Non-Fatal Error Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
-		dev_err(pcie->dev, "Fatal Error Detected\n");
+		dev_err(nwl->dev, "Fatal Error Detected\n");
 
 	if (misc_stat & MSGF_MSIC_SR_LINK_AUTO_BWIDTH)
-		dev_info(pcie->dev, "Link Autonomous Bandwidth Management Status bit set\n");
+		dev_info(nwl->dev, "Link Autonomous Bandwidth Management Status bit set\n");
 
 	if (misc_stat & MSGF_MSIC_SR_LINK_BWIDTH)
-		dev_info(pcie->dev, "Link Bandwidth Management Status bit set\n");
+		dev_info(nwl->dev, "Link Bandwidth Management Status bit set\n");
 
 	/* Clear misc interrupt status */
-	nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);
+	nwl_bridge_writel(nwl, misc_stat, MSGF_MISC_STATUS);
 
 	return IRQ_HANDLED;
 }
@@ -335,18 +335,18 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 static void nwl_pcie_leg_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct nwl_pcie *pcie;
+	struct nwl_pcie *nwl;
 	unsigned long status;
 	u32 bit;
 	u32 virq;
 
 	chained_irq_enter(chip, desc);
-	pcie = irq_desc_get_handler_data(desc);
+	nwl = irq_desc_get_handler_data(desc);
 
-	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
+	while ((status = nwl_bridge_readl(nwl, MSGF_LEG_STATUS) &
 				MSGF_LEG_SR_MASKALL) != 0) {
 		for_each_set_bit(bit, &status, INTX_NUM) {
-			virq = irq_find_mapping(pcie->legacy_irq_domain,
+			virq = irq_find_mapping(nwl->legacy_irq_domain,
 						bit + 1);
 			if (virq)
 				generic_handle_irq(virq);
@@ -356,18 +356,18 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void nwl_pcie_handle_msi_irq(struct nwl_pcie *pcie, u32 status_reg)
+static void nwl_pcie_handle_msi_irq(struct nwl_pcie *nwl, u32 status_reg)
 {
 	struct nwl_msi *msi;
 	unsigned long status;
 	u32 bit;
 	u32 virq;
 
-	msi = &pcie->msi;
+	msi = &nwl->msi;
 
-	while ((status = nwl_bridge_readl(pcie, status_reg)) != 0) {
+	while ((status = nwl_bridge_readl(nwl, status_reg)) != 0) {
 		for_each_set_bit(bit, &status, 32) {
-			nwl_bridge_writel(pcie, 1 << bit, status_reg);
+			nwl_bridge_writel(nwl, 1 << bit, status_reg);
 			virq = irq_find_mapping(msi->dev_domain, bit);
 			if (virq)
 				generic_handle_irq(virq);
@@ -378,20 +378,20 @@ static void nwl_pcie_handle_msi_irq(struct nwl_pcie *pcie, u32 status_reg)
 static void nwl_pcie_msi_handler_high(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct nwl_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct nwl_pcie *nwl = irq_desc_get_handler_data(desc);
 
 	chained_irq_enter(chip, desc);
-	nwl_pcie_handle_msi_irq(pcie, MSGF_MSI_STATUS_HI);
+	nwl_pcie_handle_msi_irq(nwl, MSGF_MSI_STATUS_HI);
 	chained_irq_exit(chip, desc);
 }
 
 static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct nwl_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct nwl_pcie *nwl = irq_desc_get_handler_data(desc);
 
 	chained_irq_enter(chip, desc);
-	nwl_pcie_handle_msi_irq(pcie, MSGF_MSI_STATUS_LO);
+	nwl_pcie_handle_msi_irq(nwl, MSGF_MSI_STATUS_LO);
 	chained_irq_exit(chip, desc);
 }
 
@@ -427,8 +427,8 @@ static struct msi_domain_info nwl_msi_domain_info = {
 
 static void nwl_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
-	phys_addr_t msi_addr = pcie->phys_pcie_reg_base;
+	struct nwl_pcie *nwl = irq_data_get_irq_chip_data(data);
+	phys_addr_t msi_addr = nwl->phys_pcie_reg_base;
 
 	msg->address_lo = lower_32_bits(msi_addr);
 	msg->address_hi = upper_32_bits(msi_addr);
@@ -450,8 +450,8 @@ static struct irq_chip nwl_irq_chip = {
 static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *args)
 {
-	struct nwl_pcie *pcie = domain->host_data;
-	struct nwl_msi *msi = &pcie->msi;
+	struct nwl_pcie *nwl = domain->host_data;
+	struct nwl_msi *msi = &nwl->msi;
 	int bit;
 	int i;
 
@@ -478,8 +478,8 @@ static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 					unsigned int nr_irqs)
 {
 	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
-	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
-	struct nwl_msi *msi = &pcie->msi;
+	struct nwl_pcie *nwl = irq_data_get_irq_chip_data(data);
+	struct nwl_msi *msi = &nwl->msi;
 
 	mutex_lock(&msi->lock);
 	bitmap_clear(msi->bitmap, data->hwirq, nr_irqs);
@@ -491,23 +491,23 @@ static const struct irq_domain_ops dev_msi_domain_ops = {
 	.free   = nwl_irq_domain_free,
 };
 
-static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
+static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *nwl)
 {
 #ifdef CONFIG_PCI_MSI
-	struct fwnode_handle *fwnode = of_node_to_fwnode(pcie->dev->of_node);
-	struct nwl_msi *msi = &pcie->msi;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(nwl->dev->of_node);
+	struct nwl_msi *msi = &nwl->msi;
 
 	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
-						&dev_msi_domain_ops, pcie);
+						&dev_msi_domain_ops, nwl);
 	if (!msi->dev_domain) {
-		dev_err(pcie->dev, "failed to create dev IRQ domain\n");
+		dev_err(nwl->dev, "failed to create dev IRQ domain\n");
 		return -ENOMEM;
 	}
 	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
 						    &nwl_msi_domain_info,
 						    msi->dev_domain);
 	if (!msi->msi_domain) {
-		dev_err(pcie->dev, "failed to create msi IRQ domain\n");
+		dev_err(nwl->dev, "failed to create msi IRQ domain\n");
 		irq_domain_remove(msi->dev_domain);
 		return -ENOMEM;
 	}
@@ -515,35 +515,35 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 	return 0;
 }
 
-static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
+static int nwl_pcie_init_irq_domain(struct nwl_pcie *nwl)
 {
-	struct device_node *node = pcie->dev->of_node;
+	struct device_node *node = nwl->dev->of_node;
 	struct device_node *legacy_intc_node;
 
 	legacy_intc_node = of_get_next_child(node, NULL);
 	if (!legacy_intc_node) {
-		dev_err(pcie->dev, "No legacy intc node found\n");
+		dev_err(nwl->dev, "No legacy intc node found\n");
 		return -EINVAL;
 	}
 
-	pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
+	nwl->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
 							INTX_NUM,
 							&legacy_domain_ops,
-							pcie);
+							nwl);
 
-	if (!pcie->legacy_irq_domain) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
+	if (!nwl->legacy_irq_domain) {
+		dev_err(nwl->dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
-	nwl_pcie_init_msi_irq_domain(pcie);
+	nwl_pcie_init_msi_irq_domain(nwl);
 	return 0;
 }
 
-static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
+static int nwl_pcie_enable_msi(struct nwl_pcie *nwl, struct pci_bus *bus)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
-	struct nwl_msi *msi = &pcie->msi;
+	struct platform_device *pdev = to_platform_device(nwl->dev);
+	struct nwl_msi *msi = &nwl->msi;
 	unsigned long base;
 	int ret;
 	int size = BITS_TO_LONGS(INT_PCI_MSI_NR) * sizeof(long);
@@ -563,7 +563,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 	}
 
 	irq_set_chained_handler_and_data(msi->irq_msi1,
-					 nwl_pcie_msi_handler_high, pcie);
+					 nwl_pcie_msi_handler_high, nwl);
 
 	/* Get msi_0 IRQ number */
 	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
@@ -574,50 +574,50 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 	}
 
 	irq_set_chained_handler_and_data(msi->irq_msi0,
-					 nwl_pcie_msi_handler_low, pcie);
+					 nwl_pcie_msi_handler_low, nwl);
 
 	/* Check for msii_present bit */
-	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
+	ret = nwl_bridge_readl(nwl, I_MSII_CAPABILITIES) & MSII_PRESENT;
 	if (!ret) {
-		dev_err(pcie->dev, "MSI not present\n");
+		dev_err(nwl->dev, "MSI not present\n");
 		ret = -EIO;
 		goto err;
 	}
 
 	/* Enable MSII */
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, I_MSII_CONTROL) |
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, I_MSII_CONTROL) |
 			  MSII_ENABLE, I_MSII_CONTROL);
 
 	/* Enable MSII status */
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, I_MSII_CONTROL) |
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, I_MSII_CONTROL) |
 			  MSII_STATUS_ENABLE, I_MSII_CONTROL);
 
 	/* setup AFI/FPCI range */
-	base = pcie->phys_pcie_reg_base;
-	nwl_bridge_writel(pcie, lower_32_bits(base), I_MSII_BASE_LO);
-	nwl_bridge_writel(pcie, upper_32_bits(base), I_MSII_BASE_HI);
+	base = nwl->phys_pcie_reg_base;
+	nwl_bridge_writel(nwl, lower_32_bits(base), I_MSII_BASE_LO);
+	nwl_bridge_writel(nwl, upper_32_bits(base), I_MSII_BASE_HI);
 
 	/*
 	 * For high range MSI interrupts: disable, clear any pending,
 	 * and enable
 	 */
-	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
+	nwl_bridge_writel(nwl, (u32)~MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
 
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,  MSGF_MSI_STATUS_HI) &
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl,  MSGF_MSI_STATUS_HI) &
 			  MSGF_MSI_SR_HI_MASK, MSGF_MSI_STATUS_HI);
 
-	nwl_bridge_writel(pcie, MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
+	nwl_bridge_writel(nwl, MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
 
 	/*
 	 * For low range MSI interrupts: disable, clear any pending,
 	 * and enable
 	 */
-	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
+	nwl_bridge_writel(nwl, (u32)~MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
 
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_MSI_STATUS_LO) &
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, MSGF_MSI_STATUS_LO) &
 			  MSGF_MSI_SR_LO_MASK, MSGF_MSI_STATUS_LO);
 
-	nwl_bridge_writel(pcie, MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
+	nwl_bridge_writel(nwl, MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
 
 	return 0;
 err:
@@ -626,163 +626,163 @@ err:
 	return ret;
 }
 
-static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
+static int nwl_pcie_bridge_init(struct nwl_pcie *nwl)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
+	struct platform_device *pdev = to_platform_device(nwl->dev);
 	u32 breg_val, ecam_val, first_busno = 0;
 	int err;
 
-	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
+	breg_val = nwl_bridge_readl(nwl, E_BREG_CAPABILITIES) & BREG_PRESENT;
 	if (!breg_val) {
-		dev_err(pcie->dev, "BREG is not present\n");
+		dev_err(nwl->dev, "BREG is not present\n");
 		return breg_val;
 	}
 
 	/* Write bridge_off to breg base */
-	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_breg_base),
+	nwl_bridge_writel(nwl, lower_32_bits(nwl->phys_breg_base),
 			  E_BREG_BASE_LO);
-	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_breg_base),
+	nwl_bridge_writel(nwl, upper_32_bits(nwl->phys_breg_base),
 			  E_BREG_BASE_HI);
 
 	/* Enable BREG */
-	nwl_bridge_writel(pcie, ~BREG_ENABLE_FORCE & BREG_ENABLE,
+	nwl_bridge_writel(nwl, ~BREG_ENABLE_FORCE & BREG_ENABLE,
 			  E_BREG_CONTROL);
 
 	/* Disable DMA channel registers */
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX0) |
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, BRCFG_PCIE_RX0) |
 			  CFG_DMA_REG_BAR, BRCFG_PCIE_RX0);
 
 	/* Enable Ingress subtractive decode translation */
-	nwl_bridge_writel(pcie, SET_ISUB_CONTROL, I_ISUB_CONTROL);
+	nwl_bridge_writel(nwl, SET_ISUB_CONTROL, I_ISUB_CONTROL);
 
 	/* Enable msg filtering details */
-	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
+	nwl_bridge_writel(nwl, CFG_ENABLE_MSG_FILTER_MASK,
 			  BRCFG_PCIE_RX_MSG_FILTER);
 
-	err = nwl_wait_for_link(pcie);
+	err = nwl_wait_for_link(nwl);
 	if (err)
 		return err;
 
-	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CAPABILITIES) & E_ECAM_PRESENT;
+	ecam_val = nwl_bridge_readl(nwl, E_ECAM_CAPABILITIES) & E_ECAM_PRESENT;
 	if (!ecam_val) {
-		dev_err(pcie->dev, "ECAM is not present\n");
+		dev_err(nwl->dev, "ECAM is not present\n");
 		return ecam_val;
 	}
 
 	/* Enable ECAM */
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, E_ECAM_CONTROL) |
 			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
 
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
-			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, E_ECAM_CONTROL) |
+			  (nwl->ecam_value << E_ECAM_SIZE_SHIFT),
 			  E_ECAM_CONTROL);
 
-	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
+	nwl_bridge_writel(nwl, lower_32_bits(nwl->phys_ecam_base),
 			  E_ECAM_BASE_LO);
-	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
+	nwl_bridge_writel(nwl, upper_32_bits(nwl->phys_ecam_base),
 			  E_ECAM_BASE_HI);
 
 	/* Get bus range */
-	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
-	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
+	ecam_val = nwl_bridge_readl(nwl, E_ECAM_CONTROL);
+	nwl->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
 	/* Write primary, secondary and subordinate bus numbers */
 	ecam_val = first_busno;
 	ecam_val |= (first_busno + 1) << 8;
-	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
-	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
+	ecam_val |= (nwl->last_busno << E_ECAM_SIZE_SHIFT);
+	writel(ecam_val, (nwl->ecam_base + PCI_PRIMARY_BUS));
 
-	if (nwl_pcie_link_up(pcie))
-		dev_info(pcie->dev, "Link is UP\n");
+	if (nwl_pcie_link_up(nwl))
+		dev_info(nwl->dev, "Link is UP\n");
 	else
-		dev_info(pcie->dev, "Link is DOWN\n");
+		dev_info(nwl->dev, "Link is DOWN\n");
 
 	/* Get misc IRQ number */
-	pcie->irq_misc = platform_get_irq_byname(pdev, "misc");
-	if (pcie->irq_misc < 0) {
+	nwl->irq_misc = platform_get_irq_byname(pdev, "misc");
+	if (nwl->irq_misc < 0) {
 		dev_err(&pdev->dev, "failed to get misc IRQ %d\n",
-			pcie->irq_misc);
+			nwl->irq_misc);
 		return -EINVAL;
 	}
 
-	err = devm_request_irq(pcie->dev, pcie->irq_misc,
+	err = devm_request_irq(nwl->dev, nwl->irq_misc,
 			       nwl_pcie_misc_handler, IRQF_SHARED,
-			       "nwl_pcie:misc", pcie);
+			       "nwl_pcie:misc", nwl);
 	if (err) {
-		dev_err(pcie->dev, "fail to register misc IRQ#%d\n",
-			pcie->irq_misc);
+		dev_err(nwl->dev, "fail to register misc IRQ#%d\n",
+			nwl->irq_misc);
 		return err;
 	}
 
 	/* Disable all misc interrupts */
-	nwl_bridge_writel(pcie, (u32)~MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
+	nwl_bridge_writel(nwl, (u32)~MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
 
 	/* Clear pending misc interrupts */
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_MISC_STATUS) &
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, MSGF_MISC_STATUS) &
 			  MSGF_MISC_SR_MASKALL, MSGF_MISC_STATUS);
 
 	/* Enable all misc interrupts */
-	nwl_bridge_writel(pcie, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
+	nwl_bridge_writel(nwl, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
 
 
 	/* Disable all legacy interrupts */
-	nwl_bridge_writel(pcie, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
+	nwl_bridge_writel(nwl, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
 
 	/* Clear pending legacy interrupts */
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, MSGF_LEG_STATUS) &
 			  MSGF_LEG_SR_MASKALL, MSGF_LEG_STATUS);
 
 	/* Enable all legacy interrupts */
-	nwl_bridge_writel(pcie, MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
+	nwl_bridge_writel(nwl, MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
 
 	/* Enable the bridge config interrupt */
-	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_INTERRUPT) |
+	nwl_bridge_writel(nwl, nwl_bridge_readl(nwl, BRCFG_INTERRUPT) |
 			  BRCFG_INTERRUPT_MASK, BRCFG_INTERRUPT);
 
 	return 0;
 }
 
-static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
+static int nwl_pcie_parse_dt(struct nwl_pcie *nwl,
 			     struct platform_device *pdev)
 {
-	struct device_node *node = pcie->dev->of_node;
+	struct device_node *node = nwl->dev->of_node;
 	struct resource *res;
 	const char *type;
 
 	/* Check for device type */
 	type = of_get_property(node, "device_type", NULL);
 	if (!type || strcmp(type, "pci")) {
-		dev_err(pcie->dev, "invalid \"device_type\" %s\n", type);
+		dev_err(nwl->dev, "invalid \"device_type\" %s\n", type);
 		return -EINVAL;
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
-	pcie->breg_base = devm_ioremap_resource(pcie->dev, res);
-	if (IS_ERR(pcie->breg_base))
-		return PTR_ERR(pcie->breg_base);
-	pcie->phys_breg_base = res->start;
+	nwl->breg_base = devm_ioremap_resource(nwl->dev, res);
+	if (IS_ERR(nwl->breg_base))
+		return PTR_ERR(nwl->breg_base);
+	nwl->phys_breg_base = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcireg");
-	pcie->pcireg_base = devm_ioremap_resource(pcie->dev, res);
-	if (IS_ERR(pcie->pcireg_base))
-		return PTR_ERR(pcie->pcireg_base);
-	pcie->phys_pcie_reg_base = res->start;
+	nwl->pcireg_base = devm_ioremap_resource(nwl->dev, res);
+	if (IS_ERR(nwl->pcireg_base))
+		return PTR_ERR(nwl->pcireg_base);
+	nwl->phys_pcie_reg_base = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
-	pcie->ecam_base = devm_ioremap_resource(pcie->dev, res);
-	if (IS_ERR(pcie->ecam_base))
-		return PTR_ERR(pcie->ecam_base);
-	pcie->phys_ecam_base = res->start;
+	nwl->ecam_base = devm_ioremap_resource(nwl->dev, res);
+	if (IS_ERR(nwl->ecam_base))
+		return PTR_ERR(nwl->ecam_base);
+	nwl->phys_ecam_base = res->start;
 
 	/* Get intx IRQ number */
-	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
-	if (pcie->irq_intx < 0) {
+	nwl->irq_intx = platform_get_irq_byname(pdev, "intx");
+	if (nwl->irq_intx < 0) {
 		dev_err(&pdev->dev, "failed to get intx IRQ %d\n",
-			pcie->irq_intx);
+			nwl->irq_intx);
 		return -EINVAL;
 	}
 
-	irq_set_chained_handler_and_data(pcie->irq_intx,
-					 nwl_pcie_leg_handler, pcie);
+	irq_set_chained_handler_and_data(nwl->irq_intx,
+					 nwl_pcie_leg_handler, nwl);
 
 	return 0;
 }
@@ -795,57 +795,57 @@ static const struct of_device_id nwl_pcie_of_match[] = {
 static int nwl_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct nwl_pcie *pcie;
+	struct nwl_pcie *nwl;
 	struct pci_bus *bus;
 	struct pci_bus *child;
 	int err;
 	resource_size_t iobase = 0;
 	LIST_HEAD(res);
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	nwl = devm_kzalloc(&pdev->dev, sizeof(*nwl), GFP_KERNEL);
+	if (!nwl)
 		return -ENOMEM;
 
-	pcie->dev = &pdev->dev;
-	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
+	nwl->dev = &pdev->dev;
+	nwl->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
-	err = nwl_pcie_parse_dt(pcie, pdev);
+	err = nwl_pcie_parse_dt(nwl, pdev);
 	if (err) {
-		dev_err(pcie->dev, "Parsing DT failed\n");
+		dev_err(nwl->dev, "Parsing DT failed\n");
 		return err;
 	}
 
-	err = nwl_pcie_bridge_init(pcie);
+	err = nwl_pcie_bridge_init(nwl);
 	if (err) {
-		dev_err(pcie->dev, "HW Initialization failed\n");
+		dev_err(nwl->dev, "HW Initialization failed\n");
 		return err;
 	}
 
 	err = of_pci_get_host_bridge_resources(node, 0, 0xff, &res, &iobase);
 	if (err) {
-		dev_err(pcie->dev, "Getting bridge resources failed\n");
+		dev_err(nwl->dev, "Getting bridge resources failed\n");
 		return err;
 	}
 
-	err = devm_request_pci_bus_resources(pcie->dev, &res);
+	err = devm_request_pci_bus_resources(nwl->dev, &res);
 	if (err)
 		goto error;
 
-	err = nwl_pcie_init_irq_domain(pcie);
+	err = nwl_pcie_init_irq_domain(nwl);
 	if (err) {
-		dev_err(pcie->dev, "Failed creating IRQ Domain\n");
+		dev_err(nwl->dev, "Failed creating IRQ Domain\n");
 		goto error;
 	}
 
-	bus = pci_create_root_bus(&pdev->dev, pcie->root_busno,
-				  &nwl_pcie_ops, pcie, &res);
+	bus = pci_create_root_bus(&pdev->dev, nwl->root_busno,
+				  &nwl_pcie_ops, nwl, &res);
 	if (!bus) {
 		err = -ENOMEM;
 		goto error;
 	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		err = nwl_pcie_enable_msi(pcie, bus);
+		err = nwl_pcie_enable_msi(nwl, bus);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"failed to enable MSI support: %d\n", err);
@@ -857,7 +857,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
-	platform_set_drvdata(pdev, pcie);
+	platform_set_drvdata(pdev, nwl);
 	return 0;
 
 error:

