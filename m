Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: [PATCH 1/3] misc: pci_endpoint_test: Fix failure path return values in probe
Date: Wed, 11 Oct 2017 14:14:36 +0530
Message-ID: <20171011084438.8296-2-kishon@ti.com>
In-Reply-To: <20171011084438.8296-1-kishon@ti.com>
References: <20171011084438.8296-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Return value of pci_endpoint_test_probe is not set properly in
a couple of failure cases. Fix it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index deb203026496..e787a63a321a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -533,6 +533,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	test->base = test->bar[test_reg_bar];
 	if (!test->base) {
+		err = -ENOMEM;
 		dev_err(dev, "Cannot perform PCI test without BAR%d\n",
 			test_reg_bar);
 		goto err_iounmap;
@@ -542,6 +543,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	id = ida_simple_get(&pci_endpoint_test_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
+		err = id;
 		dev_err(dev, "unable to get id\n");
 		goto err_iounmap;
 	}
-- 
2.11.0
