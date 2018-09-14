Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mta-01.yadro.com ([89.207.88.251]:60242 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbeINVgp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 17:36:45 -0400
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 2/4] PCI: Release and reassign resources from the root during rescan
Date: Fri, 14 Sep 2018 19:14:02 +0300
Message-ID: <20180914161404.4685-3-s.miroshnichenko@yadro.com>
In-Reply-To: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If assigned resources don't contain holes to fit memory for hotplugged
devices, these conflicting resources must be freed, sorted and reassigned.

When resources are finally allocated and written to BARs, it's time to
update bridge windows with pci_setup_bridge().

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  8 ++++++++
 drivers/pci/probe.c     | 35 ++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-bus.c | 12 ++++--------
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e0d1528d471..cb157630f8d7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -224,6 +224,11 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
+enum release_type {
+	leaf_only,
+	whole_subtree,
+};
+
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
@@ -240,6 +245,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus,
 void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head);
+void pci_bus_release_bridge_resources(struct pci_bus *bus,
+				      unsigned long type,
+				      enum release_type rel_type);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bdaafc48dc4c..2c2b853454c2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3113,6 +3113,25 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 }
 EXPORT_SYMBOL(pci_scan_bus);
 
+static void pci_setup_new_bridges(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child;
+
+		if (!pci_dev_is_added(dev))
+			continue;
+
+		child = dev->subordinate;
+		if (child)
+			pci_setup_new_bridges(child);
+	}
+
+	if (bus->self)
+		pci_setup_bridge(bus);
+}
+
 /**
  * pci_rescan_bus_bridge_resize - Scan a PCI bus for devices
  * @bridge: PCI bridge for the bus to scan
@@ -3189,11 +3208,25 @@ static void pci_bus_reset_done(struct pci_bus *bus)
 unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
+	struct pci_bus *root = bus;
+
+	while (!pci_is_root_bus(root))
+		root = root->parent;
 
 	if (pci_has_flag(PCI_MOVABLE_BARS))
 		pci_bus_reset_prepare(bus);
 	max = pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
+	if (pci_has_flag(PCI_MOVABLE_BARS)) {
+		pci_bus_release_bridge_resources(bus, IORESOURCE_IO, whole_subtree);
+		pci_bus_release_bridge_resources(bus, IORESOURCE_MEM, whole_subtree);
+		pci_bus_release_bridge_resources(bus,
+						 IORESOURCE_MEM_64 | IORESOURCE_PREFETCH,
+						 whole_subtree);
+		pci_assign_unassigned_root_bus_resources(root);
+	} else {
+		pci_assign_unassigned_bus_resources(bus);
+	}
+	pci_setup_new_bridges(bus);
 	if (pci_has_flag(PCI_MOVABLE_BARS))
 		pci_bus_reset_done(bus);
 	pci_bus_add_devices(bus);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824e83b4..fd5675bb501f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1244,7 +1244,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 	case PCI_CLASS_BRIDGE_PCI:
 		pci_bridge_check_ranges(bus);
-		if (bus->self->is_hotplug_bridge) {
+		if (bus->self->is_hotplug_bridge && !pci_has_flag(PCI_MOVABLE_BARS)) {
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mem_size = pci_hotplug_mem_size;
 		}
@@ -1582,17 +1582,13 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	}
 }
 
-enum release_type {
-	leaf_only,
-	whole_subtree,
-};
 /*
  * try to release pci bridge resources that is from leaf bridge,
  * so we can allocate big new one later
  */
-static void pci_bus_release_bridge_resources(struct pci_bus *bus,
-					     unsigned long type,
-					     enum release_type rel_type)
+void pci_bus_release_bridge_resources(struct pci_bus *bus,
+				      unsigned long type,
+				      enum release_type rel_type)
 {
 	struct pci_dev *dev;
 	bool is_leaf_bridge = true;
-- 
2.17.1
