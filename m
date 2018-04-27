Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:37148 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758920AbeD0Q57 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 12:57:59 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 07/10] misc: pci_endpoint_test: Replace lower into upper case characters
Date: Fri, 27 Apr 2018 17:57:44 +0100
Message-Id: <17224b32eaf73ac071975c4b6cda526472f11d15.1524845816.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace all initial lower case character into upper case in comments
and debug printks.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/pci_endpoint_test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index b003079..c9b6e26 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -250,7 +250,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
 					   &orig_src_phys_addr, GFP_KERNEL);
 	if (!orig_src_addr) {
-		dev_err(dev, "failed to allocate source buffer\n");
+		dev_err(dev, "Failed to allocate source buffer\n");
 		ret = false;
 		goto err;
 	}
@@ -276,7 +276,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	orig_dst_addr = dma_alloc_coherent(dev, size + alignment,
 					   &orig_dst_phys_addr, GFP_KERNEL);
 	if (!orig_dst_addr) {
-		dev_err(dev, "failed to allocate destination address\n");
+		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
 		goto err_orig_src_addr;
 	}
@@ -340,7 +340,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
 				       GFP_KERNEL);
 	if (!orig_addr) {
-		dev_err(dev, "failed to allocate address\n");
+		dev_err(dev, "Failed to allocate address\n");
 		ret = false;
 		goto err;
 	}
@@ -403,7 +403,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
 				       GFP_KERNEL);
 	if (!orig_addr) {
-		dev_err(dev, "failed to allocate destination address\n");
+		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
 		goto err;
 	}
@@ -543,7 +543,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	case IRQ_TYPE_MSI:
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
 		if (irq < 0)
-			dev_err(dev, "failed to get MSI interrupts\n");
+			dev_err(dev, "Failed to get MSI interrupts\n");
 		test->num_irqs = irq;
 		break;
 	case IRQ_TYPE_MSIX:
@@ -560,7 +560,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
 			       IRQF_SHARED, DRV_MODULE_NAME, test);
 	if (err) {
-		dev_err(dev, "failed to request IRQ %d\n", pdev->irq);
+		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
 		goto err_disable_msi;
 	}
 
@@ -578,7 +578,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 			base = pci_ioremap_bar(pdev, bar);
 			if (!base) {
-				dev_err(dev, "failed to read BAR%d\n", bar);
+				dev_err(dev, "Failed to read BAR%d\n", bar);
 				WARN_ON(bar == test_reg_bar);
 			}
 			test->bar[bar] = base;
@@ -598,7 +598,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	id = ida_simple_get(&pci_endpoint_test_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
-		dev_err(dev, "unable to get id\n");
+		dev_err(dev, "Unable to get id\n");
 		goto err_iounmap;
 	}
 
@@ -614,7 +614,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	err = misc_register(misc_device);
 	if (err) {
-		dev_err(dev, "failed to register device\n");
+		dev_err(dev, "Failed to register device\n");
 		goto err_kfree_name;
 	}
 
-- 
2.7.4
