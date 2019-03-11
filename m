Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A07C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 16:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E092084F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 16:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCKQYC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:24:02 -0400
Received: from mail-oln040092255103.outbound.protection.outlook.com ([40.92.255.103]:6254
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbfCKQYC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 12:24:02 -0400
Received: from HK2APC01FT058.eop-APC01.prod.protection.outlook.com
 (10.152.248.51) by HK2APC01HT235.eop-APC01.prod.protection.outlook.com
 (10.152.249.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.19; Mon, 11 Mar
 2019 16:23:56 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.58) by
 HK2APC01FT058.mail.protection.outlook.com (10.152.249.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19 via Frontend Transport; Mon, 11 Mar 2019 16:23:56 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::88f1:49d3:6e90:a74e]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::88f1:49d3:6e90:a74e%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:23:56 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 4/4] PCI: modify kernel parameters to differentiate between
 MMIO and MMIO_PREF sizes
Thread-Topic: [PATCH v2 4/4] PCI: modify kernel parameters to differentiate
 between MMIO and MMIO_PREF sizes
Thread-Index: AQHU2CbSoZE15JeUvkW3MoKArPS6MA==
Date:   Mon, 11 Mar 2019 16:23:55 +0000
Message-ID: <PS2P216MB0642F184D07467C1BA17064D80480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:3:1::19) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:6DE2D48CD57F8A039901BA9662A677E649FFCECB79F621CE830C517EFE683040;UpperCasedChecksum:905A81E97D7ED31690C6BECE2E5F2DA03000675E8FEBB042A7F69441891FA28E;SizeAsReceived:8025;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [ZyS+M/tH4M/1V+WCN7o9I1h6eOYyoXvxm0XJMmbsJPuXFbHs2Rw3rlm8kQrbHNi4o2T4Qr2lOUo=]
x-microsoft-original-message-id: <20190311162154.3852-5-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: LtmIgUwM0qRVaBwcBx1wM57KtXD5X6KtOqgQqmQ1wKEkTftBeoQvRNvdnpkFaJp2zBjJyX58ZI6qJkxWUi9riicmFXzXWi089aGhFNvwDgVWJ+s5jZwYtHKwSskKuKjPVprDxriS4Emt3kZ0m2zeoIBbQXGT7TI6/M0PmTBBZC8OM3x/IBL82su+jPT+dl8uhiPdOKM9Gz30XfvDdTm86biziBG2eWegXvN8vQUuXECiv5gbYfgFnlngBRbmVE6h76sYsEWOiMo8oR+kuFd+p89XFMowk/mIiHAgPqL2ZWtryUsrXJxigwQKdBeXlAnYGf0H3Ay3iK3SPFVYNtXR7631B+C1AR5ZCISL13Fo45dPPzVzdQE4JA6b33R2QbV8/h4p8ZMzf/Z31Cayn95VG0/lvF0dzxk0BLOJMKRP6hH2fKLtlJ/jHOGz/AUfk8ZzK+CIjIramwbjpa6/srr5n6SOFmKNQ1f5R1aWEFCQDqfYtMuSJnjAcm00goFmVXlXHs8deJawOWC68lyYDJjZOUZrjhhbj79JAvSZe+im+ocZMD+gxBKx7W7OcOArcQZooaA2EowK/uUF84nIBtFAgAifs5jPS2z73tDmu9BAQhy5NSRsMgQUlUVi8SzQ8qZzJRmGRX7y0QBXrvxe1PnTTKA9veW05WxbriwCKBlt7jMz4I0bvIJv0zyKjD0bunC0pdZyJT4V/og8jL02qvj7Jux3XowVuI+/s4M0+l05bUlsJBlT/fN+BSqIFj42rMxBJ+T9xXKgS+Fjpgc3XaqoxQ==
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(201702181274)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT235;
x-ms-traffictypediagnostic: HK2APC01HT235:
x-microsoft-antispam-message-info: HGOSdFrzJJ0fOVeL8BSbzJAo18UkvApzQgRYJ1zD+MWvHFE+UixWbqtUAOaFUV1X
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cb0f53-e55c-4c93-2d5f-08d6a63df517
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:23:55.9664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT235
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add new kernel parameters:
        - hp_io_size=nn
        - hp_mmio_size=nnM
        - hp_mmio_pref_size=nnM

Depreciate old kernel parameters and print warning when used:
        - hpiosize=nn
        - hpmemsize=nnM

Make hp_io_size function identically to hpiosize.
Make hp_mmio_size set additional size for MMIO bridge window.
Make hp_mmio_pref_size set additional size for MMIO_PREF bridge window.

Override old kernel parameters if any of the new ones are specified.

Make sure old kernel parameters still work identically when none of the
new kernel parameters are specified.

Make sure it is easy to remove old kernel parameters from the source
when it is deemed that sufficient time has passed to allow users to
migrate to the new kernel parameters.

Update documentation to reflect changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 .../admin-guide/kernel-parameters.txt         | 21 ++++++++--
 drivers/pci/pci.c                             | 39 +++++++++++++++++--
 drivers/pci/setup-bus.c                       | 26 +++++++------
 include/linux/pci.h                           |  3 +-
 4 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0b9..29406ae8f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3326,12 +3326,27 @@
 				the default.
 				off: Turn ECRC off
 				on: Turn ECRC on.
-		hpiosize=nn[KMG]	The fixed amount of bus space which is
+
+		hpiosize=nn[KMG]	Depreciated. Overridden by hp_io_size
+				value if any of hp_io_size, hp_mmio_size
+				or hp_mmio_pref_size are used. This sets
+				hp_io_size to the given value if not
+				overridden.
+
+		hpmemsize=nn[KMG]	Depreciated. Overridden if any of
+				hp_io_size, hp_mmio_size or
+				hp_mmio_pref_size are used. This sets
+				hp_mmio_size and hp_mmio_pref_size to
+				the given value if not overridden.
+		hp_io_size=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's IO window.
 				Default size is 256 bytes.
