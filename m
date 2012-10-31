Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54846 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935029Ab2JaI1D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 04:27:03 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 6949C3EE0B5
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:01 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5253845DE56
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:01 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3B5D745DE3E
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:01 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2E46C1DB804B
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:01 +0900 (JST)
Received: from m0000.s.css.fujitsu.com (m0000.s.css.fujitsu.com [10.23.4.183])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D6FEEE08001
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:00 +0900 (JST)
Received: from m0000.css.fujitsu.com (m0000 [127.0.0.1])
	by m0000.s.css.fujitsu.com (Postfix) with ESMTP id C25B91015CC
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:00 +0900 (JST)
Received: from DEUCALION (unknown [10.124.101.32])
	by m0000.s.css.fujitsu.com (Postfix) with SMTP id 9DEFA1015C1
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 17:27:00 +0900 (JST)
Date: Wed, 31 Oct 2012 17:26:45 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v3,RESEND 7/8] ACPI, PCI: add hostbridge removal function
Message-Id: <20121031172645.937510c3.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20121030040237.GA10472@google.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com>
	<CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
	<20120928184627.0b039d14.izumi.taku@jp.fujitsu.com>
	<20121030040237.GA10472@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Currently there's no PCI-related clean-up code
in acpi_pci_root_remove() function.
This patch introduces function for hostbridge removal,
and brings back pci_stop_bus_devices() function.

diff: rebased against current next
      updated according to Bjorn's comment

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_bind.c     |    7 +++++++
 drivers/acpi/pci_root.c     |    6 ++++++
 drivers/pci/remove.c        |   28 ++++++++++++++++++++++++++++
 include/acpi/acpi_drivers.h |    1 +
 include/linux/pci.h         |    2 ++
 5 files changed, 44 insertions(+)

Index: Bjorn-next-0925-configchange/drivers/pci/remove.c
===================================================================
--- Bjorn-next-0925-configchange.orig/drivers/pci/remove.c
+++ Bjorn-next-0925-configchange/drivers/pci/remove.c
@@ -111,3 +111,31 @@ void pci_stop_and_remove_bus_device(stru
 	pci_remove_bus_device(dev);
 }
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
+
+void pci_stop_bus_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev, *tmp;
+
+	list_for_each_entry_safe_reverse(dev, tmp,
+					 &bus->devices, bus_list) {
+		pci_stop_bus_device(dev);
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
+	list_for_each_entry_safe_reverse(dev, tmp,
+					 &root->devices, bus_list) {
+		pci_remove_bus_device(dev);
+	}
+
+	pci_remove_bus(root);
+
+	device_unregister(&bridge->dev);
+}
+EXPORT_SYMBOL(pci_remove_host_bridge);
Index: Bjorn-next-0925-configchange/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0925-configchange.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0925-configchange/drivers/acpi/pci_root.c
@@ -659,8 +659,10 @@ static int acpi_pci_root_remove(struct a
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
+	struct pci_host_bridge *bridge = to_pci_host_bridge(root->bus->bridge);
 
 	mutex_lock(&acpi_pci_root_lock);
+	pci_stop_bus_devices(root->bus);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root);
@@ -668,6 +670,10 @@ static int acpi_pci_root_remove(struct a
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	acpi_pci_unbind_root(device);
+
+	pci_remove_host_bridge(bridge);
+
 	list_del(&root->node);
 	mutex_unlock(&acpi_pci_root_lock);
 	kfree(root);
Index: Bjorn-next-0925-configchange/include/linux/pci.h
===================================================================
--- Bjorn-next-0925-configchange.orig/include/linux/pci.h
+++ Bjorn-next-0925-configchange/include/linux/pci.h
@@ -734,6 +734,8 @@ extern struct pci_dev *pci_dev_get(struc
 extern void pci_dev_put(struct pci_dev *dev);
 extern void pci_remove_bus(struct pci_bus *b);
 extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
+extern void pci_stop_bus_devices(struct pci_bus *bus);
+extern void pci_remove_host_bridge(struct pci_host_bridge *bridge);
 void pci_setup_cardbus(struct pci_bus *bus);
 extern void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
Index: Bjorn-next-0925-configchange/drivers/acpi/pci_bind.c
===================================================================
--- Bjorn-next-0925-configchange.orig/drivers/acpi/pci_bind.c
+++ Bjorn-next-0925-configchange/drivers/acpi/pci_bind.c
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
Index: Bjorn-next-0925-configchange/include/acpi/acpi_drivers.h
===================================================================
--- Bjorn-next-0925-configchange.orig/include/acpi/acpi_drivers.h
+++ Bjorn-next-0925-configchange/include/acpi/acpi_drivers.h
@@ -101,6 +101,7 @@ struct pci_bus;
 
 struct pci_dev *acpi_get_pci_dev(acpi_handle);
 int acpi_pci_bind_root(struct acpi_device *device);
+void acpi_pci_unbind_root(struct acpi_device *device);
 
 /* Arch-defined function to add a bus to the system */
 

