Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55424 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab2HJGPh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2012 02:15:37 -0400
Date: Fri, 10 Aug 2012 15:15:29 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: [PATCH 7/7][RESEND] ACPI, PCI: add resoruce-assign code for devices
 under hot-added hostbridge
Message-Id: <20120810151529.a92625d2.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
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

Index: Bjorn-next-0808/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0808.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0808/drivers/acpi/pci_root.c
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
 
Index: Bjorn-next-0808/include/acpi/acpi_bus.h
===================================================================
--- Bjorn-next-0808.orig/include/acpi/acpi_bus.h
+++ Bjorn-next-0808/include/acpi/acpi_bus.h
@@ -407,6 +407,7 @@ struct acpi_pci_root {
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
 	phys_addr_t mcfg_addr;
+	bool hot_added;
 };
 
 /* helper */

