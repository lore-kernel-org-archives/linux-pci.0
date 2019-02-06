Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B09C169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 10:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763902083B
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 10:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfBFKZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:25:26 -0500
Received: from mail-oln040092254050.outbound.protection.outlook.com ([40.92.254.50]:6045
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfBFKZ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Feb 2019 05:25:26 -0500
Received: from HK2APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.248.56) by HK2APC01HT177.eop-APC01.prod.protection.outlook.com
 (10.152.249.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Wed, 6 Feb
 2019 10:25:13 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT035.mail.protection.outlook.com (10.152.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 6 Feb 2019 10:25:13 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::cc10:24a5:4249:7da]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::cc10:24a5:4249:7da%2]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 10:25:13 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
CC:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH 1/2] PCI: fix serious bug when sizing bridges with additional
 size
Thread-Topic: [PATCH 1/2] PCI: fix serious bug when sizing bridges with
 additional size
Thread-Index: AQHUvgY+rgBkkdCfGUGAJCVkKheKcg==
Date:   Wed, 6 Feb 2019 10:25:13 +0000
Message-ID: <PS2P216MB064285AB6C7C1045AB86FC24806F0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0170.ausprd01.prod.outlook.com
 (2603:10c6:10:52::14) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:C854AC25AB305B8619941BA3785BD1FBE462156A6B6D94C90C0C70EE5764E4CA;UpperCasedChecksum:A9F0B306B5CB60AA6BFF386914E03ABB89D63681B6C3711940E26661AA63C192;SizeAsReceived:9265;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [GisFd5Hci70/cmdG/AVpQc57h2olRwWX]
x-microsoft-original-message-id: <20190206182446.26234-1-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2APC01HT177;6:ARmVHeIAD4FlmUoajg/uaSiasqBdnCI65HsL1t5UK6npFt9uEl8WGQywrNnV9dUjmb+Q2d3q3jcnEKqKNphDFZAzz8IXvO9hOKoQZu1EzFYNfkBFytQEpOHqH5GQ7oAbcPAXN4vKdkXL21mNI41z77qptgpBtdooVcE3KH59aj8LqvswvzDfSNSqMKwBIfXBuvmdn+fEnHXIPwbKP40ZTG6LdlounFiEbz9Mf1eFHwNpVej6ZoHGIfdj23uaEVxnwXxdZocwzJ6PAlDH289kJXm3/xk1L8YkqPKWld+PUlpoXjnTeUjmCnrjPYvrDTrFLOcbagNELGVBdaaiOeV2hW94CInLV712g+wo803/kcJIFCt/Lb9fPdPwKsjIh7GD1WMIiitbGqKDwiwO6LlLtkNosWYFCGCOk5aJbQ+U3zT/cg0y6c5jDP7LQerOtV/m/mP1QYT7tJOdMtNCmCU5/Q==;5:RbtRpc2akIAN3nNkobveZr0/rhZsyHdA4xbbGyT+FBTOk5cRWWUAtqObUXIOxR10rGcZPPMAoC86WoIe22EKGWWrPIS9X1Qxo2L2MIJldVr3HbCGxkrCYfyl8is03yUmwPMQyKqOjIjB9xIOlhmq2Kpa/ghcy1IBA+k0OAWPeJP5HIIgdVP7eS0PZUo6Nf94zAkTnw33S13tyGzQb4Hq+A==;7:v7HX3Eu3Pk5ODW8lXmGcSM1kRfdgyDeekYCBIVn69LFQ6SzFmJbAAT4V/dhzOnPQAEcbZLivBOhxupY9uniEmD/hEjfTCxLqTMY7QDpygWy1FIeI8u5Xiz3yFZ2Rmioi2Vw+tS6TmDZGM3vOlWIaiA==
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: 7MJMDUNTCtyAEK/T13ATu/5n2Icnl4EcgRvA/TRT4wEFj6F+/wMQ4RlsSTAtw7tJNieq+jofT6sHE7V90e6ZXc+Q0ZQc6J/9wDxLUQ7QkhJQj3F3Ajk6TWas1i2VV6dc5CHDmDGayM2+Ku2MEkw0rofxzecUjfDUFpbmasqt4Xook10fg04X+bnoccBeuhPcCQfSt1msUrKFxho0wd08xoO8TC+TfkiVkgRDyWbuyAJWUUP9mGWPZ9s8WBqUQLhcu2rFwJVCXfpDj71Ylp5yqT4PdDYvm17rty7HO5GLmm0glCe6UJH83ia55+H3zdvqe7lmwEwB1KK9/dcHDzX/sIUps1zsfKu7mTVEk5+3Uhkz4V1ZgsIUY51jGfud8ikHcw8GtgG1oK1VaDezg3afK+JjgcXX5eGpf7OvklSYXaoBb+PNWjMlEXUgwWc5kXRGS+GOUcSJw4wAyx0130YtMVrqO3BDjMzWos+gyraSWXE/rzrZHlg5u6s8O6H9zierEKcwf4pgTmPQ4CY45hYZNEPfY/AUvFHe8X08BsA2+PZxhXWyrmt0vV0soRtFhAobS1kfGAKbw0yqCuaBNAJBAWXQwoMroHhbAegOmQvLpD89q8Ai2wyhGgM+WNCfLlFaQS6ewP2bDrdFqVOX5mrbEnOtbSDhaqN4EfJ/Ukv1gUarfiK95SxZkC9cVvnejFzrBbeU6SIr4U6OJDuS4kEQ4AXrbe29ljIDt8bF2pburl5N3gn4cXbtdQ==
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT177;
x-ms-traffictypediagnostic: HK2APC01HT177:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:HK2APC01HT177;BCL:0;PCL:0;RULEID:;SRVR:HK2APC01HT177;
x-microsoft-antispam-message-info: Dqb3KLGip5QIByKK8X2tWTNY2Td5vP0XlGbPFLv8NLA3g+6Jr4ZKKq+cytsUi9yj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f015911-49fc-4c82-9df9-08d68c1d6121
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:25:12.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Background: I discovered a bug while preparing my next patch for
Thunderbolt native PCI enumeration. This bugfix is vital for that next
Thunderbolt patch. They are related and could be put together but I am
presenting them as separate patches.

