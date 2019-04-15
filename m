Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A29C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88082075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfDORKQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:10:16 -0400
Received: from mail-oln040092253057.outbound.protection.outlook.com ([40.92.253.57]:6149
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727823AbfDORKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 13:10:15 -0400
Received: from HK2APC01FT059.eop-APC01.prod.protection.outlook.com
 (10.152.248.57) by HK2APC01HT211.eop-APC01.prod.protection.outlook.com
 (10.152.248.239) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Mon, 15 Apr
 2019 17:10:06 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT059.mail.protection.outlook.com (10.152.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 15 Apr 2019 17:10:06 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647%6]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:10:06 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 5/5] PCI: Rename pci=hpiosize,hpmemsize,hpmemprefsize to be
 more readable
Thread-Topic: [PATCH v3 5/5] PCI: Rename pci=hpiosize,hpmemsize,hpmemprefsize
 to be more readable
Thread-Index: AQHU864SgCv+jL/MfUmgojl7SYfKWg==
Date:   Mon, 15 Apr 2019 17:10:06 +0000
Message-ID: <PS2P216MB0642266E4F4734B844CF99D9802B0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:41B27CDB15EDF625192568104422A995B892526F72DBF5D0E82EA6725CB2939F;UpperCasedChecksum:06A2C20392A602F1FBE9C3EA872953F4584430D848FE7D0E1AAA5FF0B16F6753;SizeAsReceived:7903;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [ouYyZVYQGcfIEtRsFRil38YYS1TNnV7G+T9w6Iw4OrMQKtLKjmfL8ZZriuKdzrcPIIpi88GnwFY=]
x-microsoft-original-message-id: <20190416010756.31313-7-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: zswcL9HXbeXjLSNNcQpvuD9Rx3UxByW78hxIPClDJZbFKk5FGFmJ1JbptZVMjiTvI5SQgO0HqFhd4f20X/RXQhfJqPrhpwDpDDwbd33Z4TNLBqsL7qRiP3+2EU/fQChANEq92wjTEvdmk0AJhJpSqi9Sl1pHr2fyQNiFbGPWROrvgabA14BPcvNvbMBsFM6nK0e0Rf3pK+wVAd7xU2byfKj/IOX9EQ9IsxjAQUDQT/ljxRfafcrtGmWYPAeC7xGeY9ksoN41+F5XCkm2I/p3knJ8wc4JF8hhhkcxRH4KiAaAdt6SRoLtSDG2S5f9JDoTUw+KHn8OV445DhBm7x3cYy9PWL8VaUu0Oh3KgH7Sc3U4ukWjjx8pX5L5SXUa0Akl3T1Q2sl2bbDd+mUy7v7X34K6GsltP6Z8fv1qHInAi7Ae6enZJPulVJ/lhMPKLIih4UANYgLfMxisVSuJYkjfFJJIwGXuVsno8Ed6NPcdat+yC9TXu1CRzKuwyVQ32gXC2jC0EtS3VTWvB5S9N5A75zcCLqdTh8aJ2oQru/qxcjpADnSFXPft2HBnp4GfuD5GCDUSE9OcvlCdH0QwLwdlLtAJbCSQosQoHl/LzFhiiO1f8nv0QD7rS8esLi9vysrNaj0rzGlnDc+d5R/i5X1YfKzp3IRI0xbicj9BgSHb3oK5WEU1TuArzDKRXY0byOEBzDRq9G9+ufuHZqe7CrZ+EA3/gbkvyjizsaepvttIGtmuVqwwhiUKLJVhop6cBX87
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT211;
x-ms-traffictypediagnostic: HK2APC01HT211:
x-microsoft-antispam-message-info: eknX8bv0bI4XQOL2Gtpi4YssnjhxLB5vlhNFrfUZZACSW9/vJIeWgXT/2BGAIeER3U2Jho9ll1/j4PrJG0DAyEz8djZ31ZAVF/mD5tQryoBhmQjAYfFeQQ+cD9Ny0kpSlF5vIamk4WLEM2WH3nsEFfd+kr+sRH7c5spkFUE6vWz7OBsf9sEv+V3YLDpRWx3Q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a8d906-eccb-43a4-ed61-08d6c1c534da
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:10:06.3528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT211
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename pci=hpiosize=nn[KMG] to pci=hp_io_size=nn[KMG]

Rename pci=hpmemsize=nn[KMG] to pci=hp_mmio_size=nn[KMG]

Rename pci=hpmemprefsize=nn[KMG] to pci=hp_mmio_pref_size=nn[KMG]

Update Documentation/admin-guide/kernel-parameters.txt to reflect the
above changes.

