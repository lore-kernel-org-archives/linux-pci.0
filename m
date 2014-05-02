Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:46759 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbaEBTDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 2 May 2014 15:03:25 -0400
Date: Fri, 2 May 2014 13:03:18 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [RESEND PATCH 2/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140502190318.GE3179@obsidianresearch.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
 <1399048876-11862-3-git-send-email-will.deacon@arm.com>
 <20140502172317.GC3179@obsidianresearch.com>
 <5644412.ouY7G25ZK8@wuerfel>
 <20140502184421.GF14645@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140502184421.GF14645@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 02, 2014 at 07:44:21PM +0100, Will Deacon wrote:
> > > > +       bus_range = &pci->cfg.bus_range;
> > > > +       for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> > > > +               u32 idx = busn - bus_range->start;
> > > > +               u32 sz = 1 << pci->cfg.ops->bus_shift;
> > > > +
> > > > +               pci->cfg.win[idx] = devm_ioremap(dev,
> > > > +                                                pci->cfg.res.start + busn * sz,
> > > > +                                                sz);
> > > 
> > > Why map each bus individually? Both CAM and ECAM define consecutive
> > > busses consecutively in the address space, and I though ioremap was OK
> > > with unaligned stuff?
> > 
> > One optimization we discussed before was to do this ioremap on the first
> > access to any config space register in one bus, so we don't actually have
> > to map all of them but only the ones that are in use.
> 
> Right, and this optimisation is because we don't have a lot of virtual
> address space on 32-bit ARM, so blowing away 256M on ECAM isn't viable.

But why not just

devm_ioremap(dev, pci->cfg.res.start + bus_range->start * sz,
		  resource_size(&bus_range) * sz);

?

> > Setup is called from probe, through pci_common_init_dev(), so that shouldn't
> > make a difference.
> 
> Given that the idea was to separate setup() and probe(), I didn't want to
> make the assumption that I was called in probe context.

IMHO, we need to have clear purposes for setup() and probe().

Probe is well defined already, it requests resources, claims the
device, puts it in reset and then does some subsystem specific thing.
The interaction with probe and devm is also already well specified.

It doesn't matter for this driver, but look at mvebu, you cannot move
the interrupt, gpio and clock acquisitions from probe() to setup(), as
they could all trigger a defered probe. Better to be consistent,
especially if this is the golden reference driver we want everyone to
follow (sorry Will)

To me setup() is more like netdev open(), so it should just do that
final step to enable the links and bring up the PCI network and be
ready to run PCI discovery. Consider, someday we might have an
unsetup() for power mangement reasons, just like we have a close() in
netdev.

If the long term plan is to keep probe() then I don't think it makes
sense to move probe() duties into setup(). That just restricts what we
can do with the setup() call if setup() is now required to always
handle defered probe and so forth.

Will, don't forget this q:

------
> +out_release_res:
> +     release_child_resources(&iomem_resource);
> +     release_child_resources(&ioport_resource);

This looks really off to me, doesn't this free all resources in the
system?
-------

Regards,
Jason