-		hpmemsize=nn[KMG]	The fixed amount of bus space which is
-				reserved for hotplug bridge's memory window.
+		hp_mmio_size=nn[KMG]	The fixed amount of bus space which is
+				reserved for hotplug bridge's 32-bit mmio window.
 				Default size is 2 megabytes.
+		hp_mmio_pref_size=nn[KMG]	The fixed amount of bus space
+				which is reserved for hotplug bridge's 64-bit
+				mmio_pref window. Default size is 2 megabytes.
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
 				Default is 1.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c25acace7..64978bf84 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -85,12 +85,15 @@ unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
 unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 
 #define DEFAULT_HOTPLUG_IO_SIZE		(256)
-#define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
-/* pci=hpmemsize=nnM,hpiosize=nn can override this */
+#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
+/* Override with pci=hp_io_size=nn,hp_mmio_size=nnM,hp_mmio_pref_size=nnM */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
-unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
+unsigned long pci_hotplug_mmio_size  = DEFAULT_HOTPLUG_MMIO_SIZE;
+unsigned long pci_hotplug_mmio_pref_size  = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
+/* Override with pci=hpbussize=nn,assign-busses */
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
@@ -6144,6 +6147,15 @@ EXPORT_SYMBOL(pci_fixup_cardbus);
 
 static int __init pci_setup(char *str)
 {
+	/*
+	 * Depreciated pci=hpmemsize=nnM but keep the functionality for now.
+	 * If none of hp_io_size, hp_mmio_size or hp_mmio_pref_size are set
+	 * then override hp_mmio_size and hp_mmio_pref_size with hpmemsize.
+	 */
+	unsigned long pci_hotplug_io_size_old = DEFAULT_HOTPLUG_IO_SIZE;
+	unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MMIO_SIZE;
+	bool use_new_pci_hotplug_params = 0;
+
 	while (str) {
 		char *k = strchr(str, ',');
 		if (k)
@@ -6176,9 +6188,23 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "ecrc=", 5)) {
 				pcie_ecrc_get_policy(str + 5);
 			} else if (!strncmp(str, "hpiosize=", 9)) {
-				pci_hotplug_io_size = memparse(str + 9, &str);
+				printk(KERN_WARNING "PCI: Depreciated option 'hpiosize', use 'hp_io_size' instead\n");
+				pci_hotplug_io_size_old =
+					memparse(str + 9, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
+				printk(KERN_WARNING "PCI: Depreciated option 'hpmemsize', use 'hp_mmio_size' and 'hp_mmio_pref_size' instead\n");
 				pci_hotplug_mem_size = memparse(str + 10, &str);
+			} else if (!strncmp(str, "hp_io_size=", 11)) {
+				use_new_pci_hotplug_params = 1;
+				pci_hotplug_io_size = memparse(str + 11, &str);
+			} else if (!strncmp(str, "hp_mmio_size=", 13)) {
+				use_new_pci_hotplug_params = 1;
+				pci_hotplug_mmio_size =
+					memparse(str + 13, &str);
+			} else if (!strncmp(str, "hp_mmio_pref_size=", 18)) {
+				use_new_pci_hotplug_params = 1;
+				pci_hotplug_mmio_pref_size =
+					memparse(str + 18, &str);
 			} else if (!strncmp(str, "hpbussize=", 10)) {
 				pci_hotplug_bus_size =
 					simple_strtoul(str + 10, &str, 0);
@@ -6204,6 +6230,11 @@ static int __init pci_setup(char *str)
 		}
 		str = k;
 	}
+	if (!use_new_pci_hotplug_params) {
+		pci_hotplug_io_size = pci_hotplug_io_size_old;
+		pci_hotplug_mmio_size = pci_hotplug_mem_size;
+		pci_hotplug_mmio_pref_size = pci_hotplug_mem_size;
+	}
 	return 0;
 }
 early_param("pci", pci_setup);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index efe899b02..56d227227 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1223,7 +1223,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
+		additional_mmio_pref_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1256,8 +1257,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	case PCI_CLASS_BRIDGE_PCI:
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
-			additional_io_size  = pci_hotplug_io_size;
-			additional_mem_size = pci_hotplug_mem_size;
+			additional_io_size = pci_hotplug_io_size;
+			additional_mmio_size = pci_hotplug_mmio_size;
+			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
 		}
 		/* Fall through */
 	default:
@@ -1275,9 +1277,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 				  prefmask, prefmask,
-				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head);
-
+				  realloc_head ? 0 : additional_mmio_pref_size,
+				  additional_mmio_pref_size, realloc_head);
 			/*
 			 * If successful, all non-prefetchable resources and any
 			 * 32-bit prefetchable resources will go in the
@@ -1298,9 +1299,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
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
@@ -1309,7 +1310,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_size;
+				additional_mmio_size +=
+					additional_mmio_pref_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1329,8 +1331,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * prefetchable resource in a 64-bit prefetchable window.
 		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
-				realloc_head ? 0 : additional_mem_size,
-				additional_mem_size, realloc_head);
+				realloc_head ? 0 : additional_mmio_size,
+				additional_mmio_size, realloc_head);
 		break;
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f..b30d55697 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1959,7 +1959,8 @@ extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
-extern unsigned long pci_hotplug_mem_size;
+extern unsigned long pci_hotplug_mmio_size;
+extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
 /* Architecture-specific versions may override these (weak) */
-- 
2.20.1

