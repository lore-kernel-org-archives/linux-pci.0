Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Toshi Kani <toshi.kani@hp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing0307@gmail.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH 7/16] ACPI / PCI: Fold acpi_pci_root_start() into acpi_pci_root_add()
Date: Thu, 20 Dec 2012 02:52:31 +0100
Message-ID: <5379946.RTtFfZ2sBu@vostro.rjw.lan>
In-Reply-To: <1855256.SyhOJGYMIh@vostro.rjw.lan>
References: <8498184.VilrUmatxI@vostro.rjw.lan> <4082842.31rfDviYHK@vostro.rjw.lan> <1855256.SyhOJGYMIh@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the code from the ACPI PCI root bridge's .start() callback
routine, acpi_pci_root_start(), directly into acpi_pci_root_add()
and drop acpi_pci_root_start().

It is safe to do that, because it is now always guaranteed that
when struct pci_dev objects are created, their companion struct
acpi_device objects are already present, so it is not necessary to
wait for them to be created before calling pci_bus_add_devices().

This change was previously proposed in a different form by
Yinghai Lu.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c |   26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c
+++ linux/drivers/acpi/pci_root.c
@@ -47,7 +47,6 @@ ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_DEVICE_NAME	"PCI Root Bridge"
 static int acpi_pci_root_add(struct acpi_device *device);
 static int acpi_pci_root_remove(struct acpi_device *device, int type);
-static int acpi_pci_root_start(struct acpi_device *device);
 
 #define ACPI_PCIE_REQ_SUPPORT (OSC_EXT_PCI_CONFIG_SUPPORT \
 				| OSC_ACTIVE_STATE_PWR_SUPPORT \
@@ -67,7 +66,6 @@ static struct acpi_driver acpi_pci_root_
 	.ops = {
 		.add = acpi_pci_root_add,
 		.remove = acpi_pci_root_remove,
-		.start = acpi_pci_root_start,
 		},
 };
 
@@ -453,6 +451,7 @@ static int __devinit acpi_pci_root_add(s
 	struct acpi_pci_root *root;
 	acpi_handle handle;
 	struct acpi_device *child;
+	struct acpi_pci_driver *driver;
 	u32 flags, base_flags;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
@@ -628,6 +627,13 @@ static int __devinit acpi_pci_root_add(s
 	if (device->wakeup.flags.run_wake)
 		device_set_run_wake(root->bus->bridge, true);
 
+	mutex_lock(&acpi_pci_root_lock);
+	list_for_each_entry(driver, &acpi_pci_drivers, node)
+		if (driver->add)
+			driver->add(root);
+	mutex_unlock(&acpi_pci_root_lock);
+
+	pci_bus_add_devices(root->bus);
 	return 0;
 
 out_del_root:
@@ -639,22 +645,6 @@ end:
 	return result;
 }
 
-static int acpi_pci_root_start(struct acpi_device *device)
-{
-	struct acpi_pci_root *root = acpi_driver_data(device);
-	struct acpi_pci_driver *driver;
-
-	mutex_lock(&acpi_pci_root_lock);
-	list_for_each_entry(driver, &acpi_pci_drivers, node)
-		if (driver->add)
-			driver->add(root);
-	mutex_unlock(&acpi_pci_root_lock);
-
-	pci_bus_add_devices(root->bus);
-
-	return 0;
-}
-
 static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);

