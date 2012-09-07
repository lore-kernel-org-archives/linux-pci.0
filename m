Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49720 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab2IGJb0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 05:31:26 -0400
Date: Fri, 7 Sep 2012 18:31:20 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, jiang.liu@huawei.com
Subject: Re: [PATCH v2 6/6] ACPI, PCI: add resoruce-assign code for devices
 under hot-added hostbridge
Message-Id: <20120907183120.558e7a62.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120907182612.92efef7d.izumi.taku@jp.fujitsu.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
	<20120903170705.4e6dbc2c.izumi.taku@jp.fujitsu.com>
	<CAE9FiQVXtTf3+jpbYzHk3D3VVm-bXEB9EcgkBwkEtYR-SRiKHA@mail.gmail.com>
	<20120907182612.92efef7d.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Currently there's no PCI-related clean-up code
in acpi_pci_root_remove() function.
This patch introduces function for hostbridge removal,
and brings back pci_stop_bus_devices() function.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_bind.c     |    7 +++++++
 drivers/acpi/pci_root.c     |    7 +++++++
 drivers/pci/remove.c        |   27 +++++++++++++++++++++++++++
 include/acpi/acpi_drivers.h |    1 +
 include/linux/pci.h         |    2 ++
 5 files changed, 44 insertions(+)

Index: Bjorn-next-0903/drivers/pci/remove.c
===================================================================
--- Bjorn-next-0903.orig/drivers/pci/remove.c
+++ Bjorn-next-0903/drivers/pci/remove.c
@@ -92,3 +92,30 @@ void pci_stop_and_remove_bus_device(stru
 	pci_destroy_dev(dev);
 }
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
+
+void pci_stop_bus_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev, *tmp;
+
+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
+		if (dev->subordinate)
+			pci_stop_bus_devices(dev->subordinate);
+		pci_stop_dev(dev);
+	}
+
+}
+EXPORT_SYMBOL(pci_stop_bus_devices);
+
+void pci_remove_host_bridge(struct pci_host_bridge *bridge)
+{
+	struct pci_bus *root = bridge->bus;
+	struct pci_dev *dev, *tmp;
+
+	list_for_each_entry_safe_reverse(dev, tmp, &root->devices, bus_list)
+		pci_stop_and_remove_bus_device(dev);
+
+	pci_remove_bus(root);
+
+	device_unregister(&bridge->dev);
+}
+EXPORT_SYMBOL(pci_remove_host_bridge);
Index: Bjorn-next-0903/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0903/drivers/acpi/pci_root.c
@@ -655,8 +655,10 @@ static int acpi_pci_root_remove(struct a
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
+	struct pci_host_bridge *bridge = to_pci_host_bridge(root->bus->bridge);
 
 	mutex_lock(&acpi_pci_root_lock);
+	pci_stop_bus_devices(root->bus);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root->device->handle);
@@ -664,6 +666,11 @@ static int acpi_pci_root_remove(struct a
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
Index: Bjorn-next-0903/include/linux/pci.h
===================================================================
--- Bjorn-next-0903.orig/include/linux/pci.h
+++ Bjorn-next-0903/include/linux/pci.h
@@ -734,6 +734,8 @@ extern struct pci_dev *pci_dev_get(struc
 extern void pci_dev_put(struct pci_dev *dev);
 extern void pci_remove_bus(struct pci_bus *b);
 extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
+extern void pci_stop_bus_devices(struct pci_bus *bus);
+extern void pci_remove_host_bridge(struct pci_host_bridge *bridge);
 void pci_setup_cardbus(struct pci_bus *bus);
 extern void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
Index: Bjorn-next-0903/drivers/acpi/pci_bind.c
===================================================================
--- Bjorn-next-0903.orig/drivers/acpi/pci_bind.c
+++ Bjorn-next-0903/drivers/acpi/pci_bind.c
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
Index: Bjorn-next-0903/include/acpi/acpi_drivers.h
===================================================================
--- Bjorn-next-0903.orig/include/acpi/acpi_drivers.h
+++ Bjorn-next-0903/include/acpi/acpi_drivers.h
@@ -101,6 +101,7 @@ struct pci_bus;
 
 struct pci_dev *acpi_get_pci_dev(acpi_handle);
 int acpi_pci_bind_root(struct acpi_device *device);
+void acpi_pci_unbind_root(struct acpi_device *device);
 
 /* Arch-defined function to add a bus to the system */
 

