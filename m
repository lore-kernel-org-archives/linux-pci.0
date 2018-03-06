Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:60920 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753880AbeCFRyh (ORCPT
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
Subject: [PATCH v11 1/4] PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API
Date: Tue,  6 Mar 2018 17:54:27 +0000
Message-Id: <7c5925afbc58c6d6b384e1dc051bb992969bf787.1520358461.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
References: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
References: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement a multiplexed IRQ domain hierarchy API in the pcie-designware
host bridge driver that funnels all MSI IRQs into a single parent
interrupt, moving away from the obsolete struct msi_controller based
API.

Although the old implementation API is still available, pcie-designware
will now use the multiplexed IRQ domains hierarchical API.

Remove all existing dwc based host bridges MSI IRQs handlers, in that the
hierarchical API now handles MSI IRQs through the hierarchical/chained
MSI domain implementation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
Change v1->v2:
- num_vectors is now not configurable by the Device Tree. Now it is 32 by
default and can be overridden by any specific SoC driver.
Change v2->v3:
- Nothing changed, just to follow the patch set version.
Change v3->v4:
- Moved Kishon's fixes (PCI end point error and a dra7xx warning) from
v3-0007 patch file to here.
- Undo the change of the function signature to be more coherent with the
host mode specific functions (Thanks Kishon).
- Refactor the added functions in order to used host_data so that getting
pp again back from pci could be avoided. (Thanks Kishon)
- Changed summary line to match the drivers/PCI convention and changelog to
maintain the consistency (thanks Bjorn).
Change v4->v5:
- Implemented Kishon MSI multiple messages fix (thanks Kishon).
Change v5->v6:
- Fixed rebase problem detected by Niklas (thanks Niklas).
Change v6->v7:
- Implemented Marc review suggestions (thanks Marc).
Change v7->v8:
- Rebased against v4.16-rc1.
Change v8->v9:
- Squashed all patches [2-7] into this, following Lorenzo sugestion (thanks
Lorenzo).
Change v9->v10:
- Log commit rewrite to be accurate by Lorenzo (thanks Lorenzo).
- Fixed kbuild test robot warning relatively to the raw_spin_lock.
- Extended patch fix to pcie-histb driver.
Change v10->v11:
- Replace unsign to sign variable type mistake (thanks Lucas).

 drivers/pci/dwc/pci-exynos.c           |  18 --
 drivers/pci/dwc/pci-imx6.c             |  18 --
 drivers/pci/dwc/pci-keystone-dw.c      |  89 +---------
 drivers/pci/dwc/pci-keystone.c         |   1 +
 drivers/pci/dwc/pci-keystone.h         |   1 +
 drivers/pci/dwc/pcie-artpec6.c         |  18 --
 drivers/pci/dwc/pcie-designware-host.c | 294 +++++++++++++++++++++++++++++----
 drivers/pci/dwc/pcie-designware-plat.c |  16 --
 drivers/pci/dwc/pcie-designware.h      |  18 ++
 drivers/pci/dwc/pcie-histb.c           |  15 --
 drivers/pci/dwc/pcie-qcom.c            |  16 --
 11 files changed, 290 insertions(+), 214 deletions(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index ca62781..4cc1e5d 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -294,15 +294,6 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct exynos_pcie *ep = arg;
-	struct dw_pcie *pci = ep->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static void exynos_pcie_msi_init(struct exynos_pcie *ep)
 {
 	struct dw_pcie *pci = ep->pci;
@@ -428,15 +419,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 			dev_err(dev, "failed to get msi irq\n");
 			return pp->msi_irq;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-					exynos_pcie_msi_irq_handler,
-					IRQF_SHARED | IRQF_NO_THREAD,
-					"exynos-pcie", ep);
-		if (ret) {
-			dev_err(dev, "failed to request msi irq\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 4fddbd0..4818ef8 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -542,15 +542,6 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	return -EINVAL;
 }
 
-static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
-{
-	struct imx6_pcie *imx6_pcie = arg;
-	struct dw_pcie *pci = imx6_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -674,15 +665,6 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 			dev_err(dev, "failed to get MSI irq\n");
 			return -ENODEV;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       imx6_pcie_msi_handler,
-				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "mx6-pcie-msi", imx6_pcie);
-		if (ret) {
-			dev_err(dev, "failed to request MSI irq\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
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
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 93b3df9..e66cede 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -383,15 +383,6 @@ static const struct dw_pcie_host_ops artpec6_pcie_host_ops = {
 	.host_init = artpec6_pcie_host_init,
 };
 
-static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
-{
-	struct artpec6_pcie *artpec6_pcie = arg;
-	struct dw_pcie *pci = artpec6_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 				 struct platform_device *pdev)
 {
@@ -406,15 +397,6 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 			dev_err(dev, "failed to get MSI irq\n");
 			return pp->msi_irq;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       artpec6_pcie_msi_handler,
-				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "artpec6-pcie-msi", artpec6_pcie);
-		if (ret) {
-			dev_err(dev, "failed to request MSI irq\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 8de2d5c..a28c496 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -50,6 +51,36 @@ static struct irq_chip dw_msi_irq_chip = {
 	.irq_unmask = pci_msi_unmask_irq,
 };
 
+static void dw_msi_ack_irq(struct irq_data *d)
+{
+	irq_chip_ack_parent(d);
+}
+
+static void dw_msi_mask_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void dw_msi_unmask_irq(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip dw_pcie_msi_irq_chip = {
+	.name = "PCI-MSI",
+	.irq_ack = dw_msi_ack_irq,
+	.irq_mask = dw_msi_mask_irq,
+	.irq_unmask = dw_msi_unmask_irq,
+};
+
+static struct msi_domain_info dw_pcie_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.chip	= &dw_pcie_msi_irq_chip,
+};
+
 /* MSI int handler */
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
@@ -78,6 +109,194 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	return ret;
 }
 
+/* Chained MSI interrupt service routine */
+static void dw_chained_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct pcie_port *pp;
+
+	chained_irq_enter(chip, desc);
+
+	pp = irq_desc_get_handler_data(desc);
+	dw_handle_msi_irq(pp);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u64 msi_target;
+
+	if (pp->ops->get_msi_addr)
+		msi_target = pp->ops->get_msi_addr(pp);
+	else
+		msi_target = (u64)pp->msi_data;
+
+	msg->address_lo = lower_32_bits(msi_target);
+	msg->address_hi = upper_32_bits(msi_target);
+
+	if (pp->ops->get_msi_data)
+		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
+	else
+		msg->data = data->hwirq;
+
+	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
+				   const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static void dw_pci_bottom_mask(struct irq_data *data)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	unsigned int res, bit, ctrl;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	if (pp->ops->msi_clear_irq) {
+		pp->ops->msi_clear_irq(pp, data->hwirq);
+	} else {
+		ctrl = data->hwirq / 32;
+		res = ctrl * 12;
+		bit = data->hwirq % 32;
+
+		pp->irq_status[ctrl] &= ~(1 << bit);
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
+				    pp->irq_status[ctrl]);
+	}
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static void dw_pci_bottom_unmask(struct irq_data *data)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	unsigned int res, bit, ctrl;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	if (pp->ops->msi_set_irq) {
+		pp->ops->msi_set_irq(pp, data->hwirq);
+	} else {
+		ctrl = data->hwirq / 32;
+		res = ctrl * 12;
+		bit = data->hwirq % 32;
+
+		pp->irq_status[ctrl] |= 1 << bit;
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
+				    pp->irq_status[ctrl]);
+	}
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static void dw_pci_bottom_ack(struct irq_data *d)
+{
+	struct msi_desc *msi = irq_data_get_msi_desc(d);
+	struct pcie_port *pp;
+
+	pp = msi_desc_to_pci_sysdata(msi);
+
+	if (pp->ops->msi_irq_ack)
+		pp->ops->msi_irq_ack(d->hwirq, pp);
+}
+
+static struct irq_chip dw_pci_msi_bottom_irq_chip = {
+	.name = "DWPCI-MSI",
+	.irq_ack = dw_pci_bottom_ack,
+	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
+	.irq_set_affinity = dw_pci_msi_set_affinity,
+	.irq_mask = dw_pci_bottom_mask,
+	.irq_unmask = dw_pci_bottom_unmask,
+};
+
+static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs,
+				    void *args)
+{
+	struct pcie_port *pp = domain->host_data;
+	unsigned long flags;
+	u32 i;
+	int bit;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
+				      order_base_2(nr_irqs));
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+
+	if (bit < 0)
+		return -ENOSPC;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, bit + i,
+				    &dw_pci_msi_bottom_irq_chip,
+				    pp, handle_edge_irq,
+				    NULL, NULL);
+
+	return 0;
+}
+
+static void dw_pcie_irq_domain_free(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+	bitmap_release_region(pp->msi_irq_in_use, data->hwirq,
+			      order_base_2(nr_irqs));
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
+	.alloc	= dw_pcie_irq_domain_alloc,
+	.free	= dw_pcie_irq_domain_free,
+};
+
+int dw_pcie_allocate_domains(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
+
+	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
+					       &dw_pcie_msi_domain_ops, pp);
+	if (!pp->irq_domain) {
+		dev_err(pci->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
+						   &dw_pcie_msi_domain_info,
+						   pp->irq_domain);
+	if (!pp->msi_domain) {
+		dev_err(pci->dev, "failed to create MSI domain\n");
+		irq_domain_remove(pp->irq_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void dw_pcie_free_msi(struct pcie_port *pp)
+{
+	irq_set_chained_handler(pp->msi_irq, NULL);
+	irq_set_handler_data(pp->msi_irq, NULL);
+
+	irq_domain_remove(pp->msi_domain);
+	irq_domain_remove(pp->irq_domain);
+}
+
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -96,20 +315,21 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 
 	/* program the msi_data */
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
-			    (u32)(msi_target & 0xffffffff));
+			    lower_32_bits(msi_target));
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
-			    (u32)(msi_target >> 32 & 0xffffffff));
+			    upper_32_bits(msi_target));
 }
 
 static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 {
-	unsigned int res, bit, val;
+	unsigned int res, bit, ctrl;
 
-	res = (irq / 32) * 12;
+	ctrl = irq / 32;
+	res = ctrl * 12;
 	bit = irq % 32;
-	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
-	val &= ~(1 << bit);
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+	pp->irq_status[ctrl] &= ~(1 << bit);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
+			    pp->irq_status[ctrl]);
 }
 
 static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
