Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:54762 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab2GYBvR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jul 2012 21:51:17 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Tue, 24 Jul 2012 21:51:16 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2D90DC90021
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 21:50:09 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6P1o9Wh411044
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 21:50:09 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6P7L0nb019746
	for <linux-pci@vger.kernel.org>; Wed, 25 Jul 2012 03:21:01 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, linuxram@us.ibm.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 6/8] pci: refactor function pbus_size_mem
Date: Wed, 25 Jul 2012 09:49:55 +0800
Message-Id: <1343180997-9483-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
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
index ca885ff..bdb7bd5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -786,6 +786,28 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
@@ -865,20 +887,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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

