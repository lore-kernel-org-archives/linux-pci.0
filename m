Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:2304
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751115AbdKUNer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Nov 2017 08:34:47 -0500
Subject: Re: [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors v5
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20171018135821.3248-1-deathsimple@vodafone.de>
 <20171018135821.3248-5-deathsimple@vodafone.de>
 <c5ca14bc-3812-ff15-7dd0-e862ce85a348@oracle.com>
 <d81d50e6-c267-fe43-214f-278e57903448@gmail.com>
 <26df0a78-8028-e42c-ce50-4cefe612a7e1@oracle.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3443aad0-8c3b-b97e-685a-96b0866827be@amd.com>
Date: Tue, 21 Nov 2017 14:34:36 +0100
MIME-Version: 1.0
In-Reply-To: <26df0a78-8028-e42c-ce50-4cefe612a7e1@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------D7D53C3D67A2F260910835E5"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------D7D53C3D67A2F260910835E5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Boris,

attached are two patches.

The first one is a trivial fix for the infinite loop issue, it now 
correctly aborts the fixup when it can't find address space for the root 
window.

The second is a workaround for your board. It simply checks if there is 
exactly one Processor Function to apply this fix on.

Both are based on linus current master branch. Please test if they fix 
your issue.

Thanks for the help,
Christian.

Am 20.11.2017 um 17:33 schrieb Boris Ostrovsky:
> On 11/20/2017 11:07 AM, Christian König wrote:
>> Am 20.11.2017 um 16:51 schrieb Boris Ostrovsky:
>>> (and then it breaks differently as a Xen guest --- we hung on the last
>>> pci_read_config_dword(), I haven't looked at this at all yet)
>> Hui? How does this fix applies to a Xen guest in the first place?
>>
>> Please provide the output of "lspci -nn" and explain further what is
>> your config with Xen.
>>
>>
>
> This is dom0.
>
> -bash-4.1# lspci -nn
> 00:00.0 Host bridge [0600]: ATI Technologies Inc RD890 Northbridge only
> dual slot (2x16) PCI-e GFX Hydra part [1002:5a10] (rev 02)
> 00:00.2 Generic system peripheral [0806]: ATI Technologies Inc Device
> [1002:5a23]
> 00:0d.0 PCI bridge [0604]: ATI Technologies Inc RD890 PCI to PCI bridge
> (external gfx1 port B) [1002:5a1e]
> 00:11.0 SATA controller [0106]: ATI Technologies Inc SB700/SB800 SATA
> Controller [AHCI mode] [1002:4391]
> 00:12.0 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
> OHCI0 Controller [1002:4397]
> 00:12.1 USB Controller [0c03]: ATI Technologies Inc SB700 USB OHCI1
> Controller [1002:4398]
> 00:12.2 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB EHCI
> Controller [1002:4396]
> 00:13.0 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
> OHCI0 Controller [1002:4397]
> 00:13.1 USB Controller [0c03]: ATI Technologies Inc SB700 USB OHCI1
> Controller [1002:4398]
> 00:13.2 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB EHCI
> Controller [1002:4396]
> 00:14.0 SMBus [0c05]: ATI Technologies Inc SBx00 SMBus Controller
> [1002:4385] (rev 3d)
> 00:14.3 ISA bridge [0601]: ATI Technologies Inc SB700/SB800 LPC host
> controller [1002:439d]
> 00:14.4 PCI bridge [0604]: ATI Technologies Inc SBx00 PCI to PCI Bridge
> [1002:4384]
> 00:14.5 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
> OHCI2 Controller [1002:4399]
> 00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1600]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1601]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1602]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1603]
> 00:18.4 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1604]
> 00:18.5 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1605]
> 00:19.0 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1600]
> 00:19.1 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1601]
> 00:19.2 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1602]
> 00:19.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1603]
> 00:19.4 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1604]
> 00:19.5 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1605]
> 01:04.0 VGA compatible controller [0300]: Matrox Graphics, Inc. MGA
> G200eW WPCM450 [102b:0532] (rev 0a)
> 02:00.0 Ethernet controller [0200]: Intel Corporation 82576 Gigabit
> Network Connection [8086:10c9] (rev 01)
> 02:00.1 Ethernet controller [0200]: Intel Corporation 82576 Gigabit
> Network Connection [8086:10c9] (rev 01)
> -bash-4.1#
>
>
> -boris



--------------D7D53C3D67A2F260910835E5
Content-Type: text/x-patch;
 name="0001-x86-PCI-fix-infinity-loop-in-search-for-64bit-BAR-pl.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-x86-PCI-fix-infinity-loop-in-search-for-64bit-BAR-pl.pa";
 filename*1="tch"

>From 9b59f5919b31f1a869ef634481331ef325a992a7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Tue, 21 Nov 2017 11:20:00 +0100
Subject: [PATCH 1/2] x86/PCI: fix infinity loop in search for 64bit BAR
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
index 1e996df687a3..5328e86f73eb 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -696,8 +696,13 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
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


--------------D7D53C3D67A2F260910835E5
Content-Type: text/x-patch;
 name="0002-x86-PCI-only-enable-a-64bit-BAR-on-single-socket-AMD.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0002-x86-PCI-only-enable-a-64bit-BAR-on-single-socket-AMD.pa";
 filename*1="tch"

>From 2dc4461ba8ec1eb54a49e1e166de9a554556e572 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Tue, 21 Nov 2017 11:08:33 +0100
Subject: [PATCH 2/2] x86/PCI: only enable a 64bit BAR on single socket AMD
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
index 5328e86f73eb..8f86060f5cf6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -665,6 +665,16 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
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
@@ -719,10 +729,10 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 
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


--------------D7D53C3D67A2F260910835E5--
