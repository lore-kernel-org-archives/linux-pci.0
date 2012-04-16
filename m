Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35016 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2DPQdr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:33:47 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so7133149dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:33:47 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Murray <scott@spiteful.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 14/17] PCI: fix race windows when shutting down cpcihp controller
Date: Tue, 17 Apr 2012 00:29:08 +0800
Message-Id: <1334593751-5916-15-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When cpci_hp_stop() is called to disabled cpcihp controller, it will disable
interrupt for that controller. But there's small window for event_thread()
to reenable the interrupt again. So stop the worker thread before disabling
the interrupt.

If check_slots() returns error, ther working thread (cpci_thread) will exit.
Later when cpci_stop_thread() or cpci_hp_intr() tries to access cpci_thread,
it may have already been destroyed. So hold a reference count to cpci_thread
to avoid invalid memory access.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/cpci_hotplug_core.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index 7898023..68e43c7 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -60,7 +60,6 @@ static atomic_t extracting;
 int cpci_debug;
 static struct cpci_hp_controller *controller;
 static struct task_struct *cpci_thread;
-static int thread_finished;
 
 static int enable_slot(struct hotplug_slot *slot);
 static int disable_slot(struct hotplug_slot *slot);
@@ -341,7 +340,8 @@ cpci_hp_intr(int irq, void *data)
 	controller->ops->disable_irq();
 
 	/* Trigger processing by the event thread */
-	wake_up_process(cpci_thread);
+	if (cpci_thread)
+		wake_up_process(cpci_thread);
 	return IRQ_HANDLED;
 }
 
@@ -508,7 +508,6 @@ event_thread(void *data)
 				msleep(500);
 			} else if (rc < 0) {
 				dbg("%s - error checking slots", __func__);
-				thread_finished = 1;
 				goto out;
 			}
 		} while (atomic_read(&extracting) && !kthread_should_stop());
@@ -540,7 +539,6 @@ poll_thread(void *data)
 					msleep(500);
 				} else if (rc < 0) {
 					dbg("%s - error checking slots", __func__);
-					thread_finished = 1;
 					goto out;
 				}
 			} while (atomic_read(&extracting) && !kthread_should_stop());
@@ -562,15 +560,24 @@ cpci_start_thread(void)
 		err("Can't start up our thread");
 		return PTR_ERR(cpci_thread);
 	}
-	thread_finished = 0;
+	get_task_struct(cpci_thread);
+
 	return 0;
 }
 
 static void
 cpci_stop_thread(void)
 {
-	kthread_stop(cpci_thread);
-	thread_finished = 1;
+	struct task_struct *tp;
+
+	if (cpci_thread) {
+		local_irq_disable();
+		tp = cpci_thread;
+		cpci_thread = NULL;
+		local_irq_enable();
+		kthread_stop(tp);
+		put_task_struct(tp);
+	}
 }
 
 int
@@ -627,8 +634,7 @@ cpci_hp_unregister_controller(struct cpci_hp_controller *old_controller)
 	int status = 0;
 
 	if (controller) {
-		if (!thread_finished)
-			cpci_stop_thread();
+		cpci_stop_thread();
 		if (controller->irq)
 			free_irq(controller->irq, controller->dev_id);
 		controller = NULL;
@@ -680,12 +686,13 @@ cpci_hp_stop(void)
 {
 	if (!controller)
 		return -ENODEV;
+	cpci_stop_thread();
 	if (controller->irq) {
 		/* Stop enum interrupt processing */
 		dbg("%s - disabling irq", __func__);
 		controller->ops->disable_irq();
+		synchronize_irq(controller->irq);
 	}
-	cpci_stop_thread();
 	return 0;
 }
 
-- 
1.7.5.4

