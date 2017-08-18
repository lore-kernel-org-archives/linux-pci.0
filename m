Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:25739 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbdHRO7G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2017 10:59:06 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 13/18] misc: pci_endpoint_test: Add support for PCI_ENDPOINT_TEST regs to be mapped to any BAR
Date: Fri, 18 Aug 2017 20:28:05 +0530
Message-ID: <20170818145810.17649-14-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_endpoint_test driver assumes the PCI_ENDPOINT_TEST registers will
always be mapped to BAR_0. This need not always be the case like in
TI's K2G where BAR_0 is mapped to PCI controller application registers.
Add support so that PCI_ENDPOINT_TEST registers can be mapped to any BAR.
Change the bar_size used for BAR test accordingly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 09c10f426b64..5fc0f6c6a9e5 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -90,9 +90,14 @@ struct pci_endpoint_test {
 	/* mutex to protect the ioctls */
 	struct mutex	mutex;
 	struct miscdevice miscdev;
+	enum pci_barno test_reg_bar;
 };
 
-static int bar_size[] = { 4, 512, 1024, 16384, 131072, 1048576 };
+struct pci_endpoint_test_data {
+	enum pci_barno test_reg_bar;
+};
+
+static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
 					  u32 offset)
@@ -147,6 +152,9 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 
 	size = bar_size[barno];
 
+	if (barno == test->test_reg_bar)
+		size = 0x4;
+
 	for (j = 0; j < size; j += 4)
 		pci_endpoint_test_bar_writel(test, barno, j, 0xA0A0A0A0);
 
@@ -390,6 +398,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	void __iomem *base;
 	struct device *dev = &pdev->dev;
 	struct pci_endpoint_test *test;
+	struct pci_endpoint_test_data *data;
+	enum pci_barno test_reg_bar = BAR_0;
 	struct miscdevice *misc_device;
 
 	if (pci_is_bridge(pdev))
@@ -399,7 +409,13 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (!test)
 		return -ENOMEM;
 
+	test->test_reg_bar = 0;
 	test->pdev = pdev;
+
+	data = (struct pci_endpoint_test_data *)ent->driver_data;
+	if (data)
+		test_reg_bar = data->test_reg_bar;
+
 	init_completion(&test->irq_raised);
 	mutex_init(&test->mutex);
 
@@ -441,14 +457,15 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		base = pci_ioremap_bar(pdev, bar);
 		if (!base) {
 			dev_err(dev, "failed to read BAR%d\n", bar);
-			WARN_ON(bar == BAR_0);
+			WARN_ON(bar == test_reg_bar);
 		}
 		test->bar[bar] = base;
 	}
 
-	test->base = test->bar[0];
+	test->base = test->bar[test_reg_bar];
 	if (!test->base) {
-		dev_err(dev, "Cannot perform PCI test without BAR0\n");
+		dev_err(dev, "Cannot perform PCI test without BAR%d\n",
+			test_reg_bar);
 		goto err_iounmap;
 	}
 
-- 
2.11.0
