Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53634 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817Ab2IRGXP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 02:23:15 -0400
Date: Tue, 18 Sep 2012 15:23:23 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: [PATCH v3 5/8] ACPI, PCI: change acpi_pci_find_root implementation
Message-Id: <20120918152323.48cb2703.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This patch changes the implementation of acpi_pci_find_root().

We can access acpi_pci_root without scanning acpi_pci_roots list.
If hostbridge hotplug is supported, acpi_pci_roots list will be
protected by mutex. We should not access acpi_pci_roots list 
if preventable to lessen deadlock risk.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: Bjorn-next-0903/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0903/drivers/acpi/pci_root.c
@@ -265,12 +265,15 @@ static acpi_status acpi_pci_osc_support(
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
 {
 	struct acpi_pci_root *root;
+	struct acpi_device *device;
 
-	list_for_each_entry(root, &acpi_pci_roots, node) {
-		if (root->device->handle == handle)
-			return root;
-	}
-	return NULL;
+	if (acpi_bus_get_device(handle, &device) ||
+	    acpi_match_device_ids(device, root_device_ids))
+		return NULL;
+
+	root = acpi_driver_data(device);
+
+	return root;
 }
 EXPORT_SYMBOL_GPL(acpi_pci_find_root);
 

