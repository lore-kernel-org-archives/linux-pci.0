Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
To: bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
	m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com,
	kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	brutallesale@gmail.com, geliangtang@163.com,
	chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0823/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:49:54 +0800
Message-Id: <20160802114954.4843-1-baolex.ni@intel.com>
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
 drivers/pci/hotplug/pcihp_skeleton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pcihp_skeleton.c b/drivers/pci/hotplug/pcihp_skeleton.c
index 172ed89..3c23f01 100644
--- a/drivers/pci/hotplug/pcihp_skeleton.c
+++ b/drivers/pci/hotplug/pcihp_skeleton.c
@@ -69,7 +69,7 @@ static int num_slots;
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-module_param(debug, bool, 0644);
+module_param(debug, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
 static int enable_slot(struct hotplug_slot *slot);
-- 
2.9.2
