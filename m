Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52165 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab2DPQcW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:32:22 -0400
Received: by pbcun15 with SMTP id un15so6539626pbc.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:32:21 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 02/17] PCI: introduce recursive rwsem to serialize PCI hotplug operations
Date: Tue, 17 Apr 2012 00:28:56 +0800
Message-Id: <1334593751-5916-3-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are multiple ways to trigger PCI hotplug requests concurrently,
such as:
1. Sysfs interfaces exported by the PCI core subsystem
2. Sysfs interfaces exported by the PCI hotplug subsystem
3. PCI hotplug events triggered by PCI Hotplug Controllers
4. ACPI hotplug events for PCI host bridges
5. Driver binding/unbinding events

The PCI core subsystem doesn't support concurrent hotplug operations yet,
so all PCI hotplug requests should be globally serialized. This patch
introduces several new interfaces to serialize PCI hotplug operations.

pci_hotplug_try_enter(): try to acquire write lock
pci_hotplug_enter(): acquire write lock
pci_hotplug_exit(): release write lock
pci_hotplug_disable(): acquire read lock
pci_hotplug_enable(): release read lock

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug.c                  |   55 ++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pci_hotplug_core.c |    8 ++--
 include/linux/pci.h                    |   14 ++++++++
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
index 2b5352a..975bd3d 100644
--- a/drivers/pci/hotplug.c
+++ b/drivers/pci/hotplug.c
@@ -1,8 +1,63 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/rwsem.h>
 #include "pci.h"
 
+/* Recursive mutex for PCI hotplug operations. */
+static DECLARE_RWSEM(pci_hotplug_rwsem);
+static struct task_struct *pci_hotplug_mutex_owner;
+static int pci_hotplug_mutex_recursive;
+
+/*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+int pci_hotplug_try_enter(void)
+{
+	if (current != pci_hotplug_mutex_owner) {
+		if (down_write_trylock(&pci_hotplug_rwsem) == 0)
+			return 0;
+		pci_hotplug_mutex_owner = current;
+	}
+	pci_hotplug_mutex_recursive++;
+
+	return 1;
+}
+EXPORT_SYMBOL(pci_hotplug_try_enter);
+
+void pci_hotplug_enter(void)
+{
+	if (current != pci_hotplug_mutex_owner) {
+		down_write(&pci_hotplug_rwsem);
+		pci_hotplug_mutex_owner = current;
+	}
+	pci_hotplug_mutex_recursive++;
+
+}
+EXPORT_SYMBOL(pci_hotplug_enter);
+
+void pci_hotplug_exit(void)
+{
+	BUG_ON(pci_hotplug_mutex_owner != current);
+	if (--pci_hotplug_mutex_recursive == 0) {
+		pci_hotplug_mutex_owner = NULL;
+		up_write(&pci_hotplug_rwsem);
+	}
+}
+EXPORT_SYMBOL(pci_hotplug_exit);
+
+void pci_hotplug_enable(void)
+{
+	up_read(&pci_hotplug_rwsem);
+}
+EXPORT_SYMBOL(pci_hotplug_enable);
+
+void pci_hotplug_disable(void)
+{
+	down_read(&pci_hotplug_rwsem);
+}
+EXPORT_SYMBOL(pci_hotplug_disable);
+
 int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct pci_dev *pdev;
diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 202f4a9..1572665 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -537,7 +537,7 @@ int __must_check pci_hp_change_slot_info(struct hotplug_slot *hotplug,
 	return 0;
 }
 
-static int __init pci_hotplug_init (void)
+static int __init pci_hp_init(void)
 {
 	int result;
 
@@ -553,13 +553,13 @@ err_cpci:
 	return result;
 }
 
-static void __exit pci_hotplug_exit (void)
+static void __exit pci_hp_exit(void)
 {
 	cpci_hotplug_exit();
 }
 
-module_init(pci_hotplug_init);
-module_exit(pci_hotplug_exit);
+module_init(pci_hp_init);
+module_exit(pci_hp_exit);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0603a60..1c5f153 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -884,6 +884,20 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 #endif
 
+#ifdef CONFIG_HOTPLUG
+extern int pci_hotplug_try_enter(void);
+extern void pci_hotplug_enter(void);
+extern void pci_hotplug_exit(void);
+extern void pci_hotplug_disable(void);
+extern void pci_hotplug_enable(void);
+#else
+static inline int pci_hotplug_try_enter(void) { return 1; }
+static inline void pci_hotplug_enter(void) {}
+static inline void pci_hotplug_exit(void) {}
+static inline void pci_hotplug_enable(void) {}
+static inline void pci_hotplug_disable(void) {}
+#endif
+
 /* Vital product data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-- 
1.7.5.4

