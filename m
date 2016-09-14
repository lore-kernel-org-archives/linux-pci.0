Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57347 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758038AbcINFNn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 01:13:43 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, <kishon@ti.com>,
        <nsekhar@ti.com>
Subject: [RFC PATCH 04/11] pci: endpoint: functions: add an EP function to test PCI
Date: Wed, 14 Sep 2016 10:42:00 +0530
Message-ID: <1473829927-20466-5-git-send-email-kishon@ti.com>
In-Reply-To: <1473829927-20466-1-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a new endpoint function driver (to program the virtual
test device) making use of the EP-core library. The complete
usage of the test function is described in
Documentation/PCI/pci-test.txt (included in this commit).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/PCI/00-INDEX                    |    3 +
 Documentation/PCI/pci-test.txt                |   79 +++++++
 drivers/pci/endpoint/Kconfig                  |    2 +
 drivers/pci/endpoint/Makefile                 |    2 +-
 drivers/pci/endpoint/functions/Kconfig        |   12 ++
 drivers/pci/endpoint/functions/Makefile       |    5 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  272 +++++++++++++++++++++++++
 7 files changed, 374 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/PCI/pci-test.txt
 create mode 100644 drivers/pci/endpoint/functions/Kconfig
 create mode 100644 drivers/pci/endpoint/functions/Makefile
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-test.c

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index e422b8151..e5a583c 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -14,3 +14,6 @@ pcieaer-howto.txt
 	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
 pci-endpoint.txt
 	- guide to add endpoint controller driver and endpoint function driver.
+pci-test.txt
+	- description of the PCI EP function that can be used to test PCI
+	  functionality
diff --git a/Documentation/PCI/pci-test.txt b/Documentation/PCI/pci-test.txt
new file mode 100644
index 0000000..2bc796b
--- /dev/null
+++ b/Documentation/PCI/pci-test.txt
@@ -0,0 +1,79 @@
+				PCI TEST
+		    Kishon Vijay Abraham I <kishon@ti.com>
+
+Traditionally PCI RC has always been validated by using standard
+PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
+However with the addition of EP-core in linux kernel, it is possible
+to configure a PCI controller that can operate in EP mode to work as
+a test device.
+
+The PCI endpoint test device is a completely software device used to
+test the endpoint functionality and serve as a sample driver for other
+PCI endpoint devices.
+
+The PCI endpoint test device has four registers:
+
+	1) PCI_ENDPOINT_TEST_COMMAND
+	2) PCI_ENDPOINT_TEST_STATUS
+	3) PCI_ENDPOINT_TEST_SRC_ADDR
+	4) PCI_ENDPOINT_TEST_DST_ADDR
+
+Since this is a virtual device, all these registers will be present
+in RAM and will be allocated using one of the standard memory allocation
+API (in this case dma_alloc_coherent)
+
+*) PCI_ENDPOINT_TEST_COMMAND:
+
+This register will be used by the host driver to indicate the function
+that the endpoint device must perform.
+
+Bitfield Description:
+  Bit 0: reset the PCI endpoint device
+  Bit 1: raise irq
+  Bit 2: Copy the data from source addr to destination address
+
+*) PCI_ENDPOINT_TEST_STATUS
+
+This register reflects the status of the PCI endpoint device.
+
+Bitfield Description:
+  Bit 0: PCI endpoint device is in initialized state
+  Bit 1: Copy is in progress
+  Bit 2: Copy is done
+  Bit 3: IRQ is raised
+  Bit 4: Source address is invalid
+  Bit 5: Destination address is invalid
+
+*) PCI_ENDPOINT_TEST_SRC_ADDR
+
+This register contains the source address for the COPY command.
+
+*) PCI_ENDPOINT_TEST_DST_ADDR
+
+This register contains the destination address for the COPY command.
+
+PCI ENDPOINT TEST DRIVER (EP SIDE)
+==================================
+
+The Endpoint side function driver is present in
+drivers/pci/endpoint/functions/pci-epf-test.c
+
+This function driver creates the PCI endpoint test device and then
+waits for commands from the host driver. If the host driver sets
+Bit 1 (raise irq) in the COMMAND register, the endpoint driver
+will raise an irq. Similarly it resets the device if Bit 0 is set
+and starts copying the data if Bit 2 is set.
+
+The function driver is also responsible for updating the STATUS
+register.
+
+PCI ENDPOINT TEST DRIVER (HOST SIDE)
+====================================
+
+The host side PCI driver is present in
+drivers/misc/pci_endpoint_test.c
+
+The PCI driver for the test device performs 3 tests
+	*) Verifying addresses programmed in BAR
+	*) Raise legacy IRQ
+	*) Copy data from source address to destination address (TODO)
diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index f1dd206..0e3dc8c 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -19,5 +19,7 @@ config PCI_ENDPOINT
 
 	   If in doubt, say "N" to disable Endpoint support.
 
