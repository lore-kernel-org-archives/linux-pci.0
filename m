Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47755 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbHUG1E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 02:27:04 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 15/52] PCI: Cache window alignment value during bus sizing
Date: Thu, 20 Aug 2015 23:20:30 -0700
Message-Id: <1440138067-4314-16-git-send-email-yinghai@kernel.org>
In-Reply-To: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are several calling to window_alignment(), and we will have more
for alt_size support, cache the value instead of keeping on getting it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c2c0806..b17ee2d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1197,6 +1197,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					mask | IORESOURCE_PREFETCH, type);
 	LIST_HEAD(align_test_list);
 	LIST_HEAD(align_test_add_list);
+	resource_size_t window_align;
 
 	if (!b_res)
 		return -ENOSPC;
@@ -1206,6 +1207,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		min_size = 0;
 	}
 
+	window_align = window_alignment(bus, b_res->flags);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -1266,10 +1269,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		}
 	}
 
-	max_align = max(max_align, window_alignment(bus, b_res->flags));
+	max_align = max(max_align, window_align);
 	if (size || min_size) {
 		min_align = calculate_mem_align(&align_test_list, max_align,
-				 size, window_alignment(bus, b_res->flags));
+						size, window_align);
 		size0 = calculate_memsize(size, min_size,
 				  resource_size(b_res), min_align);
 	}
@@ -1280,7 +1283,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (sum_add_size > size && realloc_head) {
 		min_add_align = calculate_mem_align(&align_test_add_list,
 					max_add_align, sum_add_size,
-					window_alignment(bus, b_res->flags));
+					window_align);
 		size1 = calculate_memsize(sum_add_size, min_size,
 				 resource_size(b_res), min_add_align);
 	}
-- 
1.8.4.5

