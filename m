Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60748 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758457Ab2CWPCf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2012 11:02:35 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 08/11] PCI: Introduce recursive mutex to serialize PCI hotplug operations
Date: Fri, 23 Mar 2012 22:58:24 +0800
Message-Id: <1332514707-9673-9-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are multiple entrances to trigger PCI hotplug operations:
1. Sysfs interface exported by PCI subsystem
2. PCI hotplug event triggered by PCI Hotplug Controller
3. ACPI hotplug event for PCI host bridge
4. Driver attach/detach event, such as pci_root driver

Currently pci_remove_rescan_mutex only serializes hotplug operations
triggered by method 1. This patch abstracts pci_remove_rescan_mutex
as pci_lock_hotplug()/pci_unlock_hotplug(), so it could be used to
serialize all PCI hotplug operations triggered by all methods above.
pci_lock_hotplug()/pci_unlock_hotplug() supports recursive lock.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug.c   |   26 ++++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c |   29 ++++++++++++++---------------
 include/linux/pci.h     |    4 ++++
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
index df98119..dc4d561 100644
--- a/drivers/pci/hotplug.c
+++ b/drivers/pci/hotplug.c
@@ -4,8 +4,34 @@
 #include <linux/notifier.h>
 #include "pci.h"
 
+/* Recursive mutex for PCI hotplug operations. */
+static DEFINE_MUTEX(pci_hotplug_mutex);
+static struct task_struct *pci_hotplug_mutex_owner;
+static int pci_hotplug_mutex_recursive;
+
 static BLOCKING_NOTIFIER_HEAD(pci_hotplug_notify_chain);
 
+void pci_lock_hotplug(void)
+{
+	if (current != pci_hotplug_mutex_owner) {
+		mutex_lock(&pci_hotplug_mutex);
+		pci_hotplug_mutex_owner = current;
+	}
+	pci_hotplug_mutex_recursive++;
+
+}
+EXPORT_SYMBOL(pci_lock_hotplug);
+
+void pci_unlock_hotplug(void)
+{
+	BUG_ON(pci_hotplug_mutex_owner != current);
+	if (--pci_hotplug_mutex_recursive == 0) {
+		pci_hotplug_mutex_owner = NULL;
+		mutex_unlock(&pci_hotplug_mutex);
+	}
+}
+EXPORT_SYMBOL(pci_unlock_hotplug);
+
 int pci_register_hotplug_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&pci_hotplug_notify_chain, nb);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c348048..bb97e8b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -283,7 +283,6 @@ msi_bus_store(struct device *dev, struct device_attribute *attr,
 }
 
 #ifdef CONFIG_HOTPLUG
-static DEFINE_MUTEX(pci_remove_rescan_mutex);
 static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 				size_t count)
 {
@@ -294,10 +293,10 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 		return -EINVAL;
 
 	if (val) {
-		mutex_lock(&pci_remove_rescan_mutex);
+		pci_lock_hotplug();
 		while ((b = pci_find_next_bus(b)) != NULL)
 			pci_rescan_bus(b);
-		mutex_unlock(&pci_remove_rescan_mutex);
+		pci_unlock_hotplug();
 	}
 	return count;
 }
@@ -313,9 +312,9 @@ static ssize_t bus_rescan_root_store(struct bus_type *bus, const char *buf,
 		return -EINVAL;
 
 	if (val) {
-		mutex_lock(&pci_remove_rescan_mutex);
+		pci_lock_hotplug();
 		arch_pci_root_rescan();
-		mutex_unlock(&pci_remove_rescan_mutex);
+		pci_unlock_hotplug();
 	}
 	return count;
 }
@@ -340,9 +339,9 @@ dev_rescan_store(struct device *dev, struct device_attribute *attr,
 		printk(KERN_WARNING "rescan with pci device will be removed "
 			 "shortly, please use bridge rescan_bridge\n"
 			 "or bus/rescan instead\n");
-		mutex_lock(&pci_remove_rescan_mutex);
+		pci_lock_hotplug();
 		pci_rescan_bus(pdev->bus);
-		mutex_unlock(&pci_remove_rescan_mutex);
+		pci_unlock_hotplug();
 	}
 	return count;
 }
@@ -351,9 +350,9 @@ static void bridge_rescan_callback(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	mutex_lock(&pci_remove_rescan_mutex);
+	pci_lock_hotplug();
 	pci_rescan_bus_bridge_resize(pdev);
-	mutex_unlock(&pci_remove_rescan_mutex);
+	pci_unlock_hotplug();
 }
 
 static ssize_t
@@ -382,9 +381,9 @@ static void remove_callback(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	mutex_lock(&pci_remove_rescan_mutex);
+	pci_lock_hotplug();
 	pci_stop_and_remove_bus_device(pdev);
-	mutex_unlock(&pci_remove_rescan_mutex);
+	pci_unlock_hotplug();
 }
 
 static ssize_t
@@ -414,9 +413,9 @@ static void bus_remove_callback(struct device *dev)
 {
 	struct pci_bus *bus = to_pci_bus(dev);
 
-	mutex_lock(&pci_remove_rescan_mutex);
+	pci_lock_hotplug();
 	pci_stop_and_remove_bus(bus);
-	mutex_unlock(&pci_remove_rescan_mutex);
+	pci_unlock_hotplug();
 }
 static ssize_t
 dev_bus_remove_store(struct device *dev, struct device_attribute *attr,
@@ -443,9 +442,9 @@ static void bus_rescan_callback(struct device *dev)
 {
 	struct pci_bus *bus = to_pci_bus(dev);
 
-	mutex_lock(&pci_remove_rescan_mutex);
+	pci_lock_hotplug();
 	pci_rescan_bus(bus);
-	mutex_unlock(&pci_remove_rescan_mutex);
+	pci_unlock_hotplug();
 }
 static ssize_t
 dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 953e0ef..8fa3ed5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -941,9 +941,13 @@ enum {
 };
 
 #ifdef CONFIG_HOTPLUG
+extern void pci_lock_hotplug(void);
+extern void pci_unlock_hotplug(void);
 extern int pci_register_hotplug_notifier(struct notifier_block *nb);
 extern void pci_unregister_hotplug_notifier(struct notifier_block *nb);
 #else
+static inline void pci_lock_hotplug(void) {}
+static inline  void pci_unlock_hotplug(void) {}
 static inline int pci_register_hotplug_notifier(struct notifier_block *nb)
 {
 	return 0;
-- 
1.7.5.4

