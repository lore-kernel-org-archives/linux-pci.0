Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, niklas.cassel@axis.com,
        jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [RFC 06/10] misc: pci_endpoint_test: Add MSI-X support
Date: Tue, 10 Apr 2018 18:14:45 +0100
Message-Id: <8b88f8c2b766f36c71659deb0fce635154b2b39f.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the MSI-X support and updates driver documentation accordingly.

Changes the driver parameter in order to allow the interruption type
selection.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/pci-endpoint-test.txt |   3 +
 drivers/misc/pci_endpoint_test.c                 | 102 +++++++++++++++++------
 2 files changed, 79 insertions(+), 26 deletions(-)

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
index 37db0fc..a7d9354 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,11 +42,16 @@
 #define PCI_ENDPOINT_TEST_COMMAND	0x4
 #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
 #define COMMAND_RAISE_MSI_IRQ		BIT(1)
-#define MSI_NUMBER_SHIFT		2
-/* 6 bits for MSI number */
-#define COMMAND_READ                    BIT(8)
-#define COMMAND_WRITE                   BIT(9)
-#define COMMAND_COPY                    BIT(10)
+#define COMMAND_RAISE_MSIX_IRQ		BIT(2)
+#define IRQ_TYPE_SHIFT			3
+#define IRQ_TYPE_LEGACY			0
+#define IRQ_TYPE_MSI			1
+#define IRQ_TYPE_MSIX			2
+#define MSI_NUMBER_SHIFT		5
+/* 12 bits for MSI number */
+#define COMMAND_READ                    BIT(17)
+#define COMMAND_WRITE                   BIT(18)
+#define COMMAND_COPY                    BIT(19)
 
 #define PCI_ENDPOINT_TEST_STATUS	0x8
 #define STATUS_READ_SUCCESS             BIT(0)
@@ -73,9 +78,9 @@ static DEFINE_IDA(pci_endpoint_test_ida);
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
 					    miscdev)
 
-static bool no_msi;
-module_param(no_msi, bool, 0444);
-MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
+static int irq_type = IRQ_TYPE_MSIX;
+module_param(irq_type, int, 0444);
+MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");
 
 enum pci_barno {
 	BAR_0,
@@ -103,7 +108,7 @@ struct pci_endpoint_test {
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
-	bool no_msi;
+	int irq_type;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -177,10 +182,10 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 
 static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 {
-	u32 val;
+	u32 val = COMMAND_RAISE_LEGACY_IRQ;
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_RAISE_LEGACY_IRQ);
+	val |= (IRQ_TYPE_LEGACY << IRQ_TYPE_SHIFT);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
@@ -192,12 +197,12 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 				      u8 msi_num)
 {
-	u32 val;
+	u32 val = COMMAND_RAISE_MSI_IRQ;
 	struct pci_dev *pdev = test->pdev;
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 msi_num << MSI_NUMBER_SHIFT |
-				 COMMAND_RAISE_MSI_IRQ);
+	val |= (msi_num << MSI_NUMBER_SHIFT);
+	val |= (IRQ_TYPE_MSI << IRQ_TYPE_SHIFT);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
@@ -209,6 +214,26 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_msix_irq(struct pci_endpoint_test *test,
+				       u16 msix_num)
+{
+	u32 val = COMMAND_RAISE_MSIX_IRQ;
+	struct pci_dev *pdev = test->pdev;
+
+	val |= (msix_num << MSI_NUMBER_SHIFT);
+	val |= (IRQ_TYPE_MSIX << IRQ_TYPE_SHIFT);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
+	val = wait_for_completion_timeout(&test->irq_raised,
+					  msecs_to_jiffies(1000));
+	if (!val)
+		return false;
+
+	if (test->last_irq - pdev->irq == msix_num - 1)
+		return true;
+
+	return false;
+}
+
 static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 {
 	bool ret = false;
@@ -226,6 +251,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	size_t alignment = test->alignment;
 	u32 src_crc32;
 	u32 dst_crc32;
+	u32 val = COMMAND_COPY;
 
 	if (size > SIZE_MAX - alignment)
 		goto err;
@@ -281,8 +307,9 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
 				 size);
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_COPY);
+	val |= (1 << MSI_NUMBER_SHIFT);
+	val |= (irq_type << IRQ_TYPE_SHIFT);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -314,6 +341,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	size_t offset;
 	size_t alignment = test->alignment;
 	u32 crc32;
+	u32 val = COMMAND_READ;
 
 	if (size > SIZE_MAX - alignment)
 		goto err;
@@ -348,8 +376,9 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_READ);
+	val |= (1 << MSI_NUMBER_SHIFT);
+	val |= (irq_type << IRQ_TYPE_SHIFT);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -375,6 +404,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	size_t offset;
 	size_t alignment = test->alignment;
 	u32 crc32;
+	u32 val = COMMAND_WRITE;
 
 	if (size > SIZE_MAX - alignment)
 		goto err;
@@ -403,8 +433,9 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_WRITE);
+	val |= (1 << MSI_NUMBER_SHIFT);
+	val |= (irq_type << IRQ_TYPE_SHIFT);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -438,6 +469,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_MSI:
 		ret = pci_endpoint_test_msi_irq(test, arg);
 		break;
+	case PCITEST_MSIX:
+		ret = pci_endpoint_test_msix_irq(test, arg);
+		break;
 	case PCITEST_WRITE:
 		ret = pci_endpoint_test_write(test, arg);
 		break;
@@ -490,7 +524,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (data) {
 		test_reg_bar = data->test_reg_bar;
 		test->alignment = data->alignment;
-		no_msi = data->no_msi;
+		irq_type = data->irq_type;
 	}
 
 	init_completion(&test->irq_raised);
@@ -510,11 +544,24 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (!no_msi) {
+	switch (irq_type) {
+	case IRQ_TYPE_LEGACY:
+		break;
+	case IRQ_TYPE_MSI:
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
 		if (irq < 0)
 			dev_err(dev, "failed to get MSI interrupts\n");
 		test->num_irqs = irq;
+		break;
+	case IRQ_TYPE_MSIX:
+		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
+		if (irq < 0)
+			dev_err(dev, "Failed to get MSI-X interrupts\n");
+		test->num_irqs = irq;
+		break;
+	default:
+		dev_err(dev, "Invalid IRQ type selected\n");
+		goto err_disable_msi;
 	}
 
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
@@ -529,8 +576,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				       pci_endpoint_test_irqhandler,
 				       IRQF_SHARED, DRV_MODULE_NAME, test);
 		if (err)
-			dev_err(dev, "failed to request IRQ %d for MSI %d\n",
-				pdev->irq + i, i + 1);
+			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
+				pdev->irq + i,
+				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
 	}
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
@@ -596,6 +644,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 err_disable_msi:
 	pci_disable_msi(pdev);
+	pci_disable_msix(pdev);
 	pci_release_regions(pdev);
 
 err_disable_pdev:
@@ -627,6 +676,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	for (i = 0; i < test->num_irqs; i++)
 		devm_free_irq(&pdev->dev, pdev->irq + i, test);
 	pci_disable_msi(pdev);
+	pci_disable_msix(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.7.4
