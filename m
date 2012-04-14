Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:20185 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753440Ab2DNRiG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Apr 2012 13:38:06 -0400
Message-ID: <4F89B5E8.3040906@snewbury.org.uk>
Date: Sat, 14 Apr 2012 18:37:44 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Steven Newbury <steve@snewbury.org.uk>
CC: Yinghai Lu <yinghai@kernel.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity>  <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>  <4F84110E.3000400@snewbury.org.uk>  <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>  <4F8467AA.90305@snewbury.org.uk>  <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>  <4F848357.3060007@snewbury.org.uk>  <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>  <4F848E10.1090703@snewbury.org.uk>  <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>  <1334089568.4083.2.camel@Nokia-N900>  <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>  <4F84A3EC.6030903@snewbury.org.uk>  <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>  <1334229754.30606.7.camel@Nokia-N900>   <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900>
In-Reply-To: <1334248841.2910.6.camel@Nokia-N900>
Content-Type: multipart/mixed;
 boundary="------------060603090408060709070209"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060603090408060709070209
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/04/12 17:40, Steven Newbury wrote:
> On Thu, 12 Apr 2012, 17:07:33 BST, Yinghai Lu <yinghai@kernel.org>
> wrote:
> 
>> On Thu, Apr 12, 2012 at 4:22 AM, Steven Newbury
>> <steve@snewbury.org.uk> wrote:
>>> Thanks, that fixed it! :) I had a similar patch I've been
>>> working on but I had my fix in the wrong place!
>>> 
>>> In the working case, initially the BIOS has set GMA to within
>>> the low system DRAM 0xC0000000 obviously invalid.  This
>>> conflict is detected and it's relallocated to 0x12000000.
>>> 
>>> I've attempted to modify probe.c to disable 64-bit BARs not
>>> allocated above 4G so they get reallocated above when possible
>>> later.  It seemed to work, but again broke GMA despite the BAR
>>> originally containing an invalid address as mentioned above, it
>>> seems for some reason something is different when the conflict
>>> is detected and rellocated, compared to disabling it early then
>>> allocating a valid value..?
>>> 
I've created a new quirk utilising an extra PCI resource flag to force
reallocation of the resource.  It's the first approach I've had any
success at.  It does work.  Only "Intel Page Flush" now gets allocated
@0xe0000000!


00000000-0000ffff : reserved
00010000-0009efff : System RAM
0009f000-0009ffff : reserved
000c0000-000c7fff : Video ROM
000cf000-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-df65a7ff : System RAM
  01000000-0136defd : Kernel code
  0136defe-0169127f : Kernel data
  0172f000-01809fff : Kernel bss
df65a800-dfffffff : reserved
  df65a800-df6fffff : pnp 00:0d
  df700000-df7fffff : pnp 00:0d
e0000000-e0000fff : Intel Flush Page
f0000000-f01fffff : PCI Bus 0000:0d
f6900000-f69fffff : PCI Bus 0000:09
  f69f0000-f69fffff : 0000:09:00.0
    f69f0000-f69fffff : tg3
f6a00000-f6bfffff : PCI Bus 0000:0d
f6c00000-f6cfffff : PCI Bus 0000:0c
  f6cfe000-f6cfffff : 0000:0c:00.0
    f6cfe000-f6cfffff : iwl4965
f6dfb700-f6dfb7ff : 0000:00:1f.3
f6dfb800-f6dfbfff : 0000:00:1f.2
  f6dfb800-f6dfbfff : ahci
f6dfc000-f6dfffff : 0000:00:1b.0
  f6dfc000-f6dfffff : ICH HD audio
f6e00000-f6efffff : 0000:00:02.0
f6f00000-f6ffffff : 0000:00:02.1
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f8000000-fbffffff : reserved
    f8000000-fbffffff : pnp 00:0d
fec00000-fec0ffff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:08
fed18000-fed1bfff : reserved
  fed18000-fed1bfff : pnp 00:0d