Nature of problem: On boot, the PCI bridges are handled in the function
pci_assign_unassigned_root_bus_resources(). This function makes multiple
passes / attempts to assign all of the resources. It calls
__pci_bus_size_bridges() which tries to assign required resources, plus
additional requested space. It makes calls to pbus_size_io() and
pbus_size_mem() which return zero on success. However, these functions
misleadingly return non-zero if the resource is already assigned.

The fallout: If the first attempt to allocate resources on a bridge
succeeds in 64-bit MMIO_PREF, but fails in 32-bit MMIO, then a second
attempt is made. Then, the __pbus_size_mem() returns non-zero for
MMIO_PREF because the resource is already assigned. That makes
__pci_bus_size_bridges() think there is no space (ENOSPC) and it
attempts to assign the sum of the MMIO_PREF and MMIO sizes into a 32-bit
window. This means that it tries to request the sum of the the MMIO and
MMIO_PREF size into the MMIO window. In the best case, the MMIO size is
equal to the MMIO_PREF size and we get double the window in MMIO, and
the correct size in MMIO_PREF, and nothing bad happens. In a worse case,
doubling the size makes it fail due to lack of space in the miniscule
MMIO 32-bit address space. In that case, we might be able to reduce the
requested size. In the worst case, we have requested for a vast amount
of MMIO_PREF, and a small amount of MMIO. The kernel tries to assign the
sum of the sizes of the two types in the MMIO window, leaving us with
MMIO_PREF assigned and MMIO unassigned due to the requested size being
too large to assign. In this case, there is nothing we can do about it.
If a massive additional MMIO_PREF and a small non-zero amount of
additional MMIO are needed, then we cannot reduce the requested
MMIO_PREF to work around the bug.

The cause: pbus_size_io() and pbus_size_mem() both call
find_free_bus_resource() to identify which bridge window of the bus
meets the criteria. This function explicitly skips resources with a
parent, inevitably returning NULL. The functions pbus_size_io() and
pbus_size_mem() return -ENOSPC if find_free_bus_resource() returns NULL,
meaning an assigned resource is interpreted as having been failed to
assign, potentially causing it to try to allocate it again in another
window.

The solution: my proposed patch renames find_free_bus_resource() to
find_bus_resource_of_type() and modifies it to not skip resources with
r->parent. The name change is because returning an assigned resource
makes the resource potentially not "free". The calling functions,
pbus_size_io() and pbus_size_mem() have checks added for b_res->parent
and they return 0 (success) in this case. This is because a resource
with a parent is already assigned and should be interpreted as a
success, not a failure.

Testing: I have tested my proposed patch and it appears to work
flawlessly. It has the added benefit of slashing the number of attempts
taken to assign a given BAR, meaning a much cleaner dmesg. In fact, in
my configuration, it has gone from very messy to mainly IO BAR failures.
There is nothing that can be done about IO BARs because of the 16-bit
hardware limitation, meaning the amount of available space cannot be
increased. All that I am left with is a few "failed to assign [mem
size]" very early in boot, before those BARs succeed in the next
attempt. After the small initial set of failures for MEM, there are no
more "failed to assign" whatsoever for non-IO BARs.

