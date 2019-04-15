Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB21EC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775B02075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfDORJs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:09:48 -0400
Received: from mail-oln040092255044.outbound.protection.outlook.com ([40.92.255.44]:20160
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727186AbfDORJr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 13:09:47 -0400
Received: from HK2APC01FT059.eop-APC01.prod.protection.outlook.com
 (10.152.248.54) by HK2APC01HT128.eop-APC01.prod.protection.outlook.com
 (10.152.248.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Mon, 15 Apr
 2019 17:09:43 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT059.mail.protection.outlook.com (10.152.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 15 Apr 2019 17:09:43 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647%6]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:09:43 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 3/5] PCI: Fix serious bug when sizing bridges with
 additional size
Thread-Topic: [PATCH v3 3/5] PCI: Fix serious bug when sizing bridges with
 additional size
Thread-Index: AQHU864E3j6/X6V0I02rUqV0pT1uVQ==
Date:   Mon, 15 Apr 2019 17:09:43 +0000
Message-ID: <PS2P216MB064249D559CA74018B2E02EF802B0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0087.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::13) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:32BC4E01E12A65BA0C8BBA66BB9B68C76039A0E5D8ABA35F8B997F1AAE072661;UpperCasedChecksum:2B51B0981655019053F7BF6B263E04904DF05A21351C744AD0BC449702E6F68E;SizeAsReceived:7914;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [jYtfQpo7npJGBpPrVC+jJaa0tnRwWz9vU3Bjjd5UNpA/cNpBhr6iK0Rd22y6UPow0ZVwXQXUUT0=]
x-microsoft-original-message-id: <20190416010756.31313-5-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: zswcL9HXbeXjLSNNcQpvuD9Rx3UxByW7VdAOpjuRFXPDNWJrwm9JHt/igX1n5n2+0ujgTnH+Mu1wHkr1P+PXy6emq9MKrKvTAPCo3aOZBEh6MMzTJ/00GpymEgJcCW830CClkVUyIrJc8/KVvaNxkQnlDqhIsu6+DQh96YFX+TV5fUIQePeqnZKcFkD4ZrORZ0nXhWiRpqF8m104UCLpCxwatW1nMnOs8OhVAV3JFBO9X7eKbxl39e53M8G/cInqbFht2b23PaBjp1Snezd87UjX2b85VaRixnDpqRVEP+4w9RgsRhWFNTaFX6ujoiDHk2YSz1KeS/ZQyXyyyXyqglY7op5WGUG5mhCAr9WgsIg+cGp1y3JpvDYTzxlzL6JbcMqZ6CrdLFbNb9oQmIx/WTBhcRrGDJVy53wJ+rPH1viah1AgssyKAmEdtwOvfl4tux47nQLe62e69grPfJ60l5whSJ1HnJFJ/LzJBFM0tsgLe3WcH/ko2FpoDViNElecxFuh8JmqmEXZ2EesmNLW9GwKnOdEZed6/cRbUdIy4Rx8u/q5Gxrx5HAt9t3CAa8cavU8RaegUnGZiX9m7qD3+E3mMUM4bZrEBLbXDWOlRN5LDk11UhMPWCl3Aj5Wao/al+wGSERmm3QFWu0lQQ86s/odGIGuQ2aVcp1nn2Busas8qYSuJPAPfaCDtx+87D85vdZCepYqBWcLq7eIuMJnWZgi8hLRGKfAajqK6rpJwErTy2WWpWZj4jVYOYKPYQUj
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT128;
x-ms-traffictypediagnostic: HK2APC01HT128:
x-microsoft-antispam-message-info: tbMpUnSA6G8N1MV+hqt+bQ6I2CQY0+gDbtATXtgtnumP+BOiF+gzDUzkM8wKyPJYoN6XW1h/AjoXd0/vlTEtaOVDpsDTORxeaJhvAzn9ruj0SoUCppoR3uU6Ll4r/FMrF+yCjJTHhVnBTRS80hAj+YWn8kBpJKZO0/t1NfsqVtkKNe84COLHFzpgGQma2n/a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: de425663-1755-4725-8323-08d6c1c5272e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:09:43.3234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT128
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

