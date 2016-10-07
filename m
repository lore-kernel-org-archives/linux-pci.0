Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcJGQV7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:21:59 -0400
Subject: [PATCH 01/10] PCI: altera: Name private struct pointer "altera"
 consistently
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Fri, 07 Oct 2016 11:21:53 -0500
Message-ID: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "altera", for struct altera_pcie pointers to
hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |  210 ++++++++++++++++++++--------------------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index c24e965..faf6e1f 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -88,20 +88,20 @@ struct tlp_rp_regpair_t {
 	u32 reg1;
 };
 
-static inline void cra_writel(struct altera_pcie *pcie, const u32 value,
+static inline void cra_writel(struct altera_pcie *altera, const u32 value,
 			      const u32 reg)
 {
-	writel_relaxed(value, pcie->cra_base + reg);
+	writel_relaxed(value, altera->cra_base + reg);
 }
 
-static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
+static inline u32 cra_readl(struct altera_pcie *altera, const u32 reg)
 {
-	return readl_relaxed(pcie->cra_base + reg);
+	return readl_relaxed(altera->cra_base + reg);
 }
 
-static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
+static bool altera_pcie_link_is_up(struct altera_pcie *altera)
 {
-	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
+	return !!((cra_readl(altera, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
 }
 
 /*
@@ -123,31 +123,31 @@ static bool altera_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
 	return false;
 }
 
-static void tlp_write_tx(struct altera_pcie *pcie,
+static void tlp_write_tx(struct altera_pcie *altera,
 			 struct tlp_rp_regpair_t *tlp_rp_regdata)
 {
-	cra_writel(pcie, tlp_rp_regdata->reg0, RP_TX_REG0);
-	cra_writel(pcie, tlp_rp_regdata->reg1, RP_TX_REG1);
-	cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
+	cra_writel(altera, tlp_rp_regdata->reg0, RP_TX_REG0);
+	cra_writel(altera, tlp_rp_regdata->reg1, RP_TX_REG1);
+	cra_writel(altera, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
 }
 
-static bool altera_pcie_valid_config(struct altera_pcie *pcie,
+static bool altera_pcie_valid_config(struct altera_pcie *altera,
 				     struct pci_bus *bus, int dev)
 {
 	/* If there is no link, then there is no device */
-	if (bus->number != pcie->root_bus_nr) {
-		if (!altera_pcie_link_is_up(pcie))
+	if (bus->number != altera->root_bus_nr) {
+		if (!altera_pcie_link_is_up(altera))
 			return false;
 	}
 
 	/* access only one slot on each root port */
-	if (bus->number == pcie->root_bus_nr && dev > 0)
+	if (bus->number == altera->root_bus_nr && dev > 0)
 		return false;
 
 	 return true;
 }
 
-static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
+static int tlp_read_packet(struct altera_pcie *altera, u32 *value)
 {
 	int i;
 	bool sop = 0;
@@ -160,10 +160,10 @@ static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
 	 * payload.
 	 */
 	for (i = 0; i < TLP_LOOP; i++) {
-		ctrl = cra_readl(pcie, RP_RXCPL_STATUS);
+		ctrl = cra_readl(altera, RP_RXCPL_STATUS);
 		if ((ctrl & RP_RXCPL_SOP) || (ctrl & RP_RXCPL_EOP) || sop) {
-			reg0 = cra_readl(pcie, RP_RXCPL_REG0);
-			reg1 = cra_readl(pcie, RP_RXCPL_REG1);
+			reg0 = cra_readl(altera, RP_RXCPL_REG0);
+			reg1 = cra_readl(altera, RP_RXCPL_REG1);
 
 			if (ctrl & RP_RXCPL_SOP) {
 				sop = true;
@@ -186,7 +186,7 @@ static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
-static void tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
+static void tlp_write_packet(struct altera_pcie *altera, u32 *headers,
 			     u32 data, bool align)
 {
 	struct tlp_rp_regpair_t tlp_rp_regdata;
@@ -194,13 +194,13 @@ static void tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
 	tlp_rp_regdata.reg0 = headers[0];
 	tlp_rp_regdata.reg1 = headers[1];
 	tlp_rp_regdata.ctrl = RP_TX_SOP;
-	tlp_write_tx(pcie, &tlp_rp_regdata);
+	tlp_write_tx(altera, &tlp_rp_regdata);
 
 	if (align) {
 		tlp_rp_regdata.reg0 = headers[2];
 		tlp_rp_regdata.reg1 = 0;
 		tlp_rp_regdata.ctrl = 0;
-		tlp_write_tx(pcie, &tlp_rp_regdata);
+		tlp_write_tx(altera, &tlp_rp_regdata);
 
 		tlp_rp_regdata.reg0 = data;
 		tlp_rp_regdata.reg1 = 0;
@@ -210,50 +210,50 @@ static void tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
 	}
 
 	tlp_rp_regdata.ctrl = RP_TX_EOP;
-	tlp_write_tx(pcie, &tlp_rp_regdata);
+	tlp_write_tx(altera, &tlp_rp_regdata);
 }
 
-static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
+static int tlp_cfg_dword_read(struct altera_pcie *altera, u8 bus, u32 devfn,
 			      int where, u8 byte_en, u32 *value)
 {
 	u32 headers[TLP_HDR_SIZE];
 
-	if (bus == pcie->root_bus_nr)
+	if (bus == altera->root_bus_nr)
 		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD0);
 	else
 		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
 
-	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, RP_DEVFN),
+	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(altera->root_bus_nr, RP_DEVFN),
 					TLP_READ_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
-	tlp_write_packet(pcie, headers, 0, false);
+	tlp_write_packet(altera, headers, 0, false);
 
-	return tlp_read_packet(pcie, value);
+	return tlp_read_packet(altera, value);
 }
 
-static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
+static int tlp_cfg_dword_write(struct altera_pcie *altera, u8 bus, u32 devfn,
 			       int where, u8 byte_en, u32 value)
 {
 	u32 headers[TLP_HDR_SIZE];
 	int ret;
 
-	if (bus == pcie->root_bus_nr)
+	if (bus == altera->root_bus_nr)
 		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR0);
 	else
 		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
 
-	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, RP_DEVFN),
+	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(altera->root_bus_nr, RP_DEVFN),
 					TLP_WRITE_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
 	/* check alignment to Qword */
 	if ((where & 0x7) == 0)
-		tlp_write_packet(pcie, headers, value, true);
+		tlp_write_packet(altera, headers, value, true);
 	else
-		tlp_write_packet(pcie, headers, value, false);
+		tlp_write_packet(altera, headers, value, false);
 
-	ret = tlp_read_packet(pcie, NULL);
+	ret = tlp_read_packet(altera, NULL);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
 
@@ -261,13 +261,13 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	 * Monitor changes to PCI_PRIMARY_BUS register on root port
 	 * and update local copy of root bus number accordingly.
 	 */
-	if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
-		pcie->root_bus_nr = (u8)(value);
+	if ((bus == altera->root_bus_nr) && (where == PCI_PRIMARY_BUS))
+		altera->root_bus_nr = (u8)(value);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
+static int _altera_pcie_cfg_read(struct altera_pcie *altera, u8 busno,
 				 unsigned int devfn, int where, int size,
 				 u32 *value)
 {
@@ -287,7 +287,7 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 		break;
 	}
 
-	ret = tlp_cfg_dword_read(pcie, busno, devfn,
+	ret = tlp_cfg_dword_read(altera, busno, devfn,
 				 (where & ~DWORD_MASK), byte_en, &data);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
@@ -307,7 +307,7 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
+static int _altera_pcie_cfg_write(struct altera_pcie *altera, u8 busno,
 				  unsigned int devfn, int where, int size,
 				  u32 value)
 {
@@ -330,39 +330,39 @@ static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
 		break;
 	}
 
-	return tlp_cfg_dword_write(pcie, busno, devfn, (where & ~DWORD_MASK),
+	return tlp_cfg_dword_write(altera, busno, devfn, (where & ~DWORD_MASK),
 				   byte_en, data32);
 }
 
 static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 *value)
 {
-	struct altera_pcie *pcie = bus->sysdata;
+	struct altera_pcie *altera = bus->sysdata;
 
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
+	if (!altera_pcie_valid_config(altera, bus, PCI_SLOT(devfn))) {
 		*value = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	return _altera_pcie_cfg_read(pcie, bus->number, devfn, where, size,
+	return _altera_pcie_cfg_read(altera, bus->number, devfn, where, size,
 				     value);
 }
 
 static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
 				 int where, int size, u32 value)
 {
-	struct altera_pcie *pcie = bus->sysdata;
+	struct altera_pcie *altera = bus->sysdata;
 
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
+	if (!altera_pcie_valid_config(altera, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return _altera_pcie_cfg_write(pcie, bus->number, devfn, where, size,
+	return _altera_pcie_cfg_write(altera, bus->number, devfn, where, size,
 				     value);
 }
 
@@ -371,28 +371,28 @@ static struct pci_ops altera_pcie_ops = {
 	.write = altera_pcie_cfg_write,
 };
 
-static int altera_read_cap_word(struct altera_pcie *pcie, u8 busno,
+static int altera_read_cap_word(struct altera_pcie *altera, u8 busno,
 				unsigned int devfn, int offset, u16 *value)
 {
 	u32 data;
 	int ret;
 
-	ret = _altera_pcie_cfg_read(pcie, busno, devfn,
+	ret = _altera_pcie_cfg_read(altera, busno, devfn,
 				    PCIE_CAP_OFFSET + offset, sizeof(*value),
 				    &data);
 	*value = data;
 	return ret;
 }
 
-static int altera_write_cap_word(struct altera_pcie *pcie, u8 busno,
+static int altera_write_cap_word(struct altera_pcie *altera, u8 busno,
 				 unsigned int devfn, int offset, u16 value)
 {
-	return _altera_pcie_cfg_write(pcie, busno, devfn,
+	return _altera_pcie_cfg_write(altera, busno, devfn,
 				      PCIE_CAP_OFFSET + offset, sizeof(value),
 				      value);
 }
 
-static void altera_wait_link_retrain(struct altera_pcie *pcie)
+static void altera_wait_link_retrain(struct altera_pcie *altera)
 {
 	u16 reg16;
 	unsigned long start_jiffies;
@@ -400,13 +400,13 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
 	/* Wait for link training end. */
 	start_jiffies = jiffies;
 	for (;;) {
-		altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
+		altera_read_cap_word(altera, altera->root_bus_nr, RP_DEVFN,
 				     PCI_EXP_LNKSTA, &reg16);
 		if (!(reg16 & PCI_EXP_LNKSTA_LT))
 			break;
 
 		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
-			dev_err(&pcie->pdev->dev, "link retrain timeout\n");
+			dev_err(&altera->pdev->dev, "link retrain timeout\n");
 			break;
 		}
 		udelay(100);
@@ -415,43 +415,43 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
 	/* Wait for link is up */
 	start_jiffies = jiffies;
 	for (;;) {
-		if (altera_pcie_link_is_up(pcie))
+		if (altera_pcie_link_is_up(altera))
 			break;
 
 		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
-			dev_err(&pcie->pdev->dev, "link up timeout\n");
+			dev_err(&altera->pdev->dev, "link up timeout\n");
 			break;
 		}
 		udelay(100);
 	}
 }
 
-static void altera_pcie_retrain(struct altera_pcie *pcie)
+static void altera_pcie_retrain(struct altera_pcie *altera)
 {
 	u16 linkcap, linkstat, linkctl;
 
-	if (!altera_pcie_link_is_up(pcie))
+	if (!altera_pcie_link_is_up(altera))
 		return;
 
 	/*
 	 * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
 	 * current speed is 2.5 GB/s.
 	 */
-	altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_LNKCAP,
-			     &linkcap);
+	altera_read_cap_word(altera, altera->root_bus_nr, RP_DEVFN,
+			     PCI_EXP_LNKCAP, &linkcap);
 	if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
 		return;
 
-	altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_LNKSTA,
-			     &linkstat);
+	altera_read_cap_word(altera, altera->root_bus_nr, RP_DEVFN,
+			     PCI_EXP_LNKSTA, &linkstat);
 	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
-		altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
+		altera_read_cap_word(altera, altera->root_bus_nr, RP_DEVFN,
 				     PCI_EXP_LNKCTL, &linkctl);
 		linkctl |= PCI_EXP_LNKCTL_RL;
-		altera_write_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
+		altera_write_cap_word(altera, altera->root_bus_nr, RP_DEVFN,
 				      PCI_EXP_LNKCTL, linkctl);
 
-		altera_wait_link_retrain(pcie);
+		altera_wait_link_retrain(altera);
 	}
 }
 
@@ -471,25 +471,25 @@ static const struct irq_domain_ops intx_domain_ops = {
 static void altera_pcie_isr(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct altera_pcie *pcie;
+	struct altera_pcie *altera;
 	unsigned long status;
 	u32 bit;
 	u32 virq;
 
 	chained_irq_enter(chip, desc);
-	pcie = irq_desc_get_handler_data(desc);
+	altera = irq_desc_get_handler_data(desc);
 
-	while ((status = cra_readl(pcie, P2A_INT_STATUS)
+	while ((status = cra_readl(altera, P2A_INT_STATUS)
 		& P2A_INT_STS_ALL) != 0) {
 		for_each_set_bit(bit, &status, INTX_NUM) {
 			/* clear interrupts */
-			cra_writel(pcie, 1 << bit, P2A_INT_STATUS);
+			cra_writel(altera, 1 << bit, P2A_INT_STATUS);
 
-			virq = irq_find_mapping(pcie->irq_domain, bit + 1);
+			virq = irq_find_mapping(altera->irq_domain, bit + 1);
 			if (virq)
 				generic_handle_irq(virq);
 			else
-				dev_err(&pcie->pdev->dev,
+				dev_err(&altera->pdev->dev,
 					"unexpected IRQ, INT%d\n", bit);
 		}
 	}
@@ -497,23 +497,23 @@ static void altera_pcie_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
+static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *altera)
 {
 	int err, res_valid = 0;
-	struct device *dev = &pcie->pdev->dev;
+	struct device *dev = &altera->pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct resource_entry *win;
 
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
+	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &altera->resources,
 					       NULL);
 	if (err)
 		return err;
 
-	err = devm_request_pci_bus_resources(dev, &pcie->resources);
+	err = devm_request_pci_bus_resources(dev, &altera->resources);
 	if (err)
 		goto out_release_res;
 
-	resource_list_for_each_entry(win, &pcie->resources) {
+	resource_list_for_each_entry(win, &altera->resources) {
 		struct resource *res = win->res;
 
 		if (resource_type(res) == IORESOURCE_MEM)
@@ -527,19 +527,19 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
 	err = -EINVAL;
 
 out_release_res:
-	pci_free_resource_list(&pcie->resources);
+	pci_free_resource_list(&altera->resources);
 	return err;
 }
 
-static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
+static int altera_pcie_init_irq_domain(struct altera_pcie *altera)
 {
-	struct device *dev = &pcie->pdev->dev;
+	struct device *dev = &altera->pdev->dev;
 	struct device_node *node = dev->of_node;
 
 	/* Setup INTx */
-	pcie->irq_domain = irq_domain_add_linear(node, INTX_NUM + 1,
-					&intx_domain_ops, pcie);
-	if (!pcie->irq_domain) {
+	altera->irq_domain = irq_domain_add_linear(node, INTX_NUM + 1,
+					&intx_domain_ops, altera);
+	if (!altera->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
 	}
@@ -547,10 +547,10 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	return 0;
 }
 
-static int altera_pcie_parse_dt(struct altera_pcie *pcie)
+static int altera_pcie_parse_dt(struct altera_pcie *altera)
 {
 	struct resource *cra;
-	struct platform_device *pdev = pcie->pdev;
+	struct platform_device *pdev = altera->pdev;
 
 	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
 	if (!cra) {
@@ -558,70 +558,70 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 		return -ENODEV;
 	}
 
-	pcie->cra_base = devm_ioremap_resource(&pdev->dev, cra);
-	if (IS_ERR(pcie->cra_base)) {
+	altera->cra_base = devm_ioremap_resource(&pdev->dev, cra);
+	if (IS_ERR(altera->cra_base)) {
 		dev_err(&pdev->dev, "failed to map cra memory\n");
-		return PTR_ERR(pcie->cra_base);
+		return PTR_ERR(altera->cra_base);
 	}
 
 	/* setup IRQ */
-	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", pcie->irq);
+	altera->irq = platform_get_irq(pdev, 0);
+	if (altera->irq <= 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", altera->irq);
 		return -EINVAL;
 	}
 
-	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
+	irq_set_chained_handler_and_data(altera->irq, altera_pcie_isr, altera);
 
 	return 0;
 }
 
-static void altera_pcie_host_init(struct altera_pcie *pcie)
+static void altera_pcie_host_init(struct altera_pcie *altera)
 {
-	altera_pcie_retrain(pcie);
+	altera_pcie_retrain(altera);
 }
 
 static int altera_pcie_probe(struct platform_device *pdev)
 {
-	struct altera_pcie *pcie;
+	struct altera_pcie *altera;
 	struct pci_bus *bus;
 	struct pci_bus *child;
 	int ret;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	altera = devm_kzalloc(&pdev->dev, sizeof(*altera), GFP_KERNEL);
+	if (!altera)
 		return -ENOMEM;
 
-	pcie->pdev = pdev;
+	altera->pdev = pdev;
 
-	ret = altera_pcie_parse_dt(pcie);
+	ret = altera_pcie_parse_dt(altera);
 	if (ret) {
 		dev_err(&pdev->dev, "Parsing DT failed\n");
 		return ret;
 	}
 
-	INIT_LIST_HEAD(&pcie->resources);
+	INIT_LIST_HEAD(&altera->resources);
 
-	ret = altera_pcie_parse_request_of_pci_ranges(pcie);
+	ret = altera_pcie_parse_request_of_pci_ranges(altera);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed add resources\n");
 		return ret;
 	}
 
-	ret = altera_pcie_init_irq_domain(pcie);
+	ret = altera_pcie_init_irq_domain(altera);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
 		return ret;
 	}
 
 	/* clear all interrupts */
-	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
+	cra_writel(altera, P2A_INT_STS_ALL, P2A_INT_STATUS);
 	/* enable all interrupts */
-	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
-	altera_pcie_host_init(pcie);
+	cra_writel(altera, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
+	altera_pcie_host_init(altera);
 
-	bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
-				pcie, &pcie->resources);
+	bus = pci_scan_root_bus(&pdev->dev, altera->root_bus_nr,
+				&altera_pcie_ops, altera, &altera->resources);
 	if (!bus)
 		return -ENOMEM;
 
@@ -634,7 +634,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 
 	pci_bus_add_devices(bus);
 
-	platform_set_drvdata(pdev, pcie);
+	platform_set_drvdata(pdev, altera);
 	return ret;
 }
 

