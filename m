Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21001 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbbGNXr6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 19:47:58 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 27/49] PCI: Unifiy calculate_size for io port and mmio
Date: Tue, 14 Jul 2015 15:46:58 -0700
Message-Id: <1436914040-13206-28-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436914040-13206-1-git-send-email-yinghai@kernel.org>
References: <1436914040-13206-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should check size+size1 with min_size for io port.
For example, when hotplug bridge has two children bridges,
every child bridge will need 0x1000, so size1 will be 0x2000
and size is 0. The min_size for the hotplug bridge is 0x100.
with old version calculate_iosize, we get 0x3000 for final
size because we are using size to compare with min_size. That is
not right, we should use 0x2000 instead.

After this change, calculate_memsize and calculate_iosize
is the same.

Change them to calculate_size.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9d5e550..969a0b1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1116,23 +1116,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 	return NULL;
 }
 
-static resource_size_t calculate_iosize(resource_size_t size,
-		resource_size_t min_size,
-		resource_size_t size1,
-		resource_size_t old_size,
-		resource_size_t align)
-{
-	if (size < min_size)
-		size = min_size;
-	if (old_size == 1)
-		old_size = 0;
-	size = ALIGN(size + size1, align);
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
@@ -1257,14 +1241,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	}
 
 	size = size_aligned_for_isa(size);
-	size0 = calculate_iosize(size, min_size, size1,
+	size += size1;
+	size0 = calculate_size(size, min_size,
 			resource_size(b_res), min_align);
 	sum_add_size = size_aligned_for_isa(sum_add_size);
 	sum_add_size += sum_add_size1;
 	if (sum_add_size < min_sum_size)
 		sum_add_size = min_sum_size;
 	size1 = !realloc_head ? size0 :
-		calculate_iosize(sum_add_size, min_size, 0,
+		calculate_size(sum_add_size, min_size,
 			resource_size(b_res), min_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
@@ -1617,7 +1602,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (size || min_size) {
 		min_align = calculate_mem_align(&align_test_list, max_align,
 						size, window_align);
-		size0 = calculate_memsize(size, min_size,
+		size0 = calculate_size(size, min_size,
 				  resource_size(b_res), min_align);
 	}
 	free_align_test_list(&align_test_list);
@@ -1642,7 +1627,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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

