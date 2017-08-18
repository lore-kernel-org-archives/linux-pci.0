Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 06/18] PCI: endpoint: functions/pci-epf-test: Do not reset *command* inadvertently
Date: Fri, 18 Aug 2017 20:27:58 +0530
Message-ID: <20170818145810.17649-7-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_epf_test_cmd_handler() is the delayed work function which reads
*command* (set by the host) and performs various actions requested
by the host periodically. If the value in *command* is '0', it
goes to the reset_handler where it resets *command* to '0' and queues
pci_epf_test_cmd_handler().
However if the host writes a value to the *command* just after the
pci-epf-test driver checks *command* for '0' and before the control goes
to reset_handler, the *command* will be reset to '0' and the pci-epf-test
driver won't be able to perform the actions requested by the host.
Fix it here by not resetting the *command* in the reset_handler.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 5cbc05a0762d..1a27d7950f2c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -263,22 +263,26 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	int ret;
 	u8 irq;
 	u8 msi_count;
+	u32 command;
 	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
 						     cmd_handler.work);
 	struct pci_epf *epf = epf_test->epf;
 	struct pci_epc *epc = epf->epc;
 	volatile struct pci_epf_test_reg *reg = epf_test->reg[0];
 
-	if (!reg->command)
+	command = reg->command;
+	if (!command)
 		goto reset_handler;
 
-	if (reg->command & COMMAND_RAISE_LEGACY_IRQ) {
+	reg->command = 0;
+
+	if (command & COMMAND_RAISE_LEGACY_IRQ) {
 		reg->status = STATUS_IRQ_RAISED;
 		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
 		goto reset_handler;
 	}
 
-	if (reg->command & COMMAND_WRITE) {
+	if (command & COMMAND_WRITE) {
 		ret = pci_epf_test_write(epf_test);
 		if (ret)
 			reg->status |= STATUS_WRITE_FAIL;
@@ -288,7 +292,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		goto reset_handler;
 	}
 
-	if (reg->command & COMMAND_READ) {
+	if (command & COMMAND_READ) {
 		ret = pci_epf_test_read(epf_test);
 		if (!ret)
 			reg->status |= STATUS_READ_SUCCESS;
@@ -298,7 +302,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		goto reset_handler;
 	}
 
-	if (reg->command & COMMAND_COPY) {
+	if (command & COMMAND_COPY) {
 		ret = pci_epf_test_copy(epf_test);
 		if (!ret)
 			reg->status |= STATUS_COPY_SUCCESS;
@@ -308,9 +312,9 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		goto reset_handler;
 	}
 
-	if (reg->command & COMMAND_RAISE_MSI_IRQ) {
+	if (command & COMMAND_RAISE_MSI_IRQ) {
 		msi_count = pci_epc_get_msi(epc);
-		irq = (reg->command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
+		irq = (command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
 		if (irq > msi_count || msi_count <= 0)
 			goto reset_handler;
 		reg->status = STATUS_IRQ_RAISED;
@@ -319,8 +323,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 reset_handler:
-	reg->command = 0;
-
 	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 			   msecs_to_jiffies(1));
 }
-- 
2.11.0