Remarks: I fixed some other block comments to comply with kernel code
styling standards. I had to modify the one block comment to reflect the
changes, and checkpatch.pl got really angry and yelled at me. So I
figured I may as well fix the lot.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 82 +++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a8be1a90f..c7e0a5e2b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -563,17 +563,19 @@ void pci_setup_cardbus(struct pci_bus *bus)
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
+ * Initialize bridges with base/limit values we have collected.
+ * PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
+ * requires that if there is no I/O ports or memory behind the
+ * bridge, corresponding range must be turned off by writing base
+ * value greater than limit to the bridge's base/limit registers.
+ *
+ * Note: care must be taken when updating I/O base/limit registers
+ * of bridges which support 32-bit I/O. This update requires two
+ * config space writes, so it's quite possible that an I/O window of
+ * the bridge will have some undesirable address (e.g. 0) after the
+ * first write. Ditto 64-bit prefetchable MMIO.
+ */
 static void pci_setup_bridge_io(struct pci_dev *bridge)
 {
 	struct resource *res;
@@ -636,9 +638,11 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
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
@@ -730,9 +734,11 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	return -EINVAL;
 }
 
-/* Check whether the bridge supports optional I/O and
-   prefetchable memory ranges. If not, the respective
-   base/limit registers must be read-only and read as 0. */
+/*
+ * Check whether the bridge supports optional I/O and
+ * prefetchable memory ranges. If not, the respective
+ * base/limit registers must be read-only and read as 0.
+ */
 static void pci_bridge_check_ranges(struct pci_bus *bus)
 {
 	u16 io;
@@ -752,9 +758,11 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	if (io)
 		b_res[0].flags |= IORESOURCE_IO;
 
-	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
-	    disconnect boundary by one PCI data phase.
-	    Workaround: do not use prefetching on this device. */
+	/*
+	 * DECchip 21050 pass 2 errata: the bridge may miss an address
+	 * disconnect boundary by one PCI data phase.
+	 * Workaround: do not use prefetching on this device.
+	 */
 	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
 		return;
 
@@ -789,11 +797,17 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	}
 }
 
-/* Helper function for sizing routines: find first available
-   bus resource of a given type. Note: we intentionally skip
-   the bus resources which have already been assigned (that is,
-   have non-NULL parent resource). */
-static struct resource *find_free_bus_resource(struct pci_bus *bus,
+/*
+ * Helper function for sizing routines: find first bus resource of a
+ * given type. Note: we do not skip the bus resources which have already
+ * been assigned (r->parent != NULL). This is because a resource that is
+ * already assigned (nothing more to be done) will be indistinguishable
+ * from one that failed due to lack of space if we skip assigned
+ * resources. If the caller function cannot tell the difference then it
+ * might try to place the resources in a different window, doubling up on
+ * resources or causing unforeseeable issues.
+ */
+static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
 			 unsigned long type_mask, unsigned long type)
 {
 	int i;
@@ -802,7 +816,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 	pci_bus_for_each_resource(bus, r, i) {
 		if (r == &ioport_resource || r == &iomem_resource)
 			continue;
-		if (r && (r->flags & type_mask) == type && !r->parent)
+		if (r && (r->flags & type_mask) == type)
 			return r;
 	}
 	return NULL;
@@ -820,8 +834,10 @@ static resource_size_t calculate_iosize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	/* To be fixed in 2.5: we should have sort of HAVE_ISA
-	   flag in the struct pci_bus. */
+	/*
+	 * To be fixed in 2.5: we should have sort of HAVE_ISA
+	 * flag in the struct pci_bus.
+	 */
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
@@ -900,14 +916,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		resource_size_t add_size, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
-							IORESOURCE_IO);
+	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
+					IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
 
 	if (!b_res)
 		return;
+	if (b_res->parent)
+		return;
 
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -1012,7 +1030,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t min_align, align, size, size0, size1;
 	resource_size_t aligns[18];	/* Alignments from 1Mb to 128Gb */
 	int order, max_order;
-	struct resource *b_res = find_free_bus_resource(bus,
+	struct resource *b_res = find_bus_resource_of_type(bus,
 					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
@@ -1020,6 +1038,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	if (!b_res)
 		return -ENOSPC;
+	if (b_res->parent)
+		return 0;
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
-- 
2.19.1

