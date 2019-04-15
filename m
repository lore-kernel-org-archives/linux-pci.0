Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD8C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C49D2075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfDORJk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:09:40 -0400
Received: from mail-oln040092255027.outbound.protection.outlook.com ([40.92.255.27]:50784
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbfDORJk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 13:09:40 -0400
Received: from HK2APC01FT059.eop-APC01.prod.protection.outlook.com
 (10.152.248.60) by HK2APC01HT217.eop-APC01.prod.protection.outlook.com
 (10.152.249.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Mon, 15 Apr
 2019 17:09:27 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT059.mail.protection.outlook.com (10.152.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 15 Apr 2019 17:09:27 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647%6]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:09:27 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 2/5] PCI: Cleanup comments in setup-bus.c to meet kernel
 coding style guidelines
Thread-Topic: [PATCH v3 2/5] PCI: Cleanup comments in setup-bus.c to meet
 kernel coding style guidelines
Thread-Index: AQHU8637VzvZe+R9yke1gPblleS47Q==
Date:   Mon, 15 Apr 2019 17:09:27 +0000
Message-ID: <PS2P216MB064281FA06A93B12D5270B08802B0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0088.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::14) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:2EDAF77BFE25357A776420C4C7BBA9A194E590E12DC06444AD46B482EE3AC4C0;UpperCasedChecksum:F75CE9345441C52C8D89D02B95F53F4384D31DC60D1B2692CC3CCC115917C483;SizeAsReceived:7957;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [EeUdszISIB5iFkOoQ72PsyVusDXA6Xq6/pa91sTSIM6Xgmd3IgXy1Zup3h+YHLlugjtBdPE/xNc=]
x-microsoft-original-message-id: <20190416010756.31313-4-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: zswcL9HXbeXjLSNNcQpvuD9Rx3UxByW7jXpCLV4S3pPSZ8KQNRYKi7IQoG1UDYw9h7VZJDsJ8R5LVZuP63k4e/OpeRj6mV659qD74RJCX8gnq8oUAjZugJ55crh6ijc6AnK96DYL9p5oPEcEL6XjTPgOo7jXhmhDtLfeGtwy0x6o/HzsxRPj8Yx7ZByqtIlqmWX42bIOOSR9k5rTKkWtuhwX9p+/BkYEsybwdy861ygEnK3nvST96ZUYh5wqsZvIrI9moF4yHNcDXenDo5PElYovT6FsANMYHiJYrZ1Nb1c5DAWPX4zx9zpWB0EdoCinLy3NY7+xvMfUP0g8J/i+D56LoI+sGmbWOHNDQ6VJ6bL+pmxFod/g++mYwIOGRcuWq6LEC6N7eVRilhwULfvoo5Wvh6kpWeLKupENqaMflF1+Gl0X5Fc/ox+9rBbCjTdSGmreubs5Hg8T4BrOc0NzwOCVzphOOGIIJV1VIsJ8UbZpd1fnV4EKkqfwBEItpVznmibnDrYNHsEO6K+EnFscy9w/3wuLyqgZqMoprM60UNqdR0VNV68ujYcN22x28e/slg/xR1rZoaiUIpeb4FwUMAkY2W3+/YivRedaBm75KmBZZbLgUtZp6dTALh2WzR2Zuffro/4BsW3WwzCK/rjk/pqU2gNr0/SL5sP9lMgIlJg8m3WGP3DOcAyv9PZyEHs8LmFIpActTX61zEpY40xhybAmHSKVB2pMX+Xw6JTBWkjaqldCRSDPL1z0fx7zkJDA
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT217;
x-ms-traffictypediagnostic: HK2APC01HT217:
x-microsoft-antispam-message-info: XYf4nKcgMLjzSO/jK9pVdlfd7coCFXzkgVLCP3i3CNi1q7PGO+MeUylkCOlE4AofrlYwet33Pn1Pl7drbHDCztPztFZhnm/kE5a3aoNZdM/KFUviU14cAov71xomODdlZdX4m/8416TRO6HdR3MnSZ9dqplzAw8OIrrfC4iNqyNSk6W4fam2Z3PyKNU82seL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 98711f67-b985-439d-4f4e-08d6c1c51da9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:09:27.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT217
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change block comments to accepted style with asterisks on each line.

