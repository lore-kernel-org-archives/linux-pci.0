Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42962 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757070Ab2CWPB7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2012 11:01:59 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 04/11] ACPI,PCI: fix race windows caused by alloc_acpi_hotplug_work()
Date: Fri, 23 Mar 2012 22:58:20 +0800
Message-Id: <1332514707-9673-5-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

alloc_acpi_hotplug_work() is used to move event handler from
kacpi_notify_wq to kacpi_hotplug_wq, so the event handler could
call acpi_remove_notify_handler() to unreigster itself, otherwise
it will deaklock. But alloc_acpi_hotplug_work() mechanism introduces
a small race window as below:
1. kacpi_notify_wq invokes the wrapper event handler, which enqueues
   the real event handler onto kacpi_hotplug_wq by calling
   alloc_acpi_hotplug_work().
2. Another thread calls acpi_remove_notify_handler() and releases
   all resources used by the real event handler.
3. kacpi_hotplug_wq invokes the real event handler, which may access
   the already released resources now.

This patch tries to close the small race window.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/acpiphp.h      |    7 ++++-
 drivers/pci/hotplug/acpiphp_glue.c |   50 +++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index 1a62e7b..ca2da17 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -37,6 +37,7 @@
 
 #include <linux/acpi.h>
 #include <linux/mutex.h>
+#include <linux/kref.h>
 #include <linux/pci_hotplug.h>
 
 #define dbg(format, arg...)					\
@@ -74,6 +75,7 @@ static inline const char *slot_name(struct slot *slot)
 struct acpiphp_bridge {
 	struct list_head list;
 	acpi_handle handle;
+	struct kref kref;
 	struct acpiphp_slot *slots;
 
 	/* Ejectable PCI-to-PCI bridge (PCI bridge and PCI function) */
@@ -124,6 +126,7 @@ struct acpiphp_func {
 	struct list_head sibling;
 	struct notifier_block nb;
 	acpi_handle	handle;
+	struct kref	kref;
 
 	u8		function;	/* pci function# */
 	u32		flags;		/* see below */
@@ -160,6 +163,7 @@ struct acpiphp_attention_info
 #define BRIDGE_HAS_PS1		(0x00000020)
 #define BRIDGE_HAS_PS2		(0x00000040)
 #define BRIDGE_HAS_PS3		(0x00000080)
+#define BRIDGE_IS_DEAD		(0x80000000)
 
 /* slot flags */
 
@@ -175,7 +179,8 @@ struct acpiphp_attention_info
 #define FUNC_HAS_PS1		(0x00000020)
 #define FUNC_HAS_PS2		(0x00000040)
 #define FUNC_HAS_PS3		(0x00000080)
-#define FUNC_HAS_DCK            (0x00000100)
+#define FUNC_HAS_DCK		(0x00000100)
+#define FUNC_IS_DEAD		(0x80000000)
 
 /* function prototypes */
 
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 003a6d5..764891e 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -115,6 +115,14 @@ static const struct acpi_dock_ops acpiphp_dock_ops = {
 	.handler = handle_hotplug_event_func,
 };
 
+static void acpiphp_release_func(struct kref *kref)
+{
+	struct acpiphp_func *func;
+
+	func = container_of(kref, struct acpiphp_func, kref);
+	kfree(func);
+}
+
 /* callback routine to register each ACPI PCI slot object */
 static acpi_status
 register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
@@ -153,6 +161,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 		return AE_NO_MEMORY;
 
 	INIT_LIST_HEAD(&newfunc->sibling);
+	kref_init(&newfunc->kref);
 	newfunc->handle = handle;
 	newfunc->function = function;
 
@@ -191,7 +200,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	if (!slot) {
 		slot = kzalloc(sizeof(struct acpiphp_slot), GFP_KERNEL);
 		if (!slot) {
-			kfree(newfunc);
+			kref_put(&newfunc->kref, acpiphp_release_func);
 			return AE_NO_MEMORY;
 		}
 
@@ -266,7 +275,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	bridge->nr_slots--;
 	bridge->slots = slot->next;
 	kfree(slot);
-	kfree(newfunc);
+	kref_put(&newfunc->kref, acpiphp_release_func);
 
 	return AE_OK;
 }
@@ -371,8 +380,16 @@ static inline void config_p2p_bridge_flags(struct acpiphp_bridge *bridge)
 	}
 }
 
