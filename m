Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53906 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753411AbaA0AcW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jan 2014 19:32:22 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6/11] ACPI / hotplug / PCI: Drop acpiphp_bus_add()
Date: Mon, 27 Jan 2014 01:41:59 +0100
Message-ID: <2004943.zYTADWJ10j@vostro.rjw.lan>
In-Reply-To: <2217793.001RY6hKlo@vostro.rjw.lan>
References: <2217793.001RY6hKlo@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpiphp_bus_add() is only called from one place, so move the code out
of it into that place and drop it.  Also make that code use
func_to_acpi_device() to get the struct acpi_device pointer it needs
instead of calling acpi_bus_get_device() which may be costly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -470,20 +470,6 @@ static unsigned char acpiphp_max_busnr(s
 	return max;
 }
 
-/**
- * acpiphp_bus_add - Scan ACPI namespace subtree.
- * @handle: ACPI object handle to start the scan from.
- */
-static void acpiphp_bus_add(acpi_handle handle)
-{
-	struct acpi_device *adev = NULL;
-
-	acpi_bus_scan(handle);
-	acpi_bus_get_device(handle, &adev);
-	if (acpi_device_enumerated(adev))
-		acpi_device_set_power(adev, ACPI_STATE_D0);
-}
-
 static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
 {
 	struct acpiphp_func *func;
@@ -523,9 +509,13 @@ static int acpiphp_rescan_slot(struct ac
 {
 	struct acpiphp_func *func;
 
-	list_for_each_entry(func, &slot->funcs, sibling)
-		acpiphp_bus_add(func_to_handle(func));
+	list_for_each_entry(func, &slot->funcs, sibling) {
+		struct acpi_device *adev = func_to_acpi_device(func);
 
+		acpi_bus_scan(adev->handle);
+		if (acpi_device_enumerated(adev))
+			acpi_device_set_power(adev, ACPI_STATE_D0);
+	}
 	return pci_scan_slot(slot->bus, PCI_DEVFN(slot->device, 0));
 }
 

