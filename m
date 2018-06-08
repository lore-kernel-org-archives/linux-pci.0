Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:47741 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeFHITm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jun 2018 04:19:42 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 08/10] pci-epf-test/pci_endpoint_test: Add MSI-X support
Date: Fri,  8 Jun 2018 09:19:24 +0100
Message-Id: <d8feb1f60a2aaacd174e3050fa34fa4840ed1a95.1527862777.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add MSI-X support and update driver documentation accordingly.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v2->v3:
 - New patch file created base on the previous patch
"misc: pci_endpoint_test: Add MSI-X support" patch file following
Kishon's suggestion.

 Documentation/misc-devices/pci-endpoint-test.txt |  3 +++
 drivers/misc/pci_endpoint_test.c                 | 28 ++++++++++++++++++------
 drivers/pci/endpoint/functions/pci-epf-test.c    | 23 ++++++++++++++++++-
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
index 4ebc359..fdfa0f6 100644
--- a/Documentation/misc-devices/pci-endpoint-test.txt
+++ b/Documentation/misc-devices/pci-endpoint-test.txt
@@ -10,6 +10,7 @@ The PCI driver for the test device performs the following tests
 	*) verifying addresses programmed in BAR
 	*) raise legacy IRQ
 	*) raise MSI IRQ
+	*) raise MSI-X IRQ
 	*) read data
 	*) write data
 	*) copy data
@@ -25,6 +26,8 @@ ioctl
  PCITEST_LEGACY_IRQ: Tests legacy IRQ
  PCITEST_MSI: Tests message signalled interrupts. The MSI number
 	      to be tested should be passed as argument.
+ PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
+	      to be tested should be passed as argument.
  PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
 		as argument.
  PCITEST_READ: Perform read tests. The size of the buffer should be passed
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f2061a..8d15dbe 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -39,12 +39,14 @@
 
 #define IRQ_TYPE_LEGACY				0
 #define IRQ_TYPE_MSI				1
+#define IRQ_TYPE_MSIX				2
 
 #define PCI_ENDPOINT_TEST_MAGIC			0x0
 
 #define PCI_ENDPOINT_TEST_COMMAND		0x4
 #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
 #define COMMAND_RAISE_MSI_IRQ			BIT(1)
+#define COMMAND_RAISE_MSIX_IRQ			BIT(2)
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
@@ -83,7 +85,7 @@ MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
 
 static int irq_type = IRQ_TYPE_MSI;
 module_param(irq_type, int, 0444);
-MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI)");
+MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");
 
 enum pci_barno {
 	BAR_0,
@@ -201,16 +203,18 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 }
 
 static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
-				      u8 irq_num)
+				       u16 irq_num, bool msix)
 {
 	u32 val;
 	struct pci_dev *pdev = test->pdev;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 IRQ_TYPE_MSI);
+				 msix == false ? IRQ_TYPE_MSI :
+				 IRQ_TYPE_MSIX);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, irq_num);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_RAISE_MSI_IRQ);
+				 msix == false ? COMMAND_RAISE_MSI_IRQ :
+				 COMMAND_RAISE_MSIX_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
@@ -455,7 +459,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		ret = pci_endpoint_test_legacy_irq(test);
 		break;
 	case PCITEST_MSI:
-		ret = pci_endpoint_test_msi_irq(test, arg);
+	case PCITEST_MSIX:
+		ret = pci_endpoint_test_msi_irq(test, arg, cmd == PCITEST_MSIX);
 		break;
 	case PCITEST_WRITE:
 		ret = pci_endpoint_test_write(test, arg);
@@ -542,6 +547,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 			dev_err(dev, "Failed to get MSI interrupts\n");
 		test->num_irqs = irq;
 		break;
+	case IRQ_TYPE_MSIX:
+		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
+		if (irq < 0)
+			dev_err(dev, "Failed to get MSI-X interrupts\n");
+		test->num_irqs = irq;
+		break;
 	default:
 		dev_err(dev, "Invalid IRQ type selected\n");
 	}
@@ -559,8 +570,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				       pci_endpoint_test_irqhandler,
 				       IRQF_SHARED, DRV_MODULE_NAME, test);
 		if (err)
-			dev_err(dev, "failed to request IRQ %d for MSI %d\n",
-				pci_irq_vector(pdev, i), i + 1);
+			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
+				pci_irq_vector(pdev, i),
+				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
 	}
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
@@ -626,6 +638,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 err_disable_msi:
 	pci_disable_msi(pdev);
+	pci_disable_msix(pdev);
 	pci_release_regions(pdev);
 
 err_disable_pdev:
@@ -657,6 +670,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	for (i = 0; i < test->num_irqs; i++)
 		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
 	pci_disable_msi(pdev);
+	pci_disable_msix(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ff92524..bfef6d1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -20,9 +20,11 @@
 
 #define IRQ_TYPE_LEGACY			0
 #define IRQ_TYPE_MSI			1
+#define IRQ_TYPE_MSIX			2
 
 #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
 #define COMMAND_RAISE_MSI_IRQ		BIT(1)
+#define COMMAND_RAISE_MSIX_IRQ		BIT(2)
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
@@ -265,6 +267,9 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
 	case IRQ_TYPE_MSI:
 		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
 		break;
+	case IRQ_TYPE_MSIX:
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSIX, irq);
+		break;
 	default:
 		dev_err(dev, "Failed to raise IRQ, unknown type\n");
 		break;
@@ -291,7 +296,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	reg->command = 0;
 	reg->status = 0;
 
-	if (reg->irq_type > IRQ_TYPE_MSI) {
+	if (reg->irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
 		goto reset_handler;
 	}
@@ -345,6 +350,16 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		goto reset_handler;
 	}
 
+	if (command & COMMAND_RAISE_MSIX_IRQ) {
+		count = pci_epc_get_msix(epc, epf->func_no);
+		if (reg->irq_number > count || count <= 0)
+			goto reset_handler;
+		reg->status = STATUS_IRQ_RAISED;
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSIX,
+				  reg->irq_number);
+		goto reset_handler;
+	}
+
 reset_handler:
 	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 			   msecs_to_jiffies(1));
@@ -480,6 +495,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return ret;
 	}
 
+	ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
+	if (ret) {
+		dev_err(dev, "MSI-X configuration failed\n");
+		return ret;
+	}
+
 	if (!epf_test->linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
 
-- 
2.7.4
