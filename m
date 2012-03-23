Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60748 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab2CWPDG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2012 11:03:06 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 11/11] PCI: Serialize hotplug operations triggered by acpiphp driver
Date: Fri, 23 Mar 2012 22:58:27 +0800
Message-Id: <1332514707-9673-12-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

User pci_lock_hotplug()/pci_unlock_hotplug() to serialize PCI
hotplug operations triggered by acpiphp driver.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 764891e..ee820a9 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -1095,6 +1095,8 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 	handle = hp_work->handle;
 	type = hp_work->type;
 	bridge = (struct acpiphp_bridge *)hp_work->context;
+
+	pci_lock_hotplug();
 	if (bridge->flags & BRIDGE_IS_DEAD)
 		goto out;
 
@@ -1156,6 +1158,7 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 	}
 
 out:
+	pci_unlock_hotplug();
 	kref_put(&bridge->kref, acpiphp_release_bridge);
 	kfree(hp_work); /* allocated in handle_hotplug_event_bridge */
 }
@@ -1201,6 +1204,8 @@ static void _handle_hotplug_event_func(struct work_struct *work)
 	handle = hp_work->handle;
 	type = hp_work->type;
 	func = (struct acpiphp_func *)hp_work->context;
+
+	pci_lock_hotplug();
 	if (func->flags & FUNC_IS_DEAD)
 		goto out;
 
@@ -1237,6 +1242,7 @@ static void _handle_hotplug_event_func(struct work_struct *work)
 	}
 
 out:
+	pci_unlock_hotplug();
 	kref_put(&func->kref, acpiphp_release_func);
 	kfree(hp_work); /* allocated in handle_hotplug_event_func */
 }
-- 
1.7.5.4

