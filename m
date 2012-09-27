Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:48421 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab2I0IMW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Sep 2012 04:12:22 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/8] PCI: Separate out pci_assign_unassigned_bus_resources()
Date: Thu, 27 Sep 2012 01:11:52 -0700
Message-Id: <1348733519-24684-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is main portion of pci_rescan_bus().

Separate it out and prepare to use it for pci root bus hot add later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |   32 ++++++++++++++++++--------------
 include/linux/pci.h     |    1 +
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1e808ca..1f34929 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1550,25 +1550,12 @@ enable_all:
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
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
+void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 {
-	unsigned int max;
 	struct pci_dev *dev;
 	LIST_HEAD(add_list); /* list of resources that
 					want additional resources */
 
-	max = pci_scan_child_bus(bus);
-
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &bus->devices, bus_list)
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
@@ -1581,6 +1568,23 @@ unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
 	BUG_ON(!list_empty(&add_list));
 
 	pci_enable_bridges(bus);
+}
+#ifdef CONFIG_HOTPLUG
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
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index be1de01..505c05a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -980,6 +980,7 @@ void pci_bus_size_bridges(struct pci_bus *bus);
 int pci_claim_resource(struct pci_dev *, int);
 void pci_assign_unassigned_resources(void);
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
+void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-- 
1.7.7

