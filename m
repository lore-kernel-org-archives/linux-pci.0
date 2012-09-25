Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42962 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab2IYI06 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:58 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linux-am33-list@redhat.com
Subject: [PATCH 26/29] PCI, mn10300: kill pci_root_buses in resources reservations
Date: Tue, 25 Sep 2012 01:26:27 -0700
Message-Id: <1348561590-28067-27-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: linux-am33-list@redhat.com
---
 arch/mn10300/unit-asb2305/pci-asb2305.c |   62 ++++++++++++++++--------------
 1 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.c b/arch/mn10300/unit-asb2305/pci-asb2305.c
index c4e2e79..87c945d 100644
--- a/arch/mn10300/unit-asb2305/pci-asb2305.c
+++ b/arch/mn10300/unit-asb2305/pci-asb2305.c
@@ -88,42 +88,42 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
  *	    requested by the user, configure expansion ROM address
  *	    as well.
  */
-static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
+static void __init pcibios_allocate_bridge_resources(struct pci_dev *dev)
 {
-	struct pci_bus *bus;
-	struct pci_dev *dev;
 	int idx;
 	struct resource *r;
 
-	/* Depth-First Search on bus tree */
-	list_for_each_entry(bus, bus_list, node) {
-		dev = bus->self;
-		if (dev) {
-			for (idx = PCI_BRIDGE_RESOURCES;
-			     idx < PCI_NUM_RESOURCES;
-			     idx++) {
-				r = &dev->resource[idx];
-				if (!r->flags)
-					continue;
-				if (!r->start ||
-				    pci_claim_resource(dev, idx) < 0) {
-					printk(KERN_ERR "PCI:"
-					       " Cannot allocate resource"
-					       " region %d of bridge %s\n",
-					       idx, pci_name(dev));
-					/* Something is wrong with the region.
-					 * Invalidate the resource to prevent
-					 * child resource allocations in this
-					 * range. */
-					r->start = r->end = 0;
-					r->flags = 0;
-				}
-			}
+	for (idx = PCI_BRIDGE_RESOURCES;
+	     idx < PCI_NUM_RESOURCES;
+	     idx++) {
+		r = &dev->resource[idx];
+		if (!r->flags)
+			continue;
+		if (!r->start ||
+		    pci_claim_resource(dev, idx) < 0) {
+			pr_err("PCI: Cannot allocate resource region %d of bridge %s\n",
+			       idx, pci_name(dev));
+			/* Something is wrong with the region.
+			 * Invalidate the resource to prevent
+			 * child resource allocations in this
+			 * range. */
+			r->start = r->end = 0;
+			r->flags = 0;
 		}
-		pcibios_allocate_bus_resources(&bus->children);
 	}
 }
 
+static void pcibios_allocate_bus_resources(struct pci_bus *bus)
+{
+	struct pci_bus *child;
+
+	/* Depth-First Search on bus tree */
+	if (bus->self)
+		pcibios_allocate_bridge_resources(bus->self);
+	list_for_each_entry(child, &bus->children, node)
+		pcibios_allocate_bus_resources(child);
+}
+
 static void __init pcibios_allocate_resources(int pass)
 {
 	struct pci_dev *dev = NULL;
@@ -207,8 +207,12 @@ fs_initcall(pcibios_assign_resources);
 
 void __init pcibios_resource_survey(void)
 {
+	struct pci_host_bridge *host_bridge = NULL;
+
 	DBG("PCI: Allocating resources\n");
-	pcibios_allocate_bus_resources(&pci_root_buses);
+
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_allocate_bus_resources(host_bridge->bus);
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
 }
-- 
1.7.7

