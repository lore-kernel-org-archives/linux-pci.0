Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCHv2 1/3] pci: pci-aardvark: move to MSI handling using generic
 MSI support
Date: Fri, 23 Dec 2016 10:20:52 +0100
Message-Id: <1482484854-26418-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1482484854-26418-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482484854-26418-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The MSI support introduced with the initial Aardvark driver was based
on the msi_controller structure and the of_pci_msi_chip_add() /
of_pci_find_msi_chip_by_node() API, which are being deprecated in
favor of the generic MSI support.

Therefore, this commit updates the Aardvark driver to use the generic
MSI support.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v1:
 - Rebased on top of v4.9
 - Removed the MSI_FLAG_PCI_MSIX flag since we don't support MSI-X for
   the moment.
---
 drivers/pci/host/pci-aardvark.c | 172 +++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 106 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 4fce494..3fdca5d 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -200,10 +200,12 @@ struct advk_pcie {
 	struct list_head resources;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
-	struct msi_controller msi;
 	struct irq_domain *msi_domain;
+	struct irq_domain *msi_inner_domain;
+	struct irq_chip msi_bottom_irq_chip;
 	struct irq_chip msi_irq_chip;
-	DECLARE_BITMAP(msi_irq_in_use, MSI_IRQ_NUM);
+	struct msi_domain_info msi_domain_info;
+	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
 	u16 msi_msg;
 	int root_bus_nr;
@@ -545,94 +547,64 @@ static struct pci_ops advk_pcie_ops = {
 	.write = advk_pcie_wr_conf,
 };
 
-static int advk_pcie_alloc_msi(struct advk_pcie *pcie)
+static void advk_msi_irq_compose_msi_msg(struct irq_data *data,
+					 struct msi_msg *msg)
 {
-	int hwirq;
+	struct advk_pcie *pcie = irq_data_get_irq_chip_data(data);
+	phys_addr_t msi_msg = virt_to_phys(&pcie->msi_msg);
 
-	mutex_lock(&pcie->msi_used_lock);
-	hwirq = find_first_zero_bit(pcie->msi_irq_in_use, MSI_IRQ_NUM);
-	if (hwirq >= MSI_IRQ_NUM)
-		hwirq = -ENOSPC;
-	else
-		set_bit(hwirq, pcie->msi_irq_in_use);
-	mutex_unlock(&pcie->msi_used_lock);
-
-	return hwirq;
+	msg->address_lo = lower_32_bits(msi_msg);
+	msg->address_hi = upper_32_bits(msi_msg);
+	msg->data = data->irq;
 }
 
-static void advk_pcie_free_msi(struct advk_pcie *pcie, int hwirq)
+static int advk_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
 {
-	struct device *dev = &pcie->pdev->dev;
-
-	mutex_lock(&pcie->msi_used_lock);
-	if (!test_bit(hwirq, pcie->msi_irq_in_use))
-		dev_err(dev, "trying to free unused MSI#%d\n", hwirq);
-	else
-		clear_bit(hwirq, pcie->msi_irq_in_use);
-	mutex_unlock(&pcie->msi_used_lock);
+	return -EINVAL;
 }
 
-static int advk_pcie_setup_msi_irq(struct msi_controller *chip,
-				   struct pci_dev *pdev,
-				   struct msi_desc *desc)
+static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *args)
 {
-	struct advk_pcie *pcie = pdev->bus->sysdata;
-	struct msi_msg msg;
-	int virq, hwirq;
-	phys_addr_t msi_msg_phys;
-
-	/* We support MSI, but not MSI-X */
-	if (desc->msi_attrib.is_msix)
-		return -EINVAL;
-
-	hwirq = advk_pcie_alloc_msi(pcie);
-	if (hwirq < 0)
-		return hwirq;
+	struct advk_pcie *pcie = domain->host_data;
+	int hwirq, i;
 
-	virq = irq_create_mapping(pcie->msi_domain, hwirq);
-	if (!virq) {
-		advk_pcie_free_msi(pcie, hwirq);
-		return -EINVAL;
+	mutex_lock(&pcie->msi_used_lock);
+	hwirq = bitmap_find_next_zero_area(pcie->msi_used, MSI_IRQ_NUM,
+					   0, nr_irqs, 0);
+	if (hwirq >= MSI_IRQ_NUM) {
+		mutex_unlock(&pcie->msi_used_lock);
+		return -ENOSPC;
 	}
 
-	irq_set_msi_desc(virq, desc);
-
-	msi_msg_phys = virt_to_phys(&pcie->msi_msg);
-
-	msg.address_lo = lower_32_bits(msi_msg_phys);
-	msg.address_hi = upper_32_bits(msi_msg_phys);
-	msg.data = virq;
-
-	pci_write_msi_msg(virq, &msg);
-
-	return 0;
-}
+	bitmap_set(pcie->msi_used, hwirq, nr_irqs);
+	mutex_unlock(&pcie->msi_used_lock);
 
-static void advk_pcie_teardown_msi_irq(struct msi_controller *chip,
-				       unsigned int irq)
-{
-	struct irq_data *d = irq_get_irq_data(irq);
-	struct msi_desc *msi = irq_data_get_msi_desc(d);
-	struct advk_pcie *pcie = msi_desc_to_pci_sysdata(msi);
-	unsigned long hwirq = d->hwirq;
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &pcie->msi_bottom_irq_chip,
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
 
-	irq_dispose_mapping(irq);
-	advk_pcie_free_msi(pcie, hwirq);
+	return hwirq;
 }
 
-static int advk_pcie_msi_map(struct irq_domain *domain,
-			     unsigned int virq, irq_hw_number_t hw)
+static void advk_msi_irq_domain_free(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs)
 {
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct advk_pcie *pcie = domain->host_data;
 
-	irq_set_chip_and_handler(virq, &pcie->msi_irq_chip,
-				 handle_simple_irq);
-
-	return 0;
+	mutex_lock(&pcie->msi_used_lock);
+	bitmap_clear(pcie->msi_used, d->hwirq, nr_irqs);
+	mutex_unlock(&pcie->msi_used_lock);
 }
 
-static const struct irq_domain_ops advk_pcie_msi_irq_ops = {
-	.map = advk_pcie_msi_map,
+static const struct irq_domain_ops advk_msi_domain_ops = {
+	.alloc = advk_msi_irq_domain_alloc,
+	.free = advk_msi_irq_domain_free,
 };
 
 static void advk_pcie_irq_mask(struct irq_data *d)
@@ -680,30 +652,24 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct irq_chip *msi_irq_chip;
-	struct msi_controller *msi;
+	struct irq_chip *bottom_ic, *msi_ic;
+	struct msi_domain_info *msi_di;
 	phys_addr_t msi_msg_phys;
-	int ret;
 
-	msi_irq_chip = &pcie->msi_irq_chip;
+	mutex_init(&pcie->msi_used_lock);
 
-	msi_irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-msi",
-					    dev_name(dev));
-	if (!msi_irq_chip->name)
-		return -ENOMEM;
+	bottom_ic = &pcie->msi_bottom_irq_chip;
 
-	msi_irq_chip->irq_enable = pci_msi_unmask_irq;
-	msi_irq_chip->irq_disable = pci_msi_mask_irq;
-	msi_irq_chip->irq_mask = pci_msi_mask_irq;
-	msi_irq_chip->irq_unmask = pci_msi_unmask_irq;
+	bottom_ic->name = "MSI";
+	bottom_ic->irq_compose_msi_msg = advk_msi_irq_compose_msi_msg;
+	bottom_ic->irq_set_affinity = advk_msi_set_affinity;
 
-	msi = &pcie->msi;
+	msi_ic = &pcie->msi_irq_chip;
+	msi_ic->name = "advk-MSI";
 
-	msi->setup_irq = advk_pcie_setup_msi_irq;
-	msi->teardown_irq = advk_pcie_teardown_msi_irq;
-	msi->of_node = node;
-
-	mutex_init(&pcie->msi_used_lock);
+	msi_di = &pcie->msi_domain_info;
+	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS;
+	msi_di->chip = msi_ic;
 
 	msi_msg_phys = virt_to_phys(&pcie->msi_msg);
 
@@ -712,16 +678,18 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	advk_writel(pcie, upper_32_bits(msi_msg_phys),
 		    PCIE_MSI_ADDR_HIGH_REG);
 
-	pcie->msi_domain =
+	pcie->msi_inner_domain =
 		irq_domain_add_linear(NULL, MSI_IRQ_NUM,
-				      &advk_pcie_msi_irq_ops, pcie);
-	if (!pcie->msi_domain)
+				      &advk_msi_domain_ops, pcie);
+	if (!pcie->msi_inner_domain)
 		return -ENOMEM;
 
