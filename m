Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbeDTRDT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 13:03:19 -0400
Date: Fri, 20 Apr 2018 12:03:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
        linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
Message-ID: <20180420170302.GQ28657@bhelgaas-glaptop.roam.corp.google.com>
References: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
 <20180416215044.GE28657@bhelgaas-glaptop.roam.corp.google.com>
 <CAEdQ38EdxHigQiH_k=+4enbHAutbWOE6Kc5C81ghfsC3pwELjw@mail.gmail.com>
 <20180417194344.GK28657@bhelgaas-glaptop.roam.corp.google.com>
 <20180418204808.GA2352@mail.rc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180418204808.GA2352@mail.rc.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 18, 2018 at 09:48:08PM +0100, Ivan Kokshaysky wrote:
> On Tue, Apr 17, 2018 at 02:43:44PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 16, 2018 at 09:43:42PM -0700, Matt Turner wrote:
> > > On Mon, Apr 16, 2018 at 2:50 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > Hi Matt,
> > > >
> > > > First of all, sorry about breaking Nautilus, and thanks very much for
> > > > tracking it down to this commit.
> > > 
> > > It's a particularly weird case, as far as I've been able to discern :)
> > > 
> > > > On Mon, Apr 16, 2018 at 07:33:57AM -0700, Matt Turner wrote:
> > > >> Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
> > > >> address limits in resource allocation) broke Alpha systems using
> > > >> CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
> > > >> 32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
> > > >> into the upper addresses just below 4GB.
> > > >>
> > > >> I can get a working kernel by ifdef'ing out the code in
> > > >> drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
> > > >> PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
> > > >> kernels.
> > > >>
> > > >> How can we get Nautilus working again?
> > > >
> > > > Can you collect a complete dmesg log, ideally both before and after
> > > > f75b99d5a77d?  I assume the problem is that after f75b99d5a77d? we
> > > > erroneously assign space for something above 4GB.  But if we know the
> > > > correct host bridge apertures, we shouldn't assign space outside them,
> > > > regardless of the PCI bus address size.
> > > 
> > > I made a mistake in my initial report. Commit f75b99d5a77d is actually
> > > the last *working* commit. My apologies. The next commit is
> > > d56dbf5bab8c (PCI: Allocate 64-bit BARs above 4G when possible) and it
> > > breaks Nautilus I've confirmed.
> > > 
> > > Please find attached dmesgs from those two commits, from the commit
> > > immediately before them, and another from 4.17-rc1 with my hack of #if
> > > 0'ing out the pci_bus_alloc_from_region(..., &pci_high) code.
> > > 
> > > Thanks for having a look!
> > 
> > We're telling the PCI core that the host bridge MMIO aperture is the
> > entire 64-bit address space, so when we assign BARs, some of them end
> > up above 4GB:
> > 
> >   pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffffffff]
> >   pci 0000:00:09.0: BAR 0: assigned [mem 0x100000000-0x10000ffff 64bit]
> > 
> > But it sounds like the MMIO aperture really ends at 0xffffffff, so
> > that's not going to work.
> 
> Correct... This would do as a quick fix, I think:
> 
> diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
> index ff4f54b..477ba65 100644
> --- a/arch/alpha/kernel/sys_nautilus.c
> +++ b/arch/alpha/kernel/sys_nautilus.c
> @@ -193,6 +193,8 @@ static struct resource irongate_io = {
>  };
>  static struct resource irongate_mem = {
>  	.name	= "Irongate PCI MEM",
> +	.start	= 0,
> +	.end	= 0xffffffff,
>  	.flags	= IORESOURCE_MEM,
>  };
>  static struct resource busn_resource = {
> @@ -218,7 +220,7 @@ nautilus_init_pci(void)
>  		return;
>  
>  	pci_add_resource(&bridge->windows, &ioport_resource);
> -	pci_add_resource(&bridge->windows, &iomem_resource);
> +	pci_add_resource(&bridge->windows, &irongate_mem);
>  	pci_add_resource(&bridge->windows, &busn_resource);
>  	bridge->dev.parent = NULL;
>  	bridge->sysdata = hose;

If it works for Matt, that looks reasonable to me.

> > There's probably some register in the chipset that tells us where the
> > MMIO aperture starts.  The best thing to do would be to read that
> > register, use it to initialize irongate_mem, and use that as the MMIO
> > aperture.
> 
> Surely there is the register, namely IRONGATE0->pci_mem, but it's
> basically write-only for us as it contains utter crap on bootup.
> 
> > But I don't know where to look in the chipset, and it looks like the
> > current strategy is to infer the base by looking at BAR assignments of
> > PCI devices.  Can you try the patch below (based on v4.17-rc1) and
> > save the dmesg and /proc/iomem and /proc/ioports contents?  I'm
> > guessing at some things here, so I added a few debug printks, too.
> 
> No, the strategy was to do PCI resource allocations from scratch,
> minimizing MMIO aperture to save as much RAM as possible in 4Gb
> memory configuration. That's what all that hackery with bus sizing
> was for. We pretended that irongate is sort of non-standard p2p bridge
> (which is almost true wrt internal alpha ev6 "host bridge"),
> called pci_bus_size_bridges() for it, then moved calculated MMIO
> window up to 4G boundary and then did normal "assign unassigned".
> However, it was broken long time ago in a more subtle way - even in
> Matt's dmesg from working 3.13 kernels AGP framebuffer resource ended
> up either unassigned or in the wrong place. This is relatively harmless
> if you don't use graphics though. Not sure how to fix that, this
> "root bridge" approach looks rather limiting to me.

I think the suggestion is that we should be able to enumerate all the
devices and learn their resource requirements, which only requires
config accesses and can be done with no MMIO accesses at all, and then
use that information to compute the size of the host bridge aperture,
program it, and enable it.

That does make good sense.  The problem in the ACPI world is that we
don't know how to program that host bridge aperture.  The firmware
tells us what it is with the _CRS (current resource settings) method.
There is a provision for changing it via _PRS and _SRS ("possible" and
"set" resource settings), but AFAIK no platforms implement those for
PCI host bridges, and Linux doesn't support them.

So I guess for now we're stuck with assuming a basically fixed
aperture, unless we hack around like Nautilus does.

Bjorn
