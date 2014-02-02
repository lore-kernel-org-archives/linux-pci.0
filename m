Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 4/6] ACPI / hotplug / PCI: Rework the handling of eject requests
Date: Sun, 02 Feb 2014 01:57:21 +0100
Message-ID: <2124868.AvfyTGl0GF@vostro.rjw.lan>
In-Reply-To: <1519631.YS65c9Af2C@vostro.rjw.lan>
References: <2217793.001RY6hKlo@vostro.rjw.lan> <1693151.2qrLZHyp0o@vostro.rjw.lan> <1519631.YS65c9Af2C@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To avoid the need to install a hotplug notify handler for each ACPI
namespace node representing a device and having a matching scan
handler, move the check whether or not the ejection of the given
device is enabled through its scan handler from acpi_hotplug_notify_cb()
to acpi_generic_hotplug_event().  Also, move the execution of
ACPI_OST_SC_EJECT_IN_PROGRESS _OST to acpi_generic_hotplug_event(),
because in acpi_hotplug_notify_cb() or in acpi_eject_store() we really
don't know whether or not the eject is going to be in progress (for
example, acpi_hotplug_execute() may still fail without queuing up the
work item).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -461,6 +461,12 @@ static int acpi_generic_hotplug_event(st
 		return acpi_scan_device_check(adev);
 	case ACPI_NOTIFY_EJECT_REQUEST:
 	case ACPI_OST_EC_OSPM_EJECT:
+		if (adev->handler && !adev->handler->hotplug.enabled) {
+			dev_info(&adev->dev, "Eject disabled\n");
+			return -EPERM;
+		}
+		acpi_evaluate_hotplug_ost(adev->handle, ACPI_NOTIFY_EJECT_REQUEST,
+					  ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
 		return acpi_scan_hot_remove(adev);
 	}
 	return -EINVAL;
@@ -485,6 +491,10 @@ static void acpi_device_hotplug(void *da
 
 	if (adev->handler) {
 		error = acpi_generic_hotplug_event(adev, src);
+		if (error == -EPERM) {
+			ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
+			goto err_out;
+		}
 	} else {
 		int (*event)(struct acpi_device *, u32);
 
@@ -514,7 +524,6 @@ static void acpi_device_hotplug(void *da
 
 static void acpi_hotplug_notify_cb(acpi_handle handle, u32 type, void *data)
 {
-	struct acpi_scan_handler *handler = data;
 	u32 ost_code = ACPI_OST_SC_SUCCESS;
 	struct acpi_device *adev;
 	acpi_status status;
@@ -530,13 +539,6 @@ static void acpi_hotplug_notify_cb(acpi_
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		acpi_handle_debug(handle, "ACPI_NOTIFY_EJECT_REQUEST event\n");
-		if (handler && !handler->hotplug.enabled) {
-			acpi_handle_err(handle, "Eject disabled\n");
-			ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
-			goto out;
-		}
-		acpi_evaluate_hotplug_ost(handle, ACPI_NOTIFY_EJECT_REQUEST,
-					  ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_WAKE:
@@ -637,8 +639,6 @@ acpi_eject_store(struct device *d, struc
 	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
 		return -ENODEV;
 
-	acpi_evaluate_hotplug_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
-				  ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
 	get_device(&acpi_device->dev);
 	status = acpi_hotplug_execute(acpi_device_hotplug, acpi_device,
 				      ACPI_OST_EC_OSPM_EJECT);

