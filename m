Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52642 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759537AbcINFOO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 01:14:14 -0400
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
Subject: [RFC PATCH 09/11] misc: add a new host side PCI endpoint test driver
Date: Wed, 14 Sep 2016 10:42:05 +0530
Message-ID: <1473829927-20466-10-git-send-email-kishon@ti.com>
In-Reply-To: <1473829927-20466-1-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PCI endpoint test driver that can verify base address
register and legacy interrupt. (TODO: buffer tests and
MSI interrupt). The corresponding pci-epf-test function driver
should be used on the EP side.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/Kconfig             |    7 +
 drivers/misc/Makefile            |    1 +
 drivers/misc/pci_endpoint_test.c |  291 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/misc/pci_endpoint_test.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index d002528..c578f97 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -794,6 +794,13 @@ config PANEL_BOOT_MESSAGE
 	  An empty message will only clear the display at driver init time. Any other
 	  printf()-formatted message is valid with newline and escape codes.
 
+config PCI_ENDPOINT_TEST
+	depends on PCI
+	tristate "PCI Endpoint Test driver"
+	---help---
+           Enable this configuration option to enable the host side test driver
+           for PCI Endpoint.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index fb32516..fe6ff69 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PANEL)             += panel.o
+obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
new file mode 100644
index 0000000..221a2ce
--- /dev/null
+++ b/drivers/misc/pci_endpoint_test.c
@@ -0,0 +1,291 @@
+/**
+ * ep_f_test.c - Host side test driver to test endpoint functionality
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
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+
+#include <linux/pci_regs.h>
+
+#define DRV_MODULE_NAME			"pci-endpoint-test"
+
+#define PCI_ENDPOINT_TEST_COMMAND	0x0
+#define COMMAND_RESET			BIT(0)
+#define COMMAND_RAISE_IRQ		BIT(1)
+#define COMMAND_COPY			BIT(2)
+
+#define PCI_ENDPOINT_TEST_STATUS	0x4
+#define STATUS_INITIALIZED		BIT(0)
+#define STATUS_COPY_PROGRESS		BIT(1)
+#define STATUS_COPY_DONE		BIT(2)
+#define STATUS_IRQ_RAISED		BIT(3)
+#define STATUS_SOURCE_ADDR_INVALID	BIT(4)
+#define STATUS_DEST_ADDR_INVALID	BIT(5)
+
+#define PCI_ENDPOINT_TEST_SRC_ADDR	0x8
+#define PCI_ENDPOINT_TEST_DST_ADDR	0x10
+
+enum pci_barno {
+	BAR_0,
+	BAR_1,
+	BAR_2,
+	BAR_3,
+	BAR_4,
+	BAR_5,
+};
+
+struct pci_endpoint_test {
+	struct pci_dev	*pdev;
+	void		*base;
+	void		*bar[5];
+	struct completion irq_raised;
+};
+
+static char *result[] = { "NOT OKAY", "OKAY" };
+static int bar_size[] = { 512, 1024, 16384, 131072, 1048576 };
+
+static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
+					  u32 offset)
+{
+	return readl(test->base + offset);
+}
+
+static inline void pci_endpoint_test_writel(struct pci_endpoint_test *test,
+					    u32 offset, u32 value)
+{
+	writel(value, test->base + offset);
+}
+
+static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
+					      int bar, int offset)
+{
+	return readl(test->bar[bar] + offset);
+}
+
+static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *test,
+						int bar, u32 offset, u32 value)
+{
+	writel(value, test->bar[bar] + offset);
+}
+
+static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
+{
+	struct pci_endpoint_test *test = dev_id;
+	u32 reg;
+
+	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (reg & STATUS_IRQ_RAISED) {
+		complete(&test->irq_raised);
+		reg &= ~STATUS_IRQ_RAISED;
+	}
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS,
+				 reg);
+
+	return IRQ_HANDLED;
+}
+
+static bool pci_endpoint_test_reset(struct pci_endpoint_test *test)
+{
+	int i;
+	u32 val;
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_RESET);
+	for (i = 0; i < 5; i++) {
+		val = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+		if (val & STATUS_INITIALIZED)
+			return true;
+		usleep_range(100, 200);
+	}
+
+	return false;
+}
+
+static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
+				  enum pci_barno barno)
+{
+	int j;
+	u32 val;
+	int size;
+
+	if (!test->bar[barno - 1])
+		return false;
+
+	size = bar_size[barno - 1];
+
+	for (j = 0; j < size; j += 4)
+		pci_endpoint_test_bar_writel(test, barno - 1, j, 0xA0A0A0A0);
+
+	for (j = 0; j < size; j += 4) {
+		val = pci_endpoint_test_bar_readl(test, barno - 1, j);
+		if (val != 0xA0A0A0A0)
+			return false;
+	}
+
+	return true;
+}
+
+static bool pci_endpoint_test_irq(struct pci_endpoint_test *test)
+{
+	u32 val;
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_RAISE_IRQ);
+	val = wait_for_completion_timeout(&test->irq_raised,
+					  msecs_to_jiffies(1000));
+	if (!val)
+		return false;
+
+	return true;
+}
+
+static int pci_endpoint_test_begin(struct pci_endpoint_test *test)
+{
+	bool ret;
+	enum pci_barno bar;
+
+	pr_info("****** Testing pci-endpoint-test Device ******\n");
+
+	ret = pci_endpoint_test_reset(test);
+	pr_info("Reset: %s\n", result[ret]);
+
+	for (bar = BAR_1; bar <= BAR_5; bar++) {
+		ret = pci_endpoint_test_bar(test, bar);
+		pr_info("BAR%d %s\n", bar, result[ret]);
+	}
+
+	ret = pci_endpoint_test_irq(test);
+	pr_info("Legacy IRQ: %s\n", result[ret]);
+
+	pr_info("****** End Test ******\n");
+
+	return 0;
+}
+
+static int pci_endpoint_test_probe(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
+{
+	int err;
+	enum pci_barno bar;
+	void __iomem *base;
+	struct device *dev = &pdev->dev;
+	struct pci_endpoint_test *test;
+
+	if (pci_is_bridge(pdev))
+		return -ENODEV;
+
+	test = devm_kzalloc(dev, sizeof(*test), GFP_KERNEL);
+	if (!test)
+		return -ENOMEM;
+
+	test->pdev = pdev;
+	init_completion(&test->irq_raised);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Cannot enable PCI device\n");
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DRV_MODULE_NAME);
+	if (err) {
+		dev_err(dev, "Cannot obtain PCI resources\n");
+		goto err_disable_pdev;
+	}
+
+	pci_set_master(pdev);
+
+	base = pci_ioremap_bar(pdev, BAR_0);
+	if (!base) {
+		dev_err(dev, "Cannot map test device registers\n");
+		err = -ENOMEM;
+		goto err_release_region;
+	}
+
+	test->base = base;
+
+	err = request_irq(pdev->irq, pci_endpoint_test_irqhandler, IRQF_SHARED,
+			  DRV_MODULE_NAME, test);
+	if (err) {
+		dev_err(dev, "failed to request irq\n");
+		goto err_iounmap;
+	}
+
+	for (bar = BAR_1; bar <= BAR_5; bar++) {
+		base = pci_ioremap_bar(pdev, bar);
+		if (!base)
+			dev_err(dev, "failed to read BAR%d\n", bar);
+		test->bar[bar - 1] = base;
+	}
+
+	pci_set_drvdata(pdev, test);
+	pci_endpoint_test_begin(test);
+
+	return 0;
+
+err_iounmap:
+	iounmap(test->base);
+
+err_release_region:
+	pci_release_regions(pdev);
+
+err_disable_pdev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void pci_endpoint_test_remove(struct pci_dev *pdev)
+{
+	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
+	enum pci_barno bar;
+
+	iounmap(test->base);
+
+	for (bar = BAR_1; bar <= BAR_5; bar++) {
+		if (test->bar[bar - 1])
+			iounmap(test->bar[bar - 1]);
+	}
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id pci_endpoint_test_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_ANY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
+
+static struct pci_driver pci_endpoint_test_driver = {
+	.name		= DRV_MODULE_NAME,
+	.id_table	= pci_endpoint_test_tbl,
+	.probe		= pci_endpoint_test_probe,
+	.remove		= pci_endpoint_test_remove,
+};
+module_pci_driver(pci_endpoint_test_driver);
+
+MODULE_DESCRIPTION("PCI ENDPOINT TEST DRIVER");
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

