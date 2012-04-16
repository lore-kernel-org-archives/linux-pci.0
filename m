Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35016 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2DPQeB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:34:01 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so7133149dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:34:01 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Murray <scott@spiteful.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 16/17] PCI: serialize PCI hotplug operations triggered by cpcihp drivers
Date: Tue, 17 Apr 2012 00:29:10 +0800
Message-Id: <1334593751-5916-17-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use PCI hotplug lock to globally serialize hotplug operations triggered
by cpcihp_xxx drivers.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/cpci_hotplug_core.c |   10 ++++++++++
 drivers/pci/hotplug/cpcihp_generic.c    |    2 ++
 drivers/pci/hotplug/cpcihp_zt5550.c     |   12 ++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index 68e43c7..bbac305 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -502,6 +502,10 @@ event_thread(void *data)
 		if (kthread_should_stop())
 			break;
 		do {
+			if (!pci_hotplug_try_enter()) {
+				msleep(1);
+				continue;
+			}
 			rc = check_slots();
 			if (rc > 0) {
 				/* Give userspace a chance to handle extraction */
@@ -510,6 +514,7 @@ event_thread(void *data)
 				dbg("%s - error checking slots", __func__);
 				goto out;
 			}
+			pci_hotplug_exit();
 		} while (atomic_read(&extracting) && !kthread_should_stop());
 		if (kthread_should_stop())
 			break;
@@ -533,6 +538,10 @@ poll_thread(void *data)
 			break;
 		if (controller->ops->query_enum()) {
 			do {
+				if (!pci_hotplug_try_enter()) {
+					msleep(1);
+					continue;
+				}
 				rc = check_slots();
 				if (rc > 0) {
 					/* Give userspace a chance to handle extraction */
@@ -541,6 +550,7 @@ poll_thread(void *data)
 					dbg("%s - error checking slots", __func__);
 					goto out;
 				}
+				pci_hotplug_exit();
 			} while (atomic_read(&extracting) && !kthread_should_stop());
 		}
 		msleep(100);
diff --git a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
index f002be5..91d27d5 100644
--- a/drivers/pci/hotplug/cpcihp_generic.c
+++ b/drivers/pci/hotplug/cpcihp_generic.c
@@ -154,6 +154,7 @@ static int __init cpcihp_generic_init(void)
 	if(!r)
 		return -EBUSY;
 
+	pci_hotplug_disable();
 	bus = pci_find_bus(0, bridge_busnr);
 	if (!bus) {
 		err("Invalid bus number %d", bridge_busnr);
@@ -166,6 +167,7 @@ static int __init cpcihp_generic_init(void)
 			bus = pci_bus_get(dev->subordinate);
 		pci_dev_put(dev);
 	}
+	pci_hotplug_enable();
 	if (!bus) {
 		status = -EINVAL;
 		goto init_find_bus_error;
diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index 6606520..1f81d85 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
@@ -238,13 +238,17 @@ static int zt5550_hc_init_one (struct pci_dev *pdev, const struct pci_device_id
 	dbg("registered controller");
 
 	/* Look for first device matching cPCI bus's bridge vendor and device IDs */
-	if(!(bus0_dev = pci_get_device(PCI_VENDOR_ID_DEC,
-					 PCI_DEVICE_ID_DEC_21154, NULL))) {
+	pci_hotplug_enter();
+	bus0_dev = pci_get_device(PCI_VENDOR_ID_DEC,
+				  PCI_DEVICE_ID_DEC_21154, NULL);
+	if (bus0_dev)
+		bus0 = pci_bus_get(bus0_dev->subordinate);
+	pci_dev_put(bus0_dev);
+	pci_hotplug_exit();
+	if (!bus0) {
 		status = -ENODEV;
 		goto init_find_bus_error;
 	}
-	bus0 = pci_bus_get(bus0_dev->subordinate);
-	pci_dev_put(bus0_dev);
 
 	status = cpci_hp_register_bus(bus0, 0x0a, 0x0f);
 	if(status != 0) {
-- 
1.7.5.4

