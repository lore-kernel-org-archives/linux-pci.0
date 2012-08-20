Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59984 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab2HTNq6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Aug 2012 09:46:58 -0400
Received: from /spool/local
	by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 20 Aug 2012 09:46:56 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E0D9C6E8063
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:46:52 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7KDkpLf076272
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:46:52 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7KDkkFJ016224
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:46:50 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	yinghai@kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 3/8] pci: fiddle with conversion of pci and CPU address
Date: Mon, 20 Aug 2012 21:46:30 +0800
Message-Id: <1345470395-17295-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch fiddles with the those functions used to do conversion
between PCI and CPU address. More specificly, 2 functions are
involved: pcibios_bus_to_resource() and pcibios_resource_to_bus()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |   24 +++++++++++++++++++-----
 include/linux/pci.h       |    5 ++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index fc16357..abcf053 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -37,10 +37,10 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
 	return res1->start <= res2->start && res1->end >= res2->end;
 }
 
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
+void __pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
+			       struct resource *res)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev->bus);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
@@ -57,6 +57,13 @@ void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 	region->start = res->start - offset;
 	region->end = res->end - offset;
 }
+
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			     struct resource *res)
+{
+	__pcibios_resource_to_bus(dev->bus, region, res);
+}
+
 EXPORT_SYMBOL(pcibios_resource_to_bus);
 
 static bool region_contains(struct pci_bus_region *region1,
@@ -65,10 +72,10 @@ static bool region_contains(struct pci_bus_region *region1,
 	return region1->start <= region2->start && region1->end >= region2->end;
 }
 
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev->bus);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
@@ -90,4 +97,11 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 	res->start = region->start + offset;
 	res->end = region->end + offset;
 }
+
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	__pcibios_bus_to_resource(dev->bus, res, region);
+}
+
 EXPORT_SYMBOL(pcibios_bus_to_resource);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5faa831..a47a4d3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -692,9 +692,12 @@ void pcibios_update_irq(struct pci_dev *, int irq);
 void pci_fixup_cardbus(struct pci_bus *);
 
 /* Generic PCI functions used internally */
-
+void __pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
+				struct resource *res);
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			     struct resource *res);
+void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
+			       struct pci_bus_region *region);
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region);
 void pcibios_scan_specific_bus(int busn);
-- 
1.7.5.4

