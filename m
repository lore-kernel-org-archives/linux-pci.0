Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 26/52] PCI: Don't add too much optional size for hotplug bridge io
Date: Thu, 20 Aug 2015 23:20:41 -0700
Message-Id: <1440138067-4314-27-git-send-email-yinghai@kernel.org>
In-Reply-To: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Same as patch for MMIO (PCI: Don't add too much optional size for hotplug
bridge MMIO), and this one is for io port.

It will compare required+optional with min_sum_size to get smaller
optional size.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index de47692..372a182 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1183,7 +1183,6 @@ static resource_size_t window_alignment(struct pci_bus *bus,
  *
  * @bus : the bus
  * @min_size : the minimum io window that must to be allocated
- * @add_size : additional optional io window
  * @realloc_head : track the additional io window on this list
  *
  * Sizing the IO windows of the PCI-PCI bridge is trivial,
@@ -1192,9 +1191,11 @@ static resource_size_t window_alignment(struct pci_bus *bus,
  * We must be careful with the ISA aliasing though.
  */
 static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
-		resource_size_t add_size, struct list_head *realloc_head)
+			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
+	resource_size_t min_sum_size = 0;
+	resource_size_t sum_add_size;
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
 							IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
@@ -1204,6 +1205,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	if (!b_res)
 		return;
 
+	if (realloc_head) {
+		min_sum_size = min_size;
+		min_size = 0;
+	}
+
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
@@ -1233,10 +1239,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	size0 = calculate_iosize(size, min_size, size1,
 			resource_size(b_res), min_align);
-	if (children_add_size > add_size)
-		add_size = children_add_size;
-	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
-		calculate_iosize(size, min_size, add_size + size1,
+	sum_add_size = children_add_size + size + size1;
+	if (sum_add_size < min_sum_size)
+		sum_add_size = min_sum_size;
+	size1 = !realloc_head ? size0 :
+		calculate_iosize(size, min_size, sum_add_size - size,
 			resource_size(b_res), min_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
@@ -1788,7 +1795,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t min_mem_size = 0, additional_io_size = 0;
+	resource_size_t min_mem_size = 0, min_io_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1821,13 +1828,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	case PCI_CLASS_BRIDGE_PCI:
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
-			additional_io_size  = pci_hotplug_io_size;
+			min_io_size  = pci_hotplug_io_size;
 			min_mem_size = pci_hotplug_mem_size;
 		}
 		/* Fall through */
 	default:
-		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
-			     additional_io_size, realloc_head);
+		pbus_size_io(bus, min_io_size, realloc_head);
 
 		/*
 		 * If there's a 64-bit prefetchable MMIO window, compute
-- 
1.8.4.5

