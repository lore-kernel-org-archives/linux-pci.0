Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25433C282DD
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31192177B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfDQORK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:17:10 -0400
Received: from mail-oln040092254050.outbound.protection.outlook.com ([40.92.254.50]:46084
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732105AbfDQORJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 10:17:09 -0400
Received: from HK2APC01FT008.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT018.eop-APC01.prod.protection.outlook.com
 (10.152.249.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Wed, 17 Apr
 2019 14:16:59 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT008.mail.protection.outlook.com (10.152.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Wed, 17 Apr 2019 14:16:59 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::adb3:4c16:60fd:65]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::adb3:4c16:60fd:65%5]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 14:16:59 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v4 3/4] PCI: Modify kernel parameters to differentiate between
 MMIO and MMIO_PREF sizes
Thread-Topic: [PATCH v4 3/4] PCI: Modify kernel parameters to differentiate
 between MMIO and MMIO_PREF sizes
Thread-Index: AQHU9Sg4dNe5cRl7SUmHebwitGRZzQ==
Date:   Wed, 17 Apr 2019 14:16:59 +0000
Message-ID: <PS2P216MB0642A4E43D8528D0B65C077780250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190417141610.6730-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190417141610.6730-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:BDCAEE2EF4B706058053BC38E37A9EDB211DD91E61FD09508EE4EA67F07AB586;UpperCasedChecksum:A8FEFFB4C2548FDD63E9A61AE5CE476704F75D9EB0F87AD07B279B563A162598;SizeAsReceived:7858;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [ygJSEG027QihQTG8bBhSsyUg15RgdZo0ws/oXi9Nz1g=]
x-microsoft-original-message-id: <20190417141610.6730-4-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: LtmIgUwM0qSIxq0Ww8akoyXrG9MYRnDXLdSVOZ79FhyfWge6A2//beqkGOzJQDemaxWTcOwRCOK6rDufCsOL/XwjBvb0UWGos+L5U5Iwuq9CyB01uaRaA4HRDMJ1nW500MHetE7raJ/aEV/oBnfwBeWvFyRXhDGJyjRXdGtD6nSIKpyvUcCMAIOAVJcBbBcdYnzXzwywWP3ou5W6RNDM8UDCLxkp37qcXL+ybZQ27god/fQ7s2qmeK048rpn0+QZd/gO2EHemjsz6miAc8lzgajJxLdBAmL+cqzangEZXeXw35weIW+DvLUd1B2B9GO48aOqq5P8n7KNFrR/mzo5fkvlYBGSPygz13ePzEmSKwUd5477zVr+k9X6GdzyT5O/AxYhTHH2f8UhORrvf4YDttvCjsW7ezJbHmOzSWoPDpDEPp0G9khKy/Cm976zbp2MPmiQCWOlqLhzAw+sBBtMVLWQmZs5daSw+0LenJ9CaRa9j53Oq4S+a4VxA2Svg3cCTwft7ZZgRv0R+LWQGmq5iOkSCiz74ExbVXkdgBBO4bz7ICGfuDjep8/i8UBeyBFkbbtue8hz9EGpzCK9oMfIXctIQRfUPv+cVowgZwY9bq7KMj06QihrZEAYpcBV6NvjmbP02fdh0pNJoVd/3+hZvpmpa9tvRCKT98zuW18OZDvXgyI/ex/2cwJJxmGu7xnQgYcHsDhLdJEdQbrJ5GeP3R6UbEr3HGpeHnY7zi08NyrCO3svm24Xr2HL6mae8rlNUGlJh2bS33hfZGzrCXtyNg==
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:HK2APC01HT018;
x-ms-traffictypediagnostic: HK2APC01HT018:
x-microsoft-antispam-message-info: yU3JNF0fHRsnSidHdcu3xkZUX/YS8Wdr+HWS0Jev2IbMnrPGaPPH7nt0qK/WwJgY4XzBRcPtYAFS1lBhNO6qa2EfaQpMYzoq0YQ5wEUSuGFUalgeo6xi5EbZt4LdGYcxYaZ9Vns7J9PROvR1wqdn8NG8ZcMmPuclAy4qfe7JVM2hT3IH7lz0Yu/w3jqGR1Y7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8188ac88-02da-4fb4-76bc-08d6c33f5a91
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 14:16:59.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT018
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add kernel parameter pci=hpmemprefsize=nn[KMG] to control MMIO_PREF
size for PCI hotplug bridges.

