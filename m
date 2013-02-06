Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57613 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757465Ab3BFX7D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 18:59:03 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHT00CN4P9XRDD0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 07 Feb 2013 08:59:01 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MHT00JAOPADJO90@mmp2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 07 Feb 2013 08:59:01 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Alex Deucher' <alexdeucher@gmail.com>
Cc: 'David Airlie' <airlied@linux.ie>, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <002b01ce0429$59d7acc0$0d870640$%han@samsung.com>
 <CADnq5_NsB=xZA-vMr8OkHF6W0GZgWEyZzBMD5AGMOr_jKj_jCw@mail.gmail.com>
 <CAErSpo6k=AfkAbM70Xzyvq61t2HP+YqWStdSU3eK1kXbbCjV2Q@mail.gmail.com>
In-reply-to: <CAErSpo6k=AfkAbM70Xzyvq61t2HP+YqWStdSU3eK1kXbbCjV2Q@mail.gmail.com>
Subject: RE: [PATCH] drm/pci: use PCI_EXP_LNKCAP_SLS_2_5GB/5_0GB instead of
 hardcoded values
Date: Thu, 07 Feb 2013 08:59:01 +0900
Message-id: <007f01ce04c5$ef8a4dd0$ce9ee970$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 07, 2013 2:08 AM, Bjorn Helgaas wrote
> 
> On Wed, Feb 6, 2013 at 7:27 AM, Alex Deucher <alexdeucher@gmail.com> wrote:
> > On Wed, Feb 6, 2013 at 12:18 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> >> Use PCI_EXP_LNKCAP_SLS_2_5GB and PCI_EXP_LNKCAP_SLS_5_0GB instead
> >> of hardcoded values for readability. These bit definitions were
> >> added by commit 130f1b8 ("PCI: Add PCIe Link Capability link speed
> >> and width names")
> >>
> >> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I posted the same patch last month, along with two other patches that
> fix the reporting for pre-r3.0 devices and simplify the code a bit:
> 
>     http://marc.info/?l=linux-pci&m=135732663513525&w=2
>     http://marc.info/?l=linux-pci&m=135732713413779&w=2
>     http://marc.info/?l=linux-pci&m=135732666213542&w=2

Oh, I missed your patch.
I think that my patch will be abandoned.

Best regards,
Jingoo Han

> 
> I don't know the status of any of these; I'm expecting Dave to do
> whatever he thinks is best.
> 
> >
> >> ---
> >>  drivers/gpu/drm/drm_pci.c |    4 ++--
> >>  1 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
> >> index 754bc96..11c8add 100644
> >> --- a/drivers/gpu/drm/drm_pci.c
> >> +++ b/drivers/gpu/drm/drm_pci.c
> >> @@ -504,9 +504,9 @@ int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
> >>                 if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
> >>                         *mask |= DRM_PCIE_SPEED_80;
> >>         } else {
> >> -               if (lnkcap & 1)
> >> +               if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> >>                         *mask |= DRM_PCIE_SPEED_25;
> >> -               if (lnkcap & 2)
> >> +               if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> >>                         *mask |= DRM_PCIE_SPEED_50;
> >>         }
> >>
> >> --
> >> 1.7.2.5


