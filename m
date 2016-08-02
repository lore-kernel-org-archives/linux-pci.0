Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64879 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934920AbcHBM1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Aug 2016 08:27:22 -0400
From: Baole Ni <baolex.ni@intel.com>
To: bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
	m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com,
	kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	brutallesale@gmail.com, chuansheng.liu@intel.com,
	baolex.ni@intel.com
Subject: [PATCH 0820/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:49:34 +0800
Message-Id: <20160802114934.4637-1-baolex.ni@intel.com>
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
 drivers/pci/hotplug/cpqphp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 74f3a06..3f3abe0 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -69,10 +69,10 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(power_mode, bool, 0644);
+module_param(power_mode, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(power_mode, "Power mode enabled or not");
 
-module_param(debug, bool, 0644);
+module_param(debug, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
 #define CPQHPC_MODULE_MINOR 208
-- 
2.9.2

