Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: [PATCH 2/3] misc: pci_endpoint_test: Fix pci_endpoint_test not releasing resources on remove
Date: Wed, 11 Oct 2017 14:14:37 +0530
Message-ID: <20171011084438.8296-3-kishon@ti.com>
In-Reply-To: <20171011084438.8296-1-kishon@ti.com>
References: <20171011084438.8296-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

sscanf(misc_device->name, DRV_MODULE_NAME ".%d", &id) in
pci_endpoint_test_remove returns '0' which results in
pci_endpoint_test_remove returning early without releasing the resources.
This is as a result of misc_device not having a valid name. Fix it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index e787a63a321a..5cb624b6fa0a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -551,17 +551,24 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
 	misc_device = &test->miscdev;
 	misc_device->minor = MISC_DYNAMIC_MINOR;
-	misc_device->name = name;
+	misc_device->name = kstrdup(name, GFP_KERNEL);
+	if (!misc_device->name) {
+		err = -ENOMEM;
+		goto err_ida_remove;
+	}
 	misc_device->fops = &pci_endpoint_test_fops,
 
 	err = misc_register(misc_device);
 	if (err) {
 		dev_err(dev, "failed to register device\n");
-		goto err_ida_remove;
+		goto err_kfree_name;
 	}
 
 	return 0;
 
+err_kfree_name:
+	kfree(misc_device->name);
+
 err_ida_remove:
 	ida_simple_remove(&pci_endpoint_test_ida, id);
 
@@ -592,6 +599,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 		return;
 
 	misc_deregister(&test->miscdev);
+	kfree(misc_device->name);
 	ida_simple_remove(&pci_endpoint_test_ida, id);
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		if (test->bar[bar])
-- 
2.11.0
