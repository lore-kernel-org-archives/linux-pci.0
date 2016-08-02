Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
To: bhelgaas@google.com, paulus@samba.org, mpe@ellerman.id.au,
	sbranden@broadcom.com, m.chehab@samsung.com, pawel@osciak.com,
	m.szyprowski@samsung.com, kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	brutallesale@gmail.com, geliangtang@163.com,
	chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0825/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:50:05 +0800
Message-Id: <20160802115005.4977-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/pci/hotplug/shpchp_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 3454dc7..ca7563a 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -48,9 +48,9 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(shpchp_debug, bool, 0644);
-module_param(shpchp_poll_mode, bool, 0644);
-module_param(shpchp_poll_time, int, 0644);
+module_param(shpchp_debug, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param(shpchp_poll_mode, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param(shpchp_poll_time, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(shpchp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(shpchp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(shpchp_poll_time, "Polling mechanism frequency, in seconds");
-- 
2.9.2
