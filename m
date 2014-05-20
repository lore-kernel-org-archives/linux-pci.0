Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:54820 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbaETDqP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 23:46:15 -0400
Received: by mail-ie0-f179.google.com with SMTP id rd18so3011370iec.24
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 20:46:15 -0700 (PDT)
Subject: [PATCH v10 4/4] PCI: Add resource allocation comments
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: talal@mellanox.com, Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	amirv@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Date: Mon, 19 May 2014 21:46:12 -0600
Message-ID: <20140520034612.11972.97042.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add comments in the code to match the allocation strategy of 7c671426dfc3
("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources").

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |   58 +++++++++++++++++++++++++++++++++++------------
 drivers/pci/setup-res.c |   35 +++++++++++++++-------------
 2 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index caa07fe6a23a..758ffbcf24a8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1159,17 +1159,16 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mem_size = pci_hotplug_mem_size;
 		}
-		/*
-		 * Follow thru
-		 */
+		/* Fall through */
 	default:
 		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
 			     additional_io_size, realloc_head);
-		/* If the bridge supports prefetchable range, size it
-		   separately. If it doesn't, or its prefetchable window
-		   has already been allocated by arch code, try
-		   non-prefetchable range for both types of PCI memory
-		   resources. */
+
+		/*
+		 * If there's a 64-bit prefetchable MMIO window, compute
+		 * the size required to put all 64-bit prefetchable
+		 * resources in it.
+		 */
 		b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
 		mask = IORESOURCE_MEM;
 		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
@@ -1179,29 +1178,58 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 				  prefmask, prefmask,
 				  realloc_head ? 0 : additional_mem_size,
 				  additional_mem_size, realloc_head);
+
+			/*
+			 * If successful, all non-prefetchable resources
+			 * and any 32-bit prefetchable resources will go in
+			 * the non-prefetchable window.
+			 */
 			if (ret == 0) {
-				/*
-				 * Success, with pref mmio64,
-				 * next will size non-pref or
-				 * non-mmio64 */
 				mask = prefmask;
 				type2 = prefmask & ~IORESOURCE_MEM_64;
 				type3 = prefmask & ~IORESOURCE_PREFETCH;
 			}
 		}
+
+		/*
+		 * If there is no 64-bit prefetchable window, compute the
+		 * size required to put all prefetchable resources in the
+		 * 32-bit prefetchable window (if there is one).
+		 */
 		if (!type2) {
 			prefmask &= ~IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 					 prefmask, prefmask,
 					 realloc_head ? 0 : additional_mem_size,
 					 additional_mem_size, realloc_head);
-			if (ret == 0) {
-				/* Success, next will size non-prefetch. */
+
+			/*
+			 * If successful, only non-prefetchable resources
+			 * will go in the non-prefetchable window.
+			 */
+			if (ret == 0)
 				mask = prefmask;
-			} else
+			else
 				additional_mem_size += additional_mem_size;
+
 			type2 = type3 = IORESOURCE_MEM;
 		}
+
+		/*
+		 * Compute the size required to put everything else in the
+		 * non-prefetchable window.  This includes:
+		 *
+		 *   - all non-prefetchable resources
+		 *   - 32-bit prefetchable resources if there's a 64-bit
+		 *     prefetchable window or no prefetchable window at all
+		 *   - 64-bit prefetchable resources if there's no
+		 *     prefetchable window at all
+		 *
+		 * Note that the strategy in __pci_assign_resource() must
+		 * match that used here.  Specifically, we cannot put a
+		 * 32-bit prefetchable resource in a 64-bit prefetchable
+		 * window.
+		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
 				realloc_head ? 0 : additional_mem_size,
 				additional_mem_size, realloc_head);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 3bdac9dc4a88..3da2542eb4df 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -209,20 +209,25 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
-	/* First, try exact prefetching match.. */
+	/*
+	 * First, try exact prefetching match.  Even if a 64-bit
+	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
+	 * prefetchable resource in it because pbus_size_mem() assumes a
+	 * 64-bit window will contain no 32-bit resources.  If we assign
+	 * things differently than they were sized, not everything will fit.
+	 */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
 				     pcibios_align_resource, dev);
 	if (ret == 0)
 		return 0;
 
+	/*
+	 * If the prefetchable window is only 32 bits wide, we can put
+	 * 64-bit prefetchable resources in it.
+	 */
 	if ((res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
 	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
-		/*
-		 * That failed.
-		 *
-		 * Try 32bit pref
-		 */
 		ret = pci_bus_alloc_resource(bus, res, size, align, min,
 					     IORESOURCE_PREFETCH,
 					     pcibios_align_resource, dev);
@@ -230,18 +235,16 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 			return 0;
 	}
 
-	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
-		/*
-		 * That failed.
-		 *
-		 * But a prefetching area can handle a non-prefetching
-		 * window (it will just not perform as well).
-		 *
-		 * Also can put 64bit under 32bit range. (below 4g).
-		 */
+	/*
+	 * If we didn't find a better match, we can put any memory resource
+	 * in a non-prefetchable window.  If this resource is 32 bits and
+	 * non-prefetchable, the first call already tried the only possibility
+	 * so we don't need to try again.
+	 */
+	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);
-	}
+
 	return ret;
 }
 

