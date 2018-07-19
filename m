Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:57239 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbeGSJO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jul 2018 05:14:28 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v14 10/12] pci_endpoint_test: Add 2 ioctl commands
Date: Thu, 19 Jul 2018 10:32:20 +0200
Message-Id: <1ae7bbd37d3fd1a8d4e7ae9b6d0325618736eed1.1531922095.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
References: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
References: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add MSI-X support and update driver documentation accordingly.

Add 2 new IOCTL commands:
 - Allow to reconfigure driver IRQ type in runtime.
 - Allow to retrieve current driver IRQ type configured.

Add IRQ type validation before executing the READ/WRITE/COPY tests.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v2->v3:
 - New patch file created base on the previous patch
"misc: pci_endpoint_test: Add MSI-X support" patch file following
Kishon's suggestion.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Nothing changed, just to follow the patch set version.
Change v5->v6:
 - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
from patch #10 to here.
 - Increased ioctl parameters range associated to
drivers/misc/pci_endpoint_test.c driver.
Change v6->v7:
 - irq_type variable update just before returning the function.
Change v7->v8:
 - Re-sending the patch series.
Change v8->v9:
 - Added a extra parameter to pci_endpoint_test_alloc_irq_vectors,
that specifies which irq type should be allocated.
Change v9->v10:
 - Fixed bug, report available: https://lkml.org/lkml/2018/7/16/11
 - Added IRQ type validation before executing the READ/WRITE/COPY
tests.
Change v11->v12:
 - Exchange pci_endpoint_test_release_irq() and
pci_endpoint_test_free_irq_vectors() content.
 - Refactor all previous calls to those functions.
Change v12->v13:
 - Re-sending the patch series.
Change v13->v14:
- Removed special treatment (request_irq) for IRQ legacy and
implemented a generic IRQ request for all IRQ types, following
Alan Douglas suggestion. (Already tested by Alan and Kishon on
their setups).

 Documentation/ioctl/ioctl-number.txt             |   2 +-
 Documentation/misc-devices/pci-endpoint-test.txt |   3 +
 drivers/misc/pci_endpoint_test.c                 | 206 +++++++++++++++++------
 include/uapi/linux/pcitest.h                     |   2 +
 4 files changed, 165 insertions(+), 48 deletions(-)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 65259d4..c15c4f3 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -166,7 +166,7 @@ Code  Seq#(hex)	Include File		Comments
 'P'	all	linux/soundcard.h	conflict!
 'P'	60-6F	sound/sscape_ioctl.h	conflict!
 'P'	00-0F	drivers/usb/class/usblp.c	conflict!
-'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
+'P'	01-09	drivers/misc/pci_endpoint_test.c	conflict!
 'Q'	all	linux/soundcard.h
 'R'	00-1F	linux/random.h		conflict!
 'R'	01	linux/rfkill.h		conflict!
diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
index fdfa0f6..58ccca4 100644
--- a/Documentation/misc-devices/pci-endpoint-test.txt
+++ b/Documentation/misc-devices/pci-endpoint-test.txt
@@ -28,6 +28,9 @@ ioctl
 	      to be tested should be passed as argument.
  PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
 	      to be tested should be passed as argument.
+ PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
+	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
+ PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
  PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
 		as argument.
  PCITEST_READ: Perform read tests. The size of the buffer should be passed
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index f4fef10..896e2df 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -37,6 +37,7 @@
 
 #define DRV_MODULE_NAME				"pci-endpoint-test"
 
+#define IRQ_TYPE_UNDEFINED			-1
 #define IRQ_TYPE_LEGACY				0
 #define IRQ_TYPE_MSI				1
 #define IRQ_TYPE_MSIX				2