Change behaviour of pci=hpmemsize=nn[KMG] to only control MMIO size,
rather than controlling both MMIO and MMIO_PREF sizes.

Update kernel-parameters documentation to reflect the above changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++-
 drivers/pci/pci.c                             | 12 ++++++---
 drivers/pci/setup-bus.c                       | 25 +++++++++++--------
 include/linux/pci.h                           |  3 ++-
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb..f33b590c2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3361,7 +3361,10 @@
 				reserved for hotplug bridge's IO window.
 				Default size is 256 bytes.
 		hpmemsize=nn[KMG]	The fixed amount of bus space which is
-				reserved for hotplug bridge's memory window.
+				reserved for hotplug bridge's MMIO window.
+				Default size is 2 megabytes.
+		hpmemprefsize=nn[KMG]	The fixed amount of bus space which is
+				reserved for hotplug bridge's MMIO_PREF window.
 				Default size is 2 megabytes.
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c1b362f5..e0502831f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -85,10 +85,12 @@ unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
 unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 
 #define DEFAULT_HOTPLUG_IO_SIZE		(256)
-#define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
 /* pci=hpmemsize=nnM,hpiosize=nn can override this */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
-unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
+unsigned long pci_hotplug_mmio_size = DEFAULT_HOTPLUG_MMIO_SIZE;
+unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
@@ -6245,7 +6247,11 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "hpiosize=", 9)) {
 				pci_hotplug_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
-				pci_hotplug_mem_size = memparse(str + 10, &str);
+				pci_hotplug_mmio_size =
+					memparse(str + 10, &str);
+			} else if (!strncmp(str, "hpmemprefsize=", 14)) {
+				pci_hotplug_mmio_pref_size =
+					memparse(str + 14, &str);
 			} else if (!strncmp(str, "hpbussize=", 10)) {
 				pci_hotplug_bus_size =
 					simple_strtoul(str + 10, &str, 0);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5b9ee9945..95149165a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1187,7 +1187,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
+		additional_mmio_pref_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1221,7 +1222,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
-			additional_mem_size = pci_hotplug_mem_size;
+			additional_mmio_size = pci_hotplug_mmio_size;
+			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
 		}
 		/* Fall through */
 	default:
@@ -1239,9 +1241,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (b_res[2].flags & IORESOURCE_MEM_64) {
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
-				  prefmask, prefmask,
-				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head);
+				prefmask, prefmask,
+				realloc_head ? 0 : additional_mmio_pref_size,
+				additional_mmio_pref_size, realloc_head);
 
 			/*
 			 * If successful, all non-prefetchable resources
@@ -1263,9 +1265,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (!type2) {
 			prefmask &= ~IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
-					 prefmask, prefmask,
-					 realloc_head ? 0 : additional_mem_size,
-					 additional_mem_size, realloc_head);
+				prefmask, prefmask,
+				realloc_head ? 0 : additional_mmio_pref_size,
+				additional_mmio_pref_size, realloc_head);
 
 			/*
 			 * If successful, only non-prefetchable resources
@@ -1274,7 +1276,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_size;
+				additional_mmio_size +=
+					additional_mmio_pref_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1295,8 +1298,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * window.
 		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
-				realloc_head ? 0 : additional_mem_size,
-				additional_mem_size, realloc_head);
+			realloc_head ? 0 : additional_mmio_size,
+			additional_mmio_size, realloc_head);
 		break;
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77448215e..7ab8f5b88 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1964,7 +1964,8 @@ extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
-extern unsigned long pci_hotplug_mem_size;
+extern unsigned long pci_hotplug_mmio_size;
+extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
 /* Architecture-specific versions may override these (weak) */
-- 
2.20.1

