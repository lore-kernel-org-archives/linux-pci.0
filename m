Return-Path: <SRS0=kfwO=GG=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=kfwO=GG=arm.com=lorenzo.pieralisi@kernel.org>
Date: Fri, 16 Mar 2018 17:23:44 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, treding@nvidia.com,
	bhelgaas@google.com, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, kthota@nvidia.com, swarren@nvidia.com,
	mmaddireddy@nvidia.com, Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
Message-ID: <20180316172344.GA13373@red-moon>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <7727b9bc-a44b-4cbe-1839-7e4dd7c2c186@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <7727b9bc-a44b-4cbe-1839-7e4dd7c2c186@nvidia.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 12:11:05AM +0530, Vidya Sagar wrote:

[...]

> >>>>--- a/drivers/pci/host/pci-tegra.c
> >>>>+++ b/drivers/pci/host/pci-tegra.c
> >>>>@@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
> >>>>  	}
> >>>>  	/* setup AFI/FPCI range */
> >>>>-	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> >>>>+	msi->pages = __get_free_pages(GFP_DMA, 0);
> >>>>  	msi->phys = virt_to_phys((void *)msi->pages);
> >>>Should this be GFP_DMA32?  See the comment above the GFP_DMA
> >>>definition.
> >>looking at the comments for both GFP_DMA32 and GFP_DMA, I thought GFP_DMA32
> >>is the correct one to use, but, even with that I got >32-bit addresses.
> >>GFP_DMA always gives addresses in <4GB boundary (i.e. 32-bit).
> >>I didn't dig into it to find out why is this the case.
> >This sounds worth looking into (but maybe we don't need the
> >__get_free_pages() at all; see below).  Maybe there's some underlying
> >bug.  My laptop shows this, which looks like it might be related:
> >
> >   Zone ranges:
> >     DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> >     DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> >     Normal   [mem 0x0000000100000000-0x00000004217fffff]
> >     Device   empty
> >
> >What does your machine show?
> I see following in my linux box
>  Zone ranges:
>    DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>    DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>    Normal   [mem 0x0000000100000000-0x000000106effffff]
>    Device   empty
> 
> and following in my T210 Tegra platform
> Zone ranges:
>   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
>   Normal   [mem 0x0000000100000000-0x000000017fffffff]
> 
> >
> >>>Should we be using virt_to_phys() here?  Where exactly is the
> >>>result ("msi->phys") used, i.e., what bus will that address appear
> >>>on?  If it appears on the PCI side, this should probably use
> >>>something like pcibios_resource_to_bus().
> >>This address is written to two places.  First, into host's internal
> >>register to let it know that when an incoming memory write comes
> >>with this address, raise an MSI interrupt instead of forwarding it
> >>to memory subsystem.  Second, into 'Message Address' field of
> >>'Message Address Register for MSI' register in end point's
> >>configuration space (this is done by MSI framework) for end point to
> >>know which address to be used to generate MSI interrupt.
> >Hmmm, ISTR some past discussion about this.  Here's a little: [1, 2].
> >And this commit [3] sounds like it describes a similar hardware
> >situation with Tegra where the host bridge intercepts the MSI target
> >address, so writes to it never reach system memory.  That means that
> >Tegra doesn't need to allocate system memory at all.
> >
> >Is your system similar?  Can you just statically allocate a little bus
> >address space, use that for the MSI target address, and skip the
> >__get_free_pages()?
> It is the same system where MSI memory writes don't really make it to
> system memory. But, the addresses mentioned in that patch don't work.
> we are working with hardware folks on understanding the issue better.
> Meanwhile, using GFP_DMA is giving consistent results and thought this
> can be used as a stop gap solution before we figure out a better bus
> address to be used as MSI target address.

Vidya,

I will mark this as superseded - by Thierry's patch:

https://patchwork.ozlabs.org/patch/848569/

even though we have not reached a real conclusion yet
on that patch - we should take this discussion from the
thread above.

Thank you,
Lorenzo

> >>>Do rcar_pcie_enable_msi() and xilinx_pcie_enable_msi() have a
> >>>similar problem?  They both use GFP_KERNEL, then virt_to_phys(),
> >>>then write the result of virt_to_phys() using a 32-bit register
> >>>write.
> >>Well, if those systems deal with 64-bit addresses and when an end
> >>point is connected which supports only 32-bit MSI addresses, this
> >>problem will surface when __get_free_pages() returns an address that
> >>translates to a >32-bit address after virt_to_phys() call on it.
> >I'd like to hear from the R-Car and Xilinx folks about (1) whether
> >there's a potential issue with truncating a 64-bit address, and
> >(2) whether that hardware works like Tegra, where the MSI write never
> >reaches memory so we don't actually need to allocate a page.
> >
> >If all we need is to allocate a little bus address space for the MSI
> >target, I'd like to figure out a better way to do that than
> >__get_free_pages().  The current code seems a little buggy, and
> >it's getting propagated through several drivers.
> >
> >>>>  	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
> >[1] https://lkml.kernel.org/r/20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com
> >[2] https://lkml.kernel.org/r/86efs3wesi.fsf@arm.com
> >[3] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d7bd554f27c9
> 
