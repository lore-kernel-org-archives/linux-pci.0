Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933113AbeARQEM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jan 2018 11:04:12 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, devel@acpica.org
Subject: [PATCH 1/4] PCI: acpiphp_ibm: prepare for acpi_get_object_info no longer returning status
Date: Thu, 18 Jan 2018 17:03:56 +0100
Message-Id: <20180118160359.29971-2-hdegoede@redhat.com>
In-Reply-To: <20180118160359.29971-1-hdegoede@redhat.com>
References: <20180118160359.29971-1-hdegoede@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

acpi_get_object_info is intended for early probe usage and as such should
not call any methods which may rely on OpRegions, but it used to also call
_STA to get the status, which on some systems does rely on OpRegions, this
behavior and the acpi_device_info.current_status member are being removed.

This commit prepares the acpiphp_ibm code for this by having it get the
status itself using acpi_bus_get_status_handle. Note no error handling is
necessary on any errors acpi_bus_get_status_handle leaves the value of
the passed in current_status at its 0 initialization value.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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