Justify block comments to 80-character limit to reduce the number of
lines where possible.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 265 ++++++++++++++++++++--------------------
 1 file changed, 130 insertions(+), 135 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 75827fb06..0ce641282 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -51,11 +51,9 @@ static void free_list(struct list_head *head)
 /**
  * add_to_list() - add a new resource tracker to the list
  * @head:	Head of the list
- * @dev:	device corresponding to which the resource
- *		belongs
+ * @dev:	device corresponding to which the resource belongs
  * @res:	The resource to be tracked
- * @add_size:	additional size to be optionally added
- *              to the resource
+ * @add_size:	additional size to be optionally added to the resource
  */
 static int add_to_list(struct list_head *head,
 		 struct pci_dev *dev, struct resource *res,
@@ -158,7 +156,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		tmp->res = r;
 		tmp->dev = dev;
 
-		/* fallback is smallest one or list is empty*/
+		/* fallback is smallest one or list is empty */
 		n = head;
 		list_for_each_entry(dev_res, head, list) {
 			resource_size_t align;
@@ -171,7 +169,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 				break;
 			}
 		}
-		/* Insert it just before n*/
+		/* Insert it just before n */
 		list_add_tail(&tmp->list, n);
 	}
 }
@@ -181,7 +179,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
 {
 	u16 class = dev->class >> 8;
 
-	/* Don't touch classless devices or host bridges or ioapics.  */
+	/* Don't touch classless devices or host bridges or ioapics */
 	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
 		return;
 
@@ -208,12 +206,10 @@ static inline void reset_resource(struct resource *res)
  *
  * @realloc_head : head of the list tracking requests requiring additional
  *             resources
- * @head     : head of the list tracking requests with allocated
- *             resources
+ * @head     : head of the list tracking requests with allocated resources
  *
- * Walk through each element of the realloc_head and try to procure
- * additional resources for the element, provided the element
- * is in the head list.
+ * Walk through each element of the realloc_head and try to procure additional
+ * resources for the element, provided the element is in the head list.
  */
 static void reassign_resources_sorted(struct list_head *realloc_head,
 		struct list_head *head)
@@ -315,10 +311,9 @@ static unsigned long pci_fail_res_type_mask(struct list_head *fail_head)
 		mask |= fail_res->flags;
 
 	/*
-	 * one pref failed resource will set IORESOURCE_MEM,
-	 * as we can allocate pref in non-pref range.
-	 * Will release all assigned non-pref sibling resources
-	 * according to that bit.
+	 * one pref failed resource will set IORESOURCE_MEM, as we can allocate
+	 * pref in non-pref range. Will release all assigned non-pref sibling
+	 * resources according to that bit.
 	 */
 	return mask & (IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH);
 }
