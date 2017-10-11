Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:18521 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757317AbdJKIpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2017 04:45:31 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: [PATCH 3/3] misc: pci_endpoint_test: Fix BUG_ON error during pci_disable_msi
Date: Wed, 11 Oct 2017 14:14:38 +0530
Message-ID: <20171011084438.8296-4-kishon@ti.com>
In-Reply-To: <20171011084438.8296-1-kishon@ti.com>
References: <20171011084438.8296-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_disable_msi throws a Kernel BUG if the driver has
successfully requested an irq and not released it. Fix it here by freeing
irqs before invoking pci_disable_msi.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 5cb624b6fa0a..086a7f85c2c0 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -92,6 +92,7 @@ struct pci_endpoint_test {
 	void __iomem	*bar[6];
 	struct completion irq_raised;
 	int		last_irq;
+	int		num_irqs;
 	/* mutex to protect the ioctls */
 	struct mutex	mutex;
 	struct miscdevice miscdev;
@@ -504,6 +505,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
 		if (irq < 0)
 			dev_err(dev, "failed to get MSI interrupts\n");
+		test->num_irqs = irq;
 	}
 
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
@@ -578,6 +580,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
+	for (i = 0; i < irq; i++)
+		devm_free_irq(dev, pdev->irq + i, test);
+
 err_disable_msi:
 	pci_disable_msi(pdev);
 	pci_release_regions(pdev);
@@ -591,6 +596,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 static void pci_endpoint_test_remove(struct pci_dev *pdev)
 {
 	int id;
+	int i;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
 	struct miscdevice *misc_device = &test->miscdev;
@@ -605,6 +611,8 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
+	for (i = 0; i < test->num_irqs; i++)
+		devm_free_irq(&pdev->dev, pdev->irq + i, test);
 	pci_disable_msi(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.11.0
