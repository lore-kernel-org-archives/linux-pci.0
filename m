Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 05/11] PCI: Add notification interfaces for PCI root/bus/device hotplug events
Date: Fri, 23 Mar 2012 22:58:21 +0800
Message-Id: <1332514707-9673-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When PCI root/bus/device hotplug event happens, some other components
may need to get notified in order to update their states.  For example,
the ACPI<->PCI bind logic in drivers/acpi/pci_bind.c needs to update the
binding relationship when PCI hotplug event happens. Another example is,
the PCIe AER driver needs to setup the AER configuration for newly added
PCI devices. So introduce a blocking notify chain for PCI hotplug events.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/bus.c     |    5 +++-
 drivers/pci/hotplug.c |   21 ++++++++++++++++++++
 drivers/pci/pci.h     |    8 +++++++
 drivers/pci/probe.c   |   10 ++++++++-
 drivers/pci/remove.c  |   20 ++++++++++++++----
 include/linux/pci.h   |   51 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 2803120..61b8603 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -188,6 +188,8 @@ int pci_bus_add_device(struct pci_dev *dev)
 	dev->is_added = 1;
 	pci_proc_attach_device(dev);
 	pci_create_sysfs_dev_files(dev);
+	pci_call_hotplug_notifier(PCI_HP_EVENT_DEV_START, dev);
+
 	return 0;
 }
 
@@ -212,8 +214,9 @@ int pci_bus_add_child(struct pci_bus *bus)
 
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(bus);
+	pci_call_hotplug_notifier(PCI_HP_EVENT_BUS_START, bus);
 
-	return retval;
+	return 0;
 }
 
 /**
diff --git a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
index 2b5352a..df98119 100644
--- a/drivers/pci/hotplug.c
+++ b/drivers/pci/hotplug.c
@@ -1,8 +1,29 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include "pci.h"
 
+static BLOCKING_NOTIFIER_HEAD(pci_hotplug_notify_chain);
+
+int pci_register_hotplug_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&pci_hotplug_notify_chain, nb);
+}
+EXPORT_SYMBOL(pci_register_hotplug_notifier);
+
+void pci_unregister_hotplug_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&pci_hotplug_notify_chain, nb);
+}
+EXPORT_SYMBOL(pci_unregister_hotplug_notifier);
+
+int pci_call_hotplug_notifier(int event, void *data)
+{
+	return blocking_notifier_call_chain(&pci_hotplug_notify_chain,
+		event, data);
+}
+
 int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct pci_dev *pdev;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9378d81..f0f9252 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -126,6 +126,14 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 /* Functions for PCI Hotplug drivers to use */
 int pci_hp_add_bridge(struct pci_dev *dev);
 extern unsigned int pci_do_scan_bus(struct pci_bus *bus);
+#ifdef	CONFIG_HOTPLUG
+extern int pci_call_hotplug_notifier(int event, void *data);
+#else
+static inline int pci_call_hotplug_notifier(int event, void *data)
+{
+	return NOTIFY_DONE;
+}
+#endif
 
 #ifdef HAVE_PCI_LEGACY
 extern void pci_create_legacy_files(struct pci_bus *bus);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d626c4e..edbc013 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -651,6 +651,7 @@ struct pci_bus *__ref pci_add_new_bus(struct pci_bus *parent, struct pci_dev *de
 		down_write(&pci_bus_sem);
 		list_add_tail(&child->node, &parent->children);
 		up_write(&pci_bus_sem);
+		pci_call_hotplug_notifier(PCI_HP_EVENT_BUS_ADD, child);
 	}
 	return child;
 }
@@ -1472,6 +1473,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	down_write(&pci_bus_sem);
 	list_add_tail(&dev->bus_list, &bus->devices);
 	up_write(&pci_bus_sem);
+
+	pci_call_hotplug_notifier(PCI_HP_EVENT_DEV_ADD, dev);
 }
 
 struct pci_dev *__ref pci_scan_single_device(struct pci_bus *bus, int devfn)