@@ -131,13 +351,14 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
 
 static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 {
-	unsigned int res, bit, val;
+	unsigned int res, bit, ctrl;
 
-	res = (irq / 32) * 12;
+	ctrl = irq / 32;
+	res = ctrl * 12;
 	bit = irq % 32;
-	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
-	val |= 1 << bit;
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+	pp->irq_status[ctrl] |= 1 << bit;
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
+			    pp->irq_status[ctrl]);
 }
 
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
@@ -285,11 +506,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct resource_entry *win, *tmp;
 	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
-	int i, ret;
-	struct resource_entry *win, *tmp;
+	int ret;
+
+	raw_spin_lock_init(&pci->pp.lock);
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -388,18 +611,33 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pci->num_viewport = 2;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		if (!pp->ops->msi_host_init) {
-			pp->irq_domain = irq_domain_add_linear(dev->of_node,
-						MAX_MSI_IRQS, &msi_domain_ops,
-						&dw_pcie_msi_chip);
-			if (!pp->irq_domain) {
-				dev_err(dev, "irq domain init failed\n");
-				ret = -ENXIO;
+		/*
+		 * If a specific SoC driver needs to change the
+		 * default number of vectors, it needs to implement
+		 * the set_num_vectors callback.
+		 */
+		if (!pp->ops->set_num_vectors) {
+			pp->num_vectors = MSI_DEF_NUM_VECTORS;
+		} else {
+			pp->ops->set_num_vectors(pp);
+
+			if (pp->num_vectors > MAX_MSI_IRQS ||
+			    pp->num_vectors == 0) {
+				dev_err(dev,
+					"Invalid number of vectors\n");
 				goto error;
 			}
+		}
 
-			for (i = 0; i < MAX_MSI_IRQS; i++)
-				irq_create_mapping(pp->irq_domain, i);
+		if (!pp->ops->msi_host_init) {
+			ret = dw_pcie_allocate_domains(pp);
+			if (ret)
+				goto error;
+
+			if (pp->msi_irq)
+				irq_set_chained_handler_and_data(pp->msi_irq,
+							    dw_chained_msi_isr,
+							    pp);
 		} else {
 			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
 			if (ret < 0)
@@ -421,10 +659,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	bridge->ops = &dw_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		bridge->msi = &dw_pcie_msi_chip;
-		dw_pcie_msi_chip.dev = dev;
-	}
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
@@ -593,11 +827,15 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
-	u32 val;
+	u32 val, ctrl;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	dw_pcie_setup(pci);
 
+	/* Initialize IRQ Status array */
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
+		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + (ctrl * 12), 4,
+				    &pp->irq_status[ctrl]);
 	/* setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index ebdf28b..5416aa8 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -25,13 +25,6 @@ struct dw_plat_pcie {
 	struct dw_pcie		*pci;
 };
 
-static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static int dw_plat_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -63,15 +56,6 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-					dw_plat_pcie_msi_irq_handler,
-					IRQF_SHARED | IRQF_NO_THREAD,
-					"dw-plat-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "failed to request MSI IRQ\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 11b1386..c80ee86 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -114,6 +114,7 @@
  */
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
+#define MSI_DEF_NUM_VECTORS		32
 
 /* Maximum number of inbound/outbound iATUs */
 #define MAX_IATU_IN			256
@@ -149,7 +150,9 @@ struct dw_pcie_host_ops {
 	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
 	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
+	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
+	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
 };
 
 struct pcie_port {
@@ -174,7 +177,11 @@ struct pcie_port {
 	const struct dw_pcie_host_ops *ops;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
+	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
+	u32			num_vectors;
+	u32			irq_status[MAX_MSI_CTRLS];
+	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
@@ -316,8 +323,10 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
+void dw_pcie_free_msi(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+int dw_pcie_allocate_domains(struct pcie_port *pp);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
@@ -328,6 +337,10 @@ static inline void dw_pcie_msi_init(struct pcie_port *pp)
 {
 }
 
+static inline void dw_pcie_free_msi(struct pcie_port *pp)
+{
+}
+
 static inline void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 }
@@ -336,6 +349,11 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
 {
 	return 0;
 }
+
+static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCIE_DW_EP
diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
index 70b5c0b..5d47b90 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -207,13 +207,6 @@ static struct dw_pcie_host_ops histb_pcie_host_ops = {
 	.host_init = histb_pcie_host_init,
 };
 
-static irqreturn_t histb_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 {
 	reset_control_assert(hipcie->soft_reset);
@@ -393,14 +386,6 @@ static int histb_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get MSI IRQ\n");
 			return pp->msi_irq;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       histb_pcie_msi_irq_handler,
-				       IRQF_SHARED, "histb-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "cannot request MSI IRQ\n");
-			return ret;
-		}
 	}
 
 	hipcie->phy = devm_phy_get(dev, "phy");
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 6310c66..89e5cc5 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -180,13 +180,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
@@ -1262,15 +1255,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       qcom_pcie_msi_irq_handler,
-				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "qcom-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "cannot request msi irq\n");
-			return ret;
-		}
 	}
 
 	ret = phy_init(pcie->phy);
-- 
2.7.4
