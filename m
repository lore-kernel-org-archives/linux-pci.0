Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53336 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754767AbaBBASU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Feb 2014 19:18:20 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 7/13] ACPI / hotplug / PCI: Rework acpiphp_no_hotplug()
Date: Sun, 02 Feb 2014 01:27:01 +0100
Message-ID: <2034807.s7QjzIy0FK@vostro.rjw.lan>
In-Reply-To: <1935791.liE9ZlzmO9@vostro.rjw.lan>
References: <2217793.001RY6hKlo@vostro.rjw.lan> <1935791.liE9ZlzmO9@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a struct acpi_device pointer is passed to acpiphp_no_hotplug()
instead of an ACPI handle, the function won't need to call
acpi_bus_get_device(), which may be costly, any more.  Then,
trim_stale_devices() can call acpiphp_no_hotplug() passing
the struct acpi_device object it already has directly to that
function.

Make those changes and update slot_no_hotplug() accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -617,11 +617,8 @@ static void disable_slot(struct acpiphp_
 	slot->flags &= (~SLOT_ENABLED);
 }
 
-static bool acpiphp_no_hotplug(acpi_handle handle)
+static bool acpiphp_no_hotplug(struct acpi_device *adev)
 {
-	struct acpi_device *adev = NULL;
-
-	acpi_bus_get_device(handle, &adev);
 	return adev && adev->flags.no_hotplug;
 }
 
@@ -629,10 +626,13 @@ static bool slot_no_hotplug(struct acpip
 {
 	struct acpiphp_func *func;
 
-	list_for_each_entry(func, &slot->funcs, sibling)
-		if (acpiphp_no_hotplug(func_to_handle(func)))
-			return true;
+	list_for_each_entry(func, &slot->funcs, sibling) {
+		struct acpi_device *adev = NULL;
 
+		acpi_bus_get_device(func_to_handle(func), &adev);
+		if (acpiphp_no_hotplug(adev))
+			return true;
+	}
 	return false;
 }
 
@@ -689,13 +689,12 @@ static void trim_stale_devices(struct pc
 	bool alive = false;
 
 	if (adev) {
-		acpi_handle handle = adev->handle;
 		acpi_status status;
 		unsigned long long sta;
 
-		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+		status = acpi_evaluate_integer(adev->handle, "_STA", NULL, &sta);
 		alive = (ACPI_SUCCESS(status) && sta == ACPI_STA_ALL)
-			|| acpiphp_no_hotplug(handle);
+			|| acpiphp_no_hotplug(adev);
 	}
 	if (!alive) {
 		u32 v;

