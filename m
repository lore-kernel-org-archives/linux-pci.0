Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:38712 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbdL1L5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 06:57:47 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, nsekhar@ti.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 7/9] pci: keystone SoC driver adapted to new irq API
Date: Thu, 28 Dec 2017 11:56:45 +0000
Message-Id: <d814c419df5591f9170223d61388a0af746577c4.1514455857.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adapts Keystone SoC specific driver to use the new interrupt api
available in pcie-designware. A new callback was added to dw_pcie_host_ops
to handle a specific Keystone function and msi_host_init callback is
changed to simplify the access to pci data structure for keystone all SoC
drivers that use the structure.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- Removed hardcoded num_vectors configuration (now it is done in the core driver by default)
Change v2->v3:
- 





 drivers/pci/dwc/pci-keystone-dw.c      | 88 ++--------------------------------
 drivers/pci/dwc/pci-keystone.c         |  1 +
 drivers/pci/dwc/pci-keystone.h         |  4 +-
 drivers/pci/dwc/pci-layerscape.c       |  3 +-
 drivers/pci/dwc/pcie-designware-host.c | 19 ++++++--
 drivers/pci/dwc/pcie-designware.h      |  3 +-
 6 files changed, 26 insertions(+), 92 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 2fb20b8..4fe4ab3 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -124,19 +124,15 @@ void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 	}
 }
 
-static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
+void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 {
 	u32 offset, reg_offset, bit_pos;
 	struct keystone_pcie *ks_pcie;
-	struct msi_desc *msi;
-	struct pcie_port *pp;
 	struct dw_pcie *pci;
 
-	msi = irq_data_get_msi_desc(d);
-	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
 	pci = to_dw_pcie_from_pp(pp);
 	ks_pcie = to_keystone_pcie(pci);
-	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
+	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
 	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
 
 	ks_dw_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
@@ -166,85 +162,9 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 			 BIT(bit_pos));
 }
 
-static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
+int ks_dw_pcie_msi_host_init(struct dw_pcie *pci, struct msi_controller *chip)
 {
-	struct msi_desc *msi;
-	struct pcie_port *pp;
-	u32 offset;
-
-	msi = irq_data_get_msi_desc(d);
-	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
-	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
-
-	/* Mask the end point if PVM implemented */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		if (msi->msi_attrib.maskbit)
-			pci_msi_mask_irq(d);
-	}
-
-	ks_dw_pcie_msi_clear_irq(pp, offset);
-}
-
-static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
-{
-	struct msi_desc *msi;
-	struct pcie_port *pp;
-	u32 offset;
-
-	msi = irq_data_get_msi_desc(d);
-	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
-	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
-
-	/* Mask the end point if PVM implemented */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		if (msi->msi_attrib.maskbit)
-			pci_msi_unmask_irq(d);
-	}
-
-	ks_dw_pcie_msi_set_irq(pp, offset);
-}
-
-static struct irq_chip ks_dw_pcie_msi_irq_chip = {
-	.name = "Keystone-PCIe-MSI-IRQ",
-	.irq_ack = ks_dw_pcie_msi_irq_ack,
-	.irq_mask = ks_dw_pcie_msi_irq_mask,
-	.irq_unmask = ks_dw_pcie_msi_irq_unmask,
-};
-
-static int ks_dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-			      irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &ks_dw_pcie_msi_irq_chip,
-				 handle_level_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
-	.map = ks_dw_pcie_msi_map,
-};
-
-int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	struct device *dev = pci->dev;
-	int i;
-
-	pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np,
-					MAX_MSI_IRQS,
-					&ks_dw_pcie_msi_domain_ops,
-					chip);
-	if (!pp->irq_domain) {
-		dev_err(dev, "irq domain init failed\n");
-		return -ENXIO;
-	}
-
-	for (i = 0; i < MAX_MSI_IRQS; i++)
-		irq_create_mapping(pp->irq_domain, i);
-
-	return 0;
+	return dw_pcie_allocate_domains(pci);
 }
 
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 5bee3af..76901fa 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -297,6 +297,7 @@ static const struct dw_pcie_host_ops keystone_pcie_host_ops = {
 	.msi_clear_irq = ks_dw_pcie_msi_clear_irq,
 	.get_msi_addr = ks_dw_pcie_get_msi_addr,
 	.msi_host_init = ks_dw_pcie_msi_host_init,
+	.msi_irq_ack = ks_dw_pcie_msi_irq_ack,
 	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
 };
 
diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/dwc/pci-keystone.h
index 30b7bc2..04e1366 100644
--- a/drivers/pci/dwc/pci-keystone.h
+++ b/drivers/pci/dwc/pci-keystone.h
@@ -53,9 +53,9 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 *val);
 void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie);
+void ks_dw_pcie_msi_irq_ack(int i, struct pcie_port *pp);
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp);
-int ks_dw_pcie_msi_host_init(struct pcie_port *pp,
-		struct msi_controller *chip);
+int ks_dw_pcie_msi_host_init(struct dw_pcie *pci, struct msi_controller *chip);
 int ks_dw_pcie_link_up(struct dw_pcie *pci);
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 8f34c2f..cb9af93e3 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -185,10 +185,9 @@ static int ls1021_pcie_host_init(struct pcie_port *pp)
 	return ls_pcie_host_init(pp);
 }
 
-static int ls_pcie_msi_host_init(struct pcie_port *pp,
+static int ls_pcie_msi_host_init(struct dw_pcie *pci,
 				 struct msi_controller *chip)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *msi_node;
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 289d476..ee1c105 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -66,8 +66,20 @@ static void dw_msi_unmask_irq(struct irq_data *d)
 	irq_chip_unmask_parent(d);
 }
 
+static void dw_pci_ack_irq(struct irq_data *d)
+{
+	struct msi_desc *msi = irq_data_get_msi_desc(d);
+	struct pcie_port *pp;
+
+	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
+
+	if (pp->ops->msi_irq_ack)
+		pp->ops->msi_irq_ack(d->irq, pp);
+}
+
 static struct irq_chip dw_pcie_msi_irq_chip = {
 	.name = "PCI-MSI",
+	.irq_ack = dw_pci_ack_irq,
 	.irq_mask = dw_msi_mask_irq,
 	.irq_unmask = dw_msi_unmask_irq,
 };
@@ -234,7 +246,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, bit + i,
 				    &dw_pci_msi_bottom_irq_chip,
-				    domain->host_data, handle_simple_irq,
+				    domain->host_data, handle_level_irq,
 				    NULL, NULL);
 
 	return 0;
@@ -619,11 +631,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			if (ret)
 				goto error;
 
-			irq_set_chained_handler_and_data(pci->pp.msi_irq,
+			if (pp->msi_irq)
+				irq_set_chained_handler_and_data(pp->msi_irq,
 							 dw_chained_msi_isr,
 							 pci);
 		} else {
-			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
+			ret = pp->ops->msi_host_init(pci, &dw_pcie_msi_chip);
 			if (ret < 0)
 				goto error;
 		}
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 6178251..5294352 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -145,7 +145,8 @@ struct dw_pcie_host_ops {
 	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
-	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
+	int (*msi_host_init)(struct dw_pcie *pci, struct msi_controller *chip);
+	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
 };
 
 struct pcie_port {
-- 
2.7.4
