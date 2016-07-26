Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org,
	tglx@linutronix.de,
	rjw@rjwysocki.net,
	tony.luck@intel.com
Cc: bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: [PATCH 4/4] x86/ioapic: Fix ioapic failing to request resource
Date: Wed, 27 Jul 2016 00:13:17 +0800
Message-Id: <1469549597-19253-5-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
References: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

handle_ioapic_add() uses request_resource() to request ACPI "_CRS"
resources. This can fail with the following error message:

[  247.325693] ACPI: \_SB_.IIO1.AID1: failed to insert resource

This happens when there are multiple ioapics and DSDT groups their
"_CRS" resources as the children of a parent resource, as seen from
/proc/iomem:

fec00000-fecfffff : PNP0003:00
  fec00000-fec003ff : IOAPIC 0
  fec01000-fec013ff : IOAPIC 1
  fec40000-fec403ff : IOAPIC 2

In this case request_resource() fails because there's a conflicting
resource which is the parent (fec0000-fecfffff). Fix it by using
insert_resoure() which can request resources by taking the conflicting
resource as the parent.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 drivers/acpi/ioapic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 80b0b1a..2c38ce0 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -146,10 +146,12 @@ static acpi_status handle_ioapic_add(acpi_handle handle, u32 lvl,
 
 	crs_res = &ioapic->res;
 	acpi_walk_resources(handle, METHOD_NAME__CRS, setup_res, crs_res);
+	crs_res->name = type;
+	crs_res->flags |= IORESOURCE_BUSY;
 	if (crs_res->flags == 0) {
 		acpi_handle_warn(handle, "failed to get resource\n");
 		goto exit_release;
-	} else if (request_resource(&iomem_resource, crs_res)) {
+	} else if (insert_resource(&iomem_resource, crs_res)) {
 		acpi_handle_warn(handle, "failed to insert resource\n");
 		goto exit_release;
 	}
-- 
1.8.3.1
