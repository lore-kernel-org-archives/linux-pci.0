Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbdBAQPT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Feb 2017 11:15:19 -0500
Date: Wed, 1 Feb 2017 10:15:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andreas Boll <andreas.boll.dev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: Re: [PATCH v1 2/2] drm/radeon: make MacBook Pro d3_delay quirk more
 generic
Message-ID: <20170201161514.GA13183@bhelgaas-glaptop.roam.corp.google.com>
References: <20170130203822.31891.22461.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170130204106.31891.59164.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CACiKqBfECOAsBHNqkkO84sZrjJ1itv5chOz4ZAu2jwQvBEyacg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACiKqBfECOAsBHNqkkO84sZrjJ1itv5chOz4ZAu2jwQvBEyacg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 01, 2017 at 04:45:42PM +0100, Andreas Boll wrote:
> 2017-01-30 21:41 GMT+01:00 Bjorn Helgaas <bhelgaas@google.com>:
> > The PCI Power Management Spec, r1.2, sec 5.6.1, requires a 10 millisecond
> > delay when powering on a device, i.e., transitioning from state D3hot to
> > D0.
> >
> > Apparently some devices require more time, and d1f9809ed131 ("drm/radeon:
> > add quirk for d3 delay during switcheroo poweron for apple macbooks") added
> > an additional delay for the Radeon device in a MacBook Pro.  4807c5a8a0c8
> > ("drm/radeon: add a PX quirk list") made the affected device more explicit.
> >
> > Add a generic PCI quirk to increase the d3_delay.  This means we will use
> > the additional delay for *all* wakeups from D3, not just those initiated by
> > radeon_switcheroo_set_state().
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > CC: Maarten Lankhorst <maarten.lankhorst@canonical.com>
> > ---
> >  drivers/gpu/drm/radeon/radeon_device.c |   12 ------------
> >  drivers/pci/quirks.c                   |   13 +++++++++++++
> >  2 files changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> > index 8a1df2a1afbd..8b8fd981cae5 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -113,7 +113,6 @@ static inline bool radeon_is_atpx_hybrid(void) { return false; }
> >  #endif
> >
> >  #define RADEON_PX_QUIRK_DISABLE_PX  (1 << 0)
> > -#define RADEON_PX_QUIRK_LONG_WAKEUP (1 << 1)
> >
> >  struct radeon_px_quirk {
> >         u32 chip_vendor;
> > @@ -136,9 +135,6 @@ static struct radeon_px_quirk radeon_px_quirk_list[] = {
> >          * https://bugzilla.kernel.org/show_bug.cgi?id=51381
> >          */
> >         { PCI_VENDOR_ID_ATI, 0x6840, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
> > -       /* macbook pro 8.2 */
> > -       { PCI_VENDOR_ID_ATI, 0x6741, PCI_VENDOR_ID_APPLE, 0x00e2, RADEON_PX_QUIRK_LONG_WAKEUP },
> 
> Do you intentionally removed the following line?
> > -       { 0, 0, 0, 0, 0 },

Ooh, definitely not!  Thanks for catching this.  I'll post a v2 that fixes
this.

Bjorn
