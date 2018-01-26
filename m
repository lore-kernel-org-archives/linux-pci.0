Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 4/5] ACPI / scan: Use acpi_bus_get_status for initial status of ACPI_TYPE_DEVICE devs
Date: Fri, 26 Jan 2018 16:02:59 +0100
Message-Id: <20180126150300.9691-4-hdegoede@redhat.com>
In-Reply-To: <20180126150300.9691-1-hdegoede@redhat.com>
References: <20180126150300.9691-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The acpi_get_bus_status wrapper for acpi_bus_get_status_handle has some
code to handle certain device quirks, in some cases we also need this
quirk handling for the initial _STA call.

Specifically on some devices calling _STA before all _DEP dependencies
are met results in errors like these:

[    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
               [GenericSerialBus] (20170831/evregion-166)
[    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
               (20170831/exfldio-299)
[    0.123618] ACPI Error: Method parse/execution failed
               \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)

acpi_get_bus_status already has code to avoid this, so by using it we
also silence these errors from the initial _STA call.

Note that in order for the acpi_get_bus_status handling for this to work,
we initialize dep_unmet to 1 until acpi_device_dep_initialize gets called,
this means that battery devices will be instantiated with an initial
status of 0. This is not a problem, acpi_bus_attach will get called soon
after the instantiation anyways and it will update the status as first
point of order.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note if we were to:
1) move the acpi_bus_init_power call from acpi_bus_get_power_flags to
   acpi_bus_attach, which already calls acpi_bus_init_power for uninitialized
   devices; and
2) move the acpi_bus_get_wakeup_device_flags call from acpi_add_single_object
   to acpi_bus_attach. This one is tricky, because acpi_device_add checks
   wakeup.flags.valid which gets set by this. And the acpi_wakeup_gpe_init
   call actually is the troublesome one because it uses acpi_match_device_ids
   which relies on the status...

Then we can entirely rely on the acpi_bus_get_status call in acpi_bus_attach
and remove the acpi_bus_get_status call from the device-instantiation path.
---
 drivers/acpi/scan.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b0fe5272c76a..4c1b90e91271 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1565,6 +1565,8 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
+	/* Assume there are unmet deps until acpi_device_dep_initialize runs */
+	device->dep_unmet = 1;
 }
 
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1588,6 +1590,14 @@ static int acpi_add_single_object(struct acpi_device **child,
 	}
 
 	acpi_init_device_object(device, handle, type, sta);
+	/*
+	 * For ACPI_BUS_TYPE_DEVICE getting the status is delayed till here so
+	 * that we can call acpi_bus_get_status and use its quirk handling.
+	 * Note this must be done before the get power-/wakeup_dev-flags calls.
+	 */
+	if (type == ACPI_BUS_TYPE_DEVICE)
+		acpi_bus_get_status(device);
+
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
 
@@ -1660,9 +1670,11 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 			return -ENODEV;
 
 		*type = ACPI_BUS_TYPE_DEVICE;
-		status = acpi_bus_get_status_handle(handle, sta);
-		if (ACPI_FAILURE(status))
-			*sta = 0;
+		/*
+		 * acpi_add_single_object updates this once we've an acpi_device
+		 * so that acpi_bus_get_status' quirk handling can be used.
+		 */
+		*sta = 0;
 		break;
 	case ACPI_TYPE_PROCESSOR:
 		*type = ACPI_BUS_TYPE_PROCESSOR;
@@ -1760,6 +1772,8 @@ static void acpi_device_dep_initialize(struct acpi_device *adev)
 	acpi_status status;
 	int i;
 
+	adev->dep_unmet = 0;
+
 	if (!acpi_has_method(adev->handle, "_DEP"))
 		return;
 
-- 
2.14.3

