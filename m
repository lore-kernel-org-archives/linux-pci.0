Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:54463 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab3EFNoc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 May 2013 09:44:32 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 6 May 2013 09:44:31 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 143F36E8059
	for <linux-pci@vger.kernel.org>; Mon,  6 May 2013 09:44:26 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r46DiTrJ333810
	for <linux-pci@vger.kernel.org>; Mon, 6 May 2013 09:44:29 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r46DiN6g018077
	for <linux-pci@vger.kernel.org>; Mon, 6 May 2013 09:44:28 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: benh@kernel.crashing.org, yinghai@kernel.org, bhelgaas@google.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 1/3] PCI: PCI_BUS_FLAGS_NO_IO flag for PCI bus
Date: Mon,  6 May 2013 21:44:16 +0800
Message-Id: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There has some PCI hosts (e.g. PHB3) that don't support IO. So the
patch intends to introduce the flag to indicate the special case.
In turn, we won't do IO resource assignment and enable that.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/pci.c       |    3 +++
 drivers/pci/setup-bus.c |   25 ++++++++++++++++---------
 include/linux/pci.h     |    1 +
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a899d8b..2548bad 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1218,6 +1218,9 @@ int pci_enable_device_mem(struct pci_dev *dev)
  */
 int pci_enable_device(struct pci_dev *dev)
 {
+	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_IO)
+		return pci_enable_device_flags(dev, IORESOURCE_MEM);
+
 	return pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO);
 }
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 16abaaa..c8293e90 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -133,6 +133,10 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 
 		r = &dev->resource[i];
 
+		if ((dev->bus->bus_flags & PCI_BUS_FLAGS_NO_IO) &&
+		    (r->flags & IORESOURCE_IO))
+			continue;
+
 		if (r->flags & IORESOURCE_PCI_FIXED)
 			continue;
 
@@ -1083,17 +1087,20 @@ static void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mem_size = pci_hotplug_mem_size;
 		}
+
+		/* Follow thru */
+	default:
+		if (!(bus->bus_flags & PCI_BUS_FLAGS_NO_IO))
+			pbus_size_io(bus,
+				     realloc_head ? 0 : additional_io_size,
+				     additional_io_size, realloc_head);
 		/*
-		 * Follow thru
+		 * If the bridge supports prefetchable range, size it
+		 * separately. If it doesn't, or its prefetchable window
+		 * has already been allocated by arch code, try
+		 * non-prefetchable range for both types of PCI memory
+		 * resources.
 		 */
-	default:
-		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
-			     additional_io_size, realloc_head);
-		/* If the bridge supports prefetchable range, size it
-		   separately. If it doesn't, or its prefetchable window
-		   has already been allocated by arch code, try
-		   non-prefetchable range for both types of PCI memory
-		   resources. */
 		mask = IORESOURCE_MEM;
 		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		if (pbus_size_mem(bus, prefmask, prefmask,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a24e4f..53b595a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -181,6 +181,7 @@ typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
 	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
+	PCI_BUS_FLAGS_NO_IO    = (__force pci_bus_flags_t) 4
 };
 
 /* Based on the PCI Hotplug Spec, but some values are made up by us */
-- 
1.7.5.4

