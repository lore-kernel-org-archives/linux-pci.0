Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57084 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379Ab2IRGU2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 02:20:28 -0400
Date: Tue, 18 Sep 2012 15:20:34 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: [PATCH v3 2/8] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging
 PCI root bridges
Message-Id: <20120918152034.6ebe4111.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

  ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
    
  When hot-plugging PCI root bridge, acpi_pci_drivers' add()/remove()
  methods should be invoked to notify registered drivers.
    
  -v2: Move add calling to acpi_pci_root_start by Yinghai
    
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: Bjorn-next-0808/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0808.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0808/drivers/acpi/pci_root.c
@@ -626,14 +626,25 @@ end:
 static int acpi_pci_root_start(struct acpi_device *device)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
+	struct acpi_pci_driver *driver;
+
+	list_for_each_entry(driver, &acpi_pci_drivers, node)
+		if (driver->add)
+			driver->add(device->handle);
 
 	pci_bus_add_devices(root->bus);
+
 	return 0;
 }
 
 static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
+	struct acpi_pci_driver *driver;
+
+	list_for_each_entry(driver, &acpi_pci_drivers, node)
+		if (driver->remove)
+			driver->remove(root->device->handle);
 
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);

