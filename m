Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47841 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbbHUG1R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 02:27:17 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 06/52] PCI: Don't add too much optional size for hotplug bridge MMIO
Date: Thu, 20 Aug 2015 23:20:21 -0700
Message-Id: <1440138067-4314-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current code will always add 2M for hotplug bridge MMIO even
there is child device under it already.

For example:
	40:03.0 --- 43:00.0 --- 44:02.0 -+- 45:00.0
					 \- 45:00.1

44:02.0 will need 1M as must for 45:00.0 and 45:00.1
When we calculate add_size for 44:02.0, we pass 2M as additional
size for hotplug bridge, total will be 3M.

That is different from code before changes for optional support,
or even current code that treat optional as required directly by
not passing realloc head. We only need 2M as total.

The optional size should be 1M, and total size should be 2M.

This patch change to comparing required+optional with min_sum_size to
get smaller optional size.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6cccbe4..e4aa93e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1155,7 +1155,6 @@ out:
  * @type2: second match type
  * @type3: third match type
  * @min_size : the minimum memory window that must to be allocated
- * @add_size : additional optional memory window
  * @realloc_head : track the additional memory window on this list
  *
  * Calculate the size of the bus and minimal alignment which
@@ -1168,10 +1167,11 @@ out:
 static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 unsigned long type, unsigned long type2,
 			 unsigned long type3,
-			 resource_size_t min_size, resource_size_t add_size,
+			 resource_size_t min_size,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
+	resource_size_t min_sum_size = 0;
 	resource_size_t min_align = 0, min_add_align = 0;
 	resource_size_t max_align = 0, max_add_align = 0;
 	resource_size_t size = 0, size0 = 0, size1 = 0, sum_add_size = 0;
@@ -1183,6 +1183,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (!b_res)
 		return -ENOSPC;
 
+	if (realloc_head) {
+		min_sum_size = min_size;
+		min_size = 0;
+	}
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -1253,8 +1258,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	}
 	free_align_test_list(&align_test_list);
 
-	if ((sum_add_size - size) < add_size)
-		sum_add_size = size + add_size;
+	if (sum_add_size < min_sum_size)
+		sum_add_size = min_sum_size;
 	if (sum_add_size > size && realloc_head) {
 		min_add_align = calculate_mem_align(&align_test_add_list,
 					max_add_align, sum_add_size,
@@ -1391,7 +1396,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	resource_size_t min_mem_size = 0, additional_io_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1425,7 +1430,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
-			additional_mem_size = pci_hotplug_mem_size;
+			min_mem_size = pci_hotplug_mem_size;
 		}
 		/* Fall through */
 	default:
@@ -1444,8 +1449,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 				  prefmask, prefmask,
-				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head);
+				  min_mem_size, realloc_head);
 
 			/*
 			 * If successful, all non-prefetchable resources
@@ -1468,8 +1472,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			prefmask &= ~IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 					 prefmask, prefmask,
-					 realloc_head ? 0 : additional_mem_size,
-					 additional_mem_size, realloc_head);
+					 min_mem_size, realloc_head);
 
 			/*
 			 * If successful, only non-prefetchable resources
@@ -1478,7 +1481,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_size;
+				min_mem_size += min_mem_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1499,8 +1502,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * window.
 		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
-				realloc_head ? 0 : additional_mem_size,
-				additional_mem_size, realloc_head);
+				min_mem_size, realloc_head);
 		break;
 	}
 }
-- 
1.8.4.5

