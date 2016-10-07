Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936461AbcJGQXC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:23:02 -0400
Subject: [PATCH 09/10] PCI: altera: Add local struct device pointers
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Fri, 07 Oct 2016 11:22:58 -0500
Message-ID: <20161007162258.22796.5577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 90ab581..92749e9 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -388,6 +388,7 @@ static int altera_write_cap_word(struct altera_pcie *altera, u8 busno,
 
 static void altera_wait_link_retrain(struct altera_pcie *altera)
 {
+	struct device *dev = &altera->pdev->dev;
 	u16 reg16;
 	unsigned long start_jiffies;
 
@@ -400,7 +401,7 @@ static void altera_wait_link_retrain(struct altera_pcie *altera)
 			break;
 
 		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
-			dev_err(&altera->pdev->dev, "link retrain timeout\n");
+			dev_err(dev, "link retrain timeout\n");
 			break;
 		}
 		udelay(100);
@@ -413,7 +414,7 @@ static void altera_wait_link_retrain(struct altera_pcie *altera)
 			break;
 
 		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
-			dev_err(&altera->pdev->dev, "link up timeout\n");
+			dev_err(dev, "link up timeout\n");
 			break;
 		}
 		udelay(100);
@@ -466,12 +467,14 @@ static void altera_pcie_isr(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct altera_pcie *altera;
+	struct device *dev;
 	unsigned long status;
 	u32 bit;
 	u32 virq;
 
 	chained_irq_enter(chip, desc);
 	altera = irq_desc_get_handler_data(desc);
+	dev = &altera->pdev->dev;
 
 	while ((status = altera_cra_readl(altera, P2A_INT_STATUS)
 		& P2A_INT_STS_ALL) != 0) {
@@ -483,8 +486,7 @@ static void altera_pcie_isr(struct irq_desc *desc)
 			if (virq)
 				generic_handle_irq(virq);
 			else
-				dev_err(&altera->pdev->dev,
-					"unexpected IRQ, INT%d\n", bit);
+				dev_err(dev, "unexpected IRQ, INT%d\n", bit);
 		}
 	}
 
@@ -543,20 +545,21 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *altera)
 
 static int altera_pcie_parse_dt(struct altera_pcie *altera)
 {
-	struct resource *cra;
 	struct platform_device *pdev = altera->pdev;
+	struct device *dev = &pdev->dev;
+	struct resource *cra;
 
 	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
-	altera->cra_base = devm_ioremap_resource(&pdev->dev, cra);
+	altera->cra_base = devm_ioremap_resource(dev, cra);
 	if (IS_ERR(altera->cra_base)) {
-		dev_err(&pdev->dev, "failed to map cra memory\n");
+		dev_err(dev, "failed to map cra memory\n");
 		return PTR_ERR(altera->cra_base);
 	}
 
 	/* setup IRQ */
 	altera->irq = platform_get_irq(pdev, 0);
 	if (altera->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", altera->irq);
+		dev_err(dev, "failed to get IRQ: %d\n", altera->irq);
 		return -EINVAL;
 	}
 
@@ -572,12 +575,13 @@ static void altera_pcie_host_init(struct altera_pcie *altera)
 
 static int altera_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct altera_pcie *altera;
 	struct pci_bus *bus;
 	struct pci_bus *child;
 	int ret;
 
-	altera = devm_kzalloc(&pdev->dev, sizeof(*altera), GFP_KERNEL);
+	altera = devm_kzalloc(dev, sizeof(*altera), GFP_KERNEL);
 	if (!altera)
 		return -ENOMEM;
 
@@ -585,7 +589,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 
 	ret = altera_pcie_parse_dt(altera);
 	if (ret) {
-		dev_err(&pdev->dev, "Parsing DT failed\n");
+		dev_err(dev, "Parsing DT failed\n");
 		return ret;
 	}
 
@@ -593,13 +597,13 @@ static int altera_pcie_probe(struct platform_device *pdev)
 
 	ret = altera_pcie_parse_request_of_pci_ranges(altera);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed add resources\n");
+		dev_err(dev, "Failed add resources\n");
 		return ret;
 	}
 
 	ret = altera_pcie_init_irq_domain(altera);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
+		dev_err(dev, "Failed creating IRQ Domain\n");
 		return ret;
 	}
 
@@ -609,7 +613,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	altera_cra_writel(altera, P2A_INT_ENABLE, P2A_INT_ENA_ALL);
 	altera_pcie_host_init(altera);
 
-	bus = pci_scan_root_bus(&pdev->dev, altera->root_bus_nr,
+	bus = pci_scan_root_bus(dev, altera->root_bus_nr,
 				&altera_pcie_ops, altera, &altera->resources);
 	if (!bus)
 		return -ENOMEM;

