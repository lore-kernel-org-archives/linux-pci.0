Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:36324 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeBWPKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 10:10:40 -0500
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
Subject: [PATCH v7 8/9] PCI: dwc: Remove old IRQ API
Date: Fri, 23 Feb 2018 15:10:31 +0000
Message-Id: <04106cc04a571d4b7629b34b3cfbe573fbd0a149.1519318663.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
References: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
References: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Removes the unused old IRQ API from pcie-designware.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- Nothing changed, just to follow the patch set version.
Change v2->v3:
- Nothing changed, just to follow the patch set version.
Change v3->v4:
- Patch renamed from v3-0008 to v4-0009.
- Changed summary line to match the drivers/PCI convention and changelog to
maintain the consistency (thanks Bjorn).
Change v4->v5:
- Nothing changed, just to follow the patch set version.
Change v5->v6:
- Nothing changed, just to follow the patch set version.
Change v6->v7:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pci-keystone-dw.c      |   2 +-
 drivers/pci/dwc/pci-keystone.h         |   3 +-
 drivers/pci/dwc/pci-layerscape.c       |   3 +-
 drivers/pci/dwc/pcie-designware-host.c | 190 +--------------------------------
 drivers/pci/dwc/pcie-designware.h      |   2 +-
 5 files changed, 5 insertions(+), 195 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index ace498e..7705814 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -161,7 +161,7 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 			 BIT(bit_pos));
 }
 
-int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
+int ks_dw_pcie_msi_host_init(struct pcie_port *pp)
 {
 	return dw_pcie_allocate_domains(pp);
 }
diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/dwc/pci-keystone.h
index aed3c73..8ac2f12 100644
--- a/drivers/pci/dwc/pci-keystone.h
+++ b/drivers/pci/dwc/pci-keystone.h
@@ -57,6 +57,5 @@ void ks_dw_pcie_msi_irq_ack(int i, struct pcie_port *pp);
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp);
-int ks_dw_pcie_msi_host_init(struct pcie_port *pp,
-		struct msi_controller *chip);
+int ks_dw_pcie_msi_host_init(struct pcie_port *pp);
 int ks_dw_pcie_link_up(struct dw_pcie *pci);
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 8f34c2f..e77ff65 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -185,8 +185,7 @@ static int ls1021_pcie_host_init(struct pcie_port *pp)
 	return ls_pcie_host_init(pp);
 }
 
-static int ls_pcie_msi_host_init(struct pcie_port *pp,
-				 struct msi_controller *chip)
+static int ls_pcie_msi_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 2bbe80c..2dc4941 100644
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
 static void dw_msi_ack_irq(struct irq_data *d)
 {
 	irq_chip_ack_parent(d);
@@ -325,186 +317,6 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 			    upper_32_bits(msi_target));
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
-		msi_target = (u64)pp->msi_data;
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
@@ -644,7 +456,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 							    dw_chained_msi_isr,
 							    pp);
 		} else {
-			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
+			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
 				goto error;
 		}
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index b603e88..c77c2e0 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -154,7 +154,7 @@ struct dw_pcie_host_ops {
 	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
-	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
+	int (*msi_host_init)(struct pcie_port *pp);
 	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
 };
 
-- 
2.7.4
