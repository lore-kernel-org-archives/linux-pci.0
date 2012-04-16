Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52165 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab2DPQcn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:32:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6539626pbc.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:32:43 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Zink <dan.zink@compaq.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Dely Sy <dely.l.sy@intel.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 05/17] PCI: correctly flush workqueue when destroy pcie hotplug controller
Date: Tue, 17 Apr 2012 00:28:59 +0800
Message-Id: <1334593751-5916-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When destroying a PCIe hotplug controller, all work items associated with
that controller should be flushed.  Function pcie_cleanup_slot() calls
cancel_delayed_work() and flush_workqueue() to achieve that.
Function flush_workqueue() will flush all work items already submitted,
but new work items submitted by those already submitted work items may
still be in live state when returning from flush_workqueue().

For the extreme case, pciehp driver may expierence following calling path:
1) pcie_isr() -> pciehp_handle_xxx() -> queue_interrupt_event()->queue_work()
2) interrupt_event_handler() -> handle_button_press_event() ->
   queue_delayed_work()
3) pciehp_queue_pushbutton_work() -> queue_work()

So enhance pcie_cleanup_slot() to correctly flush workqueue when destroying
PCIe hotplug controller.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index a960fae..98b775f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -889,8 +889,20 @@ static int pcie_init_slot(struct controller *ctrl)
 static void pcie_cleanup_slot(struct controller *ctrl)
 {
 	struct slot *slot = ctrl->slot;
-	cancel_delayed_work(&slot->work);
+
+	/*
+	 * Following workqueue flushing logic is to deal with the special
+	 * call path:
+	 * 1) pcie_isr() -> pciehp_handle_xxx() ->
+	 *    queue_interrupt_event(pciehp_wq_event)->queue_work(pciehp_wq)
+	 * 2) interrupt_event_handler() -> handle_button_press_event() ->
+	 *    queue_delayed_work(pciehp_wq)
+	 * 3) pciehp_queue_pushbutton_work() -> queue_work(pciehp_wq)
+	 */
 	flush_workqueue(pciehp_wq);
+	cancel_delayed_work_sync(&slot->work);
+	flush_workqueue(pciehp_wq);
+
 	kfree(slot);
 }
 
-- 
1.7.5.4

