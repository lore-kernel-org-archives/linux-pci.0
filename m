Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932970AbeAKSG6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jan 2018 13:06:58 -0500
Date: Thu, 11 Jan 2018 12:06:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: christian.koenig@amd.com
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, torvalds@linux-foundation.org,
        aaro.koskinen@iki.fi, andy.shevchenko@gmail.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        alexander.deucher@amd.com, airlied@linux.ie
Subject: Re: [PATCH 2/2] x86/PCI: limit the size of the 64bit window to 256GB
 v3
Message-ID: <20180111180656.GJ241460@bhelgaas-glaptop.roam.corp.google.com>
References: <20180111132330.2682-1-christian.koenig@amd.com>
 <20180111132330.2682-2-christian.koenig@amd.com>
 <20180111142141.GA3672@bhelgaas-glaptop.roam.corp.google.com>
 <12f934df-3a5b-08fb-d313-9c7b9734c361@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <12f934df-3a5b-08fb-d313-9c7b9734c361@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 11, 2018 at 03:51:45PM +0100, Christian König wrote:
> Am 11.01.2018 um 15:21 schrieb Bjorn Helgaas:
> >On Thu, Jan 11, 2018 at 02:23:30PM +0100, Christian König wrote:
> >>Avoid problems with BIOS implementations which don't report all used
> >>resources to the OS by only allocating a 256GB window directly below the
> >>hardware limit.
> >>
> >>For the full hardware documentation see:
> >>https://support.amd.com/TechDocs/49125_15h_Models_30h-3Fh_BKDG.pdf
> >If you can supply a section number, I'll add it here.  That spec is 700
> >pages, so a hint would be useful.
> 
> Sorry, had to search for that as well. That is noted in section
> "2.4.6 System Address Map".
> 
> Do you want to add that or should I resend the patch?

I added it and put both patches on my for-linus branch for v4.15, thanks!

> >>Fixes a silent reboot loop reported by Aaro Koskinen <aaro.koskinen@iki.fi> on
> >>an AMD-based MSI MS-7699/760GA-P43(FX) system.
> >>
> >>v2: cleanup code a bit more, update comment and explain the hw limit
> >>v3: improve commit message
> >>
> >>Link: https://lkml.kernel.org/r/20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi
> >>Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
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
