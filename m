Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4E3C169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 10:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4042B2083B
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 10:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfBFKZy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:25:54 -0500
Received: from mail-oln040092253052.outbound.protection.outlook.com ([40.92.253.52]:62720
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfBFKZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Feb 2019 05:25:53 -0500
Received: from HK2APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.248.52) by HK2APC01HT226.eop-APC01.prod.protection.outlook.com
 (10.152.249.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Wed, 6 Feb
 2019 10:25:36 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT035.mail.protection.outlook.com (10.152.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 6 Feb 2019 10:25:36 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::cc10:24a5:4249:7da]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::cc10:24a5:4249:7da%2]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 10:25:36 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
CC:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH 2/2] PCI: modify kernel parameters to differentiate between
 MMIO and MMIO_PREF sizes
Thread-Topic: [PATCH 2/2] PCI: modify kernel parameters to differentiate
 between MMIO and MMIO_PREF sizes
Thread-Index: AQHUvgZMccmOG93KK0yqItnPf4cWVA==
Date:   Wed, 6 Feb 2019 10:25:36 +0000
Message-ID: <PS2P216MB0642282AB6E92426C5D1CD20806F0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190206182446.26234-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190206182446.26234-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0050.ausprd01.prod.outlook.com
 (2603:10c6:10:2::14) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:AAF6DE51F85436E62DC4E31E2BEF18B4BB4626C92EE5C61915DC55FB8869FA2A;UpperCasedChecksum:AB53FB4310376F77E554B7218A5A996EDE5FC8AC383035275F97A7F39D14B1A2;SizeAsReceived:9443;Count:64
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [ydj2psVdciYDMv+h1ZTL/ChkmPzG93yj]
x-microsoft-original-message-id: <20190206182446.26234-2-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2APC01HT226;6:ORo3Y2CXyqGxgSByOufsv15OsFzcD6DHNGUmoC7uZiaI54Wbuy8OdCg8hDYC0Qi9INVtdwuJ47CCXAxCvcTSz8bqWa9jb4Nmsdz4g9cY3iZacR7IT8Ku6GnsZM2t0plM1NQhdZ/holnm8mlz4CBuDGmNP2p3cUhZMsep+7LCzbrp1kWzxAPDtR1CGWjGSnXt5qY0Zm4aN2KXcaJP66ziwHC6JKtSmiaHpgTIsnmuZdZVTxyKInlysutIIpRwF+/g0D8F2o9PbhdwMVyOtGMDn0/mlIoviCRdnD3UPQ58mMUcqxbrxVPBMJFW0bUhKaqgiEE45xE2qFjfYHDCEVwTAODZUUOn/o9Bu26/MrpjRxrIZiLMc6NK1TyHoB4sn59e+3DnmNZc4IvR9pII5+8Wf4LYe6HTLaonrPV5DbOVUPSHO3jmdjAJ7294B8h8vB24D++U79gSflqQz/8DAqaYlA==;5:xL6/QNXwma0zM7lyA+zK/mU7qDk+YwM3s21zqkM2fyzYOBAX4tAlrCzMMvUBKFsfXrpi+qFnsQrdKk4bnXfb42s40K+10Aypx3UxfuPxm0AMEyptOuWniuh+HfB2HuDn33h40U/E563A12N7w65NPJ8EFqjzu8vp53cp6de9K4g7aYkWTr7alsCMKoxij99d2iBKV2zl5USEk/gvYoEzkw==;7:gtTeYnUBvEh+WC7saB5Jax3OVmQTRsIfT7jcRqSHDei/FnQHzsMrOftcjX8B/z0k0xVCLUd5wnBFWmqg6L6dunabG0TKp1MiyfwI8pW1Afq1f9/IJPpZO70+PrEgKKgh6946Z/hLZq87KRntTCr6tg==
x-incomingheadercount: 64
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBRmoEB1kyLsy4P9cPpbldR5wMpwkK92bBHKoUXB3TM+SaASjU194vITYum9qPMtr4uqHNfVTGM5S9yLp5jj4MRc+BKGQE7w1vDM2R3v7xxcZz1jr2/kpA32HxMMwFU4haNMpBf2DD8SBWFEQOqoKHoRabh2X7C84HKBwvbjK0RrHG6VVImXf0JEJLopxkHlsQbA2EGY//8qsvh6aLX/bNMo95eABtpXFb4928OTNZS9hAfHvqC4Ttd/KQ09VRmYh87fYM0F+z2hZoB1z7YjvhwkBV2OBm4dmrLv0RuJwg+w8OOJquX07w96q4T3AUTCbg9IIBeiNwfiTAGNC6Uh/ou2nUliX8l/7rgPHUlb52q5Ab9LgP1TMtKLxxMuN6XmAT1Y7GK2FBrlWDoBZ1NxwqTty2UiMOD4LxY96klwG/bJM47tQmaZMS53GvrIDSW4iS3v+mvVnphSFQAY87tFZpktbXRaInt5xv2x5AfjzGWeCABkFyVErqxbNcwpoi3msbatuc6HS9mXwUKTAlHdQEEeVrIbGNYiN6UZfltEi+t0yIaTsnOYkYNhKNw7k8tv5zVYpWBjkriCJ3baq/tkK3vvuLVOooGtFFW1Mbf4Y3z0RwRFxPcCrIff8JriDBI06QmLq6LyO5QI93vfxuLidevBs0Fw1WOvMMlp8RntbICAsExeG8bT2vsSjjlUE7hvHqDKpwt79ggtj9wvkFwHgiqeSNUq25oWVJmDKPerjI0gIcmI2f8psewOE90qQ3bSUNOv4DAQB2E=
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT226;
x-ms-traffictypediagnostic: HK2APC01HT226:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:HK2APC01HT226;BCL:0;PCL:0;RULEID:;SRVR:HK2APC01HT226;
x-microsoft-antispam-message-info: KULptqYKP66OKVNvj9eyv/CKvQH/Zvq1n12uMJhbe9hTrzhsUjtyt0PKkhNXZTIM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6f76ff-92a3-4d1a-b412-08d68c1d6edd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:25:35.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT226
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Depends:
commit a1140e7bcb10ff96c192ee200e6cbf832f27158e
("PCI: fix serious bug when sizing bridges with additional size")