@@ -351,25 +346,24 @@ static void __assign_resources_sorted(struct list_head *head,
 				 struct list_head *fail_head)
 {
 	/*
-	 * Should not assign requested resources at first.
-	 *   they could be adjacent, so later reassign can not reallocate
-	 *   them one by one in parent resource window.
-	 * Try to assign requested + add_size at beginning
-	 *  if could do that, could get out early.
-	 *  if could not do that, we still try to assign requested at first,
-	 *    then try to reassign add_size for some resources.
+	 * Should not assign requested resources at first. They could be
+	 * adjacent, so later reassign can not reallocate them one by one in
+	 * parent resource window.
+	 *
+	 * Try to assign requested + add_size at beginning. If could do that,
+	 * could get out early. If could not do that, we still try to assign
+	 * requested at first, then try to reassign add_size for some resources.
 	 *
 	 * Separate three resource type checking if we need to release
 	 * assigned resource after requested + add_size try.
-	 *	1. if there is io port assign fail, will release assigned
-	 *	   io port.
-	 *	2. if there is pref mmio assign fail, release assigned
-	 *	   pref mmio.
-	 *	   if assigned pref mmio's parent is non-pref mmio and there
-	 *	   is non-pref mmio assign fail, will release that assigned
-	 *	   pref mmio.
-	 *	3. if there is non-pref mmio assign fail or pref mmio
-	 *	   assigned fail, will release assigned non-pref mmio.
+	 *	1. if there is io port assign fail, will release assigned io
+	 *	   port.
+	 *	2. if there is pref mmio assign fail, release assigned pref
+	 *	   mmio. If assigned pref mmio's parent is non-pref mmio
+	 *	   and there is non-pref mmio assign fail, will release that
+	 *	   assigned pref mmio.
+	 *	3. if there is non-pref mmio assign fail or pref mmio assigned
+	 *	   fail, will release assigned non-pref mmio.
 	 */
 	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
@@ -398,7 +392,7 @@ static void __assign_resources_sorted(struct list_head *head,
 		/*
 		 * There are two kinds of additional resources in the list:
 		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
-		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
+		 * 2. SR-IOV resource  -- IORESOURCE_SIZEALIGN
 		 * Here just fix the additional alignment for bridge
 		 */
 		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
@@ -477,8 +471,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	/* Satisfy the must-have resource requests */
 	assign_requested_resources_sorted(head, fail_head);
 
-	/* Try to satisfy any additional optional resource
-		requests */
+	/* Try to satisfy any additional optional resource requests */
 	if (realloc_head)
 		reassign_resources_sorted(realloc_head, head);
 	free_list(head);
@@ -563,17 +556,19 @@ void pci_setup_cardbus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_setup_cardbus);
 
-/* Initialize bridges with base/limit values we have collected.
-   PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
-   requires that if there is no I/O ports or memory behind the
-   bridge, corresponding range must be turned off by writing base
-   value greater than limit to the bridge's base/limit registers.
-
-   Note: care must be taken when updating I/O base/limit registers
-   of bridges which support 32-bit I/O. This update requires two
-   config space writes, so it's quite possible that an I/O window of
-   the bridge will have some undesirable address (e.g. 0) after the
-   first write. Ditto 64-bit prefetchable MMIO.  */
+/*
+ * Initialize bridges with base/limit values we have collected. PCI-to-PCI
+ * Bridge Architecture Specification rev. 1.1 (1998) requires that if there is
+ * no I/O ports or memory behind the bridge, corresponding range must be turned
+ * off by writing base value greater than limit to the bridge's base/limit
+ * registers.
+ *
+ * Note: care must be taken when updating I/O base/limit registers of bridges
+ * which support 32-bit I/O. This update requires two config space writes, so
+ * it's quite possible that an I/O window of the bridge will have some
+ * undesirable address (e.g. 0) after the first write. Ditto 64-bit prefetchable
+ *  MMIO.
+ */
 static void pci_setup_bridge_io(struct pci_dev *bridge)
 {
 	struct resource *res;
@@ -636,9 +631,11 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	struct pci_bus_region region;
 	u32 l, bu, lu;
 
-	/* Clear out the upper 32 bits of PREF limit.
-	   If PCI_PREF_BASE_UPPER32 was non-zero, this temporarily
-	   disables PREF range, which is ok. */
+	/*
+	 * Clear out the upper 32 bits of PREF limit.
+	 * If PCI_PREF_BASE_UPPER32 was non-zero, this temporarily
+	 * disables PREF range, which is ok.
+	 */
 	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
 
 	/* Set up PREF base/limit. */
@@ -730,9 +727,11 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	return -EINVAL;
 }
 
-/* Check whether the bridge supports optional I/O and
-   prefetchable memory ranges. If not, the respective
-   base/limit registers must be read-only and read as 0. */
+/*
+ * Check whether the bridge supports optional I/O and prefetchable memory
+ * ranges. If not, the respective base/limit registers must be read-only and
+ * read as 0.
+ */
 static void pci_bridge_check_ranges(struct pci_bus *bus)
 {
 	u16 io;
@@ -752,9 +751,11 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	if (io)
 		b_res[0].flags |= IORESOURCE_IO;
 
-	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
-	    disconnect boundary by one PCI data phase.
-	    Workaround: do not use prefetching on this device. */
+	/*
+	 * DECchip 21050 pass 2 errata: the bridge may miss an address
+	 * disconnect boundary by one PCI data phase. Workaround: do not use
+	 * prefetching on this device.
+	 */
 	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
 		return;
 
@@ -789,10 +790,11 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	}
 }
 
