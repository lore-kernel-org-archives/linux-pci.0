Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:37159 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab2I1JsP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 05:48:15 -0400
Date: Fri, 28 Sep 2012 18:48:33 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, jiang.liu@huawei.com,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3 8/8] ACPI, PCI: add resoruce-assign code for devices
 under hot-added hostbridge
Message-Id: <20120928184833.910cf605.izumi.taku@jp.fujitsu.com>
In-Reply-To: <CAE9FiQWujHz9D180Av8Vupdtu3Zqz2gKzv0FHW0PdpmJ3DM3sA@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152641.410dad43.izumi.taku@jp.fujitsu.com>
	<CAE9FiQU_-FYdy0ARuGaoCEg+F+5t0tDF-WToFhafGWbbAWBvDw@mail.gmail.com>
	<CAE9FiQWujHz9D180Av8Vupdtu3Zqz2gKzv0FHW0PdpmJ3DM3sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Devices under hot-added hostbridge have no chance to assign resources
and to configure them, so this patch adds such code for hot-added 
hostbridges at acpi_pci_root_start().

diff: updated according to Yinhai's comment
      disconnect dependency on CONFIG_HOTPLUG
      

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   13 +++++++++++++
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 14 insertions(+)

Index: Bjorn-next-0925/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0925.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0925/drivers/acpi/pci_root.c
@@ -628,6 +628,9 @@ static int __devinit acpi_pci_root_add(s
 	if (device->wakeup.flags.run_wake)
 		device_set_run_wake(root->bus->bridge, true);
 
+	if (system_state != SYSTEM_BOOTING)
+		root->hot_added = true;
+
 	return 0;
 
 out_del_root:
@@ -644,6 +647,16 @@ static int acpi_pci_root_start(struct ac
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	/*
+	 * Devices under hot-added hostbridge have no chance to assign
+	 * resources and to configure them, so do that here
+	 */
+	if (root->hot_added) {
+		pci_bus_size_bridges(root->bus);
+		pci_bus_assign_resources(root->bus);
+		pci_enable_bridges(root->bus);
+	}
+
 	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->add)
Index: Bjorn-next-0925/include/acpi/acpi_bus.h
===================================================================
--- Bjorn-next-0925.orig/include/acpi/acpi_bus.h
+++ Bjorn-next-0925/include/acpi/acpi_bus.h
@@ -407,6 +407,7 @@ struct acpi_pci_root {
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
 	phys_addr_t mcfg_addr;
+	bool hot_added;
 };
 
 /* helper */

