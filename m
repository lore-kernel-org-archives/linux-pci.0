Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:42213 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964927AbeFRPBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jun 2018 11:01:05 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v4 06/10] pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
Date: Mon, 18 Jun 2018 16:00:25 +0100
Message-Id: <13077810f3630c01835041e41b338dd85fa91953.1529329262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cleanup PCI_ENDPOINT_TEST memspace (by moving the interrupt number away
from command section).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v2->v3:
 - New patch file created base on the previous patch
"misc: pci_endpoint_test: Add MSI-X support" patch file following
Kishon's suggestion.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.

 drivers/misc/pci_endpoint_test.c              | 84 ++++++++++++++++-----------
 drivers/pci/endpoint/functions/pci-epf-test.c | 60 ++++++++++++-------
 2 files changed, 91 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 7b37046..56be808 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -35,38 +35,42 @@
 
 #include <uapi/linux/pcitest.h>
 
-#define DRV_MODULE_NAME			"pci-endpoint-test"
-
-#define PCI_ENDPOINT_TEST_MAGIC		0x0
-
-#define PCI_ENDPOINT_TEST_COMMAND	0x4
-#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
-#define COMMAND_RAISE_MSI_IRQ		BIT(1)
-#define MSI_NUMBER_SHIFT		2
-/* 6 bits for MSI number */
-#define COMMAND_READ                    BIT(8)
-#define COMMAND_WRITE                   BIT(9)
-#define COMMAND_COPY                    BIT(10)
-
-#define PCI_ENDPOINT_TEST_STATUS	0x8
-#define STATUS_READ_SUCCESS             BIT(0)
-#define STATUS_READ_FAIL                BIT(1)
-#define STATUS_WRITE_SUCCESS            BIT(2)
-#define STATUS_WRITE_FAIL               BIT(3)
-#define STATUS_COPY_SUCCESS             BIT(4)
-#define STATUS_COPY_FAIL                BIT(5)
-#define STATUS_IRQ_RAISED               BIT(6)
-#define STATUS_SRC_ADDR_INVALID         BIT(7)
-#define STATUS_DST_ADDR_INVALID         BIT(8)
-
-#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0xc
+#define DRV_MODULE_NAME				"pci-endpoint-test"
+
+#define IRQ_TYPE_LEGACY				0
+#define IRQ_TYPE_MSI				1
+
+#define PCI_ENDPOINT_TEST_MAGIC			0x0
+
+#define PCI_ENDPOINT_TEST_COMMAND		0x4
+#define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
+#define COMMAND_RAISE_MSI_IRQ			BIT(1)
+#define COMMAND_READ				BIT(3)
+#define COMMAND_WRITE				BIT(4)
+#define COMMAND_COPY				BIT(5)
+
+#define PCI_ENDPOINT_TEST_STATUS		0x8
+#define STATUS_READ_SUCCESS			BIT(0)
+#define STATUS_READ_FAIL			BIT(1)
+#define STATUS_WRITE_SUCCESS			BIT(2)
+#define STATUS_WRITE_FAIL			BIT(3)
+#define STATUS_COPY_SUCCESS			BIT(4)
+#define STATUS_COPY_FAIL			BIT(5)
+#define STATUS_IRQ_RAISED			BIT(6)
+#define STATUS_SRC_ADDR_INVALID			BIT(7)
+#define STATUS_DST_ADDR_INVALID			BIT(8)
+
+#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
 
 #define PCI_ENDPOINT_TEST_LOWER_DST_ADDR	0x14
 #define PCI_ENDPOINT_TEST_UPPER_DST_ADDR	0x18
 
-#define PCI_ENDPOINT_TEST_SIZE		0x1c
-#define PCI_ENDPOINT_TEST_CHECKSUM	0x20
+#define PCI_ENDPOINT_TEST_SIZE			0x1c
+#define PCI_ENDPOINT_TEST_CHECKSUM		0x20
+
+#define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
+#define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -179,6 +183,9 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 {
 	u32 val;
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 IRQ_TYPE_LEGACY);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 0);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_RAISE_LEGACY_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
@@ -190,20 +197,22 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 }
 
 static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
-				      u8 msi_num)
+				      u8 irq_num)
 {
 	u32 val;
 	struct pci_dev *pdev = test->pdev;
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, irq_num);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 msi_num << MSI_NUMBER_SHIFT |
 				 COMMAND_RAISE_MSI_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
 		return false;
 
