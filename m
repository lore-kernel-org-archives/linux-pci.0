Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36221 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514Ab2FUJiu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:38:50 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id D4D3C3EE0BC
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:38:49 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B993A45DE53
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:38:49 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9620845DD78
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:38:49 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 84B531DB802C
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:38:49 +0900 (JST)
Received: from m0001.s.css.fujitsu.com (m0001.s.css.fujitsu.com [10.23.4.186])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3AED71DB803C
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:38:49 +0900 (JST)
Date: Thu, 21 Jun 2012 18:39:01 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 3/4] acpi, pci: add hostbridge removal function
Message-Id: <20120621183901.a8b70aa8.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
References: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
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
 drivers/acpi/pci_root.c     |   12 ++++++++++++
 drivers/pci/remove.c        |   18 +++++++++++++++++-
 include/acpi/acpi_drivers.h |    1 +
 include/linux/pci.h         |    2 ++
 5 files changed, 39 insertions(+), 1 deletion(-)

Index: linux/drivers/pci/remove.c
===================================================================
--- linux.orig/drivers/pci/remove.c
+++ linux/drivers/pci/remove.c
@@ -144,7 +144,7 @@ void pci_stop_and_remove_behind_bridge(s
 	__pci_remove_behind_bridge(dev);
 }
 
-static void pci_stop_bus_devices(struct pci_bus *bus)
+void pci_stop_bus_devices(struct pci_bus *bus)
 {
 	struct list_head *l, *n;
 
@@ -180,4 +180,20 @@ void pci_stop_bus_device(struct pci_dev 
 
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
--- linux.orig/drivers/acpi/pci_root.c
+++ linux/drivers/acpi/pci_root.c
@@ -652,10 +652,22 @@ static int acpi_pci_root_start(struct ac
 static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
+	struct pci_host_bridge *bridge = to_pci_host_bridge(root->bus->bridge);
+
+	pci_stop_bus_devices(root->bus);
 
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	acpi_pci_irq_del_prt(root->bus);
+	acpi_pci_unbind_root(device);
+
+	pci_remove_host_bridge(bridge);
+
+	down_write(&acpi_pci_sem);
+	list_del(&root->node);
+	up_write(&acpi_pci_sem);
+
 	kfree(root);
 	return 0;
 }
Index: linux/include/linux/pci.h
===================================================================
--- linux.orig/include/linux/pci.h
+++ linux/include/linux/pci.h
@@ -699,7 +699,9 @@ extern void pci_dev_put(struct pci_dev *
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
--- linux.orig/drivers/acpi/pci_bind.c
+++ linux/drivers/acpi/pci_bind.c
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
--- linux.orig/include/acpi/acpi_drivers.h
+++ linux/include/acpi/acpi_drivers.h
@@ -101,6 +101,7 @@ struct pci_bus;
 
 struct pci_dev *acpi_get_pci_dev(acpi_handle);
 int acpi_pci_bind_root(struct acpi_device *device);
+void acpi_pci_unbind_root(struct acpi_device *device);
 
 /* Arch-defined function to add a bus to the system */
 

