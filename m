Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, chenkeping@huawei.com,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 2/3] ACPI,PCI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
Date: Thu, 22 Mar 2012 00:22:36 +0800
Message-Id: <1332346957-10070-3-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332346957-10070-1-git-send-email-jiang.liu@huawei.com>
References: <1332346957-10070-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

When hot-plugging PCI root bridge, acpi_pci_drivers' add()/remove()
methods should be invoked to notify registered drivers.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/pci_root.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c2d2b7b..ff73357 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -445,6 +445,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	acpi_status status;
 	int result;
 	struct acpi_pci_root *root;
+	struct acpi_pci_driver *driver;
 	acpi_handle handle;
 	struct acpi_device *child;
 	u32 flags, base_flags;
@@ -612,6 +613,10 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	if (device->wakeup.flags.run_wake)
 		device_set_run_wake(root->bus->bridge, true);
 
+	list_for_each_entry(driver, &acpi_pci_drivers, node)
+		if (driver->add)
+			driver->add(device->handle);
+
 	return 0;
 
 end:
@@ -632,6 +637,11 @@ static int acpi_pci_root_start(struct acpi_device *device)
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
1.7.5.4

