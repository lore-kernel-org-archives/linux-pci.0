Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
To: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
	rjui@broadcom.com, sbranden@broadcom.com, m.chehab@samsung.com,
	pawel@osciak.com, m.szyprowski@samsung.com,
	kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, chuansheng.liu@intel.com,
	baolex.ni@intel.com
Subject: [PATCH 0817/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:49:18 +0800
Message-Id: <20160802114918.4433-1-baolex.ni@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/pci/hotplug/acpi_pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index a5e66df..10b6d91 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -223,5 +223,5 @@ int acpi_pci_detect_ejectable(acpi_handle handle)
 }
 EXPORT_SYMBOL_GPL(acpi_pci_detect_ejectable);
 
-module_param(debug_acpi, bool, 0644);
+module_param(debug_acpi, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug_acpi, "Debugging mode for ACPI enabled or not");
-- 
2.9.2

