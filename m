Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36665 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932568AbcDHAWe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:22:34 -0400
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
Subject: [PATCH v11 48/60] PCI: Move ISA io port align out of calculate_iosize()
Date: Thu,  7 Apr 2016 17:16:01 -0700
Message-Id: <1460074573-7481-49-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to move ISA io port align out of calculate_iosize(),
so we could unify calculate_iosize and calculate_memsize later.

That extra aligning or offset is to work around ISA devices:
When one bridge have several children devices, and every device
has several io port resources and resource size < 0x400.
We need to check size, and add extra size to make sure bit8/9
to be zero.

Also need to apply same checking for optional size path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 11a4c1d..c202854 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1113,11 +1113,6 @@ static resource_size_t calculate_iosize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	/* To be fixed in 2.5: we should have sort of HAVE_ISA
-	   flag in the struct pci_bus. */
-#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
-	size = (size & 0xff) + ((size & ~0xffUL) << 2);
-#endif
 	size = ALIGN(size + size1, align);
 	if (size < old_size)
 		size = old_size;
@@ -1171,6 +1166,18 @@ static resource_size_t window_alignment(struct pci_bus *bus,
 	return max(align, arch_align);
 }
 
+static resource_size_t size_aligned_for_isa(resource_size_t size)
+{
+	/*
+	 * To be fixed in 2.5: we should have sort of HAVE_ISA
+	 *  flag in the struct pci_bus.
+	 */
+#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
+	size = (size & 0xff) + ((size & ~0xffUL) << 2);
+#endif
+	return size;
+}
+
 /**
  * pbus_size_io() - size the io window of a given bus
  *
@@ -1188,11 +1195,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 {
 	struct pci_dev *dev;
 	resource_size_t min_sum_size = 0;
-	resource_size_t sum_add_size;
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
 							IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
-	resource_size_t children_add_size = 0;
+	resource_size_t sum_add_size = 0, sum_add_size1 = 0;
 	resource_size_t min_align, align;
 
 	if (!b_res)
@@ -1209,7 +1215,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
-			unsigned long r_size;
+			unsigned long r_size, r_add_size;
 
 			if (r->parent || !(r->flags & IORESOURCE_IO))
 				continue;
@@ -1225,18 +1231,27 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			if (align > min_align)
 				min_align = align;
 
-			if (realloc_head)
-				children_add_size += get_res_add_size(realloc_head, r);
+			if (realloc_head) {
+				r_add_size = get_res_add_size(realloc_head, r);
+				r_add_size += r_size;
+				if (r_add_size < 0x400)
+					/* Might be re-aligned for ISA */
+					sum_add_size += r_add_size;
+				else
+					sum_add_size1 += r_add_size;
+			}
 		}
 	}
 
+	size = size_aligned_for_isa(size);
 	size0 = calculate_iosize(size, min_size, size1,
 			resource_size(b_res), min_align);
-	sum_add_size = children_add_size + size + size1;
+	sum_add_size = size_aligned_for_isa(sum_add_size);
+	sum_add_size += sum_add_size1;
 	if (sum_add_size < min_sum_size)
 		sum_add_size = min_sum_size;
 	size1 = !realloc_head ? size0 :
-		calculate_iosize(size, min_size, sum_add_size - size,
+		calculate_iosize(sum_add_size, min_size, 0,
 			resource_size(b_res), min_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
-- 
1.8.4.5

