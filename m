Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55354 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752103AbdFSVpv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 17:45:51 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/6] ACPI / PM: Drop run_wake from struct acpi_device_wakeup_flags
Date: Mon, 19 Jun 2017 23:33:05 +0200
Message-ID: <4516672.gNkEGjz9qs@aspire.rjw.lan>
In-Reply-To: <12296383.UdE5HVtyng@aspire.rjw.lan>
References: <12296383.UdE5HVtyng@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The run_wake flag in struct acpi_device_wakeup_flags stores the
information on whether or not the device can generate wakeup
signals at run time, but in ACPI that really is equivalent to
being able to generate wakeup signals at all.

In fact, run_wake will always be set after successful executeion of
acpi_setup_gpe_for_wake(), but if that fails, the device will not be
able to use a wakeup GPE at all, so it won't be able to wake up the
systems from sleep states too.  Hence, run_wake actually means that
the device is capable of triggering wakeup and so it is equivalent
to the valid flag.

For this reason, drop run_wake from struct acpi_device_wakeup_flags
and make sure that the valid flag is only set if
acpi_setup_gpe_for_wake() has been successful.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c |    2 +-
 drivers/acpi/proc.c     |    4 ++--
 drivers/acpi/scan.c     |   23 ++++++++---------------
 drivers/pci/pci-acpi.c  |    3 +--
 include/acpi/acpi_bus.h |    1 -
 5 files changed, 12 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -835,7 +835,7 @@ static int acpi_bus_extract_wakeup_devic
 	return err;
 }
 
-static void acpi_wakeup_gpe_init(struct acpi_device *device)
+static bool acpi_wakeup_gpe_init(struct acpi_device *device)
 {
 	static const struct acpi_device_id button_device_ids[] = {
 		{"PNP0C0C", 0},
@@ -845,13 +845,11 @@ static void acpi_wakeup_gpe_init(struct
 	};
 	struct acpi_device_wakeup *wakeup = &device->wakeup;
 	acpi_status status;
-	acpi_event_status event_status;
 
 	wakeup->flags.notifier_present = 0;
 
 	/* Power button, Lid switch always enable wakeup */
 	if (!acpi_match_device_ids(device, button_device_ids)) {
-		wakeup->flags.run_wake = 1;
 		if (!acpi_match_device_ids(device, &button_device_ids[1])) {
 			/* Do not use Lid/sleep button for S5 wakeup */
 			if (wakeup->sleep_state == ACPI_STATE_S5)
@@ -859,17 +857,12 @@ static void acpi_wakeup_gpe_init(struct
 		}
 		acpi_mark_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
 		device_set_wakeup_capable(&device->dev, true);
-		return;
+		return true;
 	}
 
-	acpi_setup_gpe_for_wake(device->handle, wakeup->gpe_device,
-				wakeup->gpe_number);
-	status = acpi_get_gpe_status(wakeup->gpe_device, wakeup->gpe_number,
-				     &event_status);
-	if (ACPI_FAILURE(status))
-		return;
-
-	wakeup->flags.run_wake = !!(event_status & ACPI_EVENT_FLAG_HAS_HANDLER);
+	status = acpi_setup_gpe_for_wake(device->handle, wakeup->gpe_device,
+					 wakeup->gpe_number);
+	return ACPI_SUCCESS(status);
 }
 
 static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
@@ -887,10 +880,10 @@ static void acpi_bus_get_wakeup_device_f
 		return;
 	}
 
-	device->wakeup.flags.valid = 1;
+	device->wakeup.flags.valid = acpi_wakeup_gpe_init(device);
 	device->wakeup.prepare_count = 0;
-	acpi_wakeup_gpe_init(device);
-	/* Call _PSW/_DSW object to disable its ability to wake the sleeping
+	/*
+	 * Call _PSW/_DSW object to disable its ability to wake the sleeping
 	 * system for the ACPI device with the _PRW object.
 	 * The _PSW object is depreciated in ACPI 3.0 and is replaced by _DSW.
 	 * So it is necessary to call _DSW object first. Only when it is not
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -313,7 +313,6 @@ struct acpi_device_perf {
 /* Wakeup Management */
 struct acpi_device_wakeup_flags {
 	u8 valid:1;		/* Can successfully enable wakeup? */
-	u8 run_wake:1;		/* Run-Wake GPE devices */
 	u8 notifier_present:1;  /* Wake-up notify handler has been installed */
 	u8 enabled:1;		/* Enabled for wakeup */
 };
Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -608,7 +608,7 @@ static int acpi_pci_root_add(struct acpi
 		pcie_no_aspm();
 
 	pci_acpi_add_bus_pm_notifier(device);
-	if (device->wakeup.flags.run_wake)
+	if (device->wakeup.flags.valid)
 		device_set_run_wake(root->bus->bridge, true);
 
 	if (hotadd) {
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -778,9 +778,8 @@ static void pci_acpi_setup(struct device
 		return;
 
 	device_set_wakeup_capable(dev, true);
+	device_set_run_wake(dev, true);
 	acpi_pci_sleep_wake(pci_dev, false);
-	if (adev->wakeup.flags.run_wake)
-		device_set_run_wake(dev, true);
 }
 
 static void pci_acpi_cleanup(struct device *dev)
Index: linux-pm/drivers/acpi/proc.c
===================================================================
--- linux-pm.orig/drivers/acpi/proc.c
+++ linux-pm/drivers/acpi/proc.c
@@ -42,7 +42,7 @@ acpi_system_wakeup_device_seq_show(struc
 
 		if (!dev->physical_node_count) {
 			seq_printf(seq, "%c%-8s\n",
-				dev->wakeup.flags.run_wake ? '*' : ' ',
+				dev->wakeup.flags.valid ? '*' : ' ',
 				device_may_wakeup(&dev->dev) ?
 					"enabled" : "disabled");
 		} else {
@@ -58,7 +58,7 @@ acpi_system_wakeup_device_seq_show(struc
 					seq_printf(seq, "\t\t");
 
 				seq_printf(seq, "%c%-8s  %s:%s\n",
-					dev->wakeup.flags.run_wake ? '*' : ' ',
+					dev->wakeup.flags.valid ? '*' : ' ',
 					(device_may_wakeup(&dev->dev) ||
 					device_may_wakeup(ldev)) ?
 					"enabled" : "disabled",
