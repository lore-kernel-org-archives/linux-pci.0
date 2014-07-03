Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:32376 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbaGCUqv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 16:46:51 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Guo Chao <yan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 2/3] PCI: Fix bus align checking with 32bit bridge pref
Date: Thu,  3 Jul 2014 13:46:18 -0700
Message-Id: <1404420379-20983-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1404420379-20983-1-git-send-email-yinghai@kernel.org>
References: <1404420379-20983-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the bridge does not support 64bit pref mmio, we should still
keep align to be 2G as old time.

So add mmio64 mask checking, keep that 2G checking in the loop.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -930,10 +930,17 @@ static int pbus_size_mem(struct pci_bus
 	struct resource *b_res = find_free_bus_resource(bus,
 					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
+	unsigned int mem64_mask;
 
 	if (!b_res)
 		return -ENOSPC;
 
+	mem64_mask = b_res->flags & IORESOURCE_MEM_64;
+
+	/* kernel does not support 64bit res */
+	if (sizeof(resource_size_t) == 4)
+		mem64_mask &= ~IORESOURCE_MEM_64;
+
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
 	size = 0;
@@ -970,12 +977,14 @@ static int pbus_size_mem(struct pci_bus
 			order = __ffs(align) - 20;
 			if (order < 0)
 				order = 0;
-			if (order >= ARRAY_SIZE(aligns)) {
+			if (order >= ARRAY_SIZE(aligns) ||
+			    (!mem64_mask && order > 11 /* 2Gb */)) {
 				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
 					 i, r, (unsigned long long) align);
 				r->flags = 0;
 				continue;
 			}
+
 			size += r_size;
 			/* Exclude ranges with size > align from
 			   calculation of the alignment. */
