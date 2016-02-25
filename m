Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39790 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759600AbcBYCSx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:18:53 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 49/59] PCI: Unify calculate_size() for io port and MMIO
Date: Wed, 24 Feb 2016 18:12:40 -0800
Message-Id: <1456366370-28995-50-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now calculate_memsize() and calculate_iosize() is the same.

Change them to calculate_size().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0af433b..c13ec01 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1104,22 +1104,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 	return NULL;
 }
 
-static resource_size_t calculate_iosize(resource_size_t size,
-		resource_size_t min_size,
-		resource_size_t old_size,
-		resource_size_t align)
-{
-	if (size < min_size)
-		size = min_size;
-	if (old_size == 1)
-		old_size = 0;
-	size = ALIGN(size, align);
-	if (size < old_size)
-		size = old_size;
-	return size;
-}
-
-static resource_size_t calculate_memsize(resource_size_t size,
+static resource_size_t calculate_size(resource_size_t size,
 		resource_size_t min_size,
 		resource_size_t old_size,
 		resource_size_t align)
@@ -1245,14 +1230,14 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	size = size_aligned_for_isa(size);
 	size += size1;
-	size0 = calculate_iosize(size, min_size,
+	size0 = calculate_size(size, min_size,
 			resource_size(b_res), min_align);
 	sum_add_size = size_aligned_for_isa(sum_add_size);
 	sum_add_size += sum_add_size1;
 	if (sum_add_size < min_sum_size)
 		sum_add_size = min_sum_size;
 	size1 = !realloc_head ? size0 :
-		calculate_iosize(sum_add_size, min_size,
+		calculate_size(sum_add_size, min_size,
 			resource_size(b_res), min_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
@@ -1581,7 +1566,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (size || min_size) {
 		min_align = calculate_mem_align(&align_test_list, max_align,
 						size, window_align);
-		size0 = calculate_memsize(size, min_size,
+		size0 = calculate_size(size, min_size,
 				  resource_size(b_res), min_align);
 	}
 	free_align_test_list(&align_test_list);
@@ -1606,7 +1591,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		min_add_align = calculate_mem_align(&align_test_add_list,
 					max_add_align, sum_add_size,
 					window_align);
-		size1 = calculate_memsize(sum_add_size, min_size,
+		size1 = calculate_size(sum_add_size, min_size,
 				 resource_size(b_res), min_add_align);
 	}
 	free_align_test_list(&align_test_add_list);
-- 
1.8.4.5

