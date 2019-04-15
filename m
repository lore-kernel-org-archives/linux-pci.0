Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC326C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB222075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfDORKA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:10:00 -0400
Received: from mail-oln040092253031.outbound.protection.outlook.com ([40.92.253.31]:6106
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727908AbfDORKA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 13:10:00 -0400
Received: from HK2APC01FT059.eop-APC01.prod.protection.outlook.com
 (10.152.248.60) by HK2APC01HT172.eop-APC01.prod.protection.outlook.com
 (10.152.249.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Mon, 15 Apr
 2019 17:09:54 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT059.mail.protection.outlook.com (10.152.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 15 Apr 2019 17:09:54 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::50ee:2afa:f5b:9647%6]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:09:54 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 4/5] PCI: modify kernel parameters to differentiate between
 MMIO and MMIO_PREF sizes
Thread-Topic: [PATCH v3 4/5] PCI: modify kernel parameters to differentiate
 between MMIO and MMIO_PREF sizes
Thread-Index: AQHU864LL3OGeK6GSU6lojrdSk0U0A==
Date:   Mon, 15 Apr 2019 17:09:54 +0000
Message-ID: <PS2P216MB0642E5E20E4B1895BD600487802B0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190416010756.31313-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0085.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::11) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:E0663390A8087AA0D5AC55D127C3F718FC01BC7971ECE70E4C3F576791501A47;UpperCasedChecksum:9D39C671F839B369109ABD8EA32AAFDC16A0D8AC7EFBFB37448919222B990774;SizeAsReceived:7964;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [XBrXi9mH+s6yqVGTW7Qa2t7XKQKxoqjhubl1zMEth4PdugitjMthwNTN6b/YUuqtU+KLomnk1ck=]
x-microsoft-original-message-id: <20190416010756.31313-6-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: LtmIgUwM0qQW+fxQnmb0JSczgOqcUbt16rkAtHivjjgvmywNfw791VYVUIGI8HXTZbci1sNqi3rS3henGUlrImrwtyfxiVZCCt4tr3mB6G4xCM02jOwDnR2L4FJxx1+rL0axGk8VG2yJG4nl9J+NdBvPWmMUDE3ikV0V+kNb9kMaePF/O9J6PlF12VF6cfuL7C0bLcduttVa4cUAdUm0zeSNGKmyDpoQVjlAENZl8BPL0lrKm1n40dK9Vzjs/qDR4WszK55YMEYtChDAHgxrSU/hQkea/y8qlKnEu3FrDI+TRCbonfNqsvnYKCr0kIYiOuBdEhs06StAa11dkFrkGIOOmXqIdqHS/h+Dncp3WSXfdIrcggQnoNiVMbbfM5uWec4QxPR0tpUbNk5qDjLPEii+psSvUYAdNI4U9sW7Ejaq4YHKAJRWirbdvG1yif0nfqnMbf5+vla+9sRQ5Ug2D4BLjen4lx1+HbnNjbK9dZs/9KbS/DsLbyTT2nePqoVo6wDuXK0ueYS2GPByuuL6HUHJVycXDnksmRkfIxp5oeZTtWrbqfX/pcqParukRTSstZ+x2tLE3QjlE5+koTbi2nkwHm7Om9TZTB1Px9Hqkih6JV+fgAEOj/Wy5dX9taBP4RMcnEHATWK2i2u8/6FNkQuQq7iRn+dlEFczCA1MYh4gE5wtjE523IWm2La56OqABCljsQ9UL4bk7dMxtEvvPZSfHf7TseX93i/QpVTbEhjLAeOepp7cIMj0AU8DTJ2KELtavUImAxhOqaLuQwYFZA==
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT172;
x-ms-traffictypediagnostic: HK2APC01HT172:
x-microsoft-antispam-message-info: 3Iw56PzN4tPN67i2NHRB9RRvEFnLIAJVJOcSk4gT2zLm2xdlR5ljWFTHRPbd5xxZ7oWDGEzLRwbsuzMK0Fv/9QiT8EYzg1Wtk4g0Uu25QkPTW6Apyww5EfFH/6j56pSzeQ/lJEObT0BdojwxeSmM0N948BXyHP2qZbVZ22XdEoYXUDh8OHO1C5PdpqxKM+RU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f448f143-1384-4d3b-fa0b-08d6c1c52de1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:09:54.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT172
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add kernel parameter pci=hpmemprefsize=nn[KMG] to control MMIO_PREF
size.

