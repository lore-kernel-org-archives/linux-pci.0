Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:50620 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbdL1L5r (ORCPT
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
Subject: [PATCH v3 1/9] pci: adding new irq api to pci-designware
Date: Thu, 28 Dec 2017 11:56:39 +0000
Message-Id: <a89026e05ea55cf82b9b6d82240a275556bbe08f.1514455857.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the new interrupt api to pcie-designware, keeping the old
one. Although the old API is still available, pcie-designware initiates
with the new one.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- num_vectors is now not configurable by DT. Now it is 32 by default and
can be overridden by any specific SoC driver.
Change v2->v3:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-host.c | 282 +++++++++++++++++++++++++++++----
 drivers/pci/dwc/pcie-designware.h      |  17 ++
 2 files changed, 272 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 81e2157..289d476 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -53,6 +54,30 @@ static struct irq_chip dw_msi_irq_chip = {
 	.irq_unmask = pci_msi_unmask_irq,
 };
 
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
+	.irq_mask = dw_msi_mask_irq,
+	.irq_unmask = dw_msi_unmask_irq,
+};
+
+static struct msi_domain_info dw_pcie_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		     MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.chip	= &dw_pcie_msi_irq_chip,
+};
+
 /* MSI int handler */
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
@@ -81,6 +106,191 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	return ret;
 }
 
+/* Chained MSI interrupt service routine */
+static void dw_chained_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct pcie_port *pp;
+	struct dw_pcie *pci;
+
+	chained_irq_enter(chip, desc);
+	pci = irq_desc_get_handler_data(desc);
+	pp = &pci->pp;
+
+	dw_handle_msi_irq(pp);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = &pci->pp;
+	u64 msi_target;
+
+	if (pp->ops->get_msi_addr)
+		msi_target = pp->ops->get_msi_addr(pp);
+	else
+		msi_target = virt_to_phys((void *)pp->msi_data);
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
+	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = &pci->pp;
+	unsigned int res, bit, ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pp->lock, flags);
+
+	if (pp->ops->msi_clear_irq)
+		pp->ops->msi_clear_irq(pp, data->hwirq);
+	else {
+		ctrl = data->hwirq / 32;
+		res = ctrl * 12;
+		bit = data->hwirq % 32;
+
+		pp->irq_status[ctrl] &= ~(1 << bit);
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
+				    pp->irq_status[ctrl]);
+	}
+
+	spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static void dw_pci_bottom_unmask(struct irq_data *data)
+{
+	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = &pci->pp;
+	unsigned int res, bit, ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pp->lock, flags);
+
+	if (pp->ops->msi_set_irq)
+		pp->ops->msi_set_irq(pp, data->hwirq);
+	else {
+		ctrl = data->hwirq / 32;
+		res = ctrl * 12;
+		bit = data->hwirq % 32;
+
+		pp->irq_status[ctrl] |= 1 << bit;
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
+				    pp->irq_status[ctrl]);
+	}
+
+	spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static struct irq_chip dw_pci_msi_bottom_irq_chip = {
+	.name = "DWPCI-MSI",
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
+	struct dw_pcie *pci = domain->host_data;
+	struct pcie_port *pp = &pci->pp;
+	unsigned long flags;
+	unsigned long bit;
+	u32 i;
+
+	spin_lock_irqsave(&pp->lock, flags);
+
+	bit = bitmap_find_next_zero_area(pp->msi_irq_in_use, pp->num_vectors, 0,
+					 nr_irqs, 0);
+
+	if (bit >= pp->num_vectors) {
+		spin_unlock_irqrestore(&pp->lock, flags);
+		return -ENOSPC;
+	}
+
+	bitmap_set(pp->msi_irq_in_use, bit, nr_irqs);
+
+	spin_unlock_irqrestore(&pp->lock, flags);
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, bit + i,
+				    &dw_pci_msi_bottom_irq_chip,
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
+
+	return 0;
+}
+
+static void dw_pcie_irq_domain_free(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = &pci->pp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pp->lock, flags);
+	bitmap_clear(pp->msi_irq_in_use, data->hwirq, nr_irqs);
+	spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
+	.alloc	= dw_pcie_irq_domain_alloc,
+	.free	= dw_pcie_irq_domain_free,
+};
+
+int dw_pcie_allocate_domains(struct dw_pcie *pci)
+{
+	struct pcie_port *pp = &pci->pp;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
+
+	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
+					       &dw_pcie_msi_domain_ops, pci);
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
 	u64 msi_target;
@@ -90,20 +300,21 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 
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
@@ -125,13 +336,14 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
 
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
@@ -279,11 +491,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct resource_entry *win, *tmp;
 	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
 	int i, ret;
-	struct resource_entry *win, *tmp;
+
+	spin_lock_init(&pci->pp.lock);
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -382,18 +596,32 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
+			ret = dw_pcie_allocate_domains(pci);
+			if (ret)
+				goto error;
+
+			irq_set_chained_handler_and_data(pci->pp.msi_irq,
+							 dw_chained_msi_isr,
+							 pci);
 		} else {
 			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
 			if (ret < 0)
@@ -415,10 +643,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	bridge->ops = &dw_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		bridge->msi = &dw_pcie_msi_chip;
-		dw_pcie_msi_chip.dev = dev;
-	}
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
@@ -587,11 +811,15 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 
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
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index e5d9d77..6178251 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -112,6 +112,7 @@
  */
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
+#define MSI_DEF_NUM_VECTORS		32
 
 struct pcie_port;
 struct dw_pcie;
@@ -143,6 +144,7 @@ struct dw_pcie_host_ops {
 	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
 	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
+	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
 };
 
@@ -168,7 +170,11 @@ struct pcie_port {
 	const struct dw_pcie_host_ops *ops;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
+	struct irq_domain	*msi_domain;
 	unsigned long		msi_data;
+	u32			num_vectors;
+	u32			irq_status[MAX_MSI_CTRLS];
+	spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
@@ -308,8 +314,10 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
+void dw_pcie_free_msi(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+int dw_pcie_allocate_domains(struct dw_pcie *pci);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
@@ -320,6 +328,10 @@ static inline void dw_pcie_msi_init(struct pcie_port *pp)
 {
 }
 
+static inline void dw_pcie_free_msi(struct pcie_port *pp)
+{
+}
+
 static inline void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 }
@@ -328,6 +340,11 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
 {
 	return 0;
 }
+
+static inline int dw_pcie_allocate_domains(struct dw_pcie *pci)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCIE_DW_EP
-- 
2.7.4
