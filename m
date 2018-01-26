Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 1/5] ACPI: export acpi_bus_get_status_handle()
Date: Fri, 26 Jan 2018 16:02:56 +0100
Message-Id: <20180126150300.9691-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some modular drivers need this, export it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set

Changes in v3:
-Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
---
 drivers/acpi/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4d0979e02a28..d44d2c287b91 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -108,6 +108,7 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 	}
 	return status;
 }
+EXPORT_SYMBOL_GPL(acpi_bus_get_status_handle);
 
 int acpi_bus_get_status(struct acpi_device *device)
 {
-- 
2.14.3

