Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47262 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646Ab2IGFA6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 7 Sep 2012 01:00:58 -0400
Received: from /spool/local
	by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Fri, 7 Sep 2012 01:00:57 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3430E38C8047
	for <linux-pci@vger.kernel.org>; Fri,  7 Sep 2012 01:00:55 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q8750sjA146848
	for <linux-pci@vger.kernel.org>; Fri, 7 Sep 2012 01:00:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q8750qWF009440
	for <linux-pci@vger.kernel.org>; Fri, 7 Sep 2012 01:00:54 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 2/5] pci: resource assignment based on p2p alignment
Date: Fri,  7 Sep 2012 13:00:32 +0800
Message-Id: <1346994035-16218-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch changes function pbus_size_io() and pbus_size_mem() to
do resource (I/O, memory and prefetchable memory) reassignment
based on the minimal alignments for the p2p bridge, which was
retrieved by function window_alignment().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 896f06e..a66cf09 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -749,17 +749,12 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
 	unsigned long size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
-	resource_size_t min_align = 4096, align;
+	resource_size_t min_align, io_align, align;
 
 	if (!b_res)
  		return;
 
-	/*
-	 * Per spec, I/O windows are 4K-aligned, but some bridges have an
-	 * extension to support 1K alignment.
-	 */
-	if (bus->self->io_window_1k)
-		min_align = 1024;
+	io_align = min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -786,8 +781,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		}
 	}
 
-	if (min_align > 4096)
-		min_align = 4096;
+	if (min_align > io_align)
+		min_align = io_align;
 
 	size0 = calculate_iosize(size, min_size, size1,
 			resource_size(b_res), min_align);
@@ -909,6 +904,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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

