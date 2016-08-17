Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org,
	tglx@linutronix.de,
	rjw@rjwysocki.net
Cc: tony.luck@intel.com,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com,
	x86@kernel.org
Subject: [PATCH v4 3/5] x86/ioapic: Fix setup_res() failing to get resource
Date: Wed, 17 Aug 2016 16:00:35 +0800
Message-Id: <1471420837-31003-4-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1471420837-31003-1-git-send-email-rui.y.wang@intel.com>
References: <1471420837-31003-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

acpi_dev_filter_resource_type() returns 0 on success, and 1 on failure.
A return value of zero means there's a matching resource, so we should
continue within setup_res() to get the resource.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 drivers/acpi/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 2449377..8ab6d42 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -46,7 +46,7 @@ static acpi_status setup_res(struct acpi_resource *acpi_res, void *data)
 	struct resource_win win;
 
 	res->flags = 0;
-	if (acpi_dev_filter_resource_type(acpi_res, IORESOURCE_MEM) == 0)
+	if (acpi_dev_filter_resource_type(acpi_res, IORESOURCE_MEM))
 		return AE_OK;
 
 	if (!acpi_dev_resource_memory(acpi_res, res)) {
-- 
1.8.3.1