+source "drivers/pci/endpoint/functions/Kconfig"
+
 endmenu
 
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 67c88bf..89310d1 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -3,4 +3,4 @@
 #
 
 obj-$(CONFIG_PCI_ENDPOINT)		:= pci-epc-core.o pci-epf-core.o \
-					   pci-ep-cfs.o
+					   pci-ep-cfs.o functions/
diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
new file mode 100644
index 0000000..175edad
--- /dev/null
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -0,0 +1,12 @@
+#
+# PCI Endpoint Functions
+#
+
+config PCI_EPF_TEST
+	tristate "PCI Endpoint Test driver"
+	depends on PCI_ENDPOINT
+	help
+	   Enable this configuration option to enable the test driver
+	   for PCI Endpoint.
+
+	   If in doubt, say "N" to disable Endpoint test driver.
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
new file mode 100644
index 0000000..53c120e
--- /dev/null
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for PCI Endpoint Functions
+#
+
+obj-$(CONFIG_PCI_EPF_TEST)		:= pci-epf-test.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
new file mode 100644
index 0000000..a7585b1
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -0,0 +1,272 @@
+/**
+ * pci-epf-test.c - Test driver to test endpoint functionality
+ *
+ * Copyright (C) 2016 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pci_ids.h>
+
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci_regs.h>
+
+#define COMMAND_RESET			BIT(0)
+#define COMMAND_RAISE_IRQ		BIT(1)
+#define COMMAND_COPY			BIT(2)
+
+#define STATUS_INITIALIZED		BIT(0)
+#define STATUS_COPY_PROGRESS		BIT(1)
+#define STATUS_COPY_DONE		BIT(2)
+#define STATUS_IRQ_RAISED		BIT(3)
+#define STATUS_SOURCE_ADDR_INVALID	BIT(4)
+#define STATUS_DEST_ADDR_INVALID	BIT(5)
+
+#define TIMER_RESOLUTION		5
+
+struct pci_epf_test {
+	struct timer_list	timer;
+	void			*reg[6];
+	struct pci_epf		*epf;
+};
+
+struct pci_epf_test_reg {
+	u32	command;
+	u32	status;
+	u64	src_addr;
+	u64	dst_addr;
+};
+
+struct pci_epf_header test_header = {
+	.vendorid	= PCI_ANY_ID,
+	.deviceid	= PCI_ANY_ID,
+	.baseclass_code = PCI_CLASS_OTHERS,
+	.interrupt_pin	= PCI_INTERRUPT_INTA,
+};
+
+static int bar_size[] = { 512, 1024, 16384, 131072, 1048576};
+
+static void pci_epf_test_cmd_handler(unsigned long data)
+{
+	struct pci_epf_test *epf_test = (struct pci_epf_test *)data;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_test_reg *reg = epf_test->reg[0];
+	unsigned long timer;
+
+	if (!reg->command)
+		goto reset_handler;
+
+	if (reg->command & COMMAND_RESET)
+		reg->status = STATUS_INITIALIZED;
+
+	if (reg->command & COMMAND_RAISE_IRQ) {
+		reg->status |= STATUS_IRQ_RAISED;
+		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY);
+	}
+
+	reg->command = 0;
+
+reset_handler:
+	timer = jiffies + msecs_to_jiffies(TIMER_RESOLUTION);
+	mod_timer(&epf_test->timer, timer);
+}
+
+static void pci_epf_test_linkup(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	unsigned long timer;
+
+	setup_timer(&epf_test->timer, pci_epf_test_cmd_handler,
+		    (unsigned long)epf_test);
+	timer = jiffies + msecs_to_jiffies(TIMER_RESOLUTION);
+	mod_timer(&epf_test->timer, timer);
+}
+
+static void pci_epf_test_unbind(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epc *epc = epf->epc;
+	int bar;
+
+	del_timer(&epf_test->timer);
+	pci_epc_stop(epc);
+	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		if (epf_test->reg[bar]) {
+			pci_epf_free_space(epf, epf_test->reg[bar], bar);
+			pci_epc_clear_bar(epc, bar);
+		}
+	}
+
+	epf->pci_epc_name = NULL;
+}
+
+static int pci_epf_test_set_bar(struct pci_epf *epf)
+{
+	int flags;
+	int bar;
+	int ret;
+	struct pci_epf_bar *epf_bar;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+
+	flags = PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32;
+	if (sizeof(dma_addr_t) == 0x8)
+		flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+
+	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		epf_bar = &epf->bar[bar];
+		ret = pci_epc_set_bar(epc, bar, epf_bar->phys_addr,
+				      epf_bar->size, flags);
+		if (ret) {
+			pci_epf_free_space(epf, epf_test->reg[bar], bar);
+			dev_err(dev, "failed to set BAR%d\n", bar);
+			if (bar == BAR_0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int pci_epf_test_alloc_space(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct device *dev = &epf->dev;
+	void *base;
+	int bar;
+
+	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
+				   BAR_0);
+	if (!base) {
+		dev_err(dev, "failed to allocated register space\n");
+		return -ENOMEM;
+	}
+	epf_test->reg[0] = base;
+
+	for (bar = BAR_1; bar <= BAR_5; bar++) {
+		base = pci_epf_alloc_space(epf, bar_size[bar - 1], bar);
+		if (!base)
+			dev_err(dev, "failed to allocate space for BAR%d\n",
+				bar);
+		epf_test->reg[bar] = base;
+	}
+
+	return 0;
+}
+
+static int pci_epf_test_bind(struct pci_epf *epf)
+{
+	int ret;
+	struct pci_epf_header *header = epf->header;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+
+	ret = pci_epc_write_header(epc, header);
+	if (ret) {
+		dev_err(dev, "configuration header write failed\n");
+		return ret;
+	}
+
+	ret = pci_epf_test_alloc_space(epf);
+	if (ret)
+		return ret;
+
+	ret = pci_epf_test_set_bar(epf);
+	if (ret)
+		return ret;
+
+	ret = pci_epc_start(epc);
+	if (ret) {
+		dev_err(dev, "failed to start endpoint controller\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pci_epf_test_probe(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test;
+	struct device *dev = &epf->dev;
+
+	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
+	if (!epf)
+		return -ENOMEM;
+
+	epf->header = &test_header;
+	epf_test->epf = epf;
+
+	epf_set_drvdata(epf, epf_test);
+	return 0;
+}
+
+static int pci_epf_test_remove(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+
+	pci_epc_unbind_epf(epf_test->epf);
+	kfree(epf_test);
+	return 0;
+}
+
+struct pci_epf_ops ops = {
+	.unbind	= pci_epf_test_unbind,
+	.bind	= pci_epf_test_bind,
+	.linkup = pci_epf_test_linkup,
+};
+
+static const struct pci_epf_device_id pci_epf_test_ids[] = {
+	{
+		.name = "pci_epf_test",
+	},
+	{},
+};
+
+static struct pci_epf_driver test_driver = {
+	.driver.name	= "pci_epf_test",
+	.probe		= pci_epf_test_probe,
+	.remove		= pci_epf_test_remove,
+	.id_table	= pci_epf_test_ids,
+	.ops		= &ops,
+	.owner		= THIS_MODULE,
+};
+
+static int __init pci_epf_test_init(void)
+{
+	int ret;
+
+	ret = pci_epf_register_driver(&test_driver);
+	if (ret) {
+		pr_err("failed to register pci epf test driver --> %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(pci_epf_test_init);
+
+static void __exit pci_epf_test_exit(void)
+{
+	pci_epf_unregister_driver(&test_driver);
+}
+module_exit(pci_epf_test_exit);
+
+MODULE_DESCRIPTION("PCI EPF TEST DRIVER");
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

