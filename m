Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:29089
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751680AbdLFR6z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Dec 2017 12:58:55 -0500
Subject: Re: [regression] PCI early boot hang on certain AMD systems
To: Ingo Molnar <mingo@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20171115185855.GA11685@bhelgaas-glaptop.roam.corp.google.com>
 <20171206161649.7ievlr7adshlxlho@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <219224e6-71f5-3209-09d5-9863a0b6fd4a@amd.com>
Date: Wed, 6 Dec 2017 18:58:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171206161649.7ievlr7adshlxlho@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------D52FCFD4D90AE8955DEAAE55"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------D52FCFD4D90AE8955DEAAE55
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ingo,

known issue with multi socket systems and the patch in question.

The attached set of patches should fix the issue and are already send to 
Bjorn for inclusion in the next rc.

Sorry for the noise,
Christian.

Am 06.12.2017 um 17:16 schrieb Ingo Molnar:
> Hi,
>
> * Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> PCI changes:
>> Christian K�nig (4):
>>        x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)
> In v4.15 one of my test systems broke, it hangs in early bootup, during early PCI
> setup:
>
> [    2.262005] pci 0000:00:18.1: adding root bus resource [mem 0x1027000000-0xfcffffffff 64bit pref window] <--- new resource
> [    2.270081] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
> [    2.271081] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
> [    2.272083] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
> [    2.273079] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
> [    2.274083] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
> [    2.275089] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
> [  hard hang ]
>
> I have bisected the hang to:
>
>    fa564ad96366: x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)
>
> Reverting the commit makes the system boot again. The 'new resource' line above is
> I believe the new BAR added by the commit.
>
> I've attached the earlyprintk boot log of the hang, with a few printks added to
> pci_amd_enable_64bit_bar() of the relevant fields:
>
> +       printk("res->start: %016llx\n", res->start);
> +       printk("res->end:   %016llx\n", res->end);
> +       printk("base:       %08x\n", base);
> +       printk("high:       %08x\n", high);
> +       printk("limit:      %08x\n", limit);
> +       printk("slot:       %d\n", i);
>
> [    2.261090] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
> [    2.262005] pci 0000:00:18.1: adding root bus resource [mem 0x1027000000-0xfcffffffff 64bit pref window]
> [    2.264001] res->start: 0000001027000000
> [    2.265001] res->end:   000000fcffffffff
> [    2.266001] base:       10270003
> [    2.267001] high:       00000000
> [    2.268001] limit:      fd000000
> [    2.269001] slot:       1
> [    2.270081] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
> [    2.271081] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
> [    2.272083] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
> [    2.273079] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
> [    2.274083] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
> [    2.275089] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
>
> On a sucessful bootup the system would continue with:
>
> [    0.583060] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
> [    0.584079] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
> [    0.585084] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
> [    0.586079] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
> [    0.588039] pci 0000:00:1a.0: [1022:1600] type 00 class 0x060000
> [    0.589090] pci 0000:00:1a.1: [1022:1601] type 00 class 0x060000
> [    0.590079] pci 0000:00:1a.2: [1022:1602] type 00 class 0x060000
> [    0.591080] pci 0000:00:1a.3: [1022:1603] type 00 class 0x060000
> [    0.593006] pci 0000:00:1a.4: [1022:1604] type 00 class 0x060000
> [    0.594079] pci 0000:00:1a.5: [1022:1605] type 00 class 0x060000
> [    0.595082] pci 0000:00:1b.0: [1022:1600] type 00 class 0x060000
> [    0.596087] pci 0000:00:1b.1: [1022:1601] type 00 class 0x060000
> [    0.597083] pci 0000:00:1b.2: [1022:1602] type 00 class 0x060000
> [    0.598080] pci 0000:00:1b.3: [1022:1603] type 00 class 0x060000
> [    0.599085] pci 0000:00:1b.4: [1022:1604] type 00 class 0x060000
> [    0.600079] pci 0000:00:1b.5: [1022:1605] type 00 class 0x060000
> [    0.601124] pci 0000:03:00.0: [1000:0072] type 00 class 0x010700
> [    0.602037] pci 0000:03:00.0: reg 0x10: [io  0xe000-0xe0ff]
> [    0.603010] pci 0000:03:00.0: reg 0x14: [mem 0xdff3c000-0xdff3ffff 64bit]
> [    0.604009] pci 0000:03:00.0: reg 0x1c: [mem 0xdff40000-0xdff7ffff 64bit]
> [    0.605011] pci 0000:03:00.0: reg 0x30: [mem 0xdff80000-0xdfffffff pref]
> ...
>
> cpuinfo:
>
>   processor       : 31
>   vendor_id       : AuthenticAMD
>   cpu family      : 21
>   model           : 1
>   model name      : AMD Opteron(tm) Processor 6278
>   stepping        : 2
>   microcode       : 0x6000626
>   cpu MHz         : 1427.124
>   cache size      : 2048 KB
>   physical id     : 1
>   siblings        : 16
>   core id         : 7
>   cpu cores       : 8
>
> board:
>
>          Manufacturer: Supermicro
>          Product Name: H8DG6/H8DGi
>
> BIOS:
>
>          Vendor: American Megatrends Inc.
>          Version: 2.0b
>          Release Date: 03/01/2012
>
> I've attached the lspci -v output and a successful full bootlog as well, with
> various debugging options enabled. Let me know if you need any other info.
>
> Thanks,
>
> 	Ingo


