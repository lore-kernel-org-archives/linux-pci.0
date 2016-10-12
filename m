Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755064AbcJLMrM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:47:12 -0400
Subject: [PATCH v2 1/6] PCI: altera: Add local struct device pointers
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Wed, 12 Oct 2016 07:47:07 -0500
Message-ID: <20161012124707.23240.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index c24e965..eac548b 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -394,6 +394,7 @@ static int altera_write_cap_word(struct altera_pcie *pcie, u8 busno,
 
 static void altera_wait_link_retrain(struct altera_pcie *pcie)
 {
+	struct device *dev = &pcie->pdev->dev;
 	u16 reg16;
 	unsigned long start_jiffies;
 
@@ -406,7 +407,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
 			break;
 
 		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
-			dev_err(&pcie->pdev->dev, "link retrain timeout\n");
+			dev_err(dev, "link retrain timeout\n");
 			break;
 		}
 		udelay(100);
@@ -419,7 +420,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
 			break;
 
 		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
-			dev_err(&pcie->pdev->dev, "link up timeout\n");
+			dev_err(dev, "link up timeout\n");
 			break;
 		}
 		udelay(100);
@@ -460,7 +461,6 @@ static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 {
 	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
 	irq_set_chip_data(irq, domain->host_data);
-
 	return 0;
 }
 
@@ -472,12 +472,14 @@ static void altera_pcie_isr(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct altera_pcie *pcie;
+	struct device *dev;
 	unsigned long status;
 	u32 bit;
 	u32 virq;
 
 	chained_irq_enter(chip, desc);
 	pcie = irq_desc_get_handler_data(desc);
+	dev = &pcie->pdev->dev;
 
 	while ((status = cra_readl(pcie, P2A_INT_STATUS)
 		& P2A_INT_STS_ALL) != 0) {
@@ -489,8 +491,7 @@ static void altera_pcie_isr(struct irq_desc *desc)
 			if (virq)
 				generic_handle_irq(virq);
 			else
-				dev_err(&pcie->pdev->dev,
-					"unexpected IRQ, INT%d\n", bit);
+				dev_err(dev, "unexpected IRQ, INT%d\n", bit);
 		}
 	}
 
@@ -549,30 +550,30 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 
 static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 {
-	struct resource *cra;
+	struct device *dev = &pcie->pdev->dev;
 	struct platform_device *pdev = pcie->pdev;
+	struct resource *cra;
 
 	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
 	if (!cra) {
-		dev_err(&pdev->dev, "no Cra memory resource defined\n");
+		dev_err(dev, "no Cra memory resource defined\n");
 		return -ENODEV;
 	}
 
-	pcie->cra_base = devm_ioremap_resource(&pdev->dev, cra);
+	pcie->cra_base = devm_ioremap_resource(dev, cra);
 	if (IS_ERR(pcie->cra_base)) {
-		dev_err(&pdev->dev, "failed to map cra memory\n");
+		dev_err(dev, "failed to map cra memory\n");
 		return PTR_ERR(pcie->cra_base);
 	}
 
 	/* setup IRQ */
 	pcie->irq = platform_get_irq(pdev, 0);
 	if (pcie->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", pcie->irq);
+		dev_err(dev, "failed to get IRQ: %d\n", pcie->irq);
 		return -EINVAL;
 	}
 
 	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
-
 	return 0;
 }
 
@@ -583,12 +584,13 @@ static void altera_pcie_host_init(struct altera_pcie *pcie)
 
 static int altera_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct altera_pcie *pcie;
 	struct pci_bus *bus;
 	struct pci_bus *child;
 	int ret;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
@@ -596,7 +598,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 
 	ret = altera_pcie_parse_dt(pcie);
 	if (ret) {
-		dev_err(&pdev->dev, "Parsing DT failed\n");
+		dev_err(dev, "Parsing DT failed\n");
 		return ret;
 	}
 
@@ -604,13 +606,13 @@ static int altera_pcie_probe(struct platform_device *pdev)
 
 	ret = altera_pcie_parse_request_of_pci_ranges(pcie);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed add resources\n");
+		dev_err(dev, "Failed add resources\n");
 		return ret;
 	}
 
 	ret = altera_pcie_init_irq_domain(pcie);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
+		dev_err(dev, "Failed creating IRQ Domain\n");
 		return ret;
 	}
 
@@ -620,7 +622,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
 	altera_pcie_host_init(pcie);
 
-	bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
+	bus = pci_scan_root_bus(dev, pcie->root_bus_nr, &altera_pcie_ops,
 				pcie, &pcie->resources);
 	if (!bus)
 		return -ENOMEM;

