Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:38578 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeENR7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 13:59:18 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 172261E1376
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 19:59:17 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 1/2] misc: pci_endpoint_test: Replace lower into upper case characters
Date: Mon, 14 May 2018 18:59:11 +0100
Message-Id: <0410b99106ec925773cadcfbf6c4646d37639a8b.1526311733.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
References: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
References: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace all initial lower case character into upper case in comments
and debug printks.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/pci_endpoint_test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index fe8897e..6a75f86 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -233,7 +233,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
 					   &orig_src_phys_addr, GFP_KERNEL);
 	if (!orig_src_addr) {
-		dev_err(dev, "failed to allocate source buffer\n");
+		dev_err(dev, "Failed to allocate source buffer\n");
 		ret = false;
 		goto err;
 	}
@@ -259,7 +259,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	orig_dst_addr = dma_alloc_coherent(dev, size + alignment,
 					   &orig_dst_phys_addr, GFP_KERNEL);
 	if (!orig_dst_addr) {
-		dev_err(dev, "failed to allocate destination address\n");
+		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
 		goto err_orig_src_addr;
 	}
@@ -321,7 +321,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
 				       GFP_KERNEL);
 	if (!orig_addr) {
-		dev_err(dev, "failed to allocate address\n");
+		dev_err(dev, "Failed to allocate address\n");
 		ret = false;
 		goto err;
 	}
@@ -382,7 +382,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
 				       GFP_KERNEL);
 	if (!orig_addr) {
-		dev_err(dev, "failed to allocate destination address\n");
+		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
 		goto err;
 	}
@@ -513,14 +513,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (!no_msi) {
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
 		if (irq < 0)
-			dev_err(dev, "failed to get MSI interrupts\n");
+			dev_err(dev, "Failed to get MSI interrupts\n");
 		test->num_irqs = irq;
 	}
 
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
 			       IRQF_SHARED, DRV_MODULE_NAME, test);
 	if (err) {
-		dev_err(dev, "failed to request IRQ %d\n", pdev->irq);
+		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
 		goto err_disable_msi;
 	}
 
@@ -537,7 +537,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 			base = pci_ioremap_bar(pdev, bar);
 			if (!base) {
-				dev_err(dev, "failed to read BAR%d\n", bar);
+				dev_err(dev, "Failed to read BAR%d\n", bar);
 				WARN_ON(bar == test_reg_bar);
 			}
 			test->bar[bar] = base;
@@ -557,7 +557,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	id = ida_simple_get(&pci_endpoint_test_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
-		dev_err(dev, "unable to get id\n");
+		dev_err(dev, "Unable to get id\n");
 		goto err_iounmap;
 	}
 
@@ -573,7 +573,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	err = misc_register(misc_device);
 	if (err) {
-		dev_err(dev, "failed to register device\n");
+		dev_err(dev, "Failed to register device\n");
 		goto err_kfree_name;
 	}
 
-- 
2.7.4