-/* Helper function for sizing routines: find first available
-   bus resource of a given type. Note: we intentionally skip
-   the bus resources which have already been assigned (that is,
-   have non-NULL parent resource). */
+/*
+ * Helper function for sizing routines: find first available bus resource of a
+ * given type. Note: we intentionally skip the bus resources which have already
+ * been assigned (that is, have non-NULL parent resource).
+ */
 static struct resource *find_free_bus_resource(struct pci_bus *bus,
 			 unsigned long type_mask, unsigned long type)
 {
@@ -820,8 +822,10 @@ static resource_size_t calculate_iosize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	/* To be fixed in 2.5: we should have sort of HAVE_ISA
-	   flag in the struct pci_bus. */
+	/*
+	 * To be fixed in 2.5: we should have sort of HAVE_ISA flag in the
+	 * struct pci_bus.
+	 */
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
@@ -870,8 +874,8 @@ static resource_size_t window_alignment(struct pci_bus *bus,
 		align = PCI_P2P_DEFAULT_MEM_ALIGN;
 	else if (type & IORESOURCE_IO) {
 		/*
-		 * Per spec, I/O windows are 4K-aligned, but some
-		 * bridges have an extension to support 1K alignment.
+		 * Per spec, I/O windows are 4K-aligned, but some bridges have
+		 * an extension to support 1K alignment.
 		 */
 		if (bus->self->io_window_1k)
 			align = PCI_P2P_DEFAULT_IO_ALIGN_1K;
@@ -891,10 +895,9 @@ static resource_size_t window_alignment(struct pci_bus *bus,
  * @add_size : additional optional io window
  * @realloc_head : track the additional io window on this list
  *
- * Sizing the IO windows of the PCI-PCI bridge is trivial,
- * since these windows have 1K or 4K granularity and the IO ranges
- * of non-bridge PCI devices are limited to 256 bytes.
- * We must be careful with the ISA aliasing though.
+ * Sizing the IO windows of the PCI-PCI bridge is trivial, since these windows
+ * have 1K or 4K granularity and the IO ranges of non-bridge PCI devices are
+ * limited to 256 bytes. We must be careful with the ISA aliasing though.
  */
 static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		resource_size_t add_size, struct list_head *realloc_head)
@@ -995,12 +998,12 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
  * @add_size : additional optional memory window
  * @realloc_head : track the additional memory window on this list
  *
- * Calculate the size of the bus and minimal alignment which
- * guarantees that all child resources fit in this size.
+ * Calculate the size of the bus and minimal alignment which guarantees that all
+ * child resources fit in this size.
  *
  * Returns -ENOSPC if there's no available bus resource of the desired type.
- * Otherwise, sets the bus resource start/end to indicate the required
- * size, adds things to realloc_head (if supplied), and returns 0.
+ * Otherwise, sets the bus resource start/end to indicate the required size,
+ * adds things to realloc_head (if supplied), and returns 0.
  */
 static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 unsigned long type, unsigned long type2,
@@ -1010,7 +1013,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, align, size, size0, size1;
-	resource_size_t aligns[18];	/* Alignments from 1Mb to 128Gb */
+	resource_size_t aligns[18]; /* Alignments from 1Mb to 128Gb */
 	int order, max_order;
 	struct resource *b_res = find_free_bus_resource(bus,
 					mask | IORESOURCE_PREFETCH, type);
@@ -1050,10 +1053,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			}
 #endif
 			/*
-			 * aligns[0] is for 1MB (since bridge memory
-			 * windows are always at least 1MB aligned), so
-			 * keep "order" from being negative for smaller
-			 * resources.
+			 * aligns[0] is for 1MB (since bridge memory windows are
+			 * always at least 1MB aligned), so keep "order" from
+			 * being negative for smaller resources.
 			 */
 			align = pci_resource_alignment(dev, r);
 			order = __ffs(align) - 20;
@@ -1066,8 +1068,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				continue;
 			}
 			size += max(r_size, align);
-			/* Exclude ranges with size > align from
-			   calculation of the alignment. */
+			/*
+			 * Exclude ranges with size > align from calculation of
+			 * the alignment.
+			 */
 			if (r_size <= align)
 				aligns[order] += align;
 			if (order > max_order)
@@ -1128,8 +1132,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	if (b_res[0].parent)
 		goto handle_b_res_1;
 	/*
-	 * Reserve some resources for CardBus.  We reserve
-	 * a fixed amount of bus space for CardBus bridges.
+	 * Reserve some resources for CardBus.  We reserve a fixed amount of bus
+	 * space for CardBus bridges.
 	 */
 	b_res[0].start = pci_cardbus_io_size;
 	b_res[0].end = b_res[0].start + pci_cardbus_io_size - 1;
@@ -1161,10 +1165,7 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
 	}
 
