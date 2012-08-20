Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:41167 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab2HTNrB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2012 09:47:01 -0400
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 20 Aug 2012 07:47:01 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E1C5F3E4003C
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:46:56 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7KDkrp6158892
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:46:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7KDklQY027683
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:46:48 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	yinghai@kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 6/8] pci: refactor function pbus_size_mem
Date: Mon, 20 Aug 2012 21:46:33 +0800
Message-Id: <1345470395-17295-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The original idea comes from Ram Pai. The patch puts the chunk of
code for calculating the minimal alignment of memory window into
separate inline function.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   36 +++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bb2eade..7eef40d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -815,6 +815,28 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	}
 }
 
+static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
+						  int max_order)
+{
+	resource_size_t align = 0;
+	resource_size_t min_align = 0;
+	int order;
+
+	for (order = 0; order <= max_order; order++) {
+		resource_size_t align1 = 1;
+
+		align1 <<= (order + 20);
+
+		if (!align)
+			min_align = align1;
+		else if (ALIGN(align + min_align, min_align) < align1)
+			min_align = align1 >> 1;
+		align += aligns[order];
+	}
+
+	return min_align;
+}
+
 /**
  * pbus_size_mem() - size the memory window of a given bus
  *
@@ -894,20 +916,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				children_add_size += get_res_add_size(realloc_head, r);
 		}
 	}
-	align = 0;
-	min_align = 0;
-	for (order = 0; order <= max_order; order++) {
-		resource_size_t align1 = 1;
-
-		align1 <<= (order + 20);
-
-		if (!align)
-			min_align = align1;
-		else if (ALIGN(align + min_align, min_align) < align1)
-			min_align = align1 >> 1;
-		align += aligns[order];
-	}
 
+	min_align = calculate_mem_align(aligns, max_order);
 	min_align = max(min_align, window_alignment(bus, b_res->flags & mask));
 	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
 	if (children_add_size > add_size)
-- 
1.7.5.4

