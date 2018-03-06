Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:47519 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbeCFRyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 12:54:37 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, shawn.guo@linaro.org,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com, nsekhar@ti.com,
        gustavo.pimentel@synopsys.com
Subject: [PATCH v11 4/4] PCI: dwc: Code cleanup
Date: Tue,  6 Mar 2018 17:54:30 +0000
Message-Id: <2c64c7e5782a45cb709044c864d288043de25534.1520358461.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
References: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
References: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace magic numbers by a well known define in order to make the code
human readable and also facilitate the code reusability.

Add a callback to define the number of vectors as an example.

Exchange lower case into upper case in comments and debug printks.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 74 +++++++++++++++++++---------------
 drivers/pci/dwc/pcie-designware-plat.c |  6 +++
 drivers/pci/dwc/pcie-designware.h      |  1 +
 3 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 550fdbb..0a3db2e 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -83,18 +83,23 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	for (i = 0; i < num_ctrls; i++) {
-		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
-				    &val);
+		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
+					(i * MSI_REG_CTRL_BLOCK_SIZE),
+				    4, &val);
 		if (!val)
 			continue;
 
 		ret = IRQ_HANDLED;
 		pos = 0;
-		while ((pos = find_next_bit((unsigned long *) &val, 32,
-					    pos)) != 32) {
-			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
+		while ((pos = find_next_bit((unsigned long *) &val,
+					    MAX_MSI_IRQS_PER_CTRL,
+					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
+			irq = irq_find_mapping(pp->irq_domain,
+					       (i * MAX_MSI_IRQS_PER_CTRL) +
+					       pos);
 			generic_handle_irq(irq);
-			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
+						(i * MSI_REG_CTRL_BLOCK_SIZE),
 					    4, 1 << pos);
 			pos++;
 		}
@@ -157,9 +162,9 @@ static void dw_pci_bottom_mask(struct irq_data *data)
 	if (pp->ops->msi_clear_irq) {
 		pp->ops->msi_clear_irq(pp, data->hwirq);
 	} else {
-		ctrl = data->hwirq / 32;
-		res = ctrl * 12;
-		bit = data->hwirq % 32;
+		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 		pp->irq_status[ctrl] &= ~(1 << bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
@@ -180,9 +185,9 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
 	if (pp->ops->msi_set_irq) {
 		pp->ops->msi_set_irq(pp, data->hwirq);
 	} else {
-		ctrl = data->hwirq / 32;
-		res = ctrl * 12;
-		bit = data->hwirq % 32;
+		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 		pp->irq_status[ctrl] |= 1 << bit;
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
@@ -248,8 +253,10 @@ static void dw_pcie_irq_domain_free(struct irq_domain *domain,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	bitmap_release_region(pp->msi_irq_in_use, data->hwirq,
 			      order_base_2(nr_irqs));
+
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
@@ -266,7 +273,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
 	if (!pp->irq_domain) {
-		dev_err(pci->dev, "failed to create IRQ domain\n");
+		dev_err(pci->dev, "Failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
@@ -274,7 +281,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 						   &dw_pcie_msi_domain_info,
 						   pp->irq_domain);
 	if (!pp->msi_domain) {
-		dev_err(pci->dev, "failed to create MSI domain\n");
+		dev_err(pci->dev, "Failed to create MSI domain\n");
 		irq_domain_remove(pp->irq_domain);
 		return -ENOMEM;
 	}
@@ -307,7 +314,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	}
 	msi_target = (u64)pp->msi_data;
 
-	/* program the msi_data */
+	/* Program the msi_data */
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
 			    lower_32_bits(msi_target));
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
@@ -330,12 +337,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
-		pp->cfg0_size = resource_size(cfg_res) / 2;
-		pp->cfg1_size = resource_size(cfg_res) / 2;
+		pp->cfg0_size = resource_size(cfg_res) >> 1;
+		pp->cfg1_size = resource_size(cfg_res) >> 1;
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
-		dev_err(dev, "missing *config* reg space\n");
+		dev_err(dev, "Missing *config* reg space\n");
 	}
 
 	bridge = pci_alloc_host_bridge(0);
@@ -357,7 +364,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		case IORESOURCE_IO:
 			ret = pci_remap_iospace(win->res, pp->io_base);
 			if (ret) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
+				dev_warn(dev, "Error %d: failed to map resource %pR\n",
 					 ret, win->res);
 				resource_list_destroy_entry(win);
 			} else {
@@ -375,8 +382,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			break;
 		case 0:
 			pp->cfg = win->res;
-			pp->cfg0_size = resource_size(pp->cfg) / 2;
-			pp->cfg1_size = resource_size(pp->cfg) / 2;
+			pp->cfg0_size = resource_size(pp->cfg) >> 1;
+			pp->cfg1_size = resource_size(pp->cfg) >> 1;
 			pp->cfg0_base = pp->cfg->start;
 			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
 			break;
@@ -391,7 +398,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg->start,
 						resource_size(pp->cfg));
 		if (!pci->dbi_base) {
-			dev_err(dev, "error with ioremap\n");
+			dev_err(dev, "Error with ioremap\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -403,7 +410,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
 					pp->cfg0_base, pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
-			dev_err(dev, "error with ioremap in function\n");
+			dev_err(dev, "Error with ioremap in function\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -414,7 +421,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_base,
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
-			dev_err(dev, "error with ioremap\n");
+			dev_err(dev, "Error with ioremap\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -586,7 +593,7 @@ static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
 			return 0;
 	}
 
-	/* access only one slot on each root port */
+	/* Access only one slot on each root port */
 	if (bus->number == pp->root_bus_nr && dev > 0)
 		return 0;
 
@@ -650,13 +657,14 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	/* Initialize IRQ Status array */
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
-		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + (ctrl * 12), 4,
-				    &pp->irq_status[ctrl]);
-	/* setup RC BARs */
+		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
+					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+				    4, &pp->irq_status[ctrl]);
+	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
 
-	/* setup interrupt pins */
+	/* Setup interrupt pins */
 	dw_pcie_dbi_ro_wr_en(pci);
 	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
 	val &= 0xffff00ff;
@@ -664,13 +672,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
-	/* setup bus numbers */
+	/* Setup bus numbers */
 	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
 	val &= 0xff000000;
 	val |= 0x00010100;
 	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
 
-	/* setup command register */
+	/* Setup command register */
 	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
@@ -683,7 +691,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
-		/* get iATU unroll support */
+		/* Get iATU unroll support */
 		pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
 		dev_dbg(pci->dev, "iATU unroll: %s\n",
 			pci->iatu_unroll_enabled ? "enabled" : "disabled");
@@ -701,7 +709,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	/* Enable write permission for the DBI read-only register */
 	dw_pcie_dbi_ro_wr_en(pci);
-	/* program correct class for RC */
+	/* Program correct class for RC */
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
 	/* Better disable write permission right after the update */
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 5416aa8..83e316e 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -38,8 +38,14 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static void dw_plat_set_num_vectors(struct pcie_port *pp)
+{
+	pp->num_vectors = MSI_DEF_NUM_VECTORS;
+}
+
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 	.host_init = dw_plat_pcie_host_init,
+	.set_num_vectors = dw_plat_set_num_vectors,
 };
 
 static int dw_plat_add_pcie_port(struct pcie_port *pp,
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index fe811db..bee4e25 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -110,6 +110,7 @@
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
+#define MSI_REG_CTRL_BLOCK_SIZE		12
 #define MSI_DEF_NUM_VECTORS		32
 
 /* Maximum number of inbound/outbound iATUs */
-- 
2.7.4
