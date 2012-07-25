Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:39157 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab2GYBuN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2012 21:50:13 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Tue, 24 Jul 2012 19:50:13 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D5FE719D8036
	for <linux-pci@vger.kernel.org>; Wed, 25 Jul 2012 01:50:06 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6P1o9UX159586
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 19:50:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6P1o7Wm016473
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 19:50:09 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, linuxram@us.ibm.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 5/8] pci: resource assignment based on p2p alignment
Date: Wed, 25 Jul 2012 09:49:54 +0800
Message-Id: <1343180997-9483-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch changes function pbus_size_io() and pbus_size_mem() to
do resource (I/O, memory and prefetchable memory) reassignment
based on the minimal alignments for the p2p bridge, which was
retrieved by function window_alignment().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c0fb9da..ca885ff 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -731,6 +731,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
 	unsigned long size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
+	resource_size_t io_align;
 
 	if (!b_res)
  		return;
@@ -756,13 +757,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 				children_add_size += get_res_add_size(realloc_head, r);
 		}
 	}
+
+	io_align = window_alignment(bus, IORESOURCE_IO);
 	size0 = calculate_iosize(size, min_size, size1,
-			resource_size(b_res), 4096);
+			resource_size(b_res), io_align);
 	if (children_add_size > add_size)
 		add_size = children_add_size;
 	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
 		calculate_iosize(size, min_size, add_size + size1,
-			resource_size(b_res), 4096);
+			resource_size(b_res), io_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window "
@@ -772,11 +775,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		return;
 	}
 	/* Alignment of the IO window is always 4K */
-	b_res->start = 4096;
+	b_res->start = io_align;
 	b_res->end = b_res->start + size0 - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1-size0, 4096);
+		add_to_list(realloc_head, bus->self, b_res, size1-size0, io_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
 				 "%pR to [bus %02x-%02x] add_size %lx\n", b_res,
 				 bus->secondary, bus->subordinate, size1-size0);
@@ -875,6 +878,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			min_align = align1 >> 1;
 		align += aligns[order];
 	}
+
+	min_align = max(min_align, window_alignment(bus, b_res->flags & mask));
 	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
 	if (children_add_size > add_size)
 		add_size = children_add_size;
-- 
1.7.5.4

