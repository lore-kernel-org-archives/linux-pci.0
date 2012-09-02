Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:40059 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab2IBV4T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Sep 2012 17:56:19 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH part5 2/7] ACPI, PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
Date: Sun,  2 Sep 2012 14:56:00 -0700
Message-Id: <1346622965-30937-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1346622965-30937-1-git-send-email-yinghai@kernel.org>
References: <1346622965-30937-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

When hot-plugging PCI root bridge, acpi_pci_drivers' add()/remove()
methods should be invoked to notify registered drivers.

-v2: Move add calling to acpi_pci_root_start by Yinghai

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 2aec08d..9ba516b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
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
 
 	/* that root bus could be removed already */
 	if (!pci_find_bus(root->segment, root->secondary.start)) {
-- 
1.7.7

