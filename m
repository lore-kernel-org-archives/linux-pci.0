Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 2/5] PCI: acpiphp_ibm: prepare for acpi_get_object_info() no longer returning status
Date: Fri, 26 Jan 2018 16:02:57 +0100
Message-Id: <20180126150300.9691-2-hdegoede@redhat.com>
In-Reply-To: <20180126150300.9691-1-hdegoede@redhat.com>
References: <20180126150300.9691-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

acpi_get_object_info() is intended for early probe usage and as such should
not call any methods which may rely on OpRegions, but it used to also call
_STA to get the status, which on some systems does rely on OpRegions, this
behavior and the acpi_device_info.current_status member are being removed.

This commit prepares the acpiphp_ibm code for this by having it get the
status itself using acpi_bus_get_status_handle(). Note no error handling is
necessary on any errors acpi_bus_get_status_handle() leaves the value of
the passed in current_status at its 0 initialization value.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use () after function names in commit message
-Add  Bjorn's Acked-by
---
 drivers/pci/hotplug/acpiphp_ibm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 984c7e8cec5a..8472c4a27f70 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -399,6 +399,7 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
 		u32 lvl, void *context, void **rv)
 {
 	acpi_handle *phandle = (acpi_handle *)context;
+	unsigned long long current_status = 0;
 	acpi_status status;
 	struct acpi_device_info *info;
 	int retval = 0;
@@ -410,7 +411,9 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
 		return retval;
 	}
 
-	if (info->current_status && (info->valid & ACPI_VALID_HID) &&
+	acpi_bus_get_status_handle(handle, &current_status);
+
+	if (current_status && (info->valid & ACPI_VALID_HID) &&
 			(!strcmp(info->hardware_id.string, IBM_HARDWARE_ID1) ||
 			 !strcmp(info->hardware_id.string, IBM_HARDWARE_ID2))) {
 		pr_debug("found hardware: %s, handle: %p\n",
-- 
2.14.3

