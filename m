Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:32044 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930Ab1LGIx4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 03:53:56 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/5] PCI: Make rescan bus could increase bridge resource size if needed
Date: Wed,  7 Dec 2011 00:53:03 -0800
Message-Id: <1323247984-15281-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current rescan will not touch bridge MMIO and IO.

Try to reuse pci_assign_unassigned_bridge_resources(bridge) to update bridge
resource, if child devices need more resource.

only do that for bridges that all children get removed before. So do not
release resources that could already be used by drivers of child devices.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/pci-sysfs.c |    5 ++++-
 drivers/pci/probe.c     |   24 ++++++++++++++++++++++++
 include/linux/pci.h     |    1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci-sysfs.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-sysfs.c
+++ linux-2.6/drivers/pci/pci-sysfs.c
@@ -366,7 +366,10 @@ dev_bus_rescan_store(struct device *dev,
 
 	if (val) {
 		mutex_lock(&pci_remove_rescan_mutex);
-		pci_rescan_bus(bus);
+		if (!pci_is_root_bus(bus) && list_empty(&bus->devices))
+			pci_rescan_bus_bridge_resize(bus->self);
+		else
+			pci_rescan_bus(bus);
 		mutex_unlock(&pci_remove_rescan_mutex);
 	}
 	return count;
Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -1661,6 +1661,30 @@ struct pci_bus * __devinit pci_scan_bus(
 
 #ifdef CONFIG_HOTPLUG
 /**
+ * pci_rescan_bus_bridge_resize - scan a PCI bus for devices.
+ * @bridge: PCI bridge for the bus to scan
+ *
+ * Scan a PCI bus and child buses for new devices, adds them,
+ * and enables them, it will resize bridge mmio/io resource if it is possible
+ * for safe, caller should make sure that children get removed already.
+ *
+ * Returns the max number of subordinate bus discovered.
+ */
+unsigned int __ref pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
+{
+	unsigned int max;
+	struct pci_bus *bus = bridge->subordinate;
+
+	max = pci_scan_child_bus(bus);
+
+	pci_assign_unassigned_bridge_resources(bridge);
+
+	pci_bus_add_devices(bus);
+
+	return max;
+}
+
+/**
  * pci_rescan_bus - scan a PCI bus for devices.
  * @bus: PCI bus to scan
  *
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -882,6 +882,7 @@ void set_pcie_hotplug_bridge(struct pci_
 /* Functions for PCI Hotplug drivers to use */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
 #ifdef CONFIG_HOTPLUG
+unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 #endif
 