fed1c000-fed1c3ff : 0000:00:1d.7
  fed1c000-fed1c3ff : ehci_hcd
fed1c400-fed1c7ff : 0000:00:1a.7
  fed1c400-fed1c7ff : ehci_hcd
fed20000-fed8ffff : reserved
  fed20000-fed3ffff : pnp 00:0d
  fed40000-fed44fff : pnp 00:0a
  fed45000-fed8ffff : pnp 00:0d
feda0000-feda5fff : reserved
  feda0000-feda3fff : pnp 00:0d
  feda4000-feda4fff : pnp 00:0d
  feda5000-feda5fff : pnp 00:0d
feda6000-feda6fff : pnp 00:0d
fee00000-fee0ffff : reserved
  fee00000-fee0ffff : pnp 00:0d
    fee00000-fee00fff : Local APIC
ffa00000-ffbfffff : pnp 00:0d
ffc00000-ffdfffff : PCI Bus 0000:0b
ffe00000-ffffffff : reserved
  ffe00000-ffffffff : pnp 00:0d
100000000-11fffffff : System RAM
fefa00000-fefbfffff : PCI Bus 0000:09
fefc00000-fefdfffff : PCI Bus 0000:0c
fefe00000-fefffffff : PCI Bus 0000:0b
ff0000000-fffffffff : 0000:00:02.0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+JtegACgkQGcb56gMuC61LDgCeO1gr1XT4iL4FK6QXrUq4E4SV
LgwAnR4zdEVkVcfJ2nebHc2++tfi8UsK
=QJc+
-----END PGP SIGNATURE-----

--------------060603090408060709070209
Content-Type: text/x-patch;
 name="hack_to_force_realloc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hack_to_force_realloc.diff"

commit 7063b1e2145bca02bbdd807d3c2ca97748deb73a
Author: Steven Newbury <steve@snewbury.org.uk>
Date:   Sat Apr 14 13:25:14 2012 +0100

    Add a new PCI resource flag to force a conflict for a given resource,
    use this new flag with a quirk to trigger reallocation over >4G.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a24d473..820dc1e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -32,6 +32,20 @@
 #include "pci.h"
 
 /*
+ * Force reallocation >4G (if available) for intel GMA
+ */
+static void __devinit quirk_intel_gma_realloc(struct pci_dev * dev)
+{
+        if (sizeof(resource_size_t) == 8) {
+                struct resource *r = &dev->resource [2];
+                if (r->start < 0x100000000) {
+                	r->flags |= IORESOURCE_MEM_FORCEREALLOC;
+                }
+        }
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a02, quirk_intel_gma_realloc);
+
+/*
  * Decoding should be disabled for a PCI device during BAR sizing to avoid
  * conflict. But doing so may cause problems on host bridge and perhaps other
  * key system devices. For devices that need to have mmio decoding always-on,
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ea96ced..aad43c3 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -116,6 +116,8 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 
 	conflict = request_resource_conflict(root, res);
 	if (conflict) {
+	if (res->flags & IORESOURCE_MEM_FORCEREALLOC)
+	        res->flags &= ~IORESOURCE_MEM_FORCEREALLOC;
 		dev_info(&dev->dev,
 			 "address space collision: %pR conflicts with %s %pR\n",
 			 res, conflict->name, conflict);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8f8433d..a4159f6 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -89,6 +89,7 @@ struct resource {
 #define IORESOURCE_MEM_32BIT		(3<<3)
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
+#define IORESOURCE_MEM_FORCEREALLOC	(1<<7)	/* Force rellocation of this resource */
 
 /* PnP I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
diff --git a/kernel/resource.c b/kernel/resource.c
index 9cbfc40..770d713 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -156,6 +156,8 @@ static struct resource * __request_resource(struct resource *root, struct resour
 	resource_size_t end = new->end;
 	struct resource *tmp, **p;
 
+	if (new->flags & IORESOURCE_MEM_FORCEREALLOC)
+	        return root;
 	if (end < start)
 		return root;
 	if (start < root->start)

--------------060603090408060709070209--