Background: I have come to find that the kernel parameters for reserving
resources for the hotplug bridges are not useful for Thunderbolt with
native PCI enumeration. You can only increase the size so far before it
fails to allocate the 32-bit MMIO windows.

Nature of problem: pci=hpmemsize=nnM is parsed from drivers/pci/pci.c
and used in drivers/pci/setup-bus.c. It overwrites pci_hotplug_mem_size
which has a default value set by DEFAULT_HOTPLUG_MEM_SIZE. When used,
this value is used to request additional space for MMIO and MMIO_PREF in
equal amounts.

The fallout: if you increase the value of pci=hpmemsize=nnM to be too
large to fit into the 32-bit address space, the MMIO window fails to
allocate and has zero-sized BARs. In the case of Thunderbolt, this means
the NHI does not have the resources needed to function, and the
thunderbolt.ko driver fails to probe the device. All Thunderbolt
functionality is lost. Even if the NHI worked, any Thunderbolt device
containing endpoints with 32-bit BARs (most of them) would fail to
initialise properly. The worst case happens if some resources end up
allocating with non-zero size, but too small. With some AMD Radeon
external GPUs, if certain combinations of BARs are assigned / failed to
assign, it can cause BUG_ON from arch/x86/mm/pat.c due to the buggy
amdgpu.ko driver trying to use a zero-sized BAR, instead of failing
gracefully. This more or less renders the system unusable.

The cause: because the kernel parameters do not allow the user to
specify the MMIO and MMIO_PREF hotplug bridge additional sizes
separately, they have no choice but to give unrealistic sizes that will
fail, or will be forced to make unpleasant compromises, resulting in
having to tolerate unstable or unpredictable operation.

The solution: My proposed patch depreciates
pci=hpmemsize=nnM,hpiosize=nn but allows them to work without any change
in user-visible functionality, with a KERN_WARNING message when either
are used. It adds the new parameters
pci=hp_io_size=nn,hp_mmio_size=nnM,hp_mmio_pref_size=nnM. If any of the
new kernel parameters are used, all of the newly-depreciated ones will
be overridden. This will allow for a grace period to allow people to
change to the new kernel parameters without unpleasant disruption. At a
time deemed appropriate by kernel developers, the old parameters can be
easily removed without the need to rework any code.

My testing: This works very well. I have not encountered any problems
and I am happily allocating 128M/64G under each Thunderbolt port with
nocrs. The success is dependent on my previous bug patch, which I
decided to separate from this feature patch. The old functionality still
works the same, and is overridden by the new commands if they are used.

Remarks: The printk at the end of pci_setup() in drivers/pci/pci.c has a
strange backquote ('`', under the tilde on the keyboard key) in the
format. I am not sure if it is a typo, or deliberate, and whether it
should change or if my KERN_WARNING logs need to use that symbol. Also,
the scripts/checkpatch.pl berates me for using printk, but the
alternative, pci_warn(), requires a pci_dev to work, and this message
does not pertain to a particular device.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 .../admin-guide/kernel-parameters.txt         | 21 ++++++++--
 drivers/pci/pci.c                             | 39 +++++++++++++++++--
 drivers/pci/setup-bus.c                       | 26 +++++++------
 include/linux/pci.h                           |  3 +-
 4 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67..284752ff7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3327,12 +3327,27 @@
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
index c7e0a5e2b..e4cdc6484 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1234,7 +1234,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
+		additional_mmio_pref_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1267,8 +1268,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
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
@@ -1287,9 +1289,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 				  prefmask, prefmask,
-				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head);
-
+				  realloc_head ? 0 : additional_mmio_pref_size,
+				  additional_mmio_pref_size, realloc_head);
 			/*
 			 * If successful, all non-prefetchable resources
 			 * and any 32-bit prefetchable resources will go in
@@ -1310,9 +1311,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
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
@@ -1321,7 +1322,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_size;
+				additional_mmio_size +=
+					additional_mmio_pref_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1342,8 +1344,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * window.
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
2.19.1