+static void acpiphp_release_bridge(struct kref *kref)
+{
+	struct acpiphp_bridge *bridge;
+
+	bridge = container_of(kref, struct acpiphp_bridge, kref);
+	kfree(bridge);
+}
+
 /* allocate and initialize PCI-to-PCI bridge data structure */
-static void add_p2p_bridge(acpi_handle *handle)
+static void add_p2p_bridge(acpi_handle handle)
 {
 	struct acpiphp_bridge *bridge;
 
@@ -382,6 +399,7 @@ static void add_p2p_bridge(acpi_handle *handle)
 		return;
 	}
 
+	kref_init(&bridge->kref);
 	bridge->handle = handle;
 	config_p2p_bridge_flags(bridge);
 
@@ -403,7 +421,7 @@ static void add_p2p_bridge(acpi_handle *handle)
 	return;
  err:
 	pci_dev_put(bridge->pci_dev);
-	kfree(bridge);
+	kref_put(&bridge->kref, acpiphp_release_bridge);
 	return;
 }
 
@@ -515,7 +533,8 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
 					err("failed to remove notify handler\n");
 			}
 			list_del(&func->sibling);
-			kfree(func);
+			func->flags |= FUNC_IS_DEAD;
+			kref_put(&func->kref, acpiphp_release_func);
 		}
 		acpiphp_unregister_hotplug_slot(slot);
 		list_del(&slot->funcs);
@@ -531,7 +550,8 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
 
 	pci_dev_put(bridge->pci_dev);
 	list_del(&bridge->list);
-	kfree(bridge);
+	bridge->flags |= BRIDGE_IS_DEAD;
+	kref_put(&bridge->kref, acpiphp_release_bridge);
 }
 
 static acpi_status
@@ -1075,6 +1095,8 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 	handle = hp_work->handle;
 	type = hp_work->type;
 	bridge = (struct acpiphp_bridge *)hp_work->context;
+	if (bridge->flags & BRIDGE_IS_DEAD)
+		goto out;
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -1133,6 +1155,8 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 		break;
 	}
 
+out:
+	kref_put(&bridge->kref, acpiphp_release_bridge);
 	kfree(hp_work); /* allocated in handle_hotplug_event_bridge */
 }
 
@@ -1147,6 +1171,11 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 static void handle_hotplug_event_bridge(acpi_handle handle, u32 type,
 					void *context)
 {
+	struct acpiphp_bridge *bridge = (struct acpiphp_bridge *)context;
+
+	/* Will be released by _handle_hotplug_event_bridge() */
+	kref_get(&bridge->kref);
+
 	/*
 	 * Currently the code adds all hotplug events to the kacpid_wq
 	 * queue when it should add hotplug events to the kacpi_hotplug_wq.
@@ -1172,6 +1201,8 @@ static void _handle_hotplug_event_func(struct work_struct *work)
 	handle = hp_work->handle;
 	type = hp_work->type;
 	func = (struct acpiphp_func *)hp_work->context;
+	if (func->flags & FUNC_IS_DEAD)
+		goto out;
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -1205,6 +1236,8 @@ static void _handle_hotplug_event_func(struct work_struct *work)
 		break;
 	}
 
+out:
+	kref_put(&func->kref, acpiphp_release_func);
 	kfree(hp_work); /* allocated in handle_hotplug_event_func */
 }
 
@@ -1219,6 +1252,11 @@ static void _handle_hotplug_event_func(struct work_struct *work)
 static void handle_hotplug_event_func(acpi_handle handle, u32 type,
 				      void *context)
 {
+	struct acpiphp_func *func = (struct acpiphp_func *)context;
+
+	/* Will be released by _handle_hotplug_event_func() */
+	kref_get(&func->kref);
+
 	/*
 	 * Currently the code adds all hotplug events to the kacpid_wq
 	 * queue when it should add hotplug events to the kacpi_hotplug_wq.
-- 
1.7.5.4

