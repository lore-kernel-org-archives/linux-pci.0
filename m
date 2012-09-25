Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:35414 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab2IYI0f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:35 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	x86@kernel.org
Subject: [PATCH 01/29] PCI, x86: Separate out pcibios_allocate_bridge_resources()
Date: Tue, 25 Sep 2012 01:26:02 -0700
Message-Id: <1348561590-28067-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thus pcibios_allocate_bus_resources() could more simple and clean.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/pci/i386.c |   46 ++++++++++++++++++++++++----------------------
 1 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index dd8ca6f..9800362 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -193,34 +193,36 @@ EXPORT_SYMBOL(pcibios_align_resource);
  *	    as well.
  */
 
-static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
+static void __init pcibios_allocate_bridge_resources(struct pci_dev *dev)
 {
-	struct pci_bus *bus;
-	struct pci_dev *dev;
 	int idx;
 	struct resource *r;
 
+	for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
+		r = &dev->resource[idx];
+		if (!r->flags)
+			continue;
+		if (!r->start || pci_claim_resource(dev, idx) < 0) {
+			/*
+			 * Something is wrong with the region.
+			 * Invalidate the resource to prevent
+			 * child resource allocations in this
+			 * range.
+			 */
+			r->start = r->end = 0;
+			r->flags = 0;
+		}
+	}
+}
+
+static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
+{
+	struct pci_bus *bus;
+
 	/* Depth-First Search on bus tree */
 	list_for_each_entry(bus, bus_list, node) {
-		if ((dev = bus->self)) {
-			for (idx = PCI_BRIDGE_RESOURCES;
-			    idx < PCI_NUM_RESOURCES; idx++) {
-				r = &dev->resource[idx];
-				if (!r->flags)
-					continue;
-				if (!r->start ||
-				    pci_claim_resource(dev, idx) < 0) {
-					/*
-					 * Something is wrong with the region.
-					 * Invalidate the resource to prevent
-					 * child resource allocations in this
-					 * range.
-					 */
-					r->start = r->end = 0;
-					r->flags = 0;
-				}
-			}
-		}
+		if (bus->self)
+			pcibios_allocate_bridge_resources(bus->self);
 		pcibios_allocate_bus_resources(&bus->children);
 	}
 }
-- 
1.7.7

