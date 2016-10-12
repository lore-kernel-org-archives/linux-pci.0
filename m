Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755112AbcJLNxN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:53:13 -0400
Subject: [PATCH v2 1/6] PCI: keystone: Add local struct device pointers
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:53:08 -0500
Message-ID: <20161012135308.29306.93184.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |   19 +++++++++++--------
 drivers/pci/host/pci-keystone.c    |   23 +++++++++++++----------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 4151509..e2c04d1 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -91,6 +91,7 @@ phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
+	struct device *dev = pp->dev;
 	u32 pending, vector;
 	int src, virq;
 
@@ -104,7 +105,7 @@ void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 		if (BIT(src) & pending) {
 			vector = offset + (src << 3);
 			virq = irq_linear_revmap(pp->irq_domain, vector);
-			dev_dbg(pp->dev, "irq: bit %d, vector %d, virq %d\n",
+			dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n",
 				src, vector, virq);
 			generic_handle_irq(virq);
 		}
@@ -215,6 +216,7 @@ static const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
 int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
 {
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	struct device *dev = pp->dev;
 	int i;
 
 	pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np,
@@ -222,7 +224,7 @@ int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
 					&ks_dw_pcie_msi_domain_ops,
 					chip);
 	if (!pp->irq_domain) {
-		dev_err(pp->dev, "irq domain init failed\n");
+		dev_err(dev, "irq domain init failed\n");
 		return -ENXIO;
 	}
 
@@ -243,6 +245,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
+	struct device *dev = pp->dev;
 	u32 pending;
 	int virq;
 
@@ -250,8 +253,7 @@ void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
 
 	if (BIT(0) & pending) {
 		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(pp->dev, ": irq: irq_offset %d, virq %d\n", offset,
-			virq);
+		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
 		generic_handle_irq(virq);
 	}
 
@@ -506,12 +508,13 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 				struct device_node *msi_intc_np)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
-	struct platform_device *pdev = to_platform_device(pp->dev);
+	struct device *dev = pp->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
 
 	/* Index 0 is the config reg. space address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pp->dbi_base = devm_ioremap_resource(pp->dev, res);
+	pp->dbi_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pp->dbi_base))
 		return PTR_ERR(pp->dbi_base);
 
@@ -524,7 +527,7 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 
 	/* Index 1 is the application reg. space address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ks_pcie->va_app_base = devm_ioremap_resource(pp->dev, res);
+	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ks_pcie->va_app_base))
 		return PTR_ERR(ks_pcie->va_app_base);
 
@@ -537,7 +540,7 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 					&ks_dw_pcie_legacy_irq_domain_ops,
 					NULL);
 	if (!ks_pcie->legacy_irq_domain) {
-		dev_err(pp->dev, "Failed to add irq domain for legacy irqs\n");
+		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 82b461b..9dfac0b 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -89,12 +89,13 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
 static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
+	struct device *dev = pp->dev;
 	unsigned int retries;
 
 	dw_pcie_setup_rc(pp);
 
 	if (dw_pcie_link_up(pp)) {
-		dev_err(pp->dev, "Link already up\n");
+		dev_err(dev, "Link already up\n");
 		return 0;
 	}
 
@@ -105,7 +106,7 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 			return 0;
 	}
 
-	dev_err(pp->dev, "phy link never came up\n");
+	dev_err(dev, "phy link never came up\n");
 	return -ETIMEDOUT;
 }
 
@@ -115,9 +116,10 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	u32 offset = irq - ks_pcie->msi_host_irqs[0];
 	struct pcie_port *pp = &ks_pcie->pp;
+	struct device *dev = pp->dev;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	dev_dbg(pp->dev, "%s, irq %d\n", __func__, irq);
+	dev_dbg(dev, "%s, irq %d\n", __func__, irq);
 
 	/*
 	 * The chained irq handler installation would have replaced normal
@@ -142,10 +144,11 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	struct pcie_port *pp = &ks_pcie->pp;
+	struct device *dev = pp->dev;
 	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	dev_dbg(pp->dev, ": Handling legacy irq %d\n", irq);
+	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
 
 	/*
 	 * The chained irq handler installation would have replaced normal
@@ -310,6 +313,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 			 struct platform_device *pdev)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
+	struct device *dev = pp->dev;
 	int ret;
 
 	ret = ks_pcie_get_irq_controller_info(ks_pcie,
@@ -332,12 +336,12 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 	 */
 	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
 	if (ks_pcie->error_irq <= 0)
-		dev_info(&pdev->dev, "no error IRQ defined\n");
+		dev_info(dev, "no error IRQ defined\n");
 	else {
 		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
 				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to request error IRQ %d\n",
+			dev_err(dev, "failed to request error IRQ %d\n",
 				ks_pcie->error_irq);
 			return ret;
 		}
@@ -347,7 +351,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 	pp->ops = &keystone_pcie_host_ops;
 	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -381,12 +385,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct phy *phy;
 	int ret;
 
-	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
-				GFP_KERNEL);
+	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
 	if (!ks_pcie)
 		return -ENOMEM;
 
 	pp = &ks_pcie->pp;
+	pp->dev = dev;
 
 	/* initialize SerDes Phy if present */
 	phy = devm_phy_get(dev, "pcie-phy");
@@ -408,7 +412,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	devm_iounmap(dev, reg_p);
 	devm_release_mem_region(dev, res->start, resource_size(res));
 
-	pp->dev = dev;
 	ks_pcie->np = dev->of_node;
 	platform_set_drvdata(pdev, ks_pcie);
 	ks_pcie->clk = devm_clk_get(dev, "pcie");

