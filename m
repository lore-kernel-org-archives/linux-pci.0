Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2141C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851D52087C
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 16:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCKQXS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:23:18 -0400
Received: from mail-oln040092254108.outbound.protection.outlook.com ([40.92.254.108]:50080
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfCKQXS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 12:23:18 -0400
Received: from HK2APC01FT058.eop-APC01.prod.protection.outlook.com
 (10.152.248.56) by HK2APC01HT068.eop-APC01.prod.protection.outlook.com
 (10.152.249.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.19; Mon, 11 Mar
 2019 16:23:13 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.58) by
 HK2APC01FT058.mail.protection.outlook.com (10.152.249.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19 via Frontend Transport; Mon, 11 Mar 2019 16:23:13 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::88f1:49d3:6e90:a74e]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::88f1:49d3:6e90:a74e%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:23:13 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v2 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHU2Ca51RCJv9elBE6SQuSaIcBu5g==
Date:   Mon, 11 Mar 2019 16:23:12 +0000
Message-ID: <PS2P216MB0642D9B14A310471B5C1CB4380480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:506DC1D188123EC99946F64215839F10F7AFC5A1973CD502C886BD1014DEFB98;UpperCasedChecksum:8D5616BE6E0D461802E07976AE8D920D8A4FEB7CF6AAC2D00297587F0A1B2A48;SizeAsReceived:8020;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [WHBHQlEXox6vXFYtrcgydvyzRUhjRkYBqxopo5tadAw/oWXtu/qBsVG2SsVwWjqkLVSWURUjdW8=]
x-microsoft-original-message-id: <20190311162154.3852-2-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBy7Mai7yE58FuKmTVyjCuVjAY5jVrnsbh+zwMq2UmABTzmgAJ2QKCyRbIBSXgEemnbJ3hUg47u+h1oEc6cvdYrWQS5P80l1NNaRLndNbPtbajpM1bNBNPDBkWZuhVY8FVvEEgXNDklkdjgIGqf1htTtc80mT9aS2zY2ekRdRW7jIiYIlVVhtDRPOtXbIVgAKreA0X+vHn6I2wxxfa2++IHKwcEE6Eh+k+X6TthbKqVAdrBRNul198pR6Yg4iG1g1zv5NoaZ4ZyR6Pnw9JbRl4aJ0wld17W6wIEAgrtr3kufOEGmWg2vA9ng55Oro4J+jwkWIaybHQXMVxHVcTyiHkRC0YEhjdbUmkUqOCIlzLagahZCeJGoXaUAysL6OHp+8xXGKjvUkNtD3vUF2bgsB9RniVyT+b/db3/Uc6S8SSinx5f6lZYKQGfDaLYyDQQzFEJmuIasmoNjYwRVogcsQeEtxbvI+tC7zYrQG4BykDhNvXZ0x5/DUFlJx6F6xaxmkeTTmirMqewghaewlSg7kw5PqyDL7JUJly2PsIFjswSTnS42U9NvT2g4cA8xfFTMyExCFSVdwtFDVAyOCTblIJOO+OnH9fKQ0QcaYBF9dqZK2vDk0fStC+kGb6S8q9XbdNtjfC6KqLgD5N16NOOc26omnrGh7v2I5BgHWJQebdod6DZSX0Ef2Wf7+1Q+m3qAWELnHD8iaBON36y/IQfHZVYNzyYKSvK8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(201702181274)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT068;
x-ms-traffictypediagnostic: HK2APC01HT068:
x-microsoft-antispam-message-info: ZRnUj+zV07VDAOa7o4CfvrRf8jDOJdRuzK4BBfA4/VNpljDKCi30KN7BECG5UQvn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4563a94c-d2a7-47b0-9e86-08d6a63ddb75
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:23:12.9872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT068
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rewrite pci_bus_distribute_available_resources to better handle bridges
with different resource alignment requirements. Pass more details
arguments recursively to track the resource start and end addresses
relative to the initial hotplug bridge. This is especially useful for
Thunderbolt with native PCI enumeration, enabling external graphics
cards and other devices with bridge alignment higher than 0x100000
bytes.

Change extend_bridge_window to resize the actual resource, rather than
using add_list and dev_res->add_size. If an additional resource entry
exists for the given resource, zero out the add_size field to avoid it
interfering. Because add_size is considered optional when allocating,
using add_size could cause issues in some cases, because successful
resource distribution requires sizes to be guaranteed. Such cases
include hot-adding nested hotplug bridges in one enumeration, and
potentially others which are yet to be encountered.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 203 ++++++++++++++++++++++------------------
 1 file changed, 110 insertions(+), 93 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed960436d..75827fb06 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1852,34 +1852,48 @@ void __init pci_assign_unassigned_resources(void)
 }
 
 static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
