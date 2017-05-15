Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:41378 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755780AbdEOREd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 13:04:33 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, marc.zyngier@arm.com
Cc: jingoohan1@gmail.com, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [RFC v2 8/8] pci: removing old irq api from pcie-designware
Date: Mon, 15 May 2017 18:03:48 +0100
Message-Id: <ca90bd0e654b8aabdafb0ddfbc194fe3a43a1855.1494867112.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494867112.git.jpinto@synopsys.com>
References: <cover.1494867112.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494867112.git.jpinto@synopsys.com>
References: <cover.1494867112.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch removes the old interrupt API.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
changes v1->v2:
- removes less because the patch set no longer has the configurable toggle
between APIs

 drivers/pci/dwc/pci-keystone-dw.c      |   2 +-
 drivers/pci/dwc/pci-keystone.h         |   2 +-
 drivers/pci/dwc/pci-layerscape.c       |   3 +-
 drivers/pci/dwc/pcie-designware-host.c | 192 +--------------------------------
 drivers/pci/dwc/pcie-designware.h      |   2 +-
 5 files changed, 6 insertions(+), 195 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index da1472e..30a5352 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -162,7 +162,7 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 			 BIT(bit_pos));
 }
 
-int ks_dw_pcie_msi_host_init(struct dw_pcie *pci, struct msi_controller *chip)
+int ks_dw_pcie_msi_host_init(struct dw_pcie *pci)
 {
 	/* overide number of vectors and sent them to Keystone Max MSI IRQs */
 	pci->pp.num_vectors = MAX_MSI_IRQS;
diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/dwc/pci-keystone.h
index 83179382..89119271 100644
--- a/drivers/pci/dwc/pci-keystone.h
+++ b/drivers/pci/dwc/pci-keystone.h
@@ -59,5 +59,5 @@ void ks_dw_pcie_msi_irq_ack(int i, struct pcie_port *pp);
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp);
-int ks_dw_pcie_msi_host_init(struct dw_pcie *pci, struct msi_controller *chip);
+int ks_dw_pcie_msi_host_init(struct dw_pcie *pci);
 int ks_dw_pcie_link_up(struct dw_pcie *pci);
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 4fb491b..231ea75 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -162,8 +162,7 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
 }
 
-static int ls_pcie_msi_host_init(struct dw_pcie *pci,
-				 struct msi_controller *chip)
+static int ls_pcie_msi_host_init(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index f1743cb..bcd7af6 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -46,14 +46,6 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
 
-static struct irq_chip dw_msi_irq_chip = {
-	.name = "PCI-MSI",
-	.irq_enable = pci_msi_unmask_irq,
-	.irq_disable = pci_msi_mask_irq,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
-};
-
 static void dw_msi_mask_irq(struct irq_data *d) {
 	pci_msi_mask_irq(d);
 	irq_chip_mask_parent(d);
@@ -313,186 +305,6 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 			    (u32)(msi_target >> 32 & 0xffffffff));
 }
 
