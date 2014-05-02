Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60670 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbaEBSZs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 May 2014 14:25:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [RESEND PATCH 2/3] PCI: ARM: add support for generic PCI host controller
Date: Fri, 02 May 2014 20:25:36 +0200
Message-ID: <5644412.ouY7G25ZK8@wuerfel>
In-Reply-To: <20140502172317.GC3179@obsidianresearch.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com> <1399048876-11862-3-git-send-email-will.deacon@arm.com> <20140502172317.GC3179@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 02 May 2014 11:23:18 Jason Gunthorpe wrote:
> On Fri, May 02, 2014 at 05:41:15PM +0100, Will Deacon wrote:
> 
> > +       bus_range = &pci->cfg.bus_range;
> > +       for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> > +               u32 idx = busn - bus_range->start;
> > +               u32 sz = 1 << pci->cfg.ops->bus_shift;
> > +
> > +               pci->cfg.win[idx] = devm_ioremap(dev,
> > +                                                pci->cfg.res.start + busn * sz,
> > +                                                sz);
> 
> Why map each bus individually? Both CAM and ECAM define consecutive
> busses consecutively in the address space, and I though ioremap was OK
> with unaligned stuff?

One optimization we discussed before was to do this ioremap on the first
access to any config space register in one bus, so we don't actually have
to map all of them but only the ones that are in use.

I don't know if there was a technical problem with that. We can't just
map/unmap on every config space access, because it can be called from
atomic context and ioremap can sleep, but the initial bus scan is
always done in a context in which we are allowed to sleep.

> > +out_unmap_cfg:
> > +     while (busn-- > bus_range->start)
> > +             devm_iounmap(dev, pci->cfg.win[busn - bus_range->start]);
> 
> Is there a reason to explicitly clean up devm resources? I guess it is
> because this is in setup not probe?

Setup is called from probe, through pci_common_init_dev(), so that shouldn't
make a difference.

> It seems strange to me for a driver to do this sort of work in a setup
> function, typically probe acquires as much stuff as it can, that way
> defered probe can work properly.
> 
> Looking at pci-mvebu, 'setup' is only populating the resource list, I
> would suggest the same split for this driver.

I suggested moving it all into setup, to make it easier to port this code
to arm64: I don't expect we will have the same pci_common_init_dev()
mechanism there, so setup will get called directly from the probe
function.

The alternative is to do everything in probe() as well for arm32, and only
do a single list_move() of the resources list to sys->resources in the
setup function. That was the advice I gave in the xilinx pci host driver
review for the same reason. I only now noticed that I recommended the opposite
here. Anyway it shouldn't matter where we do all the things, but I feel
it's better to have only one function that does all the work for the case
of having nr_controllers=1, as we always do for loadable host drivers.

	Arnd
