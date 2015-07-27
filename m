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
Subject: [PATCH v3 29/51] PCI: Allow optional only io resource must size to be 0
Date: Mon, 27 Jul 2015 16:29:47 -0700
Message-Id: <1438039809-24957-30-git-send-email-yinghai@kernel.org>
In-Reply-To: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When there is no child device under the non hotplug bridge,
We can use 0 for must size, and do not use old size as must size.

When there is child device, size will not be 0.
when the bridge is not hotplug, min_size will not be 0.
So they will still honor the old size as must size.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index aeed716..3a94617 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1242,8 +1242,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	size = size_aligned_for_isa(size);
 	size += size1;
-	size0 = calculate_size(size, min_size,
-			resource_size(b_res), min_align);
+	if (size || min_size)
+		size0 = calculate_size(size, min_size,
+					resource_size(b_res), min_align);
 	sum_add_size = size_aligned_for_isa(sum_add_size);
 	sum_add_size += sum_add_size1;
 	if (sum_add_size < min_sum_size)
@@ -1259,7 +1260,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		return;
 	}
 
-	b_res->start = min_align;
+	b_res->start = size0 ? min_align : 0;
 	b_res->end = b_res->start + size0 - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-- 
1.8.4.5