@@ -157,6 +158,100 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+
+	pci_free_irq_vectors(pdev);
+}
+
+static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
+						int type)
+{
+	int irq = -1;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	bool res = true;
+
+	switch (type) {
+	case IRQ_TYPE_LEGACY:
+		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+		if (irq < 0)
+			dev_err(dev, "Failed to get Legacy interrupt\n");
+		break;
+	case IRQ_TYPE_MSI:
+		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
+		if (irq < 0)
+			dev_err(dev, "Failed to get MSI interrupts\n");
+		break;
+	case IRQ_TYPE_MSIX:
+		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
+		if (irq < 0)
+			dev_err(dev, "Failed to get MSI-X interrupts\n");
+		break;
+	default:
+		dev_err(dev, "Invalid IRQ type selected\n");
+	}
+
+	if (irq < 0) {
+		irq = 0;
+		res = false;
+	}
+	test->num_irqs = irq;
+
+	return res;
+}
+
+static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
+{
+	int i;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	for (i = 0; i < test->num_irqs; i++)
+		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
+
+	test->num_irqs = 0;
+}
+
+static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
+{
+	int i;
+	int err;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	for (i = 0; i < test->num_irqs; i++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+				       pci_endpoint_test_irqhandler,
+				       IRQF_SHARED, DRV_MODULE_NAME, test);
+		if (err)
+			goto fail;
+	}
+
+	return true;
+
+fail:
+	switch (irq_type) {
+	case IRQ_TYPE_LEGACY:
+		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
+			pci_irq_vector(pdev, i));
+		break;
+	case IRQ_TYPE_MSI:
+		dev_err(dev, "Failed to request IRQ %d for MSI %d\n",
+			pci_irq_vector(pdev, i),
+			i + 1);
+		break;
+	case IRQ_TYPE_MSIX:
+		dev_err(dev, "Failed to request IRQ %d for MSI-X %d\n",
+			pci_irq_vector(pdev, i),
+			i + 1);
+		break;
+	}
+
+	return false;
+}
+
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
@@ -247,6 +342,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
+	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		goto err;
+	}
+
 	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
 					   &orig_src_phys_addr, GFP_KERNEL);
 	if (!orig_src_addr) {
@@ -337,6 +437,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
+	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		goto err;
+	}
+
 	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
 				       GFP_KERNEL);
 	if (!orig_addr) {
@@ -400,6 +505,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
+	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		goto err;
+	}
+
 	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
 				       GFP_KERNEL);
 	if (!orig_addr) {
@@ -440,6 +550,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	return ret;
 }
 
+static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
+				      int req_irq_type)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	if (irq_type == req_irq_type)
+		return true;
+
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
+	if (!pci_endpoint_test_alloc_irq_vectors(test, req_irq_type))
+		goto err;
+
+	if (!pci_endpoint_test_request_irq(test))
+		goto err;
+
+	irq_type = req_irq_type;
+	return true;
+
+err:
+	pci_endpoint_test_free_irq_vectors(test);
+	irq_type = IRQ_TYPE_UNDEFINED;
+	return false;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -471,6 +613,12 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_COPY:
 		ret = pci_endpoint_test_copy(test, arg);
 		break;
+	case PCITEST_SET_IRQTYPE:
+		ret = pci_endpoint_test_set_irq(test, arg);
+		break;
+	case PCITEST_GET_IRQTYPE:
+		ret = irq_type;
+		break;
 	}
 
 ret:
@@ -486,9 +634,7 @@ static const struct file_operations pci_endpoint_test_fops = {
 static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
-	int i;
 	int err;
-	int irq = 0;
 	int id;
 	char name[20];
 	enum pci_barno bar;
@@ -537,41 +683,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	switch (irq_type) {
-	case IRQ_TYPE_LEGACY:
-		break;
-	case IRQ_TYPE_MSI:
-		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
-		if (irq < 0)
-			dev_err(dev, "Failed to get MSI interrupts\n");
-		test->num_irqs = irq;
-		break;
-	case IRQ_TYPE_MSIX:
-		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
-		if (irq < 0)
-			dev_err(dev, "Failed to get MSI-X interrupts\n");
-		test->num_irqs = irq;
-		break;
-	default:
-		dev_err(dev, "Invalid IRQ type selected\n");
-	}
+	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type))
+		goto err_disable_irq;
 
-	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
-			       IRQF_SHARED, DRV_MODULE_NAME, test);
-	if (err) {
-		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
-		goto err_disable_msi;
-	}
-
-	for (i = 1; i < irq; i++) {
-		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
-				       pci_endpoint_test_irqhandler,
-				       IRQF_SHARED, DRV_MODULE_NAME, test);
-		if (err)
-			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
-				pci_irq_vector(pdev, i),
-				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
-	}
+	if (!pci_endpoint_test_request_irq(test))
+		goto err_disable_irq;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
@@ -630,13 +746,10 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
+	pci_endpoint_test_release_irq(test);
 
-	for (i = 0; i < irq; i++)
-		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
-
-err_disable_msi:
-	pci_disable_msi(pdev);
-	pci_disable_msix(pdev);
+err_disable_irq:
+	pci_endpoint_test_free_irq_vectors(test);
 	pci_release_regions(pdev);
 
 err_disable_pdev:
@@ -648,7 +761,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 static void pci_endpoint_test_remove(struct pci_dev *pdev)
 {
 	int id;
-	int i;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
 	struct miscdevice *misc_device = &test->miscdev;
@@ -665,10 +777,10 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
-	for (i = 0; i < test->num_irqs; i++)
-		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
-	pci_disable_msi(pdev);
-	pci_disable_msix(pdev);
+
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index d746fb1..cbf422e 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -17,5 +17,7 @@
 #define PCITEST_READ		_IOW('P', 0x5, unsigned long)
 #define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
+#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
+#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 
 #endif /* __UAPI_LINUX_PCITEST_H */
-- 
2.7.4
