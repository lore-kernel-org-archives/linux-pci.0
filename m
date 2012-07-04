Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:34476 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030215Ab2GDIJc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 04:09:32 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 837673EE0BC
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:09:31 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5BCD145DE54
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:09:31 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3FED145DE4F
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:09:31 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 33D99E08003
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:09:31 +0900 (JST)
Received: from m005.s.css.fujitsu.com (m005.s.css.fujitsu.com [10.23.4.35])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id DB6AE1DB803F
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:09:30 +0900 (JST)
Date: Wed, 4 Jul 2012 17:09:26 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 5/7] ACPI, PCI: Protect global lists in
 drivers/acpi/pci_root.c
Message-Id: <20120704170926.864213ba.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
References: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

    ACPI, PCI: Protect global lists in drivers/acpi/pci_root.c
    
    There are two global lists inf file drivers/acpi/pci_root.c.
    One is for registered acpi_pci_drivers, the other is for
    enumerated ACPI PCI root bridge objects. These two global
    lists may change dynamically when registering/deregistering
    acpi_pci_drivers or adding/removing ACPI PCI root bridge
    objects. So protect them by mutex lock and RCU list.
    
    Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>
    [izumi.taku@jp.fujitsu.com: a bit change at acpi_pci_root_remove()]
    Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>

---
 drivers/acpi/pci_root.c |   86 +++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 33 deletions(-)

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c	2012-07-04 09:55:49.169772504 +0900
+++ linux/drivers/acpi/pci_root.c	2012-07-04 09:55:54.435706670 +0900
@@ -27,7 +27,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/rculist.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
@@ -71,6 +72,8 @@ static struct acpi_driver acpi_pci_root_
 		},
 };
 
+/* Lock to protect both acpi_pci_roots and acpi_pci_drivers lists */
+static DEFINE_MUTEX(acpi_pci_root_lock);
 static LIST_HEAD(acpi_pci_roots);
 static LIST_HEAD(acpi_pci_drivers);
 
@@ -81,47 +84,48 @@ int acpi_pci_register_driver(struct acpi
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
+		list_for_each_entry_rcu(root, &acpi_pci_roots, node) {
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
+		list_for_each_entry_rcu(root, &acpi_pci_roots, node)
+			driver->remove(root->device->handle);
+	mutex_unlock(&acpi_pci_root_lock);
 }
-
 EXPORT_SYMBOL(acpi_pci_unregister_driver);
 
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
 {
 	struct acpi_pci_root *root;
+	struct acpi_handle *handle = NULL;
 	
-	list_for_each_entry(root, &acpi_pci_roots, node)
+	rcu_read_lock();
+	list_for_each_entry_rcu(root, &acpi_pci_roots, node)
 		if ((root->segment == (u16) seg) &&
-		    (root->secondary.start == (u16) bus))
-			return root->device->handle;
-	return NULL;		
-}
+		    (root->secondary.start == (u16) bus)) {
+			handle = root->device->handle;
+			break;
+		}
+	rcu_read_unlock();
 
+	return handle;
+}
 EXPORT_SYMBOL_GPL(acpi_get_pci_rootbridge_handle);
 
 /**
@@ -268,10 +272,15 @@ struct acpi_pci_root *acpi_pci_find_root
 {
 	struct acpi_pci_root *root;
 
-	list_for_each_entry(root, &acpi_pci_roots, node) {
-		if (root->device->handle == handle)
+	rcu_read_lock();
+	list_for_each_entry_rcu(root, &acpi_pci_roots, node) {
+		if (root->device->handle == handle) {
+			rcu_read_unlock();
 			return root;
+		}
 	}
+	rcu_read_unlock();
+
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(acpi_pci_find_root);
@@ -459,7 +468,7 @@ static int __devinit acpi_pci_root_add(s
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		printk(KERN_ERR PREFIX "can't evaluate _SEG\n");
 		result = -ENODEV;
-		goto end;
+		goto out_free;
 	}
 
 	/* Check _CRS first, then _BBN.  If no _BBN, default to zero. */
@@ -484,7 +493,7 @@ static int __devinit acpi_pci_root_add(s
 		else {
 			printk(KERN_ERR PREFIX "can't evaluate _BBN\n");
 			result = -ENODEV;
-			goto end;
+			goto out_free;
 		}
 	}
 
@@ -508,8 +517,8 @@ static int __devinit acpi_pci_root_add(s
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
 	 */
 
-	/* TBD: Locking */
-	list_add_tail(&root->node, &acpi_pci_roots);
+	mutex_lock(&acpi_pci_root_lock);
+	list_add_tail_rcu(&root->node, &acpi_pci_roots);
 
 	printk(KERN_INFO PREFIX "%s [%s] (domain %04x %pR)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
@@ -528,7 +537,7 @@ static int __devinit acpi_pci_root_add(s
 			    "Bus %04x:%02x not present in PCI namespace\n",
 			    root->segment, (unsigned int)root->secondary.start);
 		result = -ENODEV;
-		goto end;
+		goto out_del_root;
 	}
 
 	/*
@@ -538,7 +547,7 @@ static int __devinit acpi_pci_root_add(s
 	 */
 	result = acpi_pci_bind_root(device);
 	if (result)
-		goto end;
+		goto out_del_root;
 
 	/*
 	 * PCI Routing Table
@@ -614,11 +623,15 @@ static int __devinit acpi_pci_root_add(s
 	if (device->wakeup.flags.run_wake)
 		device_set_run_wake(root->bus->bridge, true);
 
+	mutex_unlock(&acpi_pci_root_lock);
+
 	return 0;
 
-end:
-	if (!list_empty(&root->node))
-		list_del(&root->node);
+out_del_root:
+	list_del_rcu(&root->node);
+	mutex_unlock(&acpi_pci_root_lock);
+	synchronize_rcu();
+out_free:
 	kfree(root);
 	return result;
 }
@@ -628,11 +641,13 @@ static int acpi_pci_root_start(struct ac
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->add)
 			driver->add(device->handle);
 
 	pci_bus_add_devices(root->bus);
+	mutex_unlock(&acpi_pci_root_lock);
 
 	return 0;
 }
@@ -642,6 +657,8 @@ static int acpi_pci_root_remove(struct a
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	mutex_lock(&acpi_pci_root_lock);
+
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root->device->handle);
@@ -649,6 +666,9 @@ static int acpi_pci_root_remove(struct a
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	list_del_rcu(&root->node);
+	mutex_unlock(&acpi_pci_root_lock);
+	synchronize_rcu();
 	kfree(root);
 	return 0;
 }

