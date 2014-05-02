Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50930 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752712AbaEBSo5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 May 2014 14:44:57 -0400
Date: Fri, 2 May 2014 19:44:21 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [RESEND PATCH 2/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140502184421.GF14645@arm.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
 <1399048876-11862-3-git-send-email-will.deacon@arm.com>
 <20140502172317.GC3179@obsidianresearch.com>
 <5644412.ouY7G25ZK8@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5644412.ouY7G25ZK8@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd, Jason,

Thanks for taking a look.

On Fri, May 02, 2014 at 07:25:36PM +0100, Arnd Bergmann wrote:
> On Friday 02 May 2014 11:23:18 Jason Gunthorpe wrote:
> > On Fri, May 02, 2014 at 05:41:15PM +0100, Will Deacon wrote:
> > 
> > > +       bus_range = &pci->cfg.bus_range;
> > > +       for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> > > +               u32 idx = busn - bus_range->start;
> > > +               u32 sz = 1 << pci->cfg.ops->bus_shift;
> > > +
> > > +               pci->cfg.win[idx] = devm_ioremap(dev,
> > > +                                                pci->cfg.res.start + busn * sz,
> > > +                                                sz);
> > 
> > Why map each bus individually? Both CAM and ECAM define consecutive
> > busses consecutively in the address space, and I though ioremap was OK
> > with unaligned stuff?
> 
> One optimization we discussed before was to do this ioremap on the first
> access to any config space register in one bus, so we don't actually have
> to map all of them but only the ones that are in use.

Right, and this optimisation is because we don't have a lot of virtual
address space on 32-bit ARM, so blowing away 256M on ECAM isn't viable.

> I don't know if there was a technical problem with that. We can't just
> map/unmap on every config space access, because it can be called from
> atomic context and ioremap can sleep, but the initial bus scan is
> always done in a context in which we are allowed to sleep.

It just doesn't seem worth it, given that we have the bus-range property
in the DT. I can revisit it if there are strong objections to the current
code though (looking back, I ended up needing to take a lock last time I
tried this).

> > > +out_unmap_cfg:
> > > +     while (busn-- > bus_range->start)
> > > +             devm_iounmap(dev, pci->cfg.win[busn - bus_range->start]);
> > 
> > Is there a reason to explicitly clean up devm resources? I guess it is
> > because this is in setup not probe?
> 
> Setup is called from probe, through pci_common_init_dev(), so that shouldn't
> make a difference.

Given that the idea was to separate setup() and probe(), I didn't want to
make the assumption that I was called in probe context.

> > It seems strange to me for a driver to do this sort of work in a setup
> > function, typically probe acquires as much stuff as it can, that way
> > defered probe can work properly.
> > 
> > Looking at pci-mvebu, 'setup' is only populating the resource list, I
> > would suggest the same split for this driver.
> 
> I suggested moving it all into setup, to make it easier to port this code
> to arm64: I don't expect we will have the same pci_common_init_dev()
> mechanism there, so setup will get called directly from the probe
> function.

In which case, I *could* remove that freeing code, but I'd rather wait until
we know for sure that it's not needed (that is, when I go about plumbing in
the support for arm64 after Liviu's patches are merged).

> The alternative is to do everything in probe() as well for arm32, and only
> do a single list_move() of the resources list to sys->resources in the
> setup function. That was the advice I gave in the xilinx pci host driver
> review for the same reason. I only now noticed that I recommended the opposite
> here. Anyway it shouldn't matter where we do all the things, but I feel
> it's better to have only one function that does all the work for the case
> of having nr_controllers=1, as we always do for loadable host drivers.

Ok, I'll leave it like it is for now then.

Will
