Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36608 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596AbcDHAWS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:22:18 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 37/60] PCI: Cache window alignment value during bus sizing
Date: Thu,  7 Apr 2016 17:15:50 -0700
Message-Id: <1460074573-7481-38-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are several calling to window_alignment(), and we will have more
for alt_size support, cache the value instead of keeping on getting it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index efa6d4e..4d2898d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1240,6 +1240,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					mask | IORESOURCE_PREFETCH, type);
 	LIST_HEAD(align_test_list);
 	LIST_HEAD(align_test_add_list);
+	resource_size_t window_align;
 
 	if (!b_res)
 		return -ENOSPC;
@@ -1249,6 +1250,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		min_size = 0;
 	}
 
+	window_align = window_alignment(bus, b_res->flags);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -1311,10 +1314,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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
@@ -1325,7 +1328,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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

