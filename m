Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60748 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758607Ab2CWPCz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2012 11:02:55 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 10/11] PCI,ACPI: serialize hotplug operations triggered by ACPI subsystem
Date: Fri, 23 Mar 2012 22:58:26 +0800
Message-Id: <1332514707-9673-11-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use pci_lock_hotplug()/pci_unlock_hotplug() to serialize PCI
hotplug operations related to ACPI root bridges.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/pci_root.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 24afd66..a8a3867 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -463,6 +463,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	if (!root)
 		return -ENOMEM;
 
+	pci_lock_hotplug();
+
 	segment = 0;
 	status = acpi_evaluate_integer(device->handle, METHOD_NAME__SEG, NULL,
 				       &segment);
@@ -627,12 +629,14 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 			driver->add(device->handle);
 
 	mutex_unlock(&acpi_pci_root_lock);
+	pci_unlock_hotplug();
 
 	return 0;
 
 out_del_root:
 	list_del_rcu(&root->node);
 	mutex_unlock(&acpi_pci_root_lock);
+	pci_unlock_hotplug();
 	synchronize_rcu();
 out_free:
 	kfree(root);
@@ -643,7 +647,9 @@ static int acpi_pci_root_start(struct acpi_device *device)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
 
+	pci_lock_hotplug();
 	pci_bus_add_devices(root->bus);
+	pci_unlock_hotplug();
 	return 0;
 }
 
@@ -652,6 +658,7 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	pci_lock_hotplug();
 	mutex_lock(&acpi_pci_root_lock);
 
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
@@ -675,6 +682,7 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 out:
 	list_del_rcu(&root->node);
 	mutex_unlock(&acpi_pci_root_lock);
+	pci_unlock_hotplug();
 	synchronize_rcu();
 	kfree(root);
 
-- 
1.7.5.4

