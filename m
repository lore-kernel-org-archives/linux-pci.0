Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:46674 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbeGPPUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jul 2018 11:20:15 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v11 09/12] pci-epf-test/pci_endpoint_test: Add MSI-X support
Date: Mon, 16 Jul 2018 16:52:21 +0200
Message-Id: <700680b7adaa169c13cac7f877c223df079e4345.1531751641.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
References: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
References: <cover.1531751641.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add MSI-X support and update driver documentation accordingly.

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
 - Moved PCITEST_MSIX ioctl entry from patch #10 to here.
 - Documented ioctl parameter type associated to
drivers/misc/pci_endpoint_test.c driver.
Change v6->v7:
 - Updated documentation.
 - Added flag that enables or not the MSI-X on the EP features. 
Change v7->v8:
 - Re-sending the patch series.
Change v8->v9:
 - Moving the EPC_FEATURE_MSIX_AVAILABLE feature set from the
dw_pcie_ep_init() to dw_plat_pcie_ep_init().
Change v9->v10:
 - Update documentation.
Change v10->v11:
 - Nothing changed, just to follow the patch set version.

 Documentation/PCI/endpoint/pci-test-function.txt  |  2 +-
 Documentation/PCI/endpoint/pci-endpoint.txt       |  4 ++--
 Documentation/PCI/endpoint/pci-test-function.txt  |  4 +++-
 Documentation/PCI/endpoint/pci-test-howto.txt     | 22 ++++++++++++++---
 Documentation/ioctl/ioctl-number.txt              |  1 +
 Documentation/misc-devices/pci-endpoint-test.txt  |  3 +++
 drivers/misc/pci_endpoint_test.c                  | 29 ++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware-plat.c |  1 +
 drivers/pci/endpoint/functions/pci-epf-test.c     | 29 +++++++++++++++++++++--
 include/linux/pci-epc.h                           |  1 +
 include/uapi/linux/pcitest.h                      |  1 +
 10 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.txt b/Documentation/PCI/endpoint/pci-endpoint.txt
index 9b1d668..e86a96b 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint.txt
@@ -44,7 +44,7 @@ by the PCI controller driver.
 	 * clear_bar: ops to reset the BAR
 	 * alloc_addr_space: ops to allocate in PCI controller address space
 	 * free_addr_space: ops to free the allocated address space
-	 * raise_irq: ops to raise a legacy or MSI interrupt
+	 * raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
 	 * start: ops to start the PCI link
 	 * stop: ops to stop the PCI link
 
@@ -96,7 +96,7 @@ by the PCI endpoint function driver.
 *) pci_epc_raise_irq()
 
    The PCI endpoint function driver should use pci_epc_raise_irq() to raise
-   Legacy Interrupt or MSI Interrupt.
+   Legacy Interrupt, MSI or MSI-X Interrupt.
 
 *) pci_epc_mem_alloc_addr()
 
diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.txt
index bf4b5cf..5916f1f 100644
--- a/Documentation/PCI/endpoint/pci-test-function.txt
+++ b/Documentation/PCI/endpoint/pci-test-function.txt
@@ -36,7 +36,7 @@ that the endpoint device must perform.
 Bitfield Description:
   Bit 0		: raise legacy IRQ
   Bit 1		: raise MSI IRQ
-  Bit 2		: raise MSI-X IRQ (reserved for future implementation)
+  Bit 2		: raise MSI-X IRQ
   Bit 3		: read command (read data from RC buffer)
   Bit 4		: write command (write data to RC buffer)
   Bit 5		: copy command (copy data from one RC buffer to another
@@ -75,6 +75,7 @@ for the READ/WRITE/COPY and raise IRQ (Legacy/MSI) commands.
 Possible types:
  - Legacy	: 0
  - MSI		: 1
+ - MSI-X	: 2
 
 *) PCI_ENDPOINT_TEST_IRQ_NUMBER
 
