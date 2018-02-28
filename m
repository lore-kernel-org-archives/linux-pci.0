Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37736 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeB1MEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 07:04:37 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, nsekhar@ti.com, gustavo.pimentel@synopsys.com
Subject: [PATCH v8 7/9] PCI: dwc: keystone: Switch to use the new IRQ API
Date: Wed, 28 Feb 2018 12:04:20 +0000
Message-Id: <341e24b44cc04210c05e64fc918b2c812066a8ee.1519819020.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
References: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
References: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes KeyStone SoC specific driver to use the new IRQ API available
in pcie-designware.

Adds new callback (ks_dw_pcie_msi_irq_ack) to dw_pcie_host_ops to handle a
specific KeyStone behavior.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- Removed hardcoded num_vectors configuration (now it is done in the core
driver by default).
Change v2->v3:
- Added Kishon's fixes (PCI end point error and a dra7xx warning).
Change v3->v4:
- Moved Kishon's fixes to v4-0001 patch file.
- Moved msi_host_init function signature change to a new v4-0008 patch file.
- Changed summary line to match the drivers/PCI convention and changelog to
maintain the consistency (thanks Bjorn).
Change v4->v5:
- Fix rebase problem.
- Implemented Kishon's suggestion.
Change v5->v6:
- Nothing changed, just to follow the patch set version.
Change v6->v7:
- Nothing changed, just to follow the patch set version.
Change v7->v8:
- Rebased against v4.16-rc1.

 drivers/pci/dwc/pci-keystone-dw.c | 89 ++-------------------------------------
 drivers/pci/dwc/pci-keystone.c    |  1 +
 drivers/pci/dwc/pci-keystone.h    |  1 +
 3 files changed, 6 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 99a0e70..86e613a 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -120,20 +120,15 @@ void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 	}
 }
 
-static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
+void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 {
-	u32 offset, reg_offset, bit_pos;
+	u32 reg_offset, bit_pos;
 	struct keystone_pcie *ks_pcie;
-	struct msi_desc *msi;
-	struct pcie_port *pp;
 	struct dw_pcie *pci;
 
-	msi = irq_data_get_msi_desc(d);
-	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
 	pci = to_dw_pcie_from_pp(pp);
 	ks_pcie = to_keystone_pcie(pci);
-	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
-	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
+	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
 
 	ks_dw_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
 			 BIT(bit_pos));
@@ -162,85 +157,9 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 			 BIT(bit_pos));
 }
 
-static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
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
 int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
 {
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
+	return dw_pcie_allocate_domains(pp);
 }
 
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index d4f8ab9..d55ae07 100644
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
index 1dd1f3e..aa50448 100644
--- a/drivers/pci/dwc/pci-keystone.h
+++ b/drivers/pci/dwc/pci-keystone.h
@@ -49,6 +49,7 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 *val);
 void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie);
+void ks_dw_pcie_msi_irq_ack(int i, struct pcie_port *pp);
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp);
-- 
2.7.4