-	/*
-	 * Check whether prefetchable memory is supported
-	 * by this bridge.
-	 */
+	/* Check whether prefetchable memory is supported by this bridge. */
 	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
 	if (!(ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0)) {
 		ctrl |= PCI_CB_BRIDGE_CTL_PREFETCH_MEM0;
@@ -1175,9 +1176,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	if (b_res[2].parent)
 		goto handle_b_res_3;
 	/*
-	 * If we have prefetchable memory support, allocate
-	 * two regions.  Otherwise, allocate one region of
-	 * twice the size.
+	 * If we have prefetchable memory support, allocate two regions.
+	 * Otherwise, allocate one region of twice the size.
 	 */
 	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
 		b_res[2].start = pci_cardbus_mem_size;
@@ -1256,9 +1256,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			     additional_io_size, realloc_head);
 
 		/*
-		 * If there's a 64-bit prefetchable MMIO window, compute
-		 * the size required to put all 64-bit prefetchable
-		 * resources in it.
+		 * If there's a 64-bit prefetchable MMIO window, compute the
+		 * size required to put all 64-bit prefetchable resources in it.
 		 */
 		b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
 		mask = IORESOURCE_MEM;
@@ -1271,9 +1270,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 				  additional_mem_size, realloc_head);
 
 			/*
-			 * If successful, all non-prefetchable resources
-			 * and any 32-bit prefetchable resources will go in
-			 * the non-prefetchable window.
+			 * If successful, all non-prefetchable resources and any
+			 * 32-bit prefetchable resources will go in the
+			 * non-prefetchable window.
 			 */
 			if (ret == 0) {
 				mask = prefmask;
@@ -1308,18 +1307,17 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 		/*
 		 * Compute the size required to put everything else in the
-		 * non-prefetchable window.  This includes:
+		 * non-prefetchable window. This includes:
 		 *
 		 *   - all non-prefetchable resources
 		 *   - 32-bit prefetchable resources if there's a 64-bit
 		 *     prefetchable window or no prefetchable window at all
-		 *   - 64-bit prefetchable resources if there's no
-		 *     prefetchable window at all
+		 *   - 64-bit prefetchable resources if there's no prefetchable
+		 *     window at all
 		 *
-		 * Note that the strategy in __pci_assign_resource() must
-		 * match that used here.  Specifically, we cannot put a
-		 * 32-bit prefetchable resource in a 64-bit prefetchable
-		 * window.
+		 * Note that the strategy in __pci_assign_resource() must match
+		 * that used here. Specifically, we cannot put a 32-bit
+		 * prefetchable resource in a 64-bit prefetchable window.
 		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
 				realloc_head ? 0 : additional_mem_size,
@@ -1352,8 +1350,8 @@ static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
 }
 
 /*
- * Try to assign any resources marked as IORESOURCE_PCI_FIXED, as they
- * are skipped by pbus_assign_resources_sorted().
+ * Try to assign any resources marked as IORESOURCE_PCI_FIXED, as they are
+ * skipped by pbus_assign_resources_sorted().
  */
 static void pdev_assign_fixed_resources(struct pci_dev *dev)
 {
@@ -1464,10 +1462,9 @@ static void pci_bus_allocate_resources(struct pci_bus *b)
 	struct pci_bus *child;
 
 	/*
-	 * Carry out a depth-first search on the PCI bus
-	 * tree to allocate bridge apertures. Read the
-	 * programmed bridge bases and recursively claim
-	 * the respective bridge resources.
+	 * Carry out a depth-first search on the PCI bus tree to allocate bridge
+	 * apertures. Read the programmed bridge bases and recursively claim the
+	 * respective bridge resources.
 	 */
 	if (b->self) {
 		pci_read_bridge_bases(b);
@@ -1532,16 +1529,15 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
 
 	/*
-	 *     1. if there is io port assign fail, will release bridge
-	 *	  io port.
-	 *     2. if there is non pref mmio assign fail, release bridge
-	 *	  nonpref mmio.
-	 *     3. if there is 64bit pref mmio assign fail, and bridge pref
-	 *	  is 64bit, release bridge pref mmio.
-	 *     4. if there is pref mmio assign fail, and bridge pref is
-	 *	  32bit mmio, release bridge pref mmio
-	 *     5. if there is pref mmio assign fail, and bridge pref is not
-	 *	  assigned, release bridge nonpref mmio.
+	 * 1. if there is io port assign fail, will release bridge io port.
+	 * 2. if there is non pref mmio assign fail, release bridge nonpref
+	 *    mmio.
+	 * 3. if there is 64bit pref mmio assign fail, and bridge pref is 64bit,
+	 *    release bridge pref mmio.
+	 * 4. if there is pref mmio assign fail, and bridge pref is 32bit mmio,
+	 *    release bridge pref mmio
+	 * 5. if there is pref mmio assign fail, and bridge pref is not
+	 *    assigned, release bridge nonpref mmio.
 	 */
 	if (type & IORESOURCE_IO)
 		idx = 0;
@@ -1561,10 +1557,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	if (!r->parent)
 		return;
 
-	/*
-	 * if there are children under that, we should release them
-	 *  all
-	 */
+	/* if there are children under that, we should release them all */
 	release_child_resources(r);
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
@@ -1589,8 +1582,8 @@ enum release_type {
 	whole_subtree,
 };
 /*
- * try to release pci bridge resources that is from leaf bridge,
- * so we can allocate big new one later
+ * try to release pci bridge resources that is from leaf bridge, so we can
+ * allocate big new one later
  */
 static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 					     unsigned long type,
@@ -1751,8 +1744,8 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
  */
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 {
-	LIST_HEAD(realloc_head); /* list of resources that
-					want additional resources */
+	LIST_HEAD(realloc_head);
+	/* list of resources that want additional resources */
 	struct list_head *add_list = NULL;
 	int tried_times = 0;
 	enum release_type rel_type = leaf_only;
@@ -1774,13 +1767,14 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 
 again:
 	/*
-	 * last try will use add_list, otherwise will try good to have as
-	 * must have, so can realloc parent bridge resource
+	 * last try will use add_list, otherwise will try good to have as must
+	 * have, so can realloc parent bridge resource
 	 */
 	if (tried_times + 1 == pci_try_num)
 		add_list = &realloc_head;
-	/* Depth first, calculate sizes and alignments of all
-	   subordinate buses. */
+	/*
+	 * Depth first, calculate sizes and alignments of all subordinate buses.
+	 */
 	__pci_bus_size_bridges(bus, add_list);
 
 	/* Depth last, allocate resources and update the hardware. */
@@ -2040,8 +2034,9 @@ pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 {
 	struct pci_bus *parent = bridge->subordinate;
-	LIST_HEAD(add_list); /* list of resources that
-					want additional resources */
+	/* list of resources that want additional resources */
+	LIST_HEAD(add_list);
+
 	int tried_times = 0;
 	LIST_HEAD(fail_head);
 	struct pci_dev_resource *fail_res;
@@ -2051,9 +2046,9 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	__pci_bus_size_bridges(parent, &add_list);
 
 	/*
-	 * Distribute remaining resources (if any) equally between
-	 * hotplug bridges below. This makes it possible to extend the
-	 * hierarchy later without running out of resources.
+	 * Distribute remaining resources (if any) equally between hotplug
+	 * bridges below. This makes it possible to extend the hierarchy
+	 * later without running out of resources.
 	 */
 	pci_bridge_distribute_available_resources(bridge, &add_list);
 
@@ -2205,8 +2200,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-	LIST_HEAD(add_list); /* list of resources that
-					want additional resources */
+	/* list of resources that want additional resources */
+	LIST_HEAD(add_list);
 
 	down_read(&pci_bus_sem);
 	for_each_pci_bridge(dev, bus)
-- 
2.20.1

