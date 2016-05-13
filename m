Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:42794 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbcEMLRA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:17:00 -0400
Message-Id: <a73a2e066e43e2e9d15d670be52fe920f013e5d1.1463134231.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 06/13] PCI: pciehp: Support runtime pm
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resume the port for the duration of board_added() and remove_board().
When plugging a device in, the port stays active as long as it has
active children.  When nothing is plugged in, the port may suspend since
hotplug detection continues to work during D3hot.  Thus further runtime
refs need not be acquired.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 880978b..edf8b0e 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include "../pci.h"
 #include "pciehp.h"
@@ -432,7 +433,9 @@ int pciehp_enable_slot(struct slot *p_slot)
 
 	pciehp_get_latch_status(p_slot, &getstatus);
 
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	rc = board_added(p_slot);
+	pm_runtime_put(&ctrl->pcie->port->dev);
 	if (rc)
 		pciehp_get_latch_status(p_slot, &getstatus);
 
@@ -445,6 +448,7 @@ int pciehp_enable_slot(struct slot *p_slot)
 int pciehp_disable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
+	int rc;
 	struct controller *ctrl = p_slot->ctrl;
 
 	if (!p_slot->ctrl)
@@ -459,7 +463,10 @@ int pciehp_disable_slot(struct slot *p_slot)
 		}
 	}
 
-	return remove_board(p_slot);
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
+	rc = remove_board(p_slot);
+	pm_runtime_put(&ctrl->pcie->port->dev);
+	return rc;
 }
 
 int pciehp_sysfs_enable_slot(struct slot *p_slot)
-- 
2.8.1

