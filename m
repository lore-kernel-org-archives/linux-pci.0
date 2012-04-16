Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52165 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2DPQcg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:32:36 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6539626pbc.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:32:36 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Scott Murray <scottm@somanetworks.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 04/17] PCI: serialize hotplug operations triggered by PCI hotplug sysfs interfaces
Date: Tue, 17 Apr 2012 00:28:58 +0800
Message-Id: <1334593751-5916-5-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use PCI hotplug lock to globally serialize hotplug operations triggered by
PCI hotplug sysfs interfaces.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 1572665..9bbbe3e 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -39,6 +39,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include "../pci.h"
 
@@ -121,6 +122,17 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
 		retval = -ENODEV;
 		goto exit;
 	}
+
+	/* Avoid deadlock with pci_hp_deregister() */
+	while (!pci_hotplug_try_enter()) {
+		/* Check whether the slot has been deregistered. */
+		if (list_empty(&slot->slot_list)) {
+			retval = -ENODEV;
+			goto exit_put;
+		}
+		msleep(1);
+	}
+
 	switch (power) {
 		case 0:
 			if (slot->ops->disable_slot)
@@ -136,8 +148,10 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
 			err ("Illegal value specified for power\n");
 			retval = -EINVAL;
 	}
-	module_put(slot->ops->owner);
 
+	pci_hotplug_exit();
+exit_put:
+	module_put(slot->ops->owner);
 exit:	
 	if (retval)
 		return retval;
@@ -500,7 +514,7 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
 		return -ENODEV;
 	}
 
-	list_del(&hotplug->slot_list);
+	list_del_init(&hotplug->slot_list);
 
 	slot = hotplug->pci_slot;
 	fs_remove_slot(slot);
-- 
1.7.5.4

