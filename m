Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v4 08/10] PCI: dwc: Replace lower into upper case characters
Date: Mon, 16 Apr 2018 15:37:56 +0100
Message-Id: <b63dede61a38b030c125d6b31e24e27e5c45afdd.1523881182.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replaces lower into upper case characters in comments and debug printks.

This is an attempt to keep the messages coherent within the designware
driver.

Also fixed code style on dw_pcie_irq_domain_free function.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
---
Change v1->v2:
- Added an extra log description line about code style following Fabio
Estevam suggestion.
Change v2->v3:
- Nothing changed, just to follow the patch set version.
Changes v3->v4:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-ep.c   | 16 ++++++++--------
 drivers/pci/dwc/pcie-designware-host.c | 35 ++++++++++++++++++----------------
 drivers/pci/dwc/pcie-designware.c      | 22 ++++++++++-----------
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index f07678b..15b22a6 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -75,7 +75,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
 
 	free_win = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
 	if (free_win >= ep->num_ib_windows) {
-		dev_err(pci->dev, "no free inbound window\n");
+		dev_err(pci->dev, "No free inbound window\n");
 		return -EINVAL;
 	}
 
@@ -100,7 +100,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
 
 	free_win = find_first_zero_bit(ep->ob_window_map, ep->num_ob_windows);
 	if (free_win >= ep->num_ob_windows) {
-		dev_err(pci->dev, "no free outbound window\n");
+		dev_err(pci->dev, "No free outbound window\n");
 		return -EINVAL;
 	}
 
@@ -204,7 +204,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
 
 	ret = dw_pcie_ep_outbound_atu(ep, addr, pci_addr, size);
 	if (ret) {
-		dev_err(pci->dev, "failed to enable address\n");
+		dev_err(pci->dev, "Failed to enable address\n");
 		return ret;
 	}
 
@@ -348,21 +348,21 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
 	if (ret < 0) {
-		dev_err(dev, "unable to read *num-ib-windows* property\n");
+		dev_err(dev, "Unable to read *num-ib-windows* property\n");
 		return ret;
 	}
 	if (ep->num_ib_windows > MAX_IATU_IN) {
-		dev_err(dev, "invalid *num-ib-windows*\n");
+		dev_err(dev, "Invalid *num-ib-windows*\n");
 		return -EINVAL;
 	}
 
 	ret = of_property_read_u32(np, "num-ob-windows", &ep->num_ob_windows);
 	if (ret < 0) {
-		dev_err(dev, "unable to read *num-ob-windows* property\n");
+		dev_err(dev, "Unable to read *num-ob-windows* property\n");
 		return ret;
 	}
 	if (ep->num_ob_windows > MAX_IATU_OUT) {
-		dev_err(dev, "invalid *num-ob-windows*\n");
+		dev_err(dev, "Invalid *num-ob-windows*\n");
 		return -EINVAL;
 	}
 
@@ -389,7 +389,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
-		dev_err(dev, "failed to create epc device\n");
+		dev_err(dev, "Failed to create epc device\n");
 		return PTR_ERR(epc);
 	}
 
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 6c409079..5a23f78 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -248,8 +248,10 @@ static void dw_pcie_irq_domain_free(struct irq_domain *domain,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	bitmap_release_region(pp->msi_irq_in_use, data->hwirq,
 			      order_base_2(nr_irqs));
+
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
@@ -266,7 +268,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
 	if (!pp->irq_domain) {
-		dev_err(pci->dev, "failed to create IRQ domain\n");
+		dev_err(pci->dev, "Failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
@@ -274,7 +276,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 						   &dw_pcie_msi_domain_info,
 						   pp->irq_domain);
 	if (!pp->msi_domain) {
-		dev_err(pci->dev, "failed to create MSI domain\n");
+		dev_err(pci->dev, "Failed to create MSI domain\n");
 		irq_domain_remove(pp->irq_domain);
 		return -ENOMEM;
 	}
@@ -301,13 +303,13 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	page = alloc_page(GFP_KERNEL);
 	pp->msi_data = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, pp->msi_data)) {
-		dev_err(dev, "failed to map MSI data\n");
+		dev_err(dev, "Failed to map MSI data\n");
 		__free_page(page);
 		return;
 	}
 	msi_target = (u64)pp->msi_data;
 
-	/* program the msi_data */
+	/* Program the msi_data */
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
 			    lower_32_bits(msi_target));
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
@@ -335,7 +337,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
-		dev_err(dev, "missing *config* reg space\n");
+		dev_err(dev, "Missing *config* reg space\n");
 	}
 
 	bridge = pci_alloc_host_bridge(0);