-			struct list_head *add_list, resource_size_t available)
+			struct list_head *add_list, resource_size_t new_size)
 {
 	struct pci_dev_resource *dev_res;
+	resource_size_t add_size;
 
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= available)
-		return;
-
-	dev_res = res_to_dev_res(add_list, res);
-	if (!dev_res)
-		return;
+	/*
+	 * Resources requested using add_size in additional resource lists are
+	 * considered optional when allocated. Guaranteed size of allocation
+	 * is required to guarantee successful resource distribution. Hence,
+	 * the size of the actual resource must be adjusted.
+	 */
+	if (new_size >= resource_size(res)) {
+		add_size = new_size - resource_size(res);
+		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
+			&add_size);
+	} else {
+		add_size = resource_size(res) - new_size;
+		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
+			&add_size);
+	}
 
-	/* Is there room to extend the window? */
-	if (available - resource_size(res) <= dev_res->add_size)
-		return;
+	res->end = res->start + new_size - 1;
 
-	dev_res->add_size = available - resource_size(res);
-	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
-		&dev_res->add_size);
+	/*
+	 * If a list entry exists, we need to remove any additional size
+	 * requested because that could interfere with the alignment and
+	 * sizing done when distributing resources, causing resources to
+	 * fail to allocate later on.
+	 */
+	dev_res = res_to_dev_res(add_list, res);
+	if (dev_res)
+		dev_res->add_size = 0;
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
-	struct list_head *add_list, resource_size_t available_io,
-	resource_size_t available_mmio, resource_size_t available_mmio_pref)
+	struct list_head *add_list, struct resource io,
+	struct resource mmio, struct resource mmio_pref)
 {
-	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
+	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
 	struct resource *io_res, *mmio_res, *mmio_pref_res;
 	struct pci_dev *dev, *bridge = bus->self;
@@ -1889,25 +1903,32 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 
 	/*
-	 * Update additional resource list (add_list) to fill all the
-	 * extra resource space available for this port except the space
-	 * calculated in __pci_bus_size_bridges() which covers all the
-	 * devices currently connected to the port and below.
+	 * The alignment of this bridge is yet to be considered, hence it must
+	 * be done now before extending its bridge window. A single bridge
+	 * might not be able to occupy the whole parent region if the alignment
+	 * differs - for example, an external GPU at the end of a Thunderbolt
+	 * daisy chain.
 	 */
-	extend_bridge_window(bridge, io_res, add_list, available_io);
-	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
-	extend_bridge_window(bridge, mmio_pref_res, add_list,
-			     available_mmio_pref);
+	align = pci_resource_alignment(bridge, io_res);
+	if (!io_res->parent && align)
+		io.start = ALIGN(io.start, align);
+
+	align = pci_resource_alignment(bridge, mmio_res);
+	if (!mmio_res->parent && align)
+		mmio.start = ALIGN(mmio.start, align);
+
+	align = pci_resource_alignment(bridge, mmio_pref_res);
+	if (!mmio_pref_res->parent && align)
+		mmio_pref.start = ALIGN(mmio_pref.start, align);
 
 	/*
-	 * Calculate the total amount of extra resource space we can
-	 * pass to bridges below this one. This is basically the
-	 * extra space reduced by the minimal required space for the
-	 * non-hotplug bridges.
+	 * Update the resources to fill as much remaining resource space in the
+	 * parent bridge as possible, while considering alignment.
 	 */
-	remaining_io = available_io;
-	remaining_mmio = available_mmio;
-	remaining_mmio_pref = available_mmio_pref;
+	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
+	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
+	extend_bridge_window(bridge, mmio_pref_res, add_list,
+		resource_size(&mmio_pref));
 
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
@@ -1921,80 +1942,79 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			normal_bridges++;
 	}
 
