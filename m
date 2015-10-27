Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v8 49/61] PCI: Don't add too much io port for hotplug bridge with old size
Date: Tue, 27 Oct 2015 13:55:41 -0700
Message-Id: <1445979353-1728-50-git-send-email-yinghai@kernel.org>
In-Reply-To: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we add too much for hotplug bridge io port.
For example, when hotplug bridge has two children bridges,
every child bridge will need 0x1000, so size1 will be 0x2000
and size is 0. The min_size for the hotplug bridge is 0x100.
with old version calculate_iosize, we get 0x3000 for final
size as we are using size to compare with min_size at first.
That is not right, we should have 0x2000.

We can check size+size1 with min_size for io port, and just add size1
to size without passing extra size1 into calculate_iosize().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4e7f0aa..d4e8da1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1106,7 +1106,6 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 
 static resource_size_t calculate_iosize(resource_size_t size,
 		resource_size_t min_size,
-		resource_size_t size1,
 		resource_size_t old_size,
 		resource_size_t align)
 {
@@ -1114,7 +1113,7 @@ static resource_size_t calculate_iosize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	size = ALIGN(size + size1, align);
+	size = ALIGN(size, align);
 	if (size < old_size)
 		size = old_size;
 	return size;
@@ -1245,14 +1244,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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

