Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:26136 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964822Ab2J3RnP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 13:43:15 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/8] PCI: Move pci_rescan_bus() back to probe.c
Date: Tue, 30 Oct 2012 10:42:39 -0700
Message-Id: <1351618965-16761-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
References: <20121030040237.GA10472@google.com>
 <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have pci_assign_unassigned_bus_resources() in as global function now.

Move back pci_rescan_bus to probe.c where it should be.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c     |   21 +++++++++++++++++++++
 drivers/pci/setup-bus.c |   22 ----------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec909af..65f62e3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1890,6 +1890,27 @@ unsigned int __ref pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+/**
+ * pci_rescan_bus - scan a PCI bus for devices.
+ * @bus: PCI bus to scan
+ *
+ * Scan a PCI bus and child buses for new devices, adds them,
+ * and enables them.
+ *
+ * Returns the max number of subordinate bus discovered.
+ */
+unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
+{
+	unsigned int max;
+
+	max = pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
+
+	return max;
+}
+EXPORT_SYMBOL_GPL(pci_rescan_bus);
+
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bridge);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1f34929..59e6c55 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1569,25 +1569,3 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 
 	pci_enable_bridges(bus);
 }
-#ifdef CONFIG_HOTPLUG
-/**
- * pci_rescan_bus - scan a PCI bus for devices.
- * @bus: PCI bus to scan
- *
- * Scan a PCI bus and child buses for new devices, adds them,
- * and enables them.
- *
- * Returns the max number of subordinate bus discovered.
- */
-unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
-{
-	unsigned int max;
-
-	max = pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
-	pci_bus_add_devices(bus);
-
-	return max;
-}
-EXPORT_SYMBOL_GPL(pci_rescan_bus);
-#endif
-- 
1.7.7