+	/*
+	 * There is only one bridge on the bus so it gets all possible
+	 * resources which it can then distribute to the possible
+	 * hotplug bridges below.
+	 */
+	if (hotplug_bridges + normal_bridges == 1) {
+		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
+		if (dev->subordinate)
+			pci_bus_distribute_available_resources(dev->subordinate,
+				add_list, io, mmio, mmio_pref);
+		return;
+	}
+
+	/*
+	 * Reduce the available resource space by what the
+	 * bridge and devices below it occupy.
+	 */
 	for_each_pci_bridge(dev, bus) {
-		const struct resource *res;
+		struct resource *res;
+		resource_size_t used_size;
 
 		if (dev->is_hotplug_bridge)
 			continue;
 
-		/*
-		 * Reduce the available resource space by what the
-		 * bridge and devices below it occupy.
-		 */
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
-		if (!res->parent && available_io > resource_size(res))
-			remaining_io -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(io.start, align) - io.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&io))
+			io.start += used_size;
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
-		if (!res->parent && available_mmio > resource_size(res))
-			remaining_mmio -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&mmio))
+			mmio.start += used_size;
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
-		if (!res->parent && available_mmio_pref > resource_size(res))
-			remaining_mmio_pref -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(mmio_pref.start, align) -
+				mmio_pref.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&mmio_pref))
+			mmio_pref.start += used_size;
 	}
 
-	/*
-	 * There is only one bridge on the bus so it gets all available
-	 * resources which it can then distribute to the possible
-	 * hotplug bridges below.
-	 */
-	if (hotplug_bridges + normal_bridges == 1) {
-		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate) {
-			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, available_io, available_mmio,
-				available_mmio_pref);
-		}
+	if (!hotplug_bridges)
 		return;
-	}
 
 	/*
-	 * Go over devices on this bus and distribute the remaining
-	 * resource space between hotplug bridges.
+	 * Distribute any remaining resources equally between
+	 * the hotplug-capable downstream ports.
 	 */
-	for_each_pci_bridge(dev, bus) {
-		resource_size_t align, io, mmio, mmio_pref;
-		struct pci_bus *b;
+	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
+	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
+	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
+		hotplug_bridges);
 
-		b = dev->subordinate;
-		if (!b || !dev->is_hotplug_bridge)
+	for_each_pci_bridge(dev, bus) {
+		if (!dev->subordinate || !dev->is_hotplug_bridge)
 			continue;
 
-		/*
-		 * Distribute available extra resources equally between
-		 * hotplug-capable downstream ports taking alignment into
-		 * account.
-		 *
-		 * Here hotplug_bridges is always != 0.
-		 */
-		align = pci_resource_alignment(bridge, io_res);
-		io = div64_ul(available_io, hotplug_bridges);
-		io = min(ALIGN(io, align), remaining_io);
-		remaining_io -= io;
-
-		align = pci_resource_alignment(bridge, mmio_res);
-		mmio = div64_ul(available_mmio, hotplug_bridges);
-		mmio = min(ALIGN(mmio, align), remaining_mmio);
-		remaining_mmio -= mmio;
+		io.end = io.start + io_per_hp - 1;
+		mmio.end = mmio.start + mmio_per_hp - 1;
+		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
 
-		align = pci_resource_alignment(bridge, mmio_pref_res);
-		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
-		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
-		remaining_mmio_pref -= mmio_pref;
+		pci_bus_distribute_available_resources(dev->subordinate,
+			add_list, io, mmio, mmio_pref);
 
-		pci_bus_distribute_available_resources(b, add_list, io, mmio,
-						       mmio_pref);
+		io.start = io.end + 1;
+		mmio.start = mmio.end + 1;
+		mmio_pref.start = mmio_pref.end + 1;
 	}
 }
 
@@ -2002,22 +2022,19 @@ static void
 pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 					  struct list_head *add_list)
 {
-	resource_size_t available_io, available_mmio, available_mmio_pref;
-	const struct resource *res;
+	struct resource io_res, mmio_res, mmio_pref_res;
 
 	if (!bridge->is_hotplug_bridge)
 		return;
 
+	io_res = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
+	mmio_res = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
+	mmio_pref_res = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
+
 	/* Take the initial extra resources from the hotplug port */
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
-	available_io = resource_size(res);
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
-	available_mmio = resource_size(res);
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
-	available_mmio_pref = resource_size(res);
 
 	pci_bus_distribute_available_resources(bridge->subordinate,
-		add_list, available_io, available_mmio, available_mmio_pref);
+		add_list, io_res, mmio_res, mmio_pref_res);
 }
 
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
-- 
2.20.1

