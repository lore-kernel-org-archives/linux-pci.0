Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17667 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538AbbGFXmF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:42:05 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 22/36] PCI: Only treat non-pef mmio64 as pref if all bridges has MEM_64
Date: Mon,  6 Jul 2015 16:39:12 -0700
Message-Id: <1436225966-27247-23-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If any bridge up to root only have 32bit pref mmio, We don't need to
treat device non-pref mmio64 as as pref mmio64.

We need to move pci_bridge_check_ranges calling early.
for parent bridges pref mmio BAR may not allocated by BIOS, res flags
is still 0, we need to have it correct set before we check them for
child device resources.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 63472e29..ab7bafe 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1007,6 +1007,18 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	return -EINVAL;
 }
 
+static bool pci_up_path_over_pref_mem64(struct pci_bus *bus)
+{
+	if (pci_is_root_bus(bus))
+		return true;
+
+	if (bus->self && !(bus->self->resource[PCI_BRIDGE_RESOURCES + 2].flags &
+			   IORESOURCE_MEM_64))
+		return false;
+
+	return pci_up_path_over_pref_mem64(bus->parent);
+}
+
 int pci_resource_pref_compatible(const struct pci_dev *dev,
 				 struct resource *res)
 {
@@ -1015,7 +1027,8 @@ int pci_resource_pref_compatible(const struct pci_dev *dev,
 
 	if ((res->flags & IORESOURCE_MEM) &&
 	    (res->flags & IORESOURCE_MEM_64) &&
-	    dev->on_all_pcie_path)
+	    dev->on_all_pcie_path &&
+	    pci_up_path_over_pref_mem64(dev->bus))
 		return res->flags | IORESOURCE_PREFETCH;
 
 	return res->flags;
@@ -1760,6 +1773,10 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	struct resource *b_res;
 	int ret;
 
+	if (!pci_is_root_bus(bus) &&
+	    (bus->self->class >> 8) == PCI_CLASS_BRIDGE_PCI)
+		pci_bridge_check_ranges(bus);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
 		if (!b)
@@ -1787,7 +1804,6 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		break;
 
 	case PCI_CLASS_BRIDGE_PCI:
-		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mem_size = pci_hotplug_mem_size;
-- 
1.8.4.5