-	if (pci_irq_vector(pdev, msi_num - 1) == test->last_irq)
+	if (pci_irq_vector(pdev, irq_num - 1) == test->last_irq)
 		return true;
 
 	return false;
@@ -281,8 +290,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
 				 size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_COPY);
+				 COMMAND_COPY);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -348,8 +360,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_READ);
+				 COMMAND_READ);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -403,8 +418,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_WRITE);
+				 COMMAND_WRITE);
 
 	wait_for_completion(&test->irq_raised);
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 63ed706..ff92524 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -18,13 +18,14 @@
 #include <linux/pci-epf.h>
 #include <linux/pci_regs.h>
 
+#define IRQ_TYPE_LEGACY			0
+#define IRQ_TYPE_MSI			1
+
 #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
 #define COMMAND_RAISE_MSI_IRQ		BIT(1)
-#define MSI_NUMBER_SHIFT		2
-#define MSI_NUMBER_MASK			(0x3f << MSI_NUMBER_SHIFT)
-#define COMMAND_READ			BIT(8)
-#define COMMAND_WRITE			BIT(9)
-#define COMMAND_COPY			BIT(10)
+#define COMMAND_READ			BIT(3)
+#define COMMAND_WRITE			BIT(4)
+#define COMMAND_COPY			BIT(5)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -56,6 +57,8 @@ struct pci_epf_test_reg {
 	u64	dst_addr;
 	u32	size;
 	u32	checksum;
+	u32	irq_type;
+	u32	irq_number;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -244,31 +247,39 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	return ret;
 }
 
-static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq)
+static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
+				   u16 irq)
 {
-	u8 msi_count;
 	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	reg->status |= STATUS_IRQ_RAISED;
-	msi_count = pci_epc_get_msi(epc, epf->func_no);
-	if (irq > msi_count || msi_count <= 0)
+
+	switch (irq_type) {
+	case IRQ_TYPE_LEGACY:
 		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
-	else
+		break;
+	case IRQ_TYPE_MSI:
 		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
+		break;
+	default:
+		dev_err(dev, "Failed to raise IRQ, unknown type\n");
+		break;
+	}
 }
 
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	int ret;
-	u8 irq;
-	u8 msi_count;
+	u16 count;
 	u32 command;
 	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
 						     cmd_handler.work);
 	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
@@ -280,7 +291,10 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	reg->command = 0;
 	reg->status = 0;
 
-	irq = (command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
+	if (reg->irq_type > IRQ_TYPE_MSI) {
+		dev_err(dev, "Failed to detect IRQ type\n");
+		goto reset_handler;
+	}
 
 	if (command & COMMAND_RAISE_LEGACY_IRQ) {
 		reg->status = STATUS_IRQ_RAISED;
@@ -294,7 +308,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_WRITE_FAIL;
 		else
 			reg->status |= STATUS_WRITE_SUCCESS;
-		pci_epf_test_raise_irq(epf_test, irq);
+		pci_epf_test_raise_irq(epf_test, reg->irq_type,
+				       reg->irq_number);
 		goto reset_handler;
 	}
 
@@ -304,7 +319,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_READ_SUCCESS;
 		else
 			reg->status |= STATUS_READ_FAIL;
-		pci_epf_test_raise_irq(epf_test, irq);
+		pci_epf_test_raise_irq(epf_test, reg->irq_type,
+				       reg->irq_number);
 		goto reset_handler;
 	}
 
@@ -314,16 +330,18 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_COPY_SUCCESS;
 		else
 			reg->status |= STATUS_COPY_FAIL;
-		pci_epf_test_raise_irq(epf_test, irq);
+		pci_epf_test_raise_irq(epf_test, reg->irq_type,
+				       reg->irq_number);
 		goto reset_handler;
 	}
 
 	if (command & COMMAND_RAISE_MSI_IRQ) {
-		msi_count = pci_epc_get_msi(epc, epf->func_no);
-		if (irq > msi_count || msi_count <= 0)
+		count = pci_epc_get_msi(epc, epf->func_no);
+		if (reg->irq_number > count || count <= 0)
 			goto reset_handler;
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI,
+				  reg->irq_number);
 		goto reset_handler;
 	}
 
@@ -457,8 +475,10 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return ret;
 
 	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "MSI configuration failed\n");
 		return ret;
+	}
 
 	if (!epf_test->linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
-- 
2.7.4
