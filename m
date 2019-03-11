Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ADCC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5953E2087F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 16:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCKQY3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:24:29 -0400
Received: from mail-oln040092255084.outbound.protection.outlook.com ([40.92.255.84]:12064
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfCKQY3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 12:24:29 -0400
Received: from HK2APC01FT058.eop-APC01.prod.protection.outlook.com
 (10.152.248.54) by HK2APC01HT133.eop-APC01.prod.protection.outlook.com
 (10.152.249.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.19; Mon, 11 Mar
 2019 16:23:43 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.58) by
 HK2APC01FT058.mail.protection.outlook.com (10.152.249.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19 via Frontend Transport; Mon, 11 Mar 2019 16:23:43 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::88f1:49d3:6e90:a74e]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::88f1:49d3:6e90:a74e%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:23:43 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 3/4] PCI: Fix serious bug when sizing bridges with
 additional size
Thread-Topic: [PATCH v2 3/4] PCI: Fix serious bug when sizing bridges with
 additional size
Thread-Index: AQHU2CbKi5pg9M3Vb0Cu14QDk47RlQ==
Date:   Mon, 11 Mar 2019 16:23:42 +0000
Message-ID: <PS2P216MB06424B087355C8E2446D38DD80480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:1E2C9B7E6CE9DCF3202EE826D96D82B67CD4B79FFAC9733F67542997078DFBAF;UpperCasedChecksum:8B7173A87655460516C186B35E3D5B9DC178B0526BFE1EDFC022036069360AFB;SizeAsReceived:7978;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [/gWneJiKTDo3aIGzZkxbjk4VLKRyWFObt6bIT1xbR7DER8i+FDUlyr8TbtQeezcGgCanAA82Juw=]
x-microsoft-original-message-id: <20190311162154.3852-4-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBy7Mai7yE58FuKmTVyjCuVjAY5jVrns8VmklBNDiF7b1NVSp2nRt5M4b06YxNwsT2cEdczbxxxtziTS2Gy5/zPjC1xnEbcocKdwJlSVeMBcrx6NC81gzvEx7tMTqXlgRw4eVW3LyU7VNJ/EuCqG009iTDhqNamclW2q+ErKzk1mqnvo+lSezKHlhr04bLkCgH/wP0kfo3zoVJsCegxFeIiKg91JQCVOoryyfWywIO8tF57az3JFJtutthuuO79aBwK+eu7DR2mxQgkvnctVqAMlQmizzEHb0CAi5t31dP0PqjMZZCmD+njgT0AOxaDdCcxSR9CeqMAzjmcJvcF3WasCe9uN/c4wE/EOuomJnZSz/2mXPs3verBQss1PLQOOSk9qShFgMMzlY52g218V6U5dvQe/foP/LOtExLWCFfO1RKtStsuoo7HlCHCVovguvVV6JBhS5LzWoCd2rXcBHt6072LbKbEn9CqMEA6dPInAbyE3jqVtYR+AKnGyvSy1L/gI54nGKeEMLSt9D7oPFB7WNnZcns0i6gaIDN69RJmzDvi3i+fqt9bK5y50y2oReKV0P9+qPQ4PcX725KkIkDQDGsZJIPrydOemWrg6biD3TynmxMMHvX605b5lwX4OMO47TM1U0cAYWlajpFFf0TfmIws2jFvh77QZJ61OO14q1UGbeSIdkNEwNuYxuvMvxNqaNWKWQVMFNC53axlLQndmVAuoCewq
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031324274)(2017031323274)(201702181274)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT133;
x-ms-traffictypediagnostic: HK2APC01HT133:
x-microsoft-antispam-message-info: /xbt2sR7bU/1c9bFPffB4FMunhkagvkOgYwSvEF+nFBxzTibp//bVYcYXW2B2qaZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c3f88d-691a-405c-0541-08d6a63ded19
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:23:42.5754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT133
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
 drivers/pci/setup-bus.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0ce641282..efe899b02 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -791,11 +791,16 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 }
 
 /*
- * Helper function for sizing routines: find first available bus resource of a
- * given type. Note: we intentionally skip the bus resources which have already
- * been assigned (that is, have non-NULL parent resource).
+ * Helper function for sizing routines: find first bus resource of a
+ * given type. Note: we do not skip the bus resources which have already
+ * been assigned (r->parent != NULL). This is because a resource that is
+ * already assigned (nothing more to be done) will be indistinguishable
+ * from one that failed due to lack of space if we skip assigned
+ * resources. If the caller function cannot tell the difference then it
+ * might try to place the resources in a different window, doubling up on
+ * resources or causing unforeseeable issues.
  */
-static struct resource *find_free_bus_resource(struct pci_bus *bus,
+static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
 			 unsigned long type_mask, unsigned long type)
 {
 	int i;
@@ -804,7 +809,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 	pci_bus_for_each_resource(bus, r, i) {
 		if (r == &ioport_resource || r == &iomem_resource)
 			continue;
-		if (r && (r->flags & type_mask) == type && !r->parent)
+		if (r && (r->flags & type_mask) == type)
 			return r;
 	}
 	return NULL;
@@ -903,14 +908,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
@@ -1015,7 +1022,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t min_align, align, size, size0, size1;
 	resource_size_t aligns[18]; /* Alignments from 1Mb to 128Gb */
 	int order, max_order;
-	struct resource *b_res = find_free_bus_resource(bus,
+	struct resource *b_res = find_bus_resource_of_type(bus,
 					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
@@ -1023,6 +1030,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	if (!b_res)
 		return -ENOSPC;
+	if (b_res->parent)
+		return 0;
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
-- 
2.20.1

