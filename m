Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, devel@acpica.org
Subject: [PATCH v2 3/5] ACPI / bus: Do not call _STA on battery devices with unmet dependencies
Date: Mon, 22 Jan 2018 09:51:33 +0100
Message-Id: <20180122085135.16732-4-hdegoede@redhat.com>
In-Reply-To: <20180122085135.16732-1-hdegoede@redhat.com>
References: <20180122085135.16732-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The battery code uses acpi_device->dep_unmet to check for unmet deps and
if there are unmet deps it does not bind to the device to avoid errors
about missing OpRegions when calling ACPI methods on the device.

The missing OpRegions when there are unmet deps problem also applies to
the _STA method of some battery devices and calling it too early results
in errors like these:

[    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
               [GenericSerialBus] (20170831/evregion-166)
[    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
               (20170831/exfldio-299)
[    0.123618] ACPI Error: Method parse/execution failed
               \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)

This commit fixes these errors happening when acpi_get_bus_status gets
called by checking dep_unmet for battery devices and reporting a status
of 0 until all dependencies are met.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index db0c05997cc2..d0d2c2543395 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -120,6 +120,12 @@ int acpi_bus_get_status(struct acpi_device *device)
 		return 0;
 	}
 
+	/* Battery devices must have their deps met before calling _STA */
+	if (acpi_device_is_battery(device) && device->dep_unmet) {
+		acpi_set_device_status(device, 0);
+		return 0;
+	}
+
 	status = acpi_bus_get_status_handle(device->handle, &sta);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
-- 
2.14.3

