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
Subject: [PATCH 2/4] x86/ioapic: Fix setup_res() failing to get resource
Date: Wed, 27 Jul 2016 00:13:15 +0800
Message-Id: <1469549597-19253-3-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
References: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

setup_res() doesn't actually get any resoure because it mistakenly
checks the return value of acpi_dev_filter_resource_type(), which
returns 0 on success, and 1 on failure. Fix it by taking the return
value of non-zero as failing to match the specified resource type.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 drivers/acpi/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 0f272e2..daf4a40 100644
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
