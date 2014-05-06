Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43659 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105AbaEFQFp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 May 2014 12:05:45 -0400
Date: Tue, 6 May 2014 17:05:05 +0100
From: Will Deacon <will.deacon@arm.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [RESEND PATCH 2/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140506160504.GM30234@arm.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
 <1399048876-11862-3-git-send-email-will.deacon@arm.com>
 <20140502172317.GC3179@obsidianresearch.com>
 <5644412.ouY7G25ZK8@wuerfel>
 <20140502184421.GF14645@arm.com>
 <20140502190318.GE3179@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140502190318.GE3179@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 02, 2014 at 08:03:18PM +0100, Jason Gunthorpe wrote:
> On Fri, May 02, 2014 at 07:44:21PM +0100, Will Deacon wrote:
> > > > > +       bus_range = &pci->cfg.bus_range;
> > > > > +       for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> > > > > +               u32 idx = busn - bus_range->start;
> > > > > +               u32 sz = 1 << pci->cfg.ops->bus_shift;
> > > > > +
> > > > > +               pci->cfg.win[idx] = devm_ioremap(dev,
> > > > > +                                                pci->cfg.res.start + busn * sz,
> > > > > +                                                sz);
> > > > 
> > > > Why map each bus individually? Both CAM and ECAM define consecutive
> > > > busses consecutively in the address space, and I though ioremap was OK
> > > > with unaligned stuff?
> > > 
> > > One optimization we discussed before was to do this ioremap on the first
> > > access to any config space register in one bus, so we don't actually have
> > > to map all of them but only the ones that are in use.
> > 
> > Right, and this optimisation is because we don't have a lot of virtual
> > address space on 32-bit ARM, so blowing away 256M on ECAM isn't viable.
> 
> But why not just
> 
> devm_ioremap(dev, pci->cfg.res.start + bus_range->start * sz,
> 		  resource_size(&bus_range) * sz);
> 
> ?

I was just trying to avoid the need for a single, virtually contiguous range
where it's not actually required. If the driver is loaded as a module, we
could already have a bunch of fragmentation in the vmalloc space.

> > > Setup is called from probe, through pci_common_init_dev(), so that shouldn't
> > > make a difference.
> > 
> > Given that the idea was to separate setup() and probe(), I didn't want to
> > make the assumption that I was called in probe context.
> 
> IMHO, we need to have clear purposes for setup() and probe().
> 
> Probe is well defined already, it requests resources, claims the
> device, puts it in reset and then does some subsystem specific thing.
> The interaction with probe and devm is also already well specified.
> 
> It doesn't matter for this driver, but look at mvebu, you cannot move
> the interrupt, gpio and clock acquisitions from probe() to setup(), as
> they could all trigger a defered probe. Better to be consistent,
> especially if this is the golden reference driver we want everyone to
> follow (sorry Will)

Groan!

> To me setup() is more like netdev open(), so it should just do that
> final step to enable the links and bring up the PCI network and be
> ready to run PCI discovery. Consider, someday we might have an
> unsetup() for power mangement reasons, just like we have a close() in
> netdev.

That's what I did originally! Anyway, this is just refactoring so shouldn't
be too much work. After reading Arnd's reply,  I'll move the bulk into
->probe().

> If the long term plan is to keep probe() then I don't think it makes
> sense to move probe() duties into setup(). That just restricts what we
> can do with the setup() call if setup() is now required to always
> handle defered probe and so forth.
> 
> Will, don't forget this q:

Sorry, that got chopped off somehow...

> ------
> > +out_release_res:
> > +     release_child_resources(&iomem_resource);
> > +     release_child_resources(&ioport_resource);
> 
> This looks really off to me, doesn't this free all resources in the
> system?

... yes, I suppose that would cause problems if we have multiple instances
of the driver. I could probably just release_resource(win->res) instead
of freeing the resources and use devm_request_mem_region for configuration
space.

Will
