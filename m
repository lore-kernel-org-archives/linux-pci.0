Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:10179 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbdHRO7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2017 10:59:11 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 15/18] misc: pci_endpoint_test: Add support to not enable MSI interrupts
Date: Fri, 18 Aug 2017 20:28:07 +0530
Message-ID: <20170818145810.17649-16-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some platforms like TI's K2G have a restriction that the host side
buffer address should be aligned to either 1MB/2MB/4MB or 8MB
addresses depending on how it is configured in the endpoint
(Ref: 11.14.4.9.1 Outbound Address Translation in K2G TRM SPRUHY8F
January 2016 – Revised May 2017). This restriction also applies to
the MSI addresses provided by the RC. However it's not possible
for the RC to know about this restriction and it may not provide
1MB/2MB/4MB or 8MB aligned address. So MSI interrupts should be
disabled even if the K2G EP has MSI capabiltiy register. Add
support to not enable MSI interrupts in pci_endpoint_test driver
so that it can be used to test K2G EP.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 5f6bd23ab657..5cbb25cf276c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -97,6 +97,7 @@ struct pci_endpoint_test {
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	bool no_msi;
 };
 
 static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
@@ -449,8 +450,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 {
 	int i;
 	int err;
-	int irq;
+	int irq = 0;
 	int id;
+	bool no_msi = false;
 	char name[20];
 	enum pci_barno bar;
 	void __iomem *base;
@@ -475,6 +477,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (data) {
 		test_reg_bar = data->test_reg_bar;
 		test->alignment = data->alignment;
+		no_msi = data->no_msi;
 	}
 
 	init_completion(&test->irq_raised);
@@ -494,9 +497,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
-	if (irq < 0)
-		dev_err(dev, "failed to get MSI interrupts\n");
+	if (!no_msi) {
+		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
+		if (irq < 0)
+			dev_err(dev, "failed to get MSI interrupts\n");
+	}
 
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
 			       IRQF_SHARED, DRV_MODULE_NAME, test);
-- 
2.11.0