-	ret = of_pci_msi_chip_add(msi);
-	if (ret < 0) {
-		irq_domain_remove(pcie->msi_domain);
-		return ret;
+	pcie->msi_domain =
+		pci_msi_create_irq_domain(of_node_to_fwnode(node),
+					  msi_di, pcie->msi_inner_domain);
+	if (!pcie->msi_domain) {
+		irq_domain_remove(pcie->msi_inner_domain);
+		return -ENOMEM;
 	}
 
 	return 0;
@@ -729,8 +697,8 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 
 static void advk_pcie_remove_msi_irq_domain(struct advk_pcie *pcie)
 {
-	of_pci_msi_chip_remove(&pcie->msi);
 	irq_domain_remove(pcie->msi_domain);
+	irq_domain_remove(pcie->msi_inner_domain);
 }
 
 static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
@@ -917,8 +885,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct advk_pcie *pcie;
 	struct resource *res;
 	struct pci_bus *bus, *child;
-	struct msi_controller *msi;
-	struct device_node *msi_node;
 	int ret, irq;
 
 	pcie = devm_kzalloc(dev, sizeof(struct advk_pcie), GFP_KERNEL);
@@ -962,14 +928,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	msi_node = of_parse_phandle(dev->of_node, "msi-parent", 0);
-	if (msi_node)
-		msi = of_pci_find_msi_chip_by_node(msi_node);
-	else
-		msi = NULL;
-
-	bus = pci_scan_root_bus_msi(dev, 0, &advk_pcie_ops,
-				    pcie, &pcie->resources, &pcie->msi);
+	bus = pci_scan_root_bus(dev, 0, &advk_pcie_ops,
+				pcie, &pcie->resources);
 	if (!bus) {
 		advk_pcie_remove_msi_irq_domain(pcie);
 		advk_pcie_remove_irq_domain(pcie);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
