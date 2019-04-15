Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0D5C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C1D2075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfDORJY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:09:24 -0400
Received: from mail-oln040092253105.outbound.protection.outlook.com ([40.92.253.105]:29024
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbfDORJY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 13:09:24 -0400
Received: from HK2APC01FT059.eop-APC01.prod.protection.outlook.com
 (10.152.248.57) by HK2APC01HT211.eop-APC01.prod.protection.outlook.com
 (10.152.248.239) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Mon, 15 Apr
 2019 17:09:16 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT059.mail.protection.outlook.com (10.152.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 15 Apr 2019 17:09:16 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647%6]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:09:16 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 1/5] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v3 1/5] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHU8630UVJocl3sDU+Wtpjo0sKjJg==
Date:   Mon, 15 Apr 2019 17:09:16 +0000
Message-ID: <PS2P216MB0642871CEAD6DFB1542E8CE2802B0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:90F67B416BBA77ED9BC10525D65C1195AF03544308BA15E1D3BA1574F83364E0;UpperCasedChecksum:8F632E6066989AE5BCF026A9D74A0E9694D66E3EA2CEC942C0820C292ACE0442;SizeAsReceived:7935;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [u1El33Fub6p46w1DAvRw1+M2Stu9RohPumqOwwXD5uDla4ZX+GUyGlcHyA05T7XuUL5vcWYuqSs=]
x-microsoft-original-message-id: <20190416010756.31313-3-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBy7Mai7yE4ToL4gNTPdRpfskE+PVEk3kj0wRVii2+08bQWUBm7jFb5sVtqkStCBOfIPOqS8OIdLudjZZfGlnQtY6hAL4sBtD5yAjq4e3CBxOcibRnN2QxHA71osbzZYUgjTHDwXeB2yf1Zjz1TF1yauq1YQcy5/jRafmQrip3PKsTVVzn0jqPgXa+eFUVrgQ6FORWkM1DuZ22rwaUJWjKyQF42N93HRzSqSgD5tCVYN354peBZMXVOl/Yb9fr7MtIdsA6kYdklz5opJzgsNWqIuVPdh5YgfrVN3h+XFVFT5UaHLOkaeamNPScDtFb39elYTu3OP8zgrw9TUHbL2zcvxvbm8V2XcSl6C/4NKFdkZWNnNT7QB3jpiBgxVCu/oBzOnszrw+nwGdSpXv2eCfY0OPS0BssNJU9X7tlrwYCcNpTXNG4ek69hDzId4KK9WTzr0VKXGCgRyKtkHYp9Gy8+D6Cr10LU5bmsTyjhe6hUY+dvsOzaS5m7hPeQV5qLFSY7ggHJmFBwjCVo27aRjeYg+aaCtm7V0yW1ubf4D2eIrPJF5HDtSlL1VEQKE1CbVp1yP8UfZxtlLIkxRg/Khl60Vs+Ypco2dFsDZaae7yWD4y9bxRpbAxUttcybutHIXJVJSzKBGcE3ngbM4hP27Fb87qyBcZOlANSgkQQuZidWW74QMe+EByrhMgaX/VyHhyuK4TiWHQ8LGvS8Q/k+g2xJ/4FSzJlAO
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT211;
x-ms-traffictypediagnostic: HK2APC01HT211:
x-microsoft-antispam-message-info: NQ65xeSB2T77zcLokLVbiqYaGe9w1AD8+mqVVDGArAzBBAH25j5CIAGuqEZSvXnz8XbiomlqdyW+zOhtqe2y7MImLvU7ZTG3o3/+DrdZ8++Y1fPWNcZOfv7Xl8Ul/4ueScUCDmMjqs2epolT8f2Dj6QqXt6D+i10dAGShNcFUD1FALjt7WvaY2FrPaqURQ2q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ede007f2-6813-4d12-05f8-08d6c1c516fd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:09:16.1615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT211
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