Change behaviour of pci=hpmemsize=nn[KMG] to only control MMIO size,
rather than controlling both MMIO and MMIO_PREF sizes.

Update kernel-parameters documentation to reflect the above changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 drivers/pci/pci.c                             |  5 +++++
 drivers/pci/setup-bus.c                       | 22 ++++++++++---------
 include/linux/pci.h                           |  1 +
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0b9..908d01027 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3332,6 +3332,9 @@
 		hpmemsize=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's memory window.
 				Default size is 2 megabytes.
+		hpmemprefsize=nn[KMG]	The fixed amount of bus space which is
+				reserved for hotplug bridge's MMIO_PREF window.
+				Default size is 2 megabytes.
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
 				Default is 1.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c25acace7..c36c92118 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -86,9 +86,11 @@ unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 
 #define DEFAULT_HOTPLUG_IO_SIZE		(256)
 #define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MEM_PREF_SIZE	(2*1024*1024)
 /* pci=hpmemsize=nnM,hpiosize=nn can override this */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
 unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
+unsigned long pci_hotplug_mem_pref_size = DEFAULT_HOTPLUG_MEM_PREF_SIZE;
 
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
@@ -6179,6 +6181,9 @@ static int __init pci_setup(char *str)
 				pci_hotplug_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
 				pci_hotplug_mem_size = memparse(str + 10, &str);
+			} else if (!strncmp(str, "hpmemprefsize=", 14)) {
+				pci_hotplug_mem_pref_size =
+					memparse(str + 14, &str);
 			} else if (!strncmp(str, "hpbussize=", 10)) {
 				pci_hotplug_bus_size =
 					simple_strtoul(str + 10, &str, 0);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index efe899b02..3806c9ff0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1223,7 +1223,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	resource_size_t additional_io_size = 0, additional_mem_size = 0,
+		additional_mem_pref_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1258,6 +1259,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mem_size = pci_hotplug_mem_size;
+			additional_mem_pref_size = pci_hotplug_mem_pref_size;
 		}
 		/* Fall through */
 	default:
@@ -1274,9 +1276,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (b_res[2].flags & IORESOURCE_MEM_64) {
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
-				  prefmask, prefmask,
-				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head);
+				prefmask, prefmask,
+				realloc_head ? 0 : additional_mem_pref_size,
+				additional_mem_pref_size, realloc_head);
 
 			/*
 			 * If successful, all non-prefetchable resources and any
@@ -1298,9 +1300,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (!type2) {
 			prefmask &= ~IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
-					 prefmask, prefmask,
-					 realloc_head ? 0 : additional_mem_size,
-					 additional_mem_size, realloc_head);
+				prefmask, prefmask,
+				realloc_head ? 0 : additional_mem_pref_size,
+				additional_mem_pref_size, realloc_head);
 
 			/*
 			 * If successful, only non-prefetchable resources
@@ -1309,7 +1311,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_size;
+				additional_mem_size += additional_mem_pref_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1329,8 +1331,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * prefetchable resource in a 64-bit prefetchable window.
 		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
-				realloc_head ? 0 : additional_mem_size,
-				additional_mem_size, realloc_head);
+			realloc_head ? 0 : additional_mem_size,
+			additional_mem_size, realloc_head);
 		break;
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f..a179856bf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1960,6 +1960,7 @@ extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mem_size;
+extern unsigned long pci_hotplug_mem_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
 /* Architecture-specific versions may override these (weak) */
-- 
2.20.1

