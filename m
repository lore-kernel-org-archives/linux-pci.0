Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936176AbcJGQYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:24:00 -0400
Subject: [PATCH 2/7] PCI: iproc: Name private struct pointer "iproc"
 consistently
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Fri, 07 Oct 2016 11:23:19 -0500
Message-ID: <20161007162319.23015.284.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "iproc", for struct iproc_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc-bcma.c     |   28 ++---
 drivers/pci/host/pcie-iproc-msi.c      |   66 ++++++------
 drivers/pci/host/pcie-iproc-platform.c |   54 +++++----
 drivers/pci/host/pcie-iproc.c          |  182 ++++++++++++++++----------------
 4 files changed, 165 insertions(+), 165 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index 0d7bee4..72273ff 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -34,28 +34,28 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);
 static int iproc_pcie_bcma_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pci_sys_data *sys = dev->sysdata;
-	struct iproc_pcie *pcie = sys->private_data;
-	struct bcma_device *bdev = container_of(pcie->dev, struct bcma_device, dev);
+	struct iproc_pcie *iproc = sys->private_data;
+	struct bcma_device *bdev = container_of(iproc->dev, struct bcma_device, dev);
 
 	return bcma_core_irq(bdev, 5);
 }
 
 static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 {
-	struct iproc_pcie *pcie;
+	struct iproc_pcie *iproc;
 	LIST_HEAD(res);
 	struct resource res_mem;
 	int ret;
 
-	pcie = devm_kzalloc(&bdev->dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	iproc = devm_kzalloc(&bdev->dev, sizeof(*iproc), GFP_KERNEL);
+	if (!iproc)
 		return -ENOMEM;
 
-	pcie->dev = &bdev->dev;
-	bcma_set_drvdata(bdev, pcie);
+	iproc->dev = &bdev->dev;
+	bcma_set_drvdata(bdev, iproc);
 
-	pcie->base = bdev->io_addr;
-	pcie->base_addr = bdev->addr;
+	iproc->base = bdev->io_addr;
+	iproc->base_addr = bdev->addr;
 
 	res_mem.start = bdev->addr_s[0];
 	res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
@@ -63,11 +63,11 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 	res_mem.flags = IORESOURCE_MEM;
 	pci_add_resource(&res, &res_mem);
 
-	pcie->map_irq = iproc_pcie_bcma_map_irq;
+	iproc->map_irq = iproc_pcie_bcma_map_irq;
 
-	ret = iproc_pcie_setup(pcie, &res);
+	ret = iproc_pcie_setup(iproc, &res);
 	if (ret)
-		dev_err(pcie->dev, "PCIe controller setup failed\n");
+		dev_err(iproc->dev, "PCIe controller setup failed\n");
 
 	pci_free_resource_list(&res);
 
@@ -76,9 +76,9 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 
 static void iproc_pcie_bcma_remove(struct bcma_device *bdev)
 {
-	struct iproc_pcie *pcie = bcma_get_drvdata(bdev);
+	struct iproc_pcie *iproc = bcma_get_drvdata(bdev);
 
-	iproc_pcie_remove(pcie);
+	iproc_pcie_remove(iproc);
 }
 
 static const struct bcma_device_id iproc_pcie_bcma_table[] = {
diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/host/pcie-iproc-msi.c
index 9a2973b..4e682a7 100644
--- a/drivers/pci/host/pcie-iproc-msi.c
+++ b/drivers/pci/host/pcie-iproc-msi.c
@@ -78,7 +78,7 @@ struct iproc_msi_grp {
  * Only meant to be used on platforms without MSI support integrated into the
  * GIC.
  *
- * @pcie: pointer to iProc PCIe data
+ * @iproc: pointer to iProc PCIe data
  * @reg_offsets: MSI register offsets
  * @grps: MSI groups
  * @nr_irqs: number of total interrupts connected to GIC
@@ -99,7 +99,7 @@ struct iproc_msi_grp {
  * @msi_addr: MSI address
  */
 struct iproc_msi {
-	struct iproc_pcie *pcie;
+	struct iproc_pcie *iproc;
 	const u16 (*reg_offsets)[IPROC_MSI_REG_SIZE];
 	struct iproc_msi_grp *grps;
 	int nr_irqs;
@@ -137,18 +137,18 @@ static inline u32 iproc_msi_read_reg(struct iproc_msi *msi,
 				     enum iproc_msi_reg reg,
 				     unsigned int eq)
 {
-	struct iproc_pcie *pcie = msi->pcie;
+	struct iproc_pcie *iproc = msi->iproc;
 
-	return readl_relaxed(pcie->base + msi->reg_offsets[eq][reg]);
+	return readl_relaxed(iproc->base + msi->reg_offsets[eq][reg]);
 }
 
 static inline void iproc_msi_write_reg(struct iproc_msi *msi,
 				       enum iproc_msi_reg reg,
 				       int eq, u32 val)
 {
-	struct iproc_pcie *pcie = msi->pcie;
+	struct iproc_pcie *iproc = msi->iproc;
 
-	writel_relaxed(val, pcie->base + msi->reg_offsets[eq][reg]);
+	writel_relaxed(val, iproc->base + msi->reg_offsets[eq][reg]);
 }
 
 static inline u32 hwirq_to_group(struct iproc_msi *msi, unsigned long hwirq)
@@ -317,7 +317,7 @@ static void iproc_msi_handler(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct iproc_msi_grp *grp;
 	struct iproc_msi *msi;
-	struct iproc_pcie *pcie;
+	struct iproc_pcie *iproc;
 	u32 eq, head, tail, nr_events;
 	unsigned long hwirq;
 	int virq;
@@ -326,7 +326,7 @@ static void iproc_msi_handler(struct irq_desc *desc)
 
 	grp = irq_desc_get_handler_data(desc);
 	msi = grp->msi;
-	pcie = msi->pcie;
+	iproc = msi->iproc;
 	eq = grp->eq;
 
 	/*
@@ -482,7 +482,7 @@ static int iproc_msi_irq_setup(struct iproc_msi *msi, unsigned int cpu)
 {
 	int i, ret;
 	cpumask_var_t mask;
-	struct iproc_pcie *pcie = msi->pcie;
+	struct iproc_pcie *iproc = msi->iproc;
 
 	for (i = cpu; i < msi->nr_irqs; i += msi->nr_cpus) {
 		irq_set_chained_handler_and_data(msi->grps[i].gic_irq,
@@ -494,12 +494,12 @@ static int iproc_msi_irq_setup(struct iproc_msi *msi, unsigned int cpu)
 			cpumask_set_cpu(cpu, mask);
 			ret = irq_set_affinity(msi->grps[i].gic_irq, mask);
 			if (ret)
-				dev_err(pcie->dev,
+				dev_err(iproc->dev,
 					"failed to set affinity for IRQ%d\n",
 					msi->grps[i].gic_irq);
 			free_cpumask_var(mask);
 		} else {
-			dev_err(pcie->dev, "failed to alloc CPU mask\n");
+			dev_err(iproc->dev, "failed to alloc CPU mask\n");
 			ret = -EINVAL;
 		}
 
@@ -513,7 +513,7 @@ static int iproc_msi_irq_setup(struct iproc_msi *msi, unsigned int cpu)
 	return 0;
 }
 
-int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
+int iproc_msi_init(struct iproc_pcie *iproc, struct device_node *node)
 {
 	struct iproc_msi *msi;
 	int i, ret;
@@ -525,44 +525,44 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 	if (!of_find_property(node, "msi-controller", NULL))
 		return -ENODEV;
 
-	if (pcie->msi)
+	if (iproc->msi)
 		return -EBUSY;
 
-	msi = devm_kzalloc(pcie->dev, sizeof(*msi), GFP_KERNEL);
+	msi = devm_kzalloc(iproc->dev, sizeof(*msi), GFP_KERNEL);
 	if (!msi)
 		return -ENOMEM;
 
-	msi->pcie = pcie;
-	pcie->msi = msi;
-	msi->msi_addr = pcie->base_addr;
+	msi->iproc = iproc;
+	iproc->msi = msi;
+	msi->msi_addr = iproc->base_addr;
 	mutex_init(&msi->bitmap_lock);
 	msi->nr_cpus = num_possible_cpus();
 
 	msi->nr_irqs = of_irq_count(node);
 	if (!msi->nr_irqs) {
-		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
+		dev_err(iproc->dev, "found no MSI GIC interrupt\n");
 		return -ENODEV;
 	}
 
 	if (msi->nr_irqs > NR_HW_IRQS) {
-		dev_warn(pcie->dev, "too many MSI GIC interrupts defined %d\n",
+		dev_warn(iproc->dev, "too many MSI GIC interrupts defined %d\n",
 			 msi->nr_irqs);
 		msi->nr_irqs = NR_HW_IRQS;
 	}
 
 	if (msi->nr_irqs < msi->nr_cpus) {
-		dev_err(pcie->dev,
+		dev_err(iproc->dev,
 			"not enough GIC interrupts for MSI affinity\n");
 		return -EINVAL;
 	}
 
 	if (msi->nr_irqs % msi->nr_cpus != 0) {
 		msi->nr_irqs -= msi->nr_irqs % msi->nr_cpus;
-		dev_warn(pcie->dev, "Reducing number of interrupts to %d\n",
+		dev_warn(iproc->dev, "Reducing number of interrupts to %d\n",
 			 msi->nr_irqs);
 	}
 
-	switch (pcie->type) {
+	switch (iproc->type) {
 	case IPROC_PCIE_PAXB:
 		msi->reg_offsets = iproc_msi_reg_paxb;
 		msi->nr_eq_region = 1;
@@ -574,7 +574,7 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 		msi->nr_msi_region = msi->nr_irqs;
 		break;
 	default:
-		dev_err(pcie->dev, "incompatible iProc PCIe interface\n");
+		dev_err(iproc->dev, "incompatible iProc PCIe interface\n");
 		return -EINVAL;
 	}
 
@@ -582,12 +582,12 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 		msi->has_inten_reg = true;
 
 	msi->nr_msi_vecs = msi->nr_irqs * EQ_LEN;
-	msi->bitmap = devm_kcalloc(pcie->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
+	msi->bitmap = devm_kcalloc(iproc->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
 				   sizeof(*msi->bitmap), GFP_KERNEL);
 	if (!msi->bitmap)
 		return -ENOMEM;
 
-	msi->grps = devm_kcalloc(pcie->dev, msi->nr_irqs, sizeof(*msi->grps),
+	msi->grps = devm_kcalloc(iproc->dev, msi->nr_irqs, sizeof(*msi->grps),
 				 GFP_KERNEL);
 	if (!msi->grps)
 		return -ENOMEM;
@@ -596,7 +596,7 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 		unsigned int irq = irq_of_parse_and_map(node, i);
 
 		if (!irq) {
-			dev_err(pcie->dev, "unable to parse/map interrupt\n");
+			dev_err(iproc->dev, "unable to parse/map interrupt\n");
 			ret = -ENODEV;
 			goto free_irqs;
 		}
@@ -606,7 +606,7 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 	}
 
 	/* Reserve memory for event queue and make sure memories are zeroed */
-	msi->eq_cpu = dma_zalloc_coherent(pcie->dev,
+	msi->eq_cpu = dma_zalloc_coherent(iproc->dev,
 					  msi->nr_eq_region * EQ_MEM_REGION_SIZE,
 					  &msi->eq_dma, GFP_KERNEL);
 	if (!msi->eq_cpu) {
@@ -616,7 +616,7 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 
 	ret = iproc_msi_alloc_domains(node, msi);
 	if (ret) {
-		dev_err(pcie->dev, "failed to create MSI domains\n");
+		dev_err(iproc->dev, "failed to create MSI domains\n");
 		goto free_eq_dma;
 	}
 
@@ -636,7 +636,7 @@ free_msi_irq:
 	iproc_msi_free_domains(msi);
 
 free_eq_dma:
-	dma_free_coherent(pcie->dev, msi->nr_eq_region * EQ_MEM_REGION_SIZE,
+	dma_free_coherent(iproc->dev, msi->nr_eq_region * EQ_MEM_REGION_SIZE,
 			  msi->eq_cpu, msi->eq_dma);
 
 free_irqs:
@@ -644,14 +644,14 @@ free_irqs:
 		if (msi->grps[i].gic_irq)
 			irq_dispose_mapping(msi->grps[i].gic_irq);
 	}
-	pcie->msi = NULL;
+	iproc->msi = NULL;
 	return ret;
 }
 EXPORT_SYMBOL(iproc_msi_init);
 
-void iproc_msi_exit(struct iproc_pcie *pcie)
+void iproc_msi_exit(struct iproc_pcie *iproc)
 {
-	struct iproc_msi *msi = pcie->msi;
+	struct iproc_msi *msi = iproc->msi;
 	unsigned int i, cpu;
 
 	if (!msi)
@@ -664,7 +664,7 @@ void iproc_msi_exit(struct iproc_pcie *pcie)
 
 	iproc_msi_free_domains(msi);
 
-	dma_free_coherent(pcie->dev, msi->nr_eq_region * EQ_MEM_REGION_SIZE,
+	dma_free_coherent(iproc->dev, msi->nr_eq_region * EQ_MEM_REGION_SIZE,
 			  msi->eq_cpu, msi->eq_dma);
 
 	for (i = 0; i < msi->nr_irqs; i++) {
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 1738c52..d348635 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -41,7 +41,7 @@ MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
 static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
-	struct iproc_pcie *pcie;
+	struct iproc_pcie *iproc;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource reg;
 	resource_size_t iobase = 0;
@@ -52,26 +52,26 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	if (!of_id)
 		return -EINVAL;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(struct iproc_pcie), GFP_KERNEL);
-	if (!pcie)
+	iproc = devm_kzalloc(&pdev->dev, sizeof(*iproc), GFP_KERNEL);
+	if (!iproc)
 		return -ENOMEM;
 
-	pcie->dev = &pdev->dev;
-	pcie->type = (enum iproc_pcie_type)of_id->data;
-	platform_set_drvdata(pdev, pcie);
+	iproc->dev = &pdev->dev;
+	iproc->type = (enum iproc_pcie_type)of_id->data;
+	platform_set_drvdata(pdev, iproc);
 
 	ret = of_address_to_resource(np, 0, &reg);
 	if (ret < 0) {
-		dev_err(pcie->dev, "unable to obtain controller resources\n");
+		dev_err(iproc->dev, "unable to obtain controller resources\n");
 		return ret;
 	}
 
-	pcie->base = devm_ioremap(pcie->dev, reg.start, resource_size(&reg));
-	if (!pcie->base) {
-		dev_err(pcie->dev, "unable to map controller registers\n");
+	iproc->base = devm_ioremap(iproc->dev, reg.start, resource_size(&reg));
+	if (!iproc->base) {
+		dev_err(iproc->dev, "unable to map controller registers\n");
 		return -ENOMEM;
 	}
-	pcie->base_addr = reg.start;
+	iproc->base_addr = reg.start;
 
 	if (of_property_read_bool(np, "brcm,pcie-ob")) {
 		u32 val;
@@ -79,47 +79,47 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(np, "brcm,pcie-ob-axi-offset",
 					   &val);
 		if (ret) {
-			dev_err(pcie->dev,
+			dev_err(iproc->dev,
 				"missing brcm,pcie-ob-axi-offset property\n");
 			return ret;
 		}
-		pcie->ob.axi_offset = val;
+		iproc->ob.axi_offset = val;
 
 		ret = of_property_read_u32(np, "brcm,pcie-ob-window-size",
 					   &val);
 		if (ret) {
-			dev_err(pcie->dev,
+			dev_err(iproc->dev,
 				"missing brcm,pcie-ob-window-size property\n");
 			return ret;
 		}
-		pcie->ob.window_size = (resource_size_t)val * SZ_1M;
+		iproc->ob.window_size = (resource_size_t)val * SZ_1M;
 
 		if (of_property_read_bool(np, "brcm,pcie-ob-oarr-size"))
-			pcie->ob.set_oarr_size = true;
+			iproc->ob.set_oarr_size = true;
 
-		pcie->need_ob_cfg = true;
+		iproc->need_ob_cfg = true;
 	}
 
 	/* PHY use is optional */
-	pcie->phy = devm_phy_get(&pdev->dev, "pcie-phy");
-	if (IS_ERR(pcie->phy)) {
-		if (PTR_ERR(pcie->phy) == -EPROBE_DEFER)
+	iproc->phy = devm_phy_get(&pdev->dev, "pcie-phy");
+	if (IS_ERR(iproc->phy)) {
+		if (PTR_ERR(iproc->phy) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		pcie->phy = NULL;
+		iproc->phy = NULL;
 	}
 
 	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &iobase);
 	if (ret) {
-		dev_err(pcie->dev,
+		dev_err(iproc->dev,
 			"unable to get PCI host bridge resources\n");
 		return ret;
 	}
 
-	pcie->map_irq = of_irq_parse_and_map_pci;
+	iproc->map_irq = of_irq_parse_and_map_pci;
 
-	ret = iproc_pcie_setup(pcie, &res);
+	ret = iproc_pcie_setup(iproc, &res);
 	if (ret)
-		dev_err(pcie->dev, "PCIe controller setup failed\n");
+		dev_err(iproc->dev, "PCIe controller setup failed\n");
 
 	pci_free_resource_list(&res);
 
@@ -128,9 +128,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 
 static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
 {
-	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
+	struct iproc_pcie *iproc = platform_get_drvdata(pdev);
 
-	return iproc_pcie_remove(pcie);
+	return iproc_pcie_remove(iproc);
 }
 
 static struct platform_driver iproc_pcie_pltfm_driver = {
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index f1ae9e1..408e99d 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -113,15 +113,15 @@ static const u16 iproc_pcie_reg_paxc[] = {
 
 static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
 {
-	struct iproc_pcie *pcie;
+	struct iproc_pcie *iproc;
 #ifdef CONFIG_ARM
 	struct pci_sys_data *sys = bus->sysdata;
 
-	pcie = sys->private_data;
+	iproc = sys->private_data;
 #else
-	pcie = bus->sysdata;
+	iproc = bus->sysdata;
 #endif
-	return pcie;
+	return iproc;
 }
 
 static inline bool iproc_pcie_reg_is_invalid(u16 reg_offset)
@@ -129,43 +129,43 @@ static inline bool iproc_pcie_reg_is_invalid(u16 reg_offset)
 	return !!(reg_offset == IPROC_PCIE_REG_INVALID);
 }
 
-static inline u16 iproc_pcie_reg_offset(struct iproc_pcie *pcie,
+static inline u16 iproc_pcie_reg_offset(struct iproc_pcie *iproc,
 					enum iproc_pcie_reg reg)
 {
-	return pcie->reg_offsets[reg];
+	return iproc->reg_offsets[reg];
 }
 
-static u32 iproc_readl(struct iproc_pcie *pcie, enum iproc_pcie_reg reg)
+static u32 iproc_readl(struct iproc_pcie *iproc, enum iproc_pcie_reg reg)
 {
-	u16 offset = iproc_pcie_reg_offset(pcie, reg);
+	u16 offset = iproc_pcie_reg_offset(iproc, reg);
 
 	if (iproc_pcie_reg_is_invalid(offset))
 		return 0;
 
-	return readl(pcie->base + offset);
+	return readl(iproc->base + offset);
 }
 
-static void iproc_writel(struct iproc_pcie *pcie, enum iproc_pcie_reg reg,
+static void iproc_writel(struct iproc_pcie *iproc, enum iproc_pcie_reg reg,
 			 u32 val)
 {
-	u16 offset = iproc_pcie_reg_offset(pcie, reg);
+	u16 offset = iproc_pcie_reg_offset(iproc, reg);
 
 	if (iproc_pcie_reg_is_invalid(offset))
 		return;
 
-	writel(val, pcie->base + offset);
+	writel(val, iproc->base + offset);
 }
 
-static inline void iproc_pcie_ob_write(struct iproc_pcie *pcie,
+static inline void iproc_pcie_ob_write(struct iproc_pcie *iproc,
 				       enum iproc_pcie_reg reg,
 				       unsigned window, u32 val)
 {
-	u16 offset = iproc_pcie_reg_offset(pcie, reg);
+	u16 offset = iproc_pcie_reg_offset(iproc, reg);
 
 	if (iproc_pcie_reg_is_invalid(offset))
 		return;
 
-	writel(val, pcie->base + offset + (window * 8));
+	writel(val, iproc->base + offset + (window * 8));
 }
 
 /**
@@ -176,7 +176,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 					    unsigned int devfn,
 					    int where)
 {
-	struct iproc_pcie *pcie = iproc_data(bus);
+	struct iproc_pcie *iproc = iproc_data(bus);
 	unsigned slot = PCI_SLOT(devfn);
 	unsigned fn = PCI_FUNC(devfn);
 	unsigned busno = bus->number;
@@ -188,20 +188,20 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 		if (slot > 0 || fn > 0)
 			return NULL;
 
-		iproc_writel(pcie, IPROC_PCIE_CFG_IND_ADDR,
+		iproc_writel(iproc, IPROC_PCIE_CFG_IND_ADDR,
 			     where & CFG_IND_ADDR_MASK);
-		offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_IND_DATA);
+		offset = iproc_pcie_reg_offset(iproc, IPROC_PCIE_CFG_IND_DATA);
 		if (iproc_pcie_reg_is_invalid(offset))
 			return NULL;
 		else
-			return (pcie->base + offset);
+			return (iproc->base + offset);
 	}
 
 	/*
 	 * PAXC is connected to an internally emulated EP within the SoC.  It
 	 * allows only one device.
 	 */
-	if (pcie->type == IPROC_PCIE_PAXC)
+	if (iproc->type == IPROC_PCIE_PAXC)
 		if (slot > 0)
 			return NULL;
 
@@ -211,12 +211,12 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 		(fn << CFG_ADDR_FUNC_NUM_SHIFT) |
 		(where & CFG_ADDR_REG_NUM_MASK) |
 		(1 & CFG_ADDR_CFG_TYPE_MASK);
-	iproc_writel(pcie, IPROC_PCIE_CFG_ADDR, val);
-	offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
+	iproc_writel(iproc, IPROC_PCIE_CFG_ADDR, val);
+	offset = iproc_pcie_reg_offset(iproc, IPROC_PCIE_CFG_DATA);
 	if (iproc_pcie_reg_is_invalid(offset))
 		return NULL;
 	else
-		return (pcie->base + offset);
+		return (iproc->base + offset);
 }
 
 static struct pci_ops iproc_pcie_ops = {
@@ -225,17 +225,17 @@ static struct pci_ops iproc_pcie_ops = {
 	.write = pci_generic_config_write32,
 };
 
-static void iproc_pcie_reset(struct iproc_pcie *pcie)
+static void iproc_pcie_reset(struct iproc_pcie *iproc)
 {
 	u32 val;
 
-	if (pcie->type == IPROC_PCIE_PAXC) {
-		val = iproc_readl(pcie, IPROC_PCIE_CLK_CTRL);
+	if (iproc->type == IPROC_PCIE_PAXC) {
+		val = iproc_readl(iproc, IPROC_PCIE_CLK_CTRL);
 		val &= ~PAXC_RESET_MASK;
-		iproc_writel(pcie, IPROC_PCIE_CLK_CTRL, val);
+		iproc_writel(iproc, IPROC_PCIE_CLK_CTRL, val);
 		udelay(100);
 		val |= PAXC_RESET_MASK;
-		iproc_writel(pcie, IPROC_PCIE_CLK_CTRL, val);
+		iproc_writel(iproc, IPROC_PCIE_CLK_CTRL, val);
 		udelay(100);
 		return;
 	}
@@ -244,18 +244,18 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
 	 * Select perst_b signal as reset source. Put the device into reset,
 	 * and then bring it out of reset
 	 */
-	val = iproc_readl(pcie, IPROC_PCIE_CLK_CTRL);
+	val = iproc_readl(iproc, IPROC_PCIE_CLK_CTRL);
 	val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
 		~RC_PCIE_RST_OUTPUT;
-	iproc_writel(pcie, IPROC_PCIE_CLK_CTRL, val);
+	iproc_writel(iproc, IPROC_PCIE_CLK_CTRL, val);
 	udelay(250);
 
 	val |= RC_PCIE_RST_OUTPUT;
-	iproc_writel(pcie, IPROC_PCIE_CLK_CTRL, val);
+	iproc_writel(iproc, IPROC_PCIE_CLK_CTRL, val);
 	msleep(100);
 }
 
-static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
+static int iproc_pcie_check_link(struct iproc_pcie *iproc, struct pci_bus *bus)
 {
 	u8 hdr_type;
 	u32 link_ctrl, class, val;
@@ -266,19 +266,19 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 	 * PAXC connects to emulated endpoint devices directly and does not
 	 * have a Serdes.  Therefore skip the link detection logic here.
 	 */
-	if (pcie->type == IPROC_PCIE_PAXC)
+	if (iproc->type == IPROC_PCIE_PAXC)
 		return 0;
 
-	val = iproc_readl(pcie, IPROC_PCIE_LINK_STATUS);
+	val = iproc_readl(iproc, IPROC_PCIE_LINK_STATUS);
 	if (!(val & PCIE_PHYLINKUP) || !(val & PCIE_DL_ACTIVE)) {
-		dev_err(pcie->dev, "PHY or data link is INACTIVE!\n");
+		dev_err(iproc->dev, "PHY or data link is INACTIVE!\n");
 		return -ENODEV;
 	}
 
 	/* make sure we are not in EP mode */
 	pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr_type);
 	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
-		dev_err(pcie->dev, "in EP mode, hdr=%#02x\n", hdr_type);
+		dev_err(iproc->dev, "in EP mode, hdr=%#02x\n", hdr_type);
 		return -EFAULT;
 	}
 
@@ -323,14 +323,14 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 		}
 	}
 
-	dev_info(pcie->dev, "link: %s\n", link_is_active ? "UP" : "DOWN");
+	dev_info(iproc->dev, "link: %s\n", link_is_active ? "UP" : "DOWN");
 
 	return link_is_active ? 0 : -ENODEV;
 }
 
-static void iproc_pcie_enable(struct iproc_pcie *pcie)
+static void iproc_pcie_enable(struct iproc_pcie *iproc)
 {
-	iproc_writel(pcie, IPROC_PCIE_INTX_EN, SYS_RC_INTX_MASK);
+	iproc_writel(iproc, IPROC_PCIE_INTX_EN, SYS_RC_INTX_MASK);
 }
 
 /**
@@ -344,16 +344,16 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
  *
  * axi_addr -> iproc_pcie_address -> OARR -> OMAP -> pci_address
  */
-static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
+static int iproc_pcie_setup_ob(struct iproc_pcie *iproc, u64 axi_addr,
 			       u64 pci_addr, resource_size_t size)
 {
-	struct iproc_pcie_ob *ob = &pcie->ob;
+	struct iproc_pcie_ob *ob = &iproc->ob;
 	unsigned i;
 	u64 max_size = (u64)ob->window_size * MAX_NUM_OB_WINDOWS;
 	u64 remainder;
 
 	if (size > max_size) {
-		dev_err(pcie->dev,
+		dev_err(iproc->dev,
 			"res size %pap exceeds max supported size 0x%llx\n",
 			&size, max_size);
 		return -EINVAL;
@@ -361,14 +361,14 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 
 	div64_u64_rem(size, ob->window_size, &remainder);
 	if (remainder) {
-		dev_err(pcie->dev,
+		dev_err(iproc->dev,
 			"res size %pap needs to be multiple of window size %pap\n",
 			&size, &ob->window_size);
 		return -EINVAL;
 	}
 
 	if (axi_addr < ob->axi_offset) {
-		dev_err(pcie->dev,
+		dev_err(iproc->dev,
 			"axi address %pap less than offset %pap\n",
 			&axi_addr, &ob->axi_offset);
 		return -EINVAL;
@@ -381,14 +381,14 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 	axi_addr -= ob->axi_offset;
 
 	for (i = 0; i < MAX_NUM_OB_WINDOWS; i++) {
-		iproc_pcie_ob_write(pcie, IPROC_PCIE_OARR_LO, i,
+		iproc_pcie_ob_write(iproc, IPROC_PCIE_OARR_LO, i,
 				    lower_32_bits(axi_addr) | OARR_VALID |
 				    (ob->set_oarr_size ? 1 : 0));
-		iproc_pcie_ob_write(pcie, IPROC_PCIE_OARR_HI, i,
+		iproc_pcie_ob_write(iproc, IPROC_PCIE_OARR_HI, i,
 				    upper_32_bits(axi_addr));
-		iproc_pcie_ob_write(pcie, IPROC_PCIE_OMAP_LO, i,
+		iproc_pcie_ob_write(iproc, IPROC_PCIE_OMAP_LO, i,
 				    lower_32_bits(pci_addr));
-		iproc_pcie_ob_write(pcie, IPROC_PCIE_OMAP_HI, i,
+		iproc_pcie_ob_write(iproc, IPROC_PCIE_OMAP_HI, i,
 				    upper_32_bits(pci_addr));
 
 		size -= ob->window_size;
@@ -402,7 +402,7 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 	return 0;
 }
 
-static int iproc_pcie_map_ranges(struct iproc_pcie *pcie,
+static int iproc_pcie_map_ranges(struct iproc_pcie *iproc,
 				 struct list_head *resources)
 {
 	struct resource_entry *window;
@@ -417,14 +417,14 @@ static int iproc_pcie_map_ranges(struct iproc_pcie *pcie,
 		case IORESOURCE_BUS:
 			break;
 		case IORESOURCE_MEM:
-			ret = iproc_pcie_setup_ob(pcie, res->start,
+			ret = iproc_pcie_setup_ob(iproc, res->start,
 						  res->start - window->offset,
 						  resource_size(res));
 			if (ret)
 				return ret;
 			break;
 		default:
-			dev_err(pcie->dev, "invalid resource %pR\n", res);
+			dev_err(iproc->dev, "invalid resource %pR\n", res);
 			return -EINVAL;
 		}
 	}
@@ -432,11 +432,11 @@ static int iproc_pcie_map_ranges(struct iproc_pcie *pcie,
 	return 0;
 }
 
-static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
+static int iproc_pcie_msi_enable(struct iproc_pcie *iproc)
 {
 	struct device_node *msi_node;
 
-	msi_node = of_parse_phandle(pcie->dev->of_node, "msi-parent", 0);
+	msi_node = of_parse_phandle(iproc->dev->of_node, "msi-parent", 0);
 	if (!msi_node)
 		return -ENODEV;
 
@@ -444,92 +444,92 @@ static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
 	 * If another MSI controller is being used, the call below should fail
 	 * but that is okay
 	 */
-	return iproc_msi_init(pcie, msi_node);
+	return iproc_msi_init(iproc, msi_node);
 }
 
-static void iproc_pcie_msi_disable(struct iproc_pcie *pcie)
+static void iproc_pcie_msi_disable(struct iproc_pcie *iproc)
 {
-	iproc_msi_exit(pcie);
+	iproc_msi_exit(iproc);
 }
 
-int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
+int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 {
 	int ret;
 	void *sysdata;
 	struct pci_bus *bus;
 
-	if (!pcie || !pcie->dev || !pcie->base)
+	if (!iproc || !iproc->dev || !iproc->base)
 		return -EINVAL;
 
-	ret = devm_request_pci_bus_resources(pcie->dev, res);
+	ret = devm_request_pci_bus_resources(iproc->dev, res);
 	if (ret)
 		return ret;
 
-	ret = phy_init(pcie->phy);
+	ret = phy_init(iproc->phy);
 	if (ret) {
-		dev_err(pcie->dev, "unable to initialize PCIe PHY\n");
+		dev_err(iproc->dev, "unable to initialize PCIe PHY\n");
 		return ret;
 	}
 
-	ret = phy_power_on(pcie->phy);
+	ret = phy_power_on(iproc->phy);
 	if (ret) {
-		dev_err(pcie->dev, "unable to power on PCIe PHY\n");
+		dev_err(iproc->dev, "unable to power on PCIe PHY\n");
 		goto err_exit_phy;
 	}
 
-	switch (pcie->type) {
+	switch (iproc->type) {
 	case IPROC_PCIE_PAXB:
-		pcie->reg_offsets = iproc_pcie_reg_paxb;
+		iproc->reg_offsets = iproc_pcie_reg_paxb;
 		break;
 	case IPROC_PCIE_PAXC:
-		pcie->reg_offsets = iproc_pcie_reg_paxc;
+		iproc->reg_offsets = iproc_pcie_reg_paxc;
 		break;
 	default:
-		dev_err(pcie->dev, "incompatible iProc PCIe interface\n");
+		dev_err(iproc->dev, "incompatible iProc PCIe interface\n");
 		ret = -EINVAL;
 		goto err_power_off_phy;
 	}
 
-	iproc_pcie_reset(pcie);
+	iproc_pcie_reset(iproc);
 
-	if (pcie->need_ob_cfg) {
-		ret = iproc_pcie_map_ranges(pcie, res);
+	if (iproc->need_ob_cfg) {
+		ret = iproc_pcie_map_ranges(iproc, res);
 		if (ret) {
-			dev_err(pcie->dev, "map failed\n");
+			dev_err(iproc->dev, "map failed\n");
 			goto err_power_off_phy;
 		}
 	}
 
 #ifdef CONFIG_ARM
-	pcie->sysdata.private_data = pcie;
-	sysdata = &pcie->sysdata;
+	iproc->sysdata.private_data = iproc;
+	sysdata = &iproc->sysdata;
 #else
-	sysdata = pcie;
+	sysdata = iproc;
 #endif
 
-	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops, sysdata, res);
+	bus = pci_create_root_bus(iproc->dev, 0, &iproc_pcie_ops, sysdata, res);
 	if (!bus) {
-		dev_err(pcie->dev, "unable to create PCI root bus\n");
+		dev_err(iproc->dev, "unable to create PCI root bus\n");
 		ret = -ENOMEM;
 		goto err_power_off_phy;
 	}
-	pcie->root_bus = bus;
+	iproc->root_bus = bus;
 
-	ret = iproc_pcie_check_link(pcie, bus);
+	ret = iproc_pcie_check_link(iproc, bus);
 	if (ret) {
-		dev_err(pcie->dev, "no PCIe EP device detected\n");
+		dev_err(iproc->dev, "no PCIe EP device detected\n");
 		goto err_rm_root_bus;
 	}
 
-	iproc_pcie_enable(pcie);
+	iproc_pcie_enable(iproc);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		if (iproc_pcie_msi_enable(pcie))
-			dev_info(pcie->dev, "not using iProc MSI\n");
+		if (iproc_pcie_msi_enable(iproc))
+			dev_info(iproc->dev, "not using iProc MSI\n");
 
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
-	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
+	pci_fixup_irqs(pci_common_swizzle, iproc->map_irq);
 	pci_bus_add_devices(bus);
 
 	return 0;
@@ -539,22 +539,22 @@ err_rm_root_bus:
 	pci_remove_root_bus(bus);
 
 err_power_off_phy:
-	phy_power_off(pcie->phy);
+	phy_power_off(iproc->phy);
 err_exit_phy:
-	phy_exit(pcie->phy);
+	phy_exit(iproc->phy);
 	return ret;
 }
 EXPORT_SYMBOL(iproc_pcie_setup);
 
-int iproc_pcie_remove(struct iproc_pcie *pcie)
+int iproc_pcie_remove(struct iproc_pcie *iproc)
 {
-	pci_stop_root_bus(pcie->root_bus);
-	pci_remove_root_bus(pcie->root_bus);
+	pci_stop_root_bus(iproc->root_bus);
+	pci_remove_root_bus(iproc->root_bus);
 
-	iproc_pcie_msi_disable(pcie);
+	iproc_pcie_msi_disable(iproc);
 
-	phy_power_off(pcie->phy);
-	phy_exit(pcie->phy);
+	phy_power_off(iproc->phy);
+	phy_exit(iproc->phy);
 
 	return 0;
 }

