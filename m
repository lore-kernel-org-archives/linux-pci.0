Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53535 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab2IRGV2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 02:21:28 -0400
Date: Tue, 18 Sep 2012 15:21:31 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: [PATCH v3 3/8] ACPI, PCI: add acpi_pci_drivers protection
Message-Id: <20120918152131.92c26a12.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Use mutex to protect global acpi_pci_drivers list against PCI
host bridge hotplug operations.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

Index: Bjorn-next-0903/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0903/drivers/acpi/pci_root.c
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
@@ -71,6 +71,8 @@ static struct acpi_driver acpi_pci_root_
 		},
 };
 
+/* Lock to protect both acpi_pci_roots and acpi_pci_drivers lists */
+static DEFINE_MUTEX(acpi_pci_root_lock);
 static LIST_HEAD(acpi_pci_roots);
 static LIST_HEAD(acpi_pci_drivers);
 
@@ -81,34 +83,30 @@ int acpi_pci_register_driver(struct acpi
 	int n = 0;
 	struct acpi_pci_root *root;
 
+	mutex_lock(&acpi_pci_root_lock);
 	list_add_tail(&driver->node, &acpi_pci_drivers);
-
-	if (!driver->add)
-		return 0;
-
-	list_for_each_entry(root, &acpi_pci_roots, node) {
-		driver->add(root->device->handle);
-		n++;
-	}
+	if (driver->add)
+		list_for_each_entry(root, &acpi_pci_roots, node) {
+			driver->add(root->device->handle);
+			n++;
+		}
+	mutex_unlock(&acpi_pci_root_lock);
 
 	return n;
 }
-
 EXPORT_SYMBOL(acpi_pci_register_driver);
 
 void acpi_pci_unregister_driver(struct acpi_pci_driver *driver)
 {
 	struct acpi_pci_root *root;
 
+	mutex_lock(&acpi_pci_root_lock);
 	list_del(&driver->node);
-
-	if (!driver->remove)
-		return;
-
-	list_for_each_entry(root, &acpi_pci_roots, node)
-		driver->remove(root->device->handle);
+	if (driver->remove)
+		list_for_each_entry(root, &acpi_pci_roots, node)
+			driver->remove(root->device->handle);
+	mutex_unlock(&acpi_pci_root_lock);
 }
-
 EXPORT_SYMBOL(acpi_pci_unregister_driver);
 
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
@@ -628,9 +626,11 @@ static int acpi_pci_root_start(struct ac
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->add)
 			driver->add(device->handle);
+	mutex_unlock(&acpi_pci_root_lock);
 
 	pci_bus_add_devices(root->bus);
 
@@ -642,9 +642,11 @@ static int acpi_pci_root_remove(struct a
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root->device->handle);
+	mutex_unlock(&acpi_pci_root_lock);
 
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);

