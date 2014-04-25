Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:52428 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbaDYSNp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 14:13:45 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so3084682eei.28
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2014 11:13:44 -0700 (PDT)
Date: Fri, 25 Apr 2014 20:13:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Jarosch <thomas.jarosch@intra2net.com>,
	linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] PCI: Add new PCI id for Intel GPU interrupt quirk
Message-ID: <20140425181340.GY26374@phenom.ffwll.local>
References: <3185796.STv3LRO1j8@storm>
 <20140425173521.GD32246@google.com>
 <20140425173718.GE32246@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140425173718.GE32246@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 25, 2014 at 11:37:18AM -0600, Bjorn Helgaas wrote:
> On Fri, Apr 25, 2014 at 11:35:21AM -0600, Bjorn Helgaas wrote:
> > [+cc Daniel, Jani, intel-gfx, dri-devel, -cc stable]
> > 
> > On Mon, Apr 07, 2014 at 03:10:32PM +0200, Thomas Jarosch wrote:
> > > After a CPU upgrade while keeping the same mainboard,
> > > we faced "spurious interrupt" problems again.
> > > 
> > > It turned out that the new CPU also featured a
> > > new GPU with a different PCI id.
> > > 
> > > -> Add this PCI id to the quirk table. Probably all other
> > > Intel GPU PCI ids are affected, too, but I don't want
> > > to add them without a test system.
> > 
> > Daniel, Jani, et al, do we need a better solution to this?  Is there
> > a more general way to solve this than by tripping over affected machines
> > one-by-one?  Could this be done in the driver rather than in a quirk?
> 
> I guess it can't be done in the driver because the problem happens even if
> the driver isn't loaded, per f67fd55fa96f ("PCI: Add quirk for still
> enabled interrupts on Intel Sandy Bridge GPUs").

Hm, this is new to me. The only thing wrt spurious interrupts I was aware
of is on g4x platforms which also fire legacy interrupts (but only for
some chip functions) when we use msi. See

commit 4e6b788c3f2388c519ab6ed7fe59f372c85d26e9
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri Feb 7 16:33:20 2014 +0100

    drm/i915: Disable dp aux irq on g4x

we simply opted to not enable those interrupts on g4x to keep things
quiet. For other platforms I'm not aware of any such issues.

I guess you could just match on all of them, but the master irq control
bit moves around a _lot_. We already have a differen early platform quirk
and for that exposed pci ids as macros in include/drm/i915_pciids.h
-Daniel

> 
> > > Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
> > > Tested-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
> > > ---
> > >  drivers/pci/quirks.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index e729206..0feb4a3 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -2954,6 +2954,7 @@ static void disable_igfx_irq(struct pci_dev *dev)
> > >  }
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
> > >  
> > >  /*
> > >   * PCI devices which are on Intel chips can skip the 10ms delay
> > > -- 
> > > 1.8.1.4
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
