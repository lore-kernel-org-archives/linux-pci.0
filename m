Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI / hotplug / ACPI: Check ignore_hotplug for all downstream devices
Date: Wed, 20 May 2015 02:14:13 +0200
Message-ID: <1499297.p2drhZLZaT@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the ignore_hotplug flag is set for a PCI device without an ACPI
companion and a bus check notification is received for an ancestor
bridge that is not the device's parent, ACPIPHP will ignore that
flag.

Namely, in that case acpiphp_check_bridge() is called for the target
bridge and if all of the devices immediately below the bridge are
still present, trim_stale_devices() will be called for each of them.
That function recursively walks the hierarchy downwards and removes
device objects corresponding to devices that don't appear to be
present any more.  Unfortunately, it only checks ignore_hotplug
for devices having ACPI companions, so it will remove the others
(if they don't respond) regardless of the ignore_hotplug value.

Fix the problem by making trim_stale_devices() take ignore_hotplug
into consideration regardless of whether or not an ACPI companion
is present for the device it has been called for.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This may fix BZ61891, but even if it doesn't, the bug is quite obvious to me.

Should be applicable since commit b440bde74f04 (PCI: Add pci_ignore_hotplug()
to ignore hotplug events for a device) which shipped in 3.17.

---
 drivers/pci/hotplug/acpiphp_glue.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -632,15 +632,14 @@ static void trim_stale_devices(struct pc
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 	struct pci_bus *bus = dev->subordinate;
-	bool alive = false;
+	bool alive = dev->ignore_hotplug;
 
 	if (adev) {
 		acpi_status status;
 		unsigned long long sta;
 
 		status = acpi_evaluate_integer(adev->handle, "_STA", NULL, &sta);
-		alive = (ACPI_SUCCESS(status) && device_status_valid(sta))
-			|| dev->ignore_hotplug;
+		alive = alive || (ACPI_SUCCESS(status) && device_status_valid(sta));
 	}
 	if (!alive)
 		alive = pci_device_is_present(dev);