@@ -83,3 +84,4 @@ This register contains the triggered ID interrupt.
 Admissible values:
  - Legacy	: 0
  - MSI		: [1 .. 32]
+ - MSI-X	: [1 .. 2048]
diff --git a/Documentation/PCI/endpoint/pci-test-howto.txt b/Documentation/PCI/endpoint/pci-test-howto.txt
index 75f48c3..65f1a13 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.txt
+++ b/Documentation/PCI/endpoint/pci-test-howto.txt
@@ -45,9 +45,9 @@ The PCI endpoint framework populates the directory with the following
 configurable fields.
 
 	# ls functions/pci_epf_test/func1
-	  baseclass_code	interrupt_pin	revid		subsys_vendor_id
-	  cache_line_size	msi_interrupts	subclass_code	vendorid
-	  deviceid          	progif_code	subsys_id
+	  baseclass_code	interrupt_pin	progif_code	subsys_id
+	  cache_line_size	msi_interrupts	revid		subsys_vendorid
+	  deviceid          	msix_interrupts	subclass_code	vendorid
 
 The PCI endpoint function driver populates these entries with default values
 when the device is bound to the driver. The pci-epf-test driver populates
@@ -67,6 +67,7 @@ device, the following commands can be used.
 	# echo 0x104c > functions/pci_epf_test/func1/vendorid
 	# echo 0xb500 > functions/pci_epf_test/func1/deviceid
 	# echo 16 > functions/pci_epf_test/func1/msi_interrupts
+	# echo 8 > functions/pci_epf_test/func1/msix_interrupts
 
 1.5 Binding pci-epf-test Device to EP Controller
 
@@ -153,6 +154,21 @@ following commands.
 	MSI30:          NOT OKAY
 	MSI31:          NOT OKAY
 	MSI32:          NOT OKAY
+	MSIX1:          OKAY
+	MSIX2:          OKAY
+	MSIX3:          OKAY
+	MSIX4:          OKAY
+	MSIX5:          OKAY
+	MSIX6:          OKAY
+	MSIX7:          OKAY
+	MSIX8:          OKAY
+	MSIX9:          NOT OKAY
+	MSIX10:         NOT OKAY
+	MSIX11:         NOT OKAY
+	MSIX12:         NOT OKAY
+	MSIX13:         NOT OKAY
+	[...]
+	MSIX2048:       NOT OKAY
 
 	Read Tests
 
diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 480c860..65259d4 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -166,6 +166,7 @@ Code  Seq#(hex)	Include File		Comments
 'P'	all	linux/soundcard.h	conflict!
 'P'	60-6F	sound/sscape_ioctl.h	conflict!
 'P'	00-0F	drivers/usb/class/usblp.c	conflict!
+'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
 'Q'	all	linux/soundcard.h
 'R'	00-1F	linux/random.h		conflict!
 'R'	01	linux/rfkill.h		conflict!
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
index 349794c..f4fef10 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -39,13 +39,14 @@
 
 #define IRQ_TYPE_LEGACY				0
 #define IRQ_TYPE_MSI				1
+#define IRQ_TYPE_MSIX				2
 
 #define PCI_ENDPOINT_TEST_MAGIC			0x0
 
 #define PCI_ENDPOINT_TEST_COMMAND		0x4
 #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
 #define COMMAND_RAISE_MSI_IRQ			BIT(1)
-/* BIT(2) is reserved for raising MSI-X IRQ command */
+#define COMMAND_RAISE_MSIX_IRQ			BIT(2)
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
@@ -84,7 +85,7 @@ MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
 
 static int irq_type = IRQ_TYPE_MSI;
 module_param(irq_type, int, 0444);
-MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI)");
+MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");
 
 enum pci_barno {
 	BAR_0,
@@ -202,16 +203,18 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 }
 
 static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
-				      u8 msi_num)
+				       u16 msi_num, bool msix)
 {
 	u32 val;
 	struct pci_dev *pdev = test->pdev;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 IRQ_TYPE_MSI);
