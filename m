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
Subject: [PATCH v4 28/52] PCI: Don't add too much io port for hotplug bridge with old size
Date: Thu, 20 Aug 2015 23:20:43 -0700
Message-Id: <1440138067-4314-29-git-send-email-yinghai@kernel.org>
In-Reply-To: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we add too much for hotplug bridge.
For example, when hotplug bridge has two children bridges,
every child bridge will need 0x1000, so size1 will be 0x2000
and size is 0. The min_size for the hotplug bridge is 0x100.
with old version calculate_iosize, we get 0x3000 for final
size as we are using size to compare with min_size at first.
That is not right, we should have 0x2000.

We should check size+size1 with min_size for io port,
just add size1 to size and and don't pass extra size1 into
calculate_iosize() directly.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8f11cd1..f3d89d1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1112,7 +1112,6 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 
 static resource_size_t calculate_iosize(resource_size_t size,
 		resource_size_t min_size,
-		resource_size_t size1,
 		resource_size_t old_size,
 		resource_size_t align)
 {
@@ -1120,7 +1119,7 @@ static resource_size_t calculate_iosize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	size = ALIGN(size + size1, align);
+	size = ALIGN(size, align);
 	if (size < old_size)
 		size = old_size;
 	return size;
@@ -1251,14 +1250,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	}
 
 	size = size_aligned_for_isa(size);
-	size0 = calculate_iosize(size, min_size, size1,
+	size += size1;
+	size0 = calculate_iosize(size, min_size,
 			resource_size(b_res), min_align);
 	sum_add_size = size_aligned_for_isa(sum_add_size);
 	sum_add_size += sum_add_size1;
 	if (sum_add_size < min_sum_size)
 		sum_add_size = min_sum_size;
 	size1 = !realloc_head ? size0 :
-		calculate_iosize(sum_add_size, min_size, 0,
+		calculate_iosize(sum_add_size, min_size,
 			resource_size(b_res), min_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
-- 
1.8.4.5

