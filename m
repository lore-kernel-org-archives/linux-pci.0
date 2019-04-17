Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB84C282DC
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCFE217F4
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfDQOQ4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:16:56 -0400
Received: from mail-oln040092255080.outbound.protection.outlook.com ([40.92.255.80]:6033
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbfDQOQ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 10:16:56 -0400
Received: from HK2APC01FT008.eop-APC01.prod.protection.outlook.com
 (10.152.248.55) by HK2APC01HT066.eop-APC01.prod.protection.outlook.com
 (10.152.249.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Wed, 17 Apr
 2019 14:16:50 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT008.mail.protection.outlook.com (10.152.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Wed, 17 Apr 2019 14:16:50 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::adb3:4c16:60fd:65]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::adb3:4c16:60fd:65%5]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 14:16:50 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v4 2/4] PCI: Fix serious bug when sizing bridges with
 additional size
Thread-Topic: [PATCH v4 2/4] PCI: Fix serious bug when sizing bridges with
 additional size
Thread-Index: AQHU9SgyKeXkTr58j0ODKuisfKR/gw==
Date:   Wed, 17 Apr 2019 14:16:50 +0000
Message-ID: <PS2P216MB0642D39B45E16723F74569A480250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190417141610.6730-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190417141610.6730-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:AEA2686BFC77E0B8295C2CC6D98F0AE82A025A56E0227523CAA8041E4157EB93;UpperCasedChecksum:DC62C1537FC1D240A6AE6EB47B63CD6B2E475442350B01E306E2B4D8D91CDBBB;SizeAsReceived:7824;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [WyzUIRclYih3miZ2HWiYHhAigWmNb9vBSp7hzbUALJ4=]
x-microsoft-original-message-id: <20190417141610.6730-3-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: zswcL9HXbeUuq4/PM8OFiqKh1bfVgTnQaL38giUIfHvRrFg9RGhJH/9GZcdEQOUvQomBxZ4Lx77ji2xs6/KqRWvq0STsYSv6bWBVg5HQpf3S9lELODWH1q9+ICxfKAZeOOPi4saBLWthkrVyLJzILjnUU9lxD04Riuy63Bb8lWhYZL7F4G1AD0mgw3Jm+6MqpyCQpjyw1Su42hyBvvYrGvKV7auUjy1mVu1/xodf5rLw85HdUeRr+NXuQvU8hVtWB7EJyfAir+ocL5gYkcIH+X944XFaTzmTPcWHKS/V8sA6K1b3evNqRsSVLyGZknw14E/TE5/HsL+A3cXAt35JTJQ41kbqzBFpdHrhBbeWhJej/Aa2rd9yixSBaTi/p5MxZfoOSal9qeAmLBX/8ugqH2HosxUPj+xZ4NCSSGq/I2e7/Ea1bnNTP7v0yvanen6nX1qWB3hjmQCrTE2xFxTuWpZ+Mk9i5TjX/Dd6c0GzcVTzryAjshpwCGi8XJ4tZ3o6q7Iv1zpgmCxOXb+Or8+p7+ZNLM+WoOFmFMH4c/wMl6JUD8x+uQEcvus0Sn0ovyiZj3dyO07fGM8KDTaZSpNl5I4TmTtNn2sZTB0ADf55u9Vj9UKVzsqyUA/U9LeKyjEcwe9WEfiya4CrXsOmWEF2nptpQ4vmnHt9uWGirh+u1pBWQu7LsuIEkihcA32vKLLBDoOyBoXtU5QhF0K2CPvj0Fqn82SsyFV8WFrIxzQBp737N//udjFfTpUbhmqo2PP1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT066;
x-ms-traffictypediagnostic: HK2APC01HT066:
x-microsoft-antispam-message-info: 6rVJO04IiqI2phWER7OQBtVovgNJZPD74IS4pb/z/7e3j5LpQL3jiO9btM/yuMC4JZZ8NsFtchKB6llnR/hs40FoIAcsvZqbWR/1LZHAr/nTa3gOHYXO1ZTULNLoWTnsV8apHn8LQ5mAOSZTaaWNng11sAK60xRzqf3iKlEf9fyVZYfoa4toHT2QS5DmlhdA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9cabd2-e94b-4758-ce83-08d6c33f5526
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 14:16:50.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT066
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change find_free_bus_resource function to not skip assigned resources
with non-null parent.

Add checks in pbus_size_io and pbus_size_mem to return success if
resource returned from find_free_bus_resource is already allocated.

This avoids pbus_size_io and pbus_size_mem returning error code to
__pci_bus_size_bridges when a resource has been successfully assigned in
a previous pass. This fixes the existing behaviour where space for a
resource could be reserved multiple times in different parent bridge
windows. This also greatly reduces the number of failed BAR messages in
dmesg when Linux assigns resources.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a1ca8a11f..5b9ee9945 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -752,11 +752,17 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	}
 }
 
-/* Helper function for sizing routines: find first available
-   bus resource of a given type. Note: we intentionally skip
-   the bus resources which have already been assigned (that is,
-   have non-NULL parent resource). */
-static struct resource *find_free_bus_resource(struct pci_bus *bus,
+/*
+ * Helper function for sizing routines: find first bus resource of a given
+ * type. Note: we do not skip the bus resources which have already been
+ * assigned (r->parent != NULL). This is because a resource that is already
+ * assigned (nothing more to be done) will be indistinguishable from one that
+ * failed due to lack of space if we skip assigned resources. If the caller
+ * function cannot tell the difference then it might try to place the
+ * resources in a different window, doubling up on resources or causing
+ * unforeseeable issues.
+ */
+static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
 			 unsigned long type_mask, unsigned long type)
 {
 	int i;
@@ -765,7 +771,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 	pci_bus_for_each_resource(bus, r, i) {
 		if (r == &ioport_resource || r == &iomem_resource)
 			continue;
-		if (r && (r->flags & type_mask) == type && !r->parent)
+		if (r && (r->flags & type_mask) == type)
 			return r;
 	}
 	return NULL;
@@ -863,14 +869,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
@@ -975,7 +983,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t min_align, align, size, size0, size1;
 	resource_size_t aligns[18];	/* Alignments from 1Mb to 128Gb */
 	int order, max_order;
-	struct resource *b_res = find_free_bus_resource(bus,
+	struct resource *b_res = find_bus_resource_of_type(bus,
 					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
@@ -983,6 +991,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	if (!b_res)
 		return -ENOSPC;
+	if (b_res->parent)
+		return 0;
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
-- 
2.20.1

