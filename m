Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 3 Sep 2012 17:06:36 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: [PATCH v2 5/6] ACPI, PCI: add hostbridge removal function
Message-Id: <20120903170636.f1749ab0.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Currently there's no PCI-related clean-up code
in acpi_pci_root_remove() function.
This patch introduces function for hostbridge removal.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_bind.c     |    7 +++++++
 drivers/acpi/pci_root.c     |    6 ++++++
 drivers/pci/remove.c        |   14 ++++++++++++++
 include/acpi/acpi_drivers.h |    1 +
 include/linux/pci.h         |    1 +
 5 files changed, 29 insertions(+)

Index: Bjorn-next-0903/drivers/pci/remove.c
===================================================================
--- Bjorn-next-0903.orig/drivers/pci/remove.c
+++ Bjorn-next-0903/drivers/pci/remove.c
@@ -92,3 +92,17 @@ void pci_stop_and_remove_bus_device(stru
 	pci_destroy_dev(dev);
 }
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
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
@@ -655,6 +655,7 @@ static int acpi_pci_root_remove(struct a
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
+	struct pci_host_bridge *bridge = to_pci_host_bridge(root->bus->bridge);
 
 	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
@@ -664,6 +665,11 @@ static int acpi_pci_root_remove(struct a
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
@@ -734,6 +734,7 @@ extern struct pci_dev *pci_dev_get(struc
 extern void pci_dev_put(struct pci_dev *dev);
 extern void pci_remove_bus(struct pci_bus *b);
 extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
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
 

