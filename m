Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 6/8] PCI, ACPI: Make acpi_pci_root_remove stop/remove pci root bus
Date: Tue, 30 Oct 2012 10:42:43 -0700
Message-Id: <1351618965-16761-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
References: <20121030040237.GA10472@google.com>
 <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It will call new added pci_stop_and_remove_bus() to stop/remove pci root bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/pci_root.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 27adbfd..aed0953 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -667,14 +667,20 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	pci_stop_root_bus(root->bus);
+
 	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root);
+	mutex_unlock(&acpi_pci_root_lock);
 
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	pci_remove_root_bus(root->bus);
+
+	mutex_lock(&acpi_pci_root_lock);
 	list_del(&root->node);
 	mutex_unlock(&acpi_pci_root_lock);
 	kfree(root);
-- 
1.7.7