@@ -357,7 +359,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		case IORESOURCE_IO:
 			ret = pci_remap_iospace(win->res, pp->io_base);
 			if (ret) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
+				dev_warn(dev, "Error %d: failed to map resource %pR\n",
 					 ret, win->res);
 				resource_list_destroy_entry(win);
 			} else {
@@ -391,7 +393,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg->start,
 						resource_size(pp->cfg));
 		if (!pci->dbi_base) {
-			dev_err(dev, "error with ioremap\n");
+			dev_err(dev, "Error with ioremap\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -403,7 +405,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
 					pp->cfg0_base, pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
-			dev_err(dev, "error with ioremap in function\n");
+			dev_err(dev, "Error with ioremap in function\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -414,7 +416,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_base,
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
-			dev_err(dev, "error with ioremap\n");
+			dev_err(dev, "Error with ioremap\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -586,7 +588,7 @@ static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
 			return 0;
 	}
 
-	/* access only one slot on each root port */
+	/* Access only one slot on each root port */
 	if (bus->number == pp->root_bus_nr && dev > 0)
 		return 0;
 
@@ -652,11 +654,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + (ctrl * 12), 4,
 				    &pp->irq_status[ctrl]);
-	/* setup RC BARs */
+
+	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
 
-	/* setup interrupt pins */
+	/* Setup interrupt pins */
 	dw_pcie_dbi_ro_wr_en(pci);
 	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
 	val &= 0xffff00ff;
@@ -664,13 +667,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
-	/* setup bus numbers */
+	/* Setup bus numbers */
 	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
 	val &= 0xff000000;
 	val |= 0x00ff0100;
 	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
 
-	/* setup command register */
+	/* Setup command register */
 	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
@@ -683,7 +686,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
-		/* get iATU unroll support */
+		/* Get iATU unroll support */
 		pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
 		dev_dbg(pci->dev, "iATU unroll: %s\n",
 			pci->iatu_unroll_enabled ? "enabled" : "disabled");
@@ -701,7 +704,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	/* Enable write permission for the DBI read-only register */
 	dw_pcie_dbi_ro_wr_en(pci);
-	/* program correct class for RC */
+	/* Program correct class for RC */
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
 	/* Better disable write permission right after the update */
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 1b7282e..778c4f7 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -69,7 +69,7 @@ u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 
 	ret = dw_pcie_read(base + reg, size, &val);
 	if (ret)
-		dev_err(pci->dev, "read DBI address failed\n");
+		dev_err(pci->dev, "Read DBI address failed\n");
 
 	return val;
 }
@@ -86,7 +86,7 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 
 	ret = dw_pcie_write(base + reg, size, val);
 	if (ret)
-		dev_err(pci->dev, "write DBI address failed\n");
+		dev_err(pci->dev, "Write DBI address failed\n");
 }
 
 static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
@@ -137,7 +137,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
 	}
-	dev_err(pci->dev, "outbound iATU is not being enabled\n");
+	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
 
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
@@ -180,7 +180,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
 	}
-	dev_err(pci->dev, "outbound iATU is not being enabled\n");
+	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
 
 static u32 dw_pcie_readl_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg)
@@ -238,7 +238,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
 	}
-	dev_err(pci->dev, "inbound iATU is not being enabled\n");
+	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
 	return -EBUSY;
 }
@@ -284,7 +284,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
 	}
-	dev_err(pci->dev, "inbound iATU is not being enabled\n");
+	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
 	return -EBUSY;
 }
@@ -313,16 +313,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
 	int retries;
 
-	/* check if the link is up or not */
+	/* Check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
 		if (dw_pcie_link_up(pci)) {
-			dev_info(pci->dev, "link up\n");
+			dev_info(pci->dev, "Link up\n");
 			return 0;
 		}
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(pci->dev, "phy link never came up\n");
+	dev_err(pci->dev, "Phy link never came up\n");
 
 	return -ETIMEDOUT;
 }
@@ -351,7 +351,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	if (ret)
 		lanes = 0;
 
-	/* set the number of lanes */
+	/* Set the number of lanes */
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_MODE_MASK;
 	switch (lanes) {
@@ -373,7 +373,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	}
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
-	/* set link width speed control register */
+	/* Set link width speed control register */
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
 	switch (lanes) {
-- 
2.7.4