Update variable names in code to reflect the naming changes and become
more readable.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++----
 drivers/pci/pci.c                             | 23 ++++++++++---------
 drivers/pci/setup-bus.c                       | 23 ++++++++++---------
 include/linux/pci.h                           |  4 ++--
 4 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 908d01027..66ffc0e7d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3326,15 +3326,15 @@
 				the default.
 				off: Turn ECRC off
 				on: Turn ECRC on.
-		hpiosize=nn[KMG]	The fixed amount of bus space which is
+		hp_io_size=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's IO window.
 				Default size is 256 bytes.
-		hpmemsize=nn[KMG]	The fixed amount of bus space which is
+		hp_mmio_size=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's memory window.
 				Default size is 2 megabytes.
-		hpmemprefsize=nn[KMG]	The fixed amount of bus space which is
-				reserved for hotplug bridge's MMIO_PREF window.
-				Default size is 2 megabytes.
+		hp_mmio_pref_size=nn[KMG]	The fixed amount of bus space
+				which is reserved for hotplug bridge's MMIO_PREF
+				window. Default size is 2 megabytes.
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
 				Default is 1.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c36c92118..5ecc432a5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -85,12 +85,12 @@ unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
 unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 
 #define DEFAULT_HOTPLUG_IO_SIZE		(256)
-#define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
-#define DEFAULT_HOTPLUG_MEM_PREF_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
 /* pci=hpmemsize=nnM,hpiosize=nn can override this */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
-unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
-unsigned long pci_hotplug_mem_pref_size = DEFAULT_HOTPLUG_MEM_PREF_SIZE;
+unsigned long pci_hotplug_mmio_size = DEFAULT_HOTPLUG_MMIO_SIZE;
+unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
@@ -6177,13 +6177,14 @@ static int __init pci_setup(char *str)
 							strlen(str + 19));
 			} else if (!strncmp(str, "ecrc=", 5)) {
 				pcie_ecrc_get_policy(str + 5);
-			} else if (!strncmp(str, "hpiosize=", 9)) {
-				pci_hotplug_io_size = memparse(str + 9, &str);
-			} else if (!strncmp(str, "hpmemsize=", 10)) {
-				pci_hotplug_mem_size = memparse(str + 10, &str);
-			} else if (!strncmp(str, "hpmemprefsize=", 14)) {
-				pci_hotplug_mem_pref_size =
-					memparse(str + 14, &str);
+			} else if (!strncmp(str, "hp_io_size=", 11)) {
+				pci_hotplug_io_size = memparse(str + 11, &str);
+			} else if (!strncmp(str, "hp_mmio_size=", 13)) {
+				pci_hotplug_mmio_size = memparse(str + 13,
+					&str);
+			} else if (!strncmp(str, "hp_mmio_pref_size=", 18)) {
+				pci_hotplug_mmio_pref_size =
+					memparse(str + 18, &str);
 			} else if (!strncmp(str, "hpbussize=", 10)) {
 				pci_hotplug_bus_size =
 					simple_strtoul(str + 10, &str, 0);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3806c9ff0..d2df8908f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1223,8 +1223,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_io_size = 0, additional_mem_size = 0,
-		additional_mem_pref_size = 0;
+	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
+		additional_mmio_pref_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1258,8 +1258,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
-			additional_mem_size = pci_hotplug_mem_size;
-			additional_mem_pref_size = pci_hotplug_mem_pref_size;
+			additional_mmio_size = pci_hotplug_mmio_size;
+			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
 		}
 		/* Fall through */
 	default:
@@ -1277,8 +1277,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 				prefmask, prefmask,
-				realloc_head ? 0 : additional_mem_pref_size,
-				additional_mem_pref_size, realloc_head);
+				realloc_head ? 0 : additional_mmio_pref_size,
+				additional_mmio_pref_size, realloc_head);
 
 			/*
 			 * If successful, all non-prefetchable resources and any
@@ -1301,8 +1301,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			prefmask &= ~IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 				prefmask, prefmask,
-				realloc_head ? 0 : additional_mem_pref_size,
-				additional_mem_pref_size, realloc_head);
+				realloc_head ? 0 : additional_mmio_pref_size,
+				additional_mmio_pref_size, realloc_head);
 
 			/*
 			 * If successful, only non-prefetchable resources
@@ -1311,7 +1311,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_pref_size;
+				additional_mmio_size +=
+					additional_mmio_pref_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1331,8 +1332,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * prefetchable resource in a 64-bit prefetchable window.
 		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
-			realloc_head ? 0 : additional_mem_size,
-			additional_mem_size, realloc_head);
+			realloc_head ? 0 : additional_mmio_size,
+			additional_mmio_size, realloc_head);
 		break;
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a179856bf..b30d55697 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1959,8 +1959,8 @@ extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
-extern unsigned long pci_hotplug_mem_size;
-extern unsigned long pci_hotplug_mem_pref_size;
+extern unsigned long pci_hotplug_mmio_size;
+extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
 /* Architecture-specific versions may override these (weak) */
-- 
2.20.1