-static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
-{
-	unsigned int res, bit, ctrl;
-
-	ctrl = irq / 32;
-	res = ctrl * 12;
-	bit = irq % 32;
-	pp->irq_status[ctrl] &= ~(1 << bit);
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
-			    pp->irq_status[ctrl]);
-}
-
-static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
-			    unsigned int nvec, unsigned int pos)
-{
-	unsigned int i;
-
-	for (i = 0; i < nvec; i++) {
-		irq_set_msi_desc_off(irq_base, i, NULL);
-		/* Disable corresponding interrupt on MSI controller */
-		if (pp->ops->msi_clear_irq)
-			pp->ops->msi_clear_irq(pp, pos + i);
-		else
-			dw_pcie_msi_clear_irq(pp, pos + i);
-	}
-
-	bitmap_release_region(pp->msi_irq_in_use, pos, order_base_2(nvec));
-}
-
-static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
-{
-	unsigned int res, bit, ctrl;
-
-	ctrl = irq / 32;
-	res = ctrl * 12;
-	bit = irq % 32;
-	pp->irq_status[ctrl] |= 1 << bit;
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
-			    pp->irq_status[ctrl]);
-}
-
-static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
-{
-	int irq, pos0, i;
-	struct pcie_port *pp;
-
-	pp = (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
-	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
-				       order_base_2(no_irqs));
-	if (pos0 < 0)
-		goto no_valid_irq;
-
-	irq = irq_find_mapping(pp->irq_domain, pos0);
-	if (!irq)
-		goto no_valid_irq;
-
-	/*
-	 * irq_create_mapping (called from dw_pcie_host_init) pre-allocates
-	 * descs so there is no need to allocate descs here. We can therefore
-	 * assume that if irq_find_mapping above returns non-zero, then the
-	 * descs are also successfully allocated.
-	 */
-
-	for (i = 0; i < no_irqs; i++) {
-		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
-			clear_irq_range(pp, irq, i, pos0);
-			goto no_valid_irq;
-		}
-		/*Enable corresponding interrupt in MSI interrupt controller */
-		if (pp->ops->msi_set_irq)
-			pp->ops->msi_set_irq(pp, pos0 + i);
-		else
-			dw_pcie_msi_set_irq(pp, pos0 + i);
-	}
-
-	*pos = pos0;
-	desc->nvec_used = no_irqs;
-	desc->msi_attrib.multiple = order_base_2(no_irqs);
-
-	return irq;
-
-no_valid_irq:
-	*pos = pos0;
-	return -ENOSPC;
-}
-
-static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
-{
-	struct msi_msg msg;
-	u64 msi_target;
-
-	if (pp->ops->get_msi_addr)
-		msi_target = pp->ops->get_msi_addr(pp);
-	else
-		msi_target = virt_to_phys((void *)pp->msi_data);
-
-	msg.address_lo = (u32)(msi_target & 0xffffffff);
-	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
-
-	if (pp->ops->get_msi_data)
-		msg.data = pp->ops->get_msi_data(pp, pos);
-	else
-		msg.data = pos;
-
-	pci_write_msi_msg(irq, &msg);
-}
-
-static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
-			    struct msi_desc *desc)
-{
-	int irq, pos;
-	struct pcie_port *pp = pdev->bus->sysdata;
-
-	if (desc->msi_attrib.is_msix)
-		return -EINVAL;
-
-	irq = assign_irq(1, desc, &pos);
-	if (irq < 0)
-		return irq;
-
-	dw_msi_setup_msg(pp, irq, pos);
-
-	return 0;
-}
-
-static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
-			     int nvec, int type)
-{
-#ifdef CONFIG_PCI_MSI
-	int irq, pos;
-	struct msi_desc *desc;
-	struct pcie_port *pp = pdev->bus->sysdata;
-
-	/* MSI-X interrupts are not supported */
-	if (type == PCI_CAP_ID_MSIX)
-		return -EINVAL;
-
-	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
-	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
-
-	irq = assign_irq(nvec, desc, &pos);
-	if (irq < 0)
-		return irq;
-
-	dw_msi_setup_msg(pp, irq, pos);
-
-	return 0;
-#else
-	return -EINVAL;
-#endif
-}
-
-static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
-{
-	struct irq_data *data = irq_get_irq_data(irq);
-	struct msi_desc *msi = irq_data_get_msi_desc(data);
-	struct pcie_port *pp = (struct pcie_port *)msi_desc_to_pci_sysdata(msi);
-
-	clear_irq_range(pp, irq, 1, data->hwirq);
-}
-
-static struct msi_controller dw_pcie_msi_chip = {
-	.setup_irq = dw_msi_setup_irq,
-	.setup_irqs = dw_msi_setup_irqs,
-	.teardown_irq = dw_msi_teardown_irq,
-};
-
-static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-			   irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops msi_domain_ops = {
-	.map = dw_pcie_msi_map,
-};
-
 int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -502,7 +314,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct resource_entry *win, *tmp;
 	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
-	int i, ret;
+	int ret;
 
 	LIST_HEAD(res);
 
@@ -614,7 +426,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 							 dw_chained_msi_isr,
 							 pci);
 		} else {
-			ret = pp->ops->msi_host_init(pci, &dw_pcie_msi_chip);
+			ret = pp->ops->msi_host_init(pci);
 			if (ret < 0)
 				goto error;
 		}
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 2ac99fa..f486587 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -140,7 +140,7 @@ struct dw_pcie_host_ops {
 	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
 	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
-	int (*msi_host_init)(struct dw_pcie *pci, struct msi_controller *chip);
+	int (*msi_host_init)(struct dw_pcie *pci);
 	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
 };
 
-- 
2.9.3
