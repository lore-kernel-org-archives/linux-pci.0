Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 8/9] ACPI / dock: Drop remove_dock_dependent_devices()
Date: Wed, 19 Feb 2014 02:32:12 +0100
Message-ID: <3723851.WP79lXh8Px@vostro.rjw.lan>
In-Reply-To: <3011875.q18rCmXyYX@vostro.rjw.lan>
References: <3011875.q18rCmXyYX@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since remove_dock_dependent_devices() is only called from acpi_dock_add()
and it only is called if the add_dock_dependent_device() adding the
dock station to its own list of dependent devices has failed, it is not
really necessary, because the dock station's list of dependent devices
is guaranteed to be empty at that point.  Drop it, then.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/dock.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -114,16 +114,6 @@ static int add_dock_dependent_device(str
 	return 0;
 }
 
-static void remove_dock_dependent_devices(struct dock_station *ds)
-{
-	struct dock_dependent_device *dd, *aux;
-
-	list_for_each_entry_safe(dd, aux, &ds->dependent_devices, list) {
-		list_del(&dd->list);
-		kfree(dd);
-	}
-}
-
 static void dock_hotplug_event(struct dock_dependent_device *dd, u32 event,
 			       enum dock_callback_type cb_type)
 {
@@ -674,8 +664,8 @@ void acpi_dock_add(struct acpi_device *a
 	return;
 
 err_rmgroup:
-	remove_dock_dependent_devices(dock_station);
 	sysfs_remove_group(&dd->dev.kobj, &dock_attribute_group);
+
 err_unregister:
 	platform_device_unregister(dd);
 	acpi_handle_err(handle, "%s encountered error %d\n", __func__, ret);

