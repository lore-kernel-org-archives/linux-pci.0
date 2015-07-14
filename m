Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48203 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbbGNW6C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 18:58:02 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 26/49] PCI: Move ISA ioport align out of calculate_iosize
Date: Tue, 14 Jul 2015 15:46:57 -0700
Message-Id: <1436914040-13206-27-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436914040-13206-1-git-send-email-yinghai@kernel.org>
References: <1436914040-13206-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So we could unify calculate_iosize and calculate_memsize later.

when one bridge have several children devices, and every devices
have several io port resources and resource size < 0x400.

We need to check size, and add extra size to make sure bit8/9
to be zero.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index de55e07..9d5e550 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1126,11 +1126,6 @@ static resource_size_t calculate_iosize(resource_size_t size,
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
@@ -1184,6 +1179,18 @@ static resource_size_t window_alignment(struct pci_bus *bus,
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
@@ -1201,11 +1208,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
@@ -1222,7 +1228,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
-			unsigned long r_size;
+			unsigned long r_size, r_add_size;
 
 			if (r->parent || !(r->flags & IORESOURCE_IO))
 				continue;
@@ -1238,18 +1244,27 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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

