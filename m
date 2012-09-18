Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 18 Sep 2012 15:24:40 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	yinghai@kernel.org, jiang.liu@huawei.com
Subject: [PATCH v3 6/8] ACPI, PCI: add acpi_pci_roots protection
Message-Id: <20120918152440.117dd1cb.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Use mutex to protect acpi_pci_roots list against PCI host bridge 
hotplug operations.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

Index: Bjorn-next-0903/drivers/acpi/pci_root.c
===================================================================
--- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
+++ Bjorn-next-0903/drivers/acpi/pci_root.c
@@ -112,12 +112,17 @@ EXPORT_SYMBOL(acpi_pci_unregister_driver
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
 {
 	struct acpi_pci_root *root;
+	struct acpi_handle *handle = NULL;
 	
+	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(root, &acpi_pci_roots, node)
 		if ((root->segment == (u16) seg) &&
-		    (root->secondary.start == (u16) bus))
-			return root->device->handle;
-	return NULL;		
+		    (root->secondary.start == (u16) bus)) {
+			handle = root->device->handle;
+			break;
+		}
+	mutex_unlock(&acpi_pci_root_lock);
+	return handle;
 }
 
 EXPORT_SYMBOL_GPL(acpi_get_pci_rootbridge_handle);
@@ -509,8 +514,9 @@ static int __devinit acpi_pci_root_add(s
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
 	 */
 
-	/* TBD: Locking */
+	mutex_lock(&acpi_pci_root_lock);
 	list_add_tail(&root->node, &acpi_pci_roots);
+	mutex_unlock(&acpi_pci_root_lock);
 
 	printk(KERN_INFO PREFIX "%s [%s] (domain %04x %pR)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
@@ -529,7 +535,7 @@ static int __devinit acpi_pci_root_add(s
 			    "Bus %04x:%02x not present in PCI namespace\n",
 			    root->segment, (unsigned int)root->secondary.start);
 		result = -ENODEV;
-		goto end;
+		goto out_del_root;
 	}
 
 	/*
@@ -539,7 +545,7 @@ static int __devinit acpi_pci_root_add(s
 	 */
 	result = acpi_pci_bind_root(device);
 	if (result)
-		goto end;
+		goto out_del_root;
 
 	/*
 	 * PCI Routing Table
@@ -617,9 +623,11 @@ static int __devinit acpi_pci_root_add(s
 
 	return 0;
 
+out_del_root:
+	mutex_lock(&acpi_pci_root_lock);
+	list_del(&root->node);
+	mutex_unlock(&acpi_pci_root_lock);
 end:
-	if (!list_empty(&root->node))
-		list_del(&root->node);
 	kfree(root);
 	return result;
 }
@@ -649,11 +657,12 @@ static int acpi_pci_root_remove(struct a
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root);
-	mutex_unlock(&acpi_pci_root_lock);
 
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	list_del(&root->node);
+	mutex_unlock(&acpi_pci_root_lock);
 	kfree(root);
 	return 0;
 }

