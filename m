Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38744 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934532AbcHBM1H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Aug 2016 08:27:07 -0400
From: Baole Ni <baolex.ni@intel.com>
To: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
	rjui@broadcom.com, sbranden@broadcom.com, m.chehab@samsung.com,
	pawel@osciak.com, m.szyprowski@samsung.com,
	kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, chuansheng.liu@intel.com,
	baolex.ni@intel.com
Subject: [PATCH 0818/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:49:23 +0800
Message-Id: <20160802114923.4500-1-baolex.ni@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/pci/hotplug/acpiphp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index 3c81fc8..66365dc 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -61,7 +61,7 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(disable, "disable acpiphp driver");
-module_param_named(disable, acpiphp_disabled, bool, 0444);
+module_param_named(disable, acpiphp_disabled, bool, S_IRUSR | S_IRGRP | S_IROTH);
 
 static int enable_slot(struct hotplug_slot *slot);
 static int disable_slot(struct hotplug_slot *slot);
-- 
2.9.2

