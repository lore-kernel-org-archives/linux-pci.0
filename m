Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:38440 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeENR14 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 13:27:56 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0F9CB1E04F9
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 19:27:55 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] misc: pci_endpoint_test: Use pci_irq_vector function
Date: Mon, 14 May 2018 18:27:48 +0100
Message-Id: <a9f06365aedf72e34781716ffff89b375c9f5642.1526318738.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace "pdev->irq + index" operation by the pci_irq_vector() call,
that converts from device vector to Linux IRQ.
(suggestion made by Alan Douglas).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/pci_endpoint_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index fe8897e..28d0cd9 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -203,7 +203,7 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	if (!val)
 		return false;
 
-	if (test->last_irq - pdev->irq == msi_num - 1)
+	if (pci_irq_vector(pdev, msi_num - 1) == test->last_irq)
 		return true;
 
 	return false;
@@ -525,12 +525,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	for (i = 1; i < irq; i++) {
-		err = devm_request_irq(dev, pdev->irq + i,
+		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
 				       pci_endpoint_test_irqhandler,
 				       IRQF_SHARED, DRV_MODULE_NAME, test);
 		if (err)
 			dev_err(dev, "failed to request IRQ %d for MSI %d\n",
-				pdev->irq + i, i + 1);
+				pci_irq_vector(pdev, i), i + 1);
 	}
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
@@ -592,7 +592,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	for (i = 0; i < irq; i++)
-		devm_free_irq(dev, pdev->irq + i, test);
+		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
 
 err_disable_msi:
 	pci_disable_msi(pdev);
@@ -625,7 +625,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 	for (i = 0; i < test->num_irqs; i++)
-		devm_free_irq(&pdev->dev, pdev->irq + i, test);
+		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
 	pci_disable_msi(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.7.4
