Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26008 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbcFRCZn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2016 22:25:43 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v13 16/16] PCI: Restore pref MMIO allocation logic for host bridge without mmio64
Date: Fri, 17 Jun 2016 19:25:01 -0700
Message-Id: <20160618022501.15648-17-yinghai@kernel.org>
In-Reply-To: <20160618022501.15648-1-yinghai@kernel.org>
References: <20160618022501.15648-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From 5b2854155 (PCI: Restrict 64-bit prefetchable bridge windows to 64-bit
resources), we change the logic for pref mmio allocation:
When bridge pref support mmio64, we will only put children pref
that support mmio64 into it, and will put children pref mmio32
into bridge's non-pref mmio32.

That could leave bridge pref bar not used when that pref bar is mmio64,
and children res only has mmio32.
Also could have allocation failure when non-pref mmio32 is not big
enough space for those children pref mmio32.

That is not rational when the host bridge does not have 64bit mmio
above 4g at all.

The patch restore to old logic:
when host bridge does not have has_mem64, put children pref mmio64 and
pref mmio32 all under bridges pref bars.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 drivers/pci/bus.c       |  4 +++-
 drivers/pci/setup-bus.c | 13 +++++++++----
 drivers/pci/setup-res.c |  9 ++++++---
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index dd7cdbe..f116296 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -204,8 +204,10 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 {
 #ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
 	int rc;
+	unsigned long mmio64 = pci_find_host_bridge(bus)->has_mem64 ?
+				IORESOURCE_MEM_64 : 0;
 
-	if (res->flags & IORESOURCE_MEM_64) {
+	if (res->flags & mmio64) {
 		rc = pci_bus_alloc_from_region(bus, res, size, align, min,
 					       type_mask, alignf, alignf_data,
 					       &pci_high);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9404032..0845a57 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1311,7 +1311,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
 		mask = IORESOURCE_MEM;
 		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-		if (b_res[2].flags & IORESOURCE_MEM_64) {
+		if ((b_res[2].flags & IORESOURCE_MEM_64) &&
+		    pci_find_host_bridge(bus)->has_mem64) {
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 				  prefmask, prefmask,
@@ -1513,17 +1514,21 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	 *	  io port.
 	 *     2. if there is non pref mmio assign fail, release bridge
 	 *	  nonpref mmio.
-	 *     3. if there is 64bit pref mmio assign fail, and bridge pref
+	 *     3. if there is pref mmio assign fail, and host bridge does
+	 *	  have 64bit mmio, release bridge pref mmio.
+	 *     4. if there is 64bit pref mmio assign fail, and bridge pref
 	 *	  is 64bit, release bridge pref mmio.
-	 *     4. if there is pref mmio assign fail, and bridge pref is
+	 *     5. if there is pref mmio assign fail, and bridge pref is
 	 *	  32bit mmio, release bridge pref mmio
-	 *     5. if there is pref mmio assign fail, and bridge pref is not
+	 *     6. if there is pref mmio assign fail, and bridge pref is not
 	 *	  assigned, release bridge nonpref mmio.
 	 */
 	if (type & IORESOURCE_IO)
 		idx = 0;
 	else if (!(type & IORESOURCE_PREFETCH))
 		idx = 1;
+	else if (!pci_find_host_bridge(bus)->has_mem64)
+		idx = 2;
 	else if ((type & IORESOURCE_MEM_64) &&
 		 (b_res[2].flags & IORESOURCE_MEM_64))
 		idx = 2;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index f741fed..59271ee 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -212,6 +212,8 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	struct resource *res = dev->resource + resno;
 	resource_size_t min;
 	int ret;
+	unsigned long mmio64 = pci_find_host_bridge(bus)->has_mem64 ?
+				IORESOURCE_MEM_64 : 0;
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
@@ -223,7 +225,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 * things differently than they were sized, not everything will fit.
 	 */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
-				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
+				     IORESOURCE_PREFETCH | mmio64,
 				     pcibios_align_resource, dev);
 	if (ret == 0)
 		return 0;
@@ -232,7 +234,8 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 * If the prefetchable window is only 32 bits wide, we can put
 	 * 64-bit prefetchable resources in it.
 	 */
-	if ((res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
+	if (mmio64 &&
+	    (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
 	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
 		ret = pci_bus_alloc_resource(bus, res, size, align, min,
 					     IORESOURCE_PREFETCH,
@@ -247,7 +250,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 * non-prefetchable, the first call already tried the only possibility
 	 * so we don't need to try again.
 	 */
-	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
+	if (res->flags & (IORESOURCE_PREFETCH | mmio64))
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);
 
-- 
2.8.3

