Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42242 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934789AbcHBMc7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Aug 2016 08:32:59 -0400
From: Baole Ni <baolex.ni@intel.com>
To: bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
	m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com,
	kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	brutallesale@gmail.com, chuansheng.liu@intel.com,
	baolex.ni@intel.com
Subject: [PATCH 0822/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:49:48 +0800
Message-Id: <20160802114948.4775-1-baolex.ni@intel.com>
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
 drivers/pci/hotplug/pciehp_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ac531e6..9e6af11 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -51,10 +51,10 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(pciehp_debug, bool, 0644);
-module_param(pciehp_poll_mode, bool, 0644);
-module_param(pciehp_poll_time, int, 0644);
-module_param(pciehp_force, bool, 0644);
+module_param(pciehp_debug, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param(pciehp_poll_mode, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param(pciehp_poll_time, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param(pciehp_force, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
-- 
2.9.2

