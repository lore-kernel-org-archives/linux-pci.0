Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / hotplug / PCI: Use pci_device_is_present()
Date: Mon, 03 Mar 2014 01:19:25 +0100
Message-ID: <1505390.MlpMqG8COu@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the ACPI-based PCI hotplug (ACPIPHP) code use
pci_device_is_present() for checking if devices are present instead
of open coding the same thing.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of current linux-next.

Thanks!

---
 drivers/pci/hotplug/acpiphp_glue.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -668,12 +668,9 @@ static void trim_stale_devices(struct pc
 		alive = (ACPI_SUCCESS(status) && device_status_valid(sta))
 			|| acpiphp_no_hotplug(adev);
 	}
-	if (!alive) {
-		u32 v;
+	if (!alive)
+		alive = pci_device_is_present(dev);
 
-		/* Check if the device responds. */
-		alive = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &v, 0);
-	}
 	if (!alive) {
 		pci_stop_and_remove_bus_device(dev);
 		if (adev)

