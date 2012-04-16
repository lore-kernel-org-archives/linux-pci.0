Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52165 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab2DPQdN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:33:13 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6539626pbc.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:33:13 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Zink <dan.zink@compaq.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Dely Sy <dely.l.sy@intel.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 09/17] PCI: correctly flush workqueues and timer when destroy SHPC controller
Date: Tue, 17 Apr 2012 00:29:03 +0800
Message-Id: <1334593751-5916-10-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

del_timer() only deactivates a timer but doesn't wait for the handler
to finish, so use del_timer_sync() to deactivate a timer and wait for
the handler to finish in hpc_release_ctrl().

This patch also tune the workqueue flush logic to correctly flush all
work items.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/shpchp_core.c |    2 +-
 drivers/pci/hotplug/shpchp_hpc.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index aaa66be..19762b3 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -173,8 +173,8 @@ void cleanup_slots(struct controller *ctrl)
 	list_for_each_safe(tmp, next, &ctrl->slot_list) {
 		slot = list_entry(tmp, struct slot, slot_list);
 		list_del(&slot->slot_list);
-		cancel_delayed_work(&slot->work);
 		flush_workqueue(shpchp_wq);
+		cancel_delayed_work_sync(&slot->work);
 		flush_workqueue(shpchp_ordered_wq);
 		pci_hp_deregister(slot->hotplug_slot);
 	}
diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index 2bc6182..ff63887 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -593,7 +593,7 @@ static void hpc_release_ctlr(struct controller *ctrl)
 	}
 
 	if (shpchp_poll_mode)
-		del_timer(&ctrl->poll_timer);
+		del_timer_sync(&ctrl->poll_timer);
 	else {
 		free_irq(ctrl->pci_dev->irq, ctrl);
 		pci_disable_msi(ctrl->pci_dev);
-- 
1.7.5.4

