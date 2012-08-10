Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55394 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab2HJGPA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2012 02:15:00 -0400
Date: Fri, 10 Aug 2012 15:14:55 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: [PATCH 6/7][RESEND] ACPI, PCI: add hostbridge removal function
Message-Id: <20120810151455.d881caf4.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
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

Index: Bjorn-next-0718/drivers/pci/remove.c
===================================================================
--- Bjorn-next-0718.orig/drivers/pci/remove.c
+++ Bjorn-next-0718/drivers/pci/remove.c
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
Index: Bjorn-next-0718/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0718.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0718/drivers/acpi/pci_root.c
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
Index: Bjorn-next-0718/include/linux/pci.h
===================================================================
--- Bjorn-next-0718.orig/include/linux/pci.h
+++ Bjorn-next-0718/include/linux/pci.h
@@ -736,7 +736,9 @@ extern void pci_dev_put(struct pci_dev *
 extern void pci_remove_bus(struct pci_bus *b);
 extern void __pci_remove_bus_device(struct pci_dev *dev);
 extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
+extern void pci_stop_bus_devices(struct pci_bus *bus);
 extern void pci_stop_bus_device(struct pci_dev *dev);
+extern void pci_remove_host_bridge(struct pci_host_bridge *bridge);
 void pci_setup_cardbus(struct pci_bus *bus);
 extern void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
Index: Bjorn-next-0718/drivers/acpi/pci_bind.c
===================================================================
--- Bjorn-next-0718.orig/drivers/acpi/pci_bind.c
+++ Bjorn-next-0718/drivers/acpi/pci_bind.c
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
Index: Bjorn-next-0718/include/acpi/acpi_drivers.h
===================================================================
--- Bjorn-next-0718.orig/include/acpi/acpi_drivers.h
+++ Bjorn-next-0718/include/acpi/acpi_drivers.h
@@ -101,6 +101,7 @@ struct pci_bus;
 
 struct pci_dev *acpi_get_pci_dev(acpi_handle);
 int acpi_pci_bind_root(struct acpi_device *device);
+void acpi_pci_unbind_root(struct acpi_device *device);
 
 /* Arch-defined function to add a bus to the system */
 

