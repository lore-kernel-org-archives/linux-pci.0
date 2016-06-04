Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22285 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbcFDAMU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2016 20:12:20 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v12 12/15] PCI: Only treat non-pref mmio64 as pref if all bridges have MEM_64
Date: Fri,  3 Jun 2016 17:06:39 -0700
Message-Id: <20160604000642.28162-13-yinghai@kernel.org>
In-Reply-To: <20160604000642.28162-1-yinghai@kernel.org>
References: <20160604000642.28162-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If any bridge up to root only have 32bit pref mmio, We don't need to
treat device non-pref mmio64 as as pref mmio64.

We need to move pci_bridge_check_ranges calling early.
For parent bridges pref mmio BAR may not allocated by BIOS, res flags
is still 0, we need to have it correct set before we check them for
child device resources.

-v2: check all bus resources instead of just res[15].

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 drivers/pci/setup-bus.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b3b1565..ffb1941 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -738,6 +738,29 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	return -EINVAL;
 }
 
+static bool pci_up_path_over_pref_mem64(struct pci_bus *bus)
+{
+	if (pci_is_root_bus(bus))
+		return true;
+
+	if (bus->self) {
+		int i;
+		bool found = false;
+		struct resource *res;
+
+		pci_bus_for_each_resource(bus, res, i)
+			if (res->flags & IORESOURCE_MEM_64) {
+				found = true;
+				break;
+			}
+
+		if (!found)
+			return false;
+	}
+
+	return pci_up_path_over_pref_mem64(bus->parent);
+}
+
 int pci_resource_pref_compatible(const struct pci_dev *dev,
 				 struct resource *res)
 {
@@ -746,7 +769,8 @@ int pci_resource_pref_compatible(const struct pci_dev *dev,
 
 	if ((res->flags & IORESOURCE_MEM) &&
 	    (res->flags & IORESOURCE_MEM_64) &&
-	    dev->on_all_pcie_path)
+	    dev->on_all_pcie_path &&
+	    pci_up_path_over_pref_mem64(dev->bus))
 		return res->flags | IORESOURCE_PREFETCH;
 
 	return res->flags;
@@ -1239,6 +1263,10 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	struct resource *b_res;
 	int ret;
 
+	if (!pci_is_root_bus(bus) &&
+	    (bus->self->class >> 8) == PCI_CLASS_BRIDGE_PCI)
+		pci_bridge_check_ranges(bus);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
 		if (!b)
@@ -1266,7 +1294,6 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		break;
 
 	case PCI_CLASS_BRIDGE_PCI:
-		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mem_size = pci_hotplug_mem_size;
-- 
2.8.3

