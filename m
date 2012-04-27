Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v2 09/19] PCI: correctly flush workqueues and timer when destroy SHPC controller
Date: Fri, 27 Apr 2012 23:16:50 +0800
Message-Id: <1335539820-11232-10-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com>
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

del_timer() only deactivates a timer but doesn't wait for the handler
to finish, so use del_timer_sync() to deactivate a timer and wait for
the handler to finish in hpc_release_ctrl().

This patch also tune the workqueue flush logic to correctly flush all
work items.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
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

