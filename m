Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:59959 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757894AbdELQ4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2017 12:56:33 -0400
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
Subject: [RFC 1/8] pci: adding new irq api to pci-designware
Date: Fri, 12 May 2017 17:56:10 +0100
Message-Id: <d9664b857b0b9fe9cba6b8de5f0b6d365fe86f36.1494606911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494606911.git.jpinto@synopsys.com>
References: <cover.1494606911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494606911.git.jpinto@synopsys.com>
References: <cover.1494606911.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the new interrupt api to pecie-designware, keeping the old
one. A define was added to toggle between the two apis (for testing purposes).

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 241 ++++++++++++++++++++++++++++++++-
 drivers/pci/dwc/pcie-designware.h      |   5 +
 2 files changed, 244 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 28ed32b..6810ea10b 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -19,6 +20,9 @@
 
 #include "pcie-designware.h"
 
+/* Temporary: Activate to use new IRQ API */
+/*#define CONFIG_PCIEDW_NEW_IRQ_API*/
+
 static struct pci_ops dw_pcie_ops;
 
 static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
@@ -45,6 +49,7 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
 
+#ifndef CONFIG_PCIEDW_NEW_IRQ_API
 static struct irq_chip dw_msi_irq_chip = {
 	.name = "PCI-MSI",
 	.irq_enable = pci_msi_unmask_irq,
@@ -52,6 +57,29 @@ static struct irq_chip dw_msi_irq_chip = {
 	.irq_mask = pci_msi_mask_irq,
 	.irq_unmask = pci_msi_unmask_irq,
 };
+#else
+static void dw_msi_mask_irq(struct irq_data *d) {
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void dw_msi_unmask_irq(struct irq_data *d) {
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip dw_msi_irq_chip = {
+	.name = "PCI-MSI",
+	.irq_mask = dw_msi_mask_irq,
+	.irq_unmask = dw_msi_unmask_irq,
+};
+
+static struct msi_domain_info dw_pcie_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		     MSI_FLAG_PCI_MSIX),
+	.chip	= &dw_msi_irq_chip,
+};
+#endif
 
 /* MSI int handler */
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
@@ -81,6 +109,190 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	return ret;
 }
 
+#ifdef CONFIG_PCIEDW_NEW_IRQ_API
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
+	msg->address_lo = (u32)(msi_target & 0xffffffff);
+	msg->address_hi = (u32)(msi_target >> 32 & 0xffffffff);
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
+	unsigned int res, bit, val;
+
+	mutex_lock(&pp->lock);
+
+	if (pp->ops->msi_clear_irq)
+		pp->ops->msi_clear_irq(pp, data->hwirq);
+	else {
+		res = (data->hwirq / 32) * 12;
+		bit = data->hwirq % 32;
+
+		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
+		val &= ~(1 << bit);
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+	}
+
+	mutex_unlock(&pp->lock);
+}
+
+static void dw_pci_bottom_unmask(struct irq_data *data)
+{
+	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = &pci->pp;
+	unsigned int res, bit, val;
+
+	mutex_lock(&pp->lock);
+
+	if (pp->ops->msi_set_irq)
+		pp->ops->msi_set_irq(pp, data->hwirq);
+	else {
+		res = (data->hwirq / 32) * 12;
+		bit = data->hwirq % 32;
+
+		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
+		val |= 1 << bit;
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+	}
+
+	mutex_unlock(&pp->lock);
+}
+
+static struct irq_chip dw_pci_msi_bottom_irq_chip = {
+	.name			= "DWPCI-MSI",
+	.irq_compose_msi_msg	= dw_pci_setup_msi_msg,
+	.irq_set_affinity	= dw_pci_msi_set_affinity,
+	.irq_mask		= dw_pci_bottom_mask,
+	.irq_unmask		= dw_pci_bottom_unmask,
+};
+
+static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs,
+				    void *args)
+{
+	struct dw_pcie *pci = domain->host_data;
+	struct pcie_port *pp = &pci->pp;
+	unsigned long bit;
+
+	mutex_lock(&pp->lock);
+
+	WARN_ON(nr_irqs != 1);
+
+	bit = find_first_zero_bit(pp->msi_irq_in_use, pp->num_vectors);
+	if (bit >= pp->num_vectors) {
+		mutex_unlock(&pp->lock);
+		return -ENOSPC;
+	}
+
+	set_bit(bit, pp->msi_irq_in_use);
+
+	mutex_unlock(&pp->lock);
+
+	irq_domain_set_info(domain, virq, bit, &dw_pci_msi_bottom_irq_chip,
+			    domain->host_data, handle_simple_irq,
+			    NULL, NULL);
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
+
+	mutex_lock(&pp->lock);
+
+	if (!test_bit(data->hwirq, pp->msi_irq_in_use))
+		dev_err(pci->dev, "trying to free unused MSI#%lu\n",
+			data->hwirq);
+	else
+		__clear_bit(data->hwirq, pp->msi_irq_in_use);
+
+	mutex_unlock(&pp->lock);
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
+	pp->irq_domain = irq_domain_add_linear(NULL, pp->num_vectors,
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
+#endif
+
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
 	u64 msi_target;
@@ -279,11 +491,16 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct resource_entry *win, *tmp;
 	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
-	int i, ret;
+#ifndef CONFIG_PCIEDW_NEW_IRQ_API
+	int i;
+#endif
+	int ret;
 	LIST_HEAD(res);
-	struct resource_entry *win, *tmp;
+
+	mutex_init(&pci->pp.lock);
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -378,6 +595,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		if (!pp->ops->msi_host_init) {
+			ret = of_property_read_u32(np, "num-vectors",
+						   &pp->num_vectors);
+			if (ret)
+				pp->num_vectors = 1;
+
+#ifndef CONFIG_PCIEDW_NEW_IRQ_API
 			pp->irq_domain = irq_domain_add_linear(dev->of_node,
 						MAX_MSI_IRQS, &msi_domain_ops,
 						&dw_pcie_msi_chip);
@@ -389,6 +612,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 			for (i = 0; i < MAX_MSI_IRQS; i++)
 				irq_create_mapping(pp->irq_domain, i);
+#else
+			ret = dw_pcie_allocate_domains(pci);
+			if (ret)
+				goto error;
+
+			irq_set_chained_handler_and_data(pci->pp.msi_irq,
+							 dw_chained_msi_isr,
+							 pci);
+#endif
 		} else {
 			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
 			if (ret < 0)
@@ -400,6 +632,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->ops->host_init(pp);
 
 	pp->root_bus_nr = pp->busn->start;
+#ifndef CONFIG_PCIEDW_NEW_IRQ_API
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		bus = pci_scan_root_bus_msi(dev, pp->root_bus_nr,
 					    &dw_pcie_ops, pp, &res,
@@ -408,6 +641,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	} else
 		bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
 					pp, &res);
+#else
+	bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
+				pp, &res);
+#endif
 	if (!bus) {
 		ret = -ENOMEM;
 		goto error;
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index c6a8405..15481a5 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -165,7 +165,10 @@ struct pcie_port {
 	struct dw_pcie_host_ops	*ops;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
+	struct irq_domain	*msi_domain;
 	unsigned long		msi_data;
+	u32			num_vectors;
+	struct mutex		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
@@ -282,8 +285,10 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
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
-- 
2.9.3
