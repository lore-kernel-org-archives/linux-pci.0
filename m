Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:41198 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab2HTNrG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2012 09:47:06 -0400
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 20 Aug 2012 07:47:05 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B11D9C40002
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:47:01 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7KDkphG152260
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:46:54 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7KDkjjU004794
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:46:47 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	yinghai@kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 5/8] pci: resource assignment based on p2p alignment
Date: Mon, 20 Aug 2012 21:46:32 +0800
Message-Id: <1345470395-17295-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch changes function pbus_size_io() and pbus_size_mem() to
do resource (I/O, memory and prefetchable memory) reassignment
based on the minimal alignments for the p2p bridge, which was
retrieved by function window_alignment().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 826a4f3..bb2eade 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -741,7 +741,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
 	unsigned long size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
-	resource_size_t min_align = 4096, align;
+	resource_size_t io_align, min_align, align;
 
 	if (!b_res)
  		return;
@@ -750,8 +750,14 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	 * Per spec, I/O windows are 4K-aligned, but some bridges have an
 	 * extension to support 1K alignment.
 	 */
-	if (bus->self->io_window_1k)
+	if (bus->self->io_window_1k) {
+		io_align = 4096;
 		min_align = 1024;
+	} else {
+		io_align = window_alignment(bus, IORESOURCE_IO);
+		min_align = io_align;
+	}
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -778,8 +784,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		}
 	}
 
-	if (min_align > 4096)
-		min_align = 4096;
+	if (min_align > io_align)
+		min_align = io_align;
 
 	size0 = calculate_iosize(size, min_size, size1,
 			resource_size(b_res), min_align);
@@ -901,6 +907,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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

