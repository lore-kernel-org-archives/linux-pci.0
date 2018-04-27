Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 10/10] misc: pci_endpoint_test: Use pci_irq_vector function
Date: Fri, 27 Apr 2018 17:57:47 +0100
Message-Id: <d817b639ca484665a085df9a5cdefbcd7a062e31.1524845816.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace "pdev->irq + index" operation by the pci_irq_vector() call,
that converts from device vector to Linux IRQ.
(suggestion made by Alan Douglas).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/pci_endpoint_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c9b6e26..cbdd0c6 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -220,7 +220,7 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	if (!val)
 		return false;
 
-	if (test->last_irq - pdev->irq == msi_num - 1)
+	if (pci_irq_vector(pdev, irq_num - 1) == test->last_irq)
 		return true;
 
 	return false;
@@ -565,12 +565,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	for (i = 1; i < irq; i++) {
-		err = devm_request_irq(dev, pdev->irq + i,
+		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
 				       pci_endpoint_test_irqhandler,
 				       IRQF_SHARED, DRV_MODULE_NAME, test);
 		if (err)
 			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
-				pdev->irq + i,
+				pci_irq_vector(pdev, i),
 				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
 	}
 
@@ -633,7 +633,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	for (i = 0; i < irq; i++)
-		devm_free_irq(dev, pdev->irq + i, test);
+		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
 
 err_disable_msi:
 	pci_disable_msi(pdev);
@@ -667,7 +667,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 	for (i = 0; i < test->num_irqs; i++)
-		devm_free_irq(&pdev->dev, pdev->irq + i, test);
+		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
 	pci_disable_msi(pdev);
 	pci_disable_msix(pdev);
 	pci_release_regions(pdev);
-- 
2.7.4