--------------D52FCFD4D90AE8955DEAAE55
Content-Type: text/x-patch;
 name="0001-x86-PCI-fix-infinity-loop-in-search-for-64bit-BAR-pl.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-x86-PCI-fix-infinity-loop-in-search-for-64bit-BAR-pl.pa";
 filename*1="tch"

>From 91990a4f966e1862f9747072c4f46946169e2d8b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Tue, 21 Nov 2017 11:20:00 +0100
Subject: [PATCH 1/3] x86/PCI: fix infinity loop in search for 64bit BAR
 placement
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Break the loop if we can't find some address space for a 64bit BAR.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e59378bf37d9..e857b3ac5755 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -695,8 +695,13 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	res->end = 0xfd00000000ull - 1;
 
 	/* Just grab the free area behind system memory for this */
-	while ((conflict = request_resource_conflict(&iomem_resource, res)))
+	while ((conflict = request_resource_conflict(&iomem_resource, res))) {
+		if (conflict->end >= res->end) {
+			kfree(res);
+			return;
+		}
 		res->start = conflict->end + 1;
+	}
 
 	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
 
-- 
2.11.0


--------------D52FCFD4D90AE8955DEAAE55
Content-Type: text/x-patch;
 name="0002-x86-PCI-only-enable-a-64bit-BAR-on-single-socket-AMD.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0002-x86-PCI-only-enable-a-64bit-BAR-on-single-socket-AMD.pa";
 filename*1="tch"

>From 21ae889eaa7330b57f17cc86b6d0239300eb3f95 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Tue, 21 Nov 2017 11:08:33 +0100
Subject: [PATCH 2/3] x86/PCI: only enable a 64bit BAR on single socket AMD
 Family 15h systems
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When we have a multi socket system each CPU core needs the same setup. Since
this is tricky to do in the fixup code disable enabling a 64bit BAR on multi
socket systems for now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e857b3ac5755..c817ab85dc82 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -664,6 +664,16 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	unsigned i;
 	u32 base, limit, high;
 	struct resource *res, *conflict;
+	struct pci_dev *other;
+
+	/* Check that we are the only device of that type */
+	other = pci_get_device(dev->vendor, dev->device, NULL);
+	if (other != dev ||
+	    (other = pci_get_device(dev->vendor, dev->device, other))) {
+		/* This is a multi socket system, don't touch it for now */
+		pci_dev_put(other);
+		return;
+	}
 
 	for (i = 0; i < 8; i++) {
 		pci_read_config_dword(dev, AMD_141b_MMIO_BASE(i), &base);
@@ -718,10 +728,10 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 
 	pci_bus_add_resource(dev->bus, res, 0);
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
 #endif
-- 
2.11.0


--------------D52FCFD4D90AE8955DEAAE55
Content-Type: text/x-patch;
 name="0003-x86-PCI-limit-the-size-of-the-64bit-BAR-to-256GB.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0003-x86-PCI-limit-the-size-of-the-64bit-BAR-to-256GB.patch"

>From e5d5c9682aa02a6b9c0c6bd446d433b924441679 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Tue, 28 Nov 2017 10:02:35 +0100
Subject: [PATCH 3/3] x86/PCI: limit the size of the 64bit BAR to 256GB
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This avoids problems with Xen which hides some memory resources from the
OS and potentially also allows memory hotplug while this fixup is
enabled.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index c817ab85dc82..149adbc7f2a3 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -701,7 +701,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	res->name = "PCI Bus 0000:00";
 	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
 		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
-	res->start = 0x100000000ull;
+	res->start = 0xbd00000000ull;
 	res->end = 0xfd00000000ull - 1;
 
 	/* Just grab the free area behind system memory for this */
-- 
2.11.0


--------------D52FCFD4D90AE8955DEAAE55--
