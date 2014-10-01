Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39387 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbaJAHmK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 03:42:10 -0400
Message-ID: <1412149289.4285.204.camel@pasglop>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Wed, 01 Oct 2014 17:41:29 +1000
In-Reply-To: <s5htx3o44tv.wl-tiwai@suse.de>
References: <1412129393.4285.195.camel@pasglop>
	 <s5htx3o44tv.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-01 at 09:38 +0200, Takashi Iwai wrote:

> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 3e6d22d..2b679d5 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -297,7 +297,7 @@ enum {
> >  /* quirks for ATI/AMD HDMI */
> >  #define AZX_DCAPS_PRESET_ATI_HDMI \
> >  	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
> > -	 AZX_DCAPS_NO_MSI64)
> > +	 AZX_DCAPS_NO_MSI64 | AZX_DCAPS_NO_64BIT)
> 
> The only concern is that this will disable 64bit DMA also on x86 where
> it has been working fine.  Can we add an ifdef CONFIG_PPC for this?

I don't like that approach because technically the chip doesn't do
64-bit DMA ... it does something like 40 or 48 (might actually depend on
the chip version) and for all I know it will break on future x86 with
more memory or other platforms with similar address encodings as
powerpc...

The right thing might be to get the exact number of bits and do the
appropriate dma_set_mask() like the graphics driver does, but that's a
bit tricky unless we add a DMA mask field in that big array of chips in
there...

Cheers,
Ben.


