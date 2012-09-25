Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42927 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab2IYI0z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:55 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 24/29] PCI, frv: kill pci_root_buses in resources reservations
Date: Tue, 25 Sep 2012 01:26:25 -0700
Message-Id: <1348561590-28067-25-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: David Howells <dhowells@redhat.com>
---
 arch/frv/mb93090-mb00/pci-frv.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
index c281217..2a127f9 100644
--- a/arch/frv/mb93090-mb00/pci-frv.c
+++ b/arch/frv/mb93090-mb00/pci-frv.c
@@ -78,27 +78,26 @@ pcibios_align_resource(void *data, const struct resource *res,
  *	    as well.
  */
 
-static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
+static void __init pcibios_allocate_bridge_resources(struct pci_dev *dev)
 {
-	struct list_head *ln;
-	struct pci_bus *bus;
-	struct pci_dev *dev;
 	int idx;
 	struct resource *r;
+	for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
+		r = &dev->resource[idx];
+		if (!r->start)
+			continue;
+		pci_claim_resource(dev, idx);
+	}
+}
+static void __init pcibios_allocate_bus_resources(struct pci_bus *bus)
+{
+	struct pci_bus *child;
 
 	/* Depth-First Search on bus tree */
-	for (ln=bus_list->next; ln != bus_list; ln=ln->next) {
-		bus = pci_bus_b(ln);
-		if ((dev = bus->self)) {
-			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
-				r = &dev->resource[idx];
-				if (!r->start)
-					continue;
-				pci_claim_resource(dev, idx);
-			}
-		}
-		pcibios_allocate_bus_resources(&bus->children);
-	}
+	if (bus->self)
+		pcibios_allocate_bridge_resources(bus->self);
+	list_for_each_entry(child, &bus->children, node)
+		pcibios_allocate_bus_resources(child);
 }
 
 static void __init pcibios_allocate_resources(int pass)
@@ -188,8 +187,12 @@ static void __init pcibios_assign_resources(void)
 
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
 	pcibios_assign_resources();
-- 
1.7.7

