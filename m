Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43653 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaETDqC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 23:46:02 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so226571igb.3
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 20:46:01 -0700 (PDT)
Subject: [PATCH v10 2/4] PCI: Change pbus_size_mem() return values to be
 more conventional
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: talal@mellanox.com, Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	amirv@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Date: Mon, 19 May 2014 21:45:58 -0600
Message-ID: <20140520034558.11972.74795.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pbus_size_mem() previously returned 0 for failure and 1 for success.
Change it to return -ENOSPC for failure and 0 for success.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 589f2261ab0e..caa07fe6a23a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -915,6 +915,10 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
  *
  * Calculate the size of the bus and minimal alignment which
  * guarantees that all child resources fit in this size.
+ *
+ * Returns -ENOSPC 0 if there's no available bus resource of the desired type.
+ * Otherwise, sets the bus resource start/end to indicate the required
+ * size, adds things to realloc_head (if supplied), and returns 0.
  */
 static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 unsigned long type, unsigned long type2,
@@ -931,7 +935,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_size = 0;
 
 	if (!b_res)
-		return 0;
+		return -ENOSPC;
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
@@ -998,7 +1002,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				 "%pR to %pR (unused)\n", b_res,
 				 &bus->busn_res);
 		b_res->flags = 0;
-		return 1;
+		return 0;
 	}
 	b_res->start = min_align;
 	b_res->end = size0 + min_align - 1;
@@ -1009,7 +1013,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				 "%pR to %pR add_size %llx\n", b_res,
 				 &bus->busn_res, (unsigned long long)size1-size0);
 	}
-	return 1;
+	return 0;
 }
 
 unsigned long pci_cardbus_resource_alignment(struct resource *res)
@@ -1121,6 +1125,7 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
 	resource_size_t additional_mem_size = 0, additional_io_size = 0;
 	struct resource *b_res;
+	int ret;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
@@ -1170,25 +1175,27 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		if (b_res[2].flags & IORESOURCE_MEM_64) {
 			prefmask |= IORESOURCE_MEM_64;
-			if (pbus_size_mem(bus, prefmask, prefmask,
+			ret = pbus_size_mem(bus, prefmask, prefmask,
 				  prefmask, prefmask,
 				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head)) {
-					/*
-					 * Success, with pref mmio64,
-					 * next will size non-pref or
-					 * non-mmio64 */
-					mask = prefmask;
-					type2 = prefmask & ~IORESOURCE_MEM_64;
-					type3 = prefmask & ~IORESOURCE_PREFETCH;
+				  additional_mem_size, realloc_head);
+			if (ret == 0) {
+				/*
+				 * Success, with pref mmio64,
+				 * next will size non-pref or
+				 * non-mmio64 */
+				mask = prefmask;
+				type2 = prefmask & ~IORESOURCE_MEM_64;
+				type3 = prefmask & ~IORESOURCE_PREFETCH;
 			}
 		}
 		if (!type2) {
 			prefmask &= ~IORESOURCE_MEM_64;
-			if (pbus_size_mem(bus, prefmask, prefmask,
+			ret = pbus_size_mem(bus, prefmask, prefmask,
 					 prefmask, prefmask,
 					 realloc_head ? 0 : additional_mem_size,
-					 additional_mem_size, realloc_head)) {
+					 additional_mem_size, realloc_head);
+			if (ret == 0) {
 				/* Success, next will size non-prefetch. */
 				mask = prefmask;
 			} else

