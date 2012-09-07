Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:33580 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab2IGFBJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 01:01:09 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 6 Sep 2012 23:01:08 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4C01919D8043
	for <linux-pci@vger.kernel.org>; Thu,  6 Sep 2012 23:01:05 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q8750toZ183880
	for <linux-pci@vger.kernel.org>; Thu, 6 Sep 2012 23:00:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q8750qiw017916
	for <linux-pci@vger.kernel.org>; Thu, 6 Sep 2012 23:00:55 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 3/5] pci: refactor function pbus_size_mem
Date: Fri,  7 Sep 2012 13:00:33 +0800
Message-Id: <1346994035-16218-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
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
index a66cf09..1e808ca 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -812,6 +812,28 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
@@ -891,20 +913,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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