+				 msix == false ? IRQ_TYPE_MSI :
+				 IRQ_TYPE_MSIX);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, msi_num);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_RAISE_MSI_IRQ);
+				 msix == false ? COMMAND_RAISE_MSI_IRQ :
+				 COMMAND_RAISE_MSIX_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
@@ -456,7 +459,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		ret = pci_endpoint_test_legacy_irq(test);
 		break;
 	case PCITEST_MSI:
-		ret = pci_endpoint_test_msi_irq(test, arg);
+	case PCITEST_MSIX:
+		ret = pci_endpoint_test_msi_irq(test, arg, cmd == PCITEST_MSIX);
 		break;
 	case PCITEST_WRITE:
 		ret = pci_endpoint_test_write(test, arg);
@@ -542,6 +546,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
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
@@ -558,8 +568,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
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
@@ -625,6 +636,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 err_disable_msi:
 	pci_disable_msi(pdev);
+	pci_disable_msix(pdev);
 	pci_release_regions(pdev);
 
 err_disable_pdev:
@@ -656,6 +668,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	for (i = 0; i < test->num_irqs; i++)
 		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
 	pci_disable_msi(pdev);
+	pci_disable_msix(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 160714d..d2dd0c7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -77,6 +77,7 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 
 	epc->features |= EPC_FEATURE_NO_LINKUP_NOTIFIER;
+	epc->features |= EPC_FEATURE_MSIX_AVAILABLE;
 }
 
 static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index eb9cd00..123f58c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -20,10 +20,11 @@
 
 #define IRQ_TYPE_LEGACY			0
 #define IRQ_TYPE_MSI			1
+#define IRQ_TYPE_MSIX			2
 
 #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
 #define COMMAND_RAISE_MSI_IRQ		BIT(1)
-/* BIT(2) is reserved for raising MSI-X IRQ command */
+#define COMMAND_RAISE_MSIX_IRQ		BIT(2)
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
@@ -47,6 +48,7 @@ struct pci_epf_test {
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
 	bool			linkup_notifier;
+	bool			msix_available;
 	struct delayed_work	cmd_handler;
 };
 
@@ -266,6 +268,9 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
 	case IRQ_TYPE_MSI:
 		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
 		break;
+	case IRQ_TYPE_MSIX:
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSIX, irq);
+		break;
 	default:
 		dev_err(dev, "Failed to raise IRQ, unknown type\n");
 		break;
@@ -292,7 +297,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	reg->command = 0;
 	reg->status = 0;
 
-	if (reg->irq_type > IRQ_TYPE_MSI) {
+	if (reg->irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
 		goto reset_handler;
 	}
@@ -346,6 +351,16 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
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
@@ -459,6 +474,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	else
 		epf_test->linkup_notifier = true;
 
+	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
+
 	epf_test->test_reg_bar = EPC_FEATURE_GET_BAR(epc->features);
 
 	ret = pci_epc_write_header(epc, epf->func_no, header);
@@ -481,6 +498,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return ret;
 	}
 
+	if (epf_test->msix_available) {
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI-X configuration failed\n");
+			return ret;
+		}
+	}
+
 	if (!epf_test->linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index bb2395b..37dab81 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -102,6 +102,7 @@ struct pci_epc {
 
 #define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
 #define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
+#define EPC_FEATURE_MSIX_AVAILABLE		BIT(4)
 #define EPC_FEATURE_SET_BAR(features, bar)	\
 		(features |= (EPC_FEATURE_BAR_MASK & (bar << 1)))
 #define EPC_FEATURE_GET_BAR(features)		\
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 953cf03..d746fb1 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -16,5 +16,6 @@
 #define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
 #define PCITEST_READ		_IOW('P', 0x5, unsigned long)
 #define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
+#define PCITEST_MSIX		_IOW('P', 0x7, int)
 
 #endif /* __UAPI_LINUX_PCITEST_H */
-- 
2.7.4