@@ -1753,8 +1756,10 @@ static unsigned int __devinit __pci_scan_child_bus(struct pci_bus *bus,
 	if (!bus->is_added) {
 		dev_dbg(&bus->dev, "fixups for bus pass %d\n", pass);
 		pcibios_fixup_bus(bus);
-		if (pci_is_root_bus(bus))
+		if (pci_is_root_bus(bus)) {
 			bus->is_added = 1;
+			pci_call_hotplug_notifier(PCI_HP_EVENT_BUS_START, bus);
+		}
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
@@ -1876,6 +1881,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	list_add_tail(&b->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
 
+	pci_call_hotplug_notifier(PCI_HP_EVENT_ROOT_ADD, bridge);
+	pci_call_hotplug_notifier(PCI_HP_EVENT_BUS_ADD, b);
+
 	return b;
 
 class_dev_reg_err:
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 18efb31..2b6dd97 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -20,6 +20,7 @@ static void pci_free_resources(struct pci_dev *dev)
 static void pci_stop_dev(struct pci_dev *dev)
 {
 	if (dev->is_added) {
+		pci_call_hotplug_notifier(PCI_HP_EVENT_DEV_STOP, dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
 		device_unregister(&dev->dev);
@@ -32,6 +33,8 @@ static void pci_stop_dev(struct pci_dev *dev)
 
 static void pci_destroy_dev(struct pci_dev *dev)
 {
+	pci_call_hotplug_notifier(PCI_HP_EVENT_DEV_REMOVE, dev);
+
 	/* Remove the device from the device lists, and prevent any further
 	 * list accesses from this device */
 	down_write(&pci_bus_sem);
@@ -64,16 +67,21 @@ int pci_remove_device_safe(struct pci_dev *dev)
 
 void pci_remove_bus(struct pci_bus *pci_bus)
 {
-	pci_proc_detach_bus(pci_bus);
+	if (pci_bus->is_added)
+		pci_call_hotplug_notifier(PCI_HP_EVENT_BUS_STOP, pci_bus);
 
-	down_write(&pci_bus_sem);
-	list_del(&pci_bus->node);
-	pci_bus_release_busn_res(pci_bus);
-	up_write(&pci_bus_sem);
 	if (pci_bus->is_added || pci_is_root_bus(pci_bus)) {
 		pci_remove_legacy_files(pci_bus);
 		device_unregister(&pci_bus->dev);
+		pci_bus->is_added = 0;
 	}
+
+	pci_call_hotplug_notifier(PCI_HP_EVENT_BUS_REMOVE, pci_bus);
+	pci_proc_detach_bus(pci_bus);
+	down_write(&pci_bus_sem);
+	list_del(&pci_bus->node);
+	pci_bus_release_busn_res(pci_bus);
+	up_write(&pci_bus_sem);
 }
 EXPORT_SYMBOL(pci_remove_bus);
 
@@ -171,8 +179,10 @@ void pci_stop_bus_device(struct pci_dev *dev)
 
 static void pci_stop_host_bridge(struct pci_host_bridge *bridge)
 {
+	pci_call_hotplug_notifier(PCI_HP_EVENT_ROOT_REMOVE, bridge);
 	device_unregister(&bridge->dev);
 }
+
 /*
  * it will support pci root bus too, in that case we need
  *  stop and remove host bridge
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 427ea42..953e0ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -53,6 +53,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/irqreturn.h>
+#include <linux/notifier.h>
 
 /* Include the ID list */
 #include <linux/pci_ids.h>
@@ -903,6 +904,56 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 #endif
 
+/*
+ * Notification event types for PCI root, bus and device hotplug.
+ */
+enum {
+	PCI_HP_EVENT_BUS_ADD = 0x1,	/* New bus (struct pci_bus *)v has
+					 * been created.
+					 */
+	PCI_HP_EVENT_BUS_REMOVE = 0x2,	/* Bus (struct pci_bus *)v will be
+					 * destroyed.
+					 */
+	PCI_HP_EVENT_BUS_START = 0x3,	/* Bus (struct pci_bus *)v has been
+					 * started.
+					 */
+	PCI_HP_EVENT_BUS_STOP = 0x4,	/* Bus (struct pci_bus *)v will be
+					 * stopped.
+					 */
+	PCI_HP_EVENT_DEV_ADD = 0x11,	/* New device (struct pci_dev *)v has
+					 * been created.
+					 */
+	PCI_HP_EVENT_DEV_REMOVE = 0x12,	/* Device (struct pci_dev *)v will be
+					 * destroyed.
+					 */
+	PCI_HP_EVENT_DEV_START = 0x13,	/* Device (struct pci_dev *)v has been
+					 * started.
+					 */
+	PCI_HP_EVENT_DEV_STOP = 0x14,	/* Device (struct pci_dev *)v will be
+					 * stopped.
+					 */
+	PCI_HP_EVENT_ROOT_ADD = 0x21,	/* Root (struct pci_host_bridge *)v
+					 * has been created.
+					 */
+	PCI_HP_EVENT_ROOT_REMOVE = 0x22,/* Root (struct pci_host_bridge *)v
+					 * will be destroyed.
+					 */
+};
+
+#ifdef CONFIG_HOTPLUG
+extern int pci_register_hotplug_notifier(struct notifier_block *nb);
+extern void pci_unregister_hotplug_notifier(struct notifier_block *nb);
+#else
+static inline int pci_register_hotplug_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline void pci_unregister_hotplug_notifier(struct notifier_block *nb)
+{
+}
+#endif
+
 /* Vital product data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-- 
1.7.5.4

