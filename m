Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbeAJUhv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jan 2018 15:37:51 -0500
Date: Wed, 10 Jan 2018 14:37:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: christian.koenig@amd.com
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH 2/2] x86/PCI: limit the size of the 64bit window to 256GB
 v2
Message-ID: <20180110203746.GA241460@bhelgaas-glaptop.roam.corp.google.com>
References: <20180110122551.1637-1-christian.koenig@amd.com>
 <20180110122551.1637-2-christian.koenig@amd.com>
 <20180110180230.GA227910@bhelgaas-glaptop.roam.corp.google.com>
 <2382e9b9-aa03-a845-4d67-c01fe52004bf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2382e9b9-aa03-a845-4d67-c01fe52004bf@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 10, 2018 at 07:14:56PM +0100, Christian König wrote:
> Am 10.01.2018 um 19:02 schrieb Bjorn Helgaas:
> >[+cc linux-pci, previous cc list]
> >
> >On Wed, Jan 10, 2018 at 01:25:51PM +0100, Christian König wrote:
> >>Avoid problems with BIOS implementations which don't report all used
> >>resources to the OS by only allocating a 256GB window directly below the
> >>hardware limit.
> >>
> >>v2: cleanup code a bit more, update comment and explain the hw limit
> >Fixes a silent reboot loop reported by Aaro Koskinen
> ><aaro.koskinen@iki.fi> on an AMD-based MSI MS-7699/760GA-P43(FX)
> >system.
> >
> >Link: https://lkml.kernel.org/r/20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi
> >Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >
> >>Signed-off-by: Christian König <christian.koenig@amd.com>
> >>---
> >>  arch/x86/pci/fixup.c | 19 +++++++++----------
> >>  1 file changed, 9 insertions(+), 10 deletions(-)
> >>
> >>diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> >>index a91280da2ea1..9c1c98d7e3a7 100644
> >>--- a/arch/x86/pci/fixup.c
> >>+++ b/arch/x86/pci/fixup.c
> >>@@ -662,10 +662,11 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
> >>   */
> >>  static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
> >>  {
> >>-	unsigned i;
> >>  	u32 base, limit, high;
> >>-	struct resource *res, *conflict;
> >>  	struct pci_dev *other;
> >>+	struct resource *res;
> >>+	unsigned i;
> >>+	int r;
> >>  	if (!(pci_probe & PCI_BIG_ROOT_WINDOW))
> >>  		return;
> >>@@ -702,19 +703,17 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
> >>  	if (!res)
> >>  		return;
> >>+	/* Allocate a 256GB window directly below the 0xfd00000000 hw limit */
> >Can you include a citation for the hardware limit in the changelog?
> >I'll try to dig it up myself if you don't beat me to it.
> 
> Sure, no problem. The first one in the series is ok as it is?

Yeah, I think so, although it would be good to add doc as Randy suggests.
Can you cc the folks involved (in particular, linux-pci) next time, too?

> >>  	res->name = "PCI Bus 0000:00";
> >>  	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
> >>  		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
> >>-	res->start = 0x100000000ull;
> >>+	res->start = 0xbd00000000ull;
> >>  	res->end = 0xfd00000000ull - 1;
> >>-	/* Just grab the free area behind system memory for this */
> >>-	while ((conflict = request_resource_conflict(&iomem_resource, res))) {
> >>-		if (conflict->end >= res->end) {
> >>-			kfree(res);
> >>-			return;
> >>-		}
> >>-		res->start = conflict->end + 1;
> >>+	r = request_resource(&iomem_resource, res);
> >>+	if (r) {
> >>+		kfree(res);
> >>+		return;
> >>  	}
> >>  	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
> >>-- 
> >>2.11.0
> >>
> 
