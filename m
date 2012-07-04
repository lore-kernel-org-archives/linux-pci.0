Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:34578 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab2GDILE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 04:11:04 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id B51993EE0BD
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:03 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9060A45DE5A
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:03 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 73EA045DE52
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:03 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 574621DB8038
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:03 +0900 (JST)
Received: from m0000.s.css.fujitsu.com (m0000.s.css.fujitsu.com [10.23.4.183])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 09C161DB803E
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:03 +0900 (JST)
Date: Wed, 4 Jul 2012 17:10:58 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 6/7] ACPI, PCI: add hostbridge removal function
Message-Id: <20120704171058.fafc5071.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
References: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Currently there's no PCI-related clean-up code
in acpi_pci_root_remove() function.
This patch introduces function for hostbridge removal.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_bind.c     |    7 +++++++
 drivers/acpi/pci_root.c     |    8 ++++++++
 drivers/pci/remove.c        |   18 +++++++++++++++++-
 include/acpi/acpi_drivers.h |    1 +
 include/linux/pci.h         |    2 ++
 5 files changed, 35 insertions(+), 1 deletion(-)

Index: linux/drivers/pci/remove.c
===================================================================
--- linux.orig/drivers/pci/remove.c	2012-07-04 09:55:33.695965952 +0900
+++ linux/drivers/pci/remove.c	2012-07-04 09:55:57.374674896 +0900
@@ -143,7 +143,7 @@ void pci_stop_and_remove_behind_bridge(s
 	__pci_remove_behind_bridge(dev);
 }
 
-static void pci_stop_bus_devices(struct pci_bus *bus)
+void pci_stop_bus_devices(struct pci_bus *bus)
 {
 	struct list_head *l, *n;
 
@@ -179,4 +179,20 @@ void pci_stop_bus_device(struct pci_dev 
 
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
 EXPORT_SYMBOL(pci_stop_and_remove_behind_bridge);
+EXPORT_SYMBOL(pci_stop_bus_devices);
 EXPORT_SYMBOL_GPL(pci_stop_bus_device);
+
+void pci_remove_host_bridge(struct pci_host_bridge *bridge)
+{
+	struct list_head *l, *n;
+	struct pci_bus *root = bridge->bus;
+
+	list_for_each_safe(l, n, &root->devices)
+		__pci_remove_bus_device(pci_dev_b(l));
+
+	pci_remove_bus(root);
+
+	device_unregister(&bridge->dev);
+}
+EXPORT_SYMBOL(pci_remove_host_bridge);
+
Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c	2012-07-04 09:55:54.435706670 +0900
+++ linux/drivers/acpi/pci_root.c	2012-07-04 09:55:57.375674818 +0900
@@ -656,9 +656,12 @@ static int acpi_pci_root_remove(struct a
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
+	struct pci_host_bridge *bridge = to_pci_host_bridge(root->bus->bridge);
 
 	mutex_lock(&acpi_pci_root_lock);
 
+	pci_stop_bus_devices(root->bus);
+
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root->device->handle);
@@ -666,6 +669,11 @@ static int acpi_pci_root_remove(struct a
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	acpi_pci_irq_del_prt(root->bus);
+	acpi_pci_unbind_root(device);
+
+	pci_remove_host_bridge(bridge);
+
 	list_del_rcu(&root->node);
 	mutex_unlock(&acpi_pci_root_lock);
 	synchronize_rcu();
Index: linux/include/linux/pci.h
===================================================================
--- linux.orig/include/linux/pci.h	2012-07-04 09:54:51.863488983 +0900
+++ linux/include/linux/pci.h	2012-07-04 09:55:57.380674441 +0900
@@ -734,7 +734,9 @@ extern void pci_dev_put(struct pci_dev *
 extern void pci_remove_bus(struct pci_bus *b);
 extern void __pci_remove_bus_device(struct pci_dev *dev);
 extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
+extern void pci_stop_bus_devices(struct pci_bus *bus);
 extern void pci_stop_bus_device(struct pci_dev *dev);
+extern void pci_remove_host_bridge(struct pci_host_bridge *bridge);
 void pci_setup_cardbus(struct pci_bus *bus);
 extern void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
Index: linux/drivers/acpi/pci_bind.c
===================================================================
--- linux.orig/drivers/acpi/pci_bind.c	2012-07-04 09:54:51.863488983 +0900
+++ linux/drivers/acpi/pci_bind.c	2012-07-04 09:55:57.382674297 +0900
@@ -118,3 +118,10 @@ int acpi_pci_bind_root(struct acpi_devic
 
 	return 0;
 }
+
+void  acpi_pci_unbind_root(struct acpi_device *device)
+{
+	device->ops.bind = NULL;
+	device->ops.unbind = NULL;
+}
+
Index: linux/include/acpi/acpi_drivers.h
===================================================================
--- linux.orig/include/acpi/acpi_drivers.h	2012-07-04 09:54:51.863488983 +0900
+++ linux/include/acpi/acpi_drivers.h	2012-07-04 09:55:57.386674021 +0900
@@ -101,6 +101,7 @@ struct pci_bus;
 
 struct pci_dev *acpi_get_pci_dev(acpi_handle);
 int acpi_pci_bind_root(struct acpi_device *device);
+void acpi_pci_unbind_root(struct acpi_device *device);
 
 /* Arch-defined function to add a bus to the system */
 

