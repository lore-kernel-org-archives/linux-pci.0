Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:44637 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab2GDILs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 04:11:48 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id CB4BB3EE0C1
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:47 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id ABC7845DE52
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:47 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 96E8745DE50
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:47 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8B63A1DB803F
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:47 +0900 (JST)
Received: from m001.s.css.fujitsu.com (m001.s.css.fujitsu.com [10.23.4.39])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 47EDC1DB803B
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 17:11:47 +0900 (JST)
Date: Wed, 4 Jul 2012 17:11:31 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 7/7] ACPI, PCI: add resoruce-assign code for devices under
 hot-added hostbridge
Message-Id: <20120704171131.bc416947.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
References: <20120704170345.07cd0ad7.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Devices under hot-added hostbridge have no chance to assign resources
and to configure them, so this patch adds such code for hot-added 
hostbridges at acpi_pci_root_start().

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   18 ++++++++++++++++++
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 19 insertions(+)

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c	2012-07-04 09:55:57.375674818 +0900
+++ linux/drivers/acpi/pci_root.c	2012-07-04 09:56:00.771627515 +0900
@@ -39,6 +39,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/apei.h>
+#include <linux/pci_hotplug.h>
 
 #define PREFIX "ACPI: "
 
@@ -462,6 +463,10 @@ static int __devinit acpi_pci_root_add(s
 	if (!root)
 		return -ENOMEM;
 
+	if (system_state != SYSTEM_BOOTING) {
+		root->hot_added = true;
+	}
+
 	segment = 0;
 	status = acpi_evaluate_integer(device->handle, METHOD_NAME__SEG, NULL,
 				       &segment);
@@ -640,12 +645,25 @@ static int acpi_pci_root_start(struct ac
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
+	struct pci_dev *pdev;
 
 	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->add)
 			driver->add(device->handle);
 
+	/*
+ 	 * Devices under hot-added hostbridge have no chance to assign
+ 	 * resources and to configure them, so do that here
+ 	 */
+	if (root->hot_added) {
+		pci_bus_size_bridges(root->bus);
+		pci_bus_assign_resources(root->bus);
+		list_for_each_entry(pdev, &root->bus->devices, bus_list)
+			pci_configure_slot(pdev);
+		pci_enable_bridges(root->bus);
+	}
+
 	pci_bus_add_devices(root->bus);
 	mutex_unlock(&acpi_pci_root_lock);
 
Index: linux/include/acpi/acpi_bus.h
===================================================================
--- linux.orig/include/acpi/acpi_bus.h	2012-07-04 09:54:51.754490344 +0900
+++ linux/include/acpi/acpi_bus.h	2012-07-04 09:56:00.772627502 +0900
@@ -402,6 +402,7 @@ struct acpi_pci_root {
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
 	phys_addr_t mcfg_addr;
+	bool hot_added;
 };
 
 /* helper */

