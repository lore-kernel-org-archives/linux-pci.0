Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:33412 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab3KSGhI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 01:37:08 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Tue, 19 Nov 2013 12:07:05 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id A3F00E0056
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:09:00 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAJ6axdW48562202
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:06:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAJ6b1hR008553
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:07:02 +0530
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yinghai@kernel.org
Subject: [RFC PATCH 1/3] PCI: do not compare CPU address with PCI address
Date: Tue, 19 Nov 2013 14:36:56 +0800
Message-Id: <1384843018-9479-2-git-send-email-yan@linux.vnet.ibm.com>
In-Reply-To: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
References: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In resource assignment code, limits are exerted to restrict allocated
resource range. However these limits are PCI address but compared to
CPU address in the end. Translated them before comparing.

We can't just use pcibios_bus_to_resource because the limits may not
included in the host bridge window. Introduce a help function to
do this translation, if address missed, return an approximate one.

Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
---
 drivers/pci/bus.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index fc1b740..532c0a4 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -99,6 +99,64 @@ void pci_bus_remove_resources(struct pci_bus *bus)
 }
 
 /**
+ * pci_bus_to_resource
+ *
+ * Much like pcibios_bus_to_resource() except it takes a single address
+ * and returns an approximate one if target address is not included
+ * in the bridge window. The approximate address is smaller than required
+ * one is 'bound' is 1, larger than required one if 'bound' is 0.
+ */
+static resource_size_t pci_bus_to_resource(struct pci_bus *bus, int flags,
+				    int mask, resource_size_t addr, int bound)
+{
+	struct pci_host_bridge *bridge;
+	struct pci_host_bridge_window *window, *match = NULL;
+	resource_size_t max = 0, min = -1;
+	resource_size_t offset = -1, start, end;
+
+	while (bus->parent)
+		bus = bus->parent;
+
+	bridge = to_pci_host_bridge(bus->bridge);
+
+	list_for_each_entry(window, &bridge->windows, list) {
+		if ((flags ^ window->res->flags) & mask)
+			continue;
+
+		start = window->res->start - window->offset;
+		end = window->res->end - window->offset;
+
+		if (addr >= start && addr <= end) {
+			offset = window->offset;
+			break;
+		}
+
+		if (bound && addr > end && end > max) {
+			max = end;
+			match = window;
+		} else if (!bound && addr < start && start < min) {
+			min = start;
+			match = window;
+		}
+	}
+
+	if (offset == -1) {
+		/*
+		 * Not even found the matched type. This may happen,
+		 * for example, if try to translate IO address in a HB
+		 * without IO window. Just return the original address,
+		 * it will fail later anyway.
+		 */
+		if (match == NULL)
+			return addr;
+
+		return (bound ? max : min) + match->offset;
+	}
+
+	return addr + offset;
+}
+
+/**
  * pci_bus_alloc_resource - allocate a resource from a parent bus
  * @bus: PCI bus
  * @res: resource to allocate
@@ -129,9 +187,12 @@ pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 
 	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
 
-	/* don't allocate too high if the pref mem doesn't support 64bit*/
+	/* don't allocate too high if the pref mem doesn't support 64bit */
 	if (!(res->flags & IORESOURCE_MEM_64))
-		max = PCIBIOS_MAX_MEM_32;
+		max = pci_bus_to_resource(bus, res->flags, type_mask,
+							PCIBIOS_MAX_MEM_32, 1);
+
+	min = pci_bus_to_resource(bus, res->flags, type_mask, min, 0);
 
 	pci_bus_for_each_resource(bus, r, i) {
 		if (!r)
-- 
1.8.3.2

