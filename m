Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38744 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964865AbcHBM1J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Aug 2016 08:27:09 -0400
From: Baole Ni <baolex.ni@intel.com>
To: scott@spiteful.org, bhelgaas@google.com, rjui@broadcom.com,
	sbranden@broadcom.com, m.chehab@samsung.com, pawel@osciak.com,
	m.szyprowski@samsung.com, kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0819/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:49:28 +0800
Message-Id: <20160802114928.4566-1-baolex.ni@intel.com>
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
 drivers/pci/hotplug/cpcihp_zt5550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index 5f49c3f..d737008 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
@@ -322,7 +322,7 @@ module_exit(zt5550_exit);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-module_param(debug, bool, 0644);
+module_param(debug, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-module_param(poll, bool, 0644);
+module_param(poll, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(poll, "#ENUM polling mode enabled or not");
-- 
2.9.2

