Return-Path: <SRS0=d0NJ=CL=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=d0NJ=CL=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 13 Nov 2017 11:06:14 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	treding@nvidia.com, bhelgaas@google.com,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	kthota@nvidia.com, swarren@nvidia.com, mmaddireddy@nvidia.com,
	Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
Message-ID: <20171113110614.GB27700@red-moon>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <20171110112201.GA25235@red-moon>
 <3887d62c-98bb-04d5-5b40-96d5b7b43e63@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3887d62c-98bb-04d5-5b40-96d5b7b43e63@arm.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 12:04:21PM +0000, Robin Murphy wrote:

[...]

> >>>>Do rcar_pcie_enable_msi() and xilinx_pcie_enable_msi() have a
> >>>>similar problem?  They both use GFP_KERNEL, then virt_to_phys(),
> >>>>then write the result of virt_to_phys() using a 32-bit register
> >>>>write.
> >>>
> >>>Well, if those systems deal with 64-bit addresses and when an end
> >>>point is connected which supports only 32-bit MSI addresses, this
> >>>problem will surface when __get_free_pages() returns an address that
> >>>translates to a >32-bit address after virt_to_phys() call on it.
> >>
> >>I'd like to hear from the R-Car and Xilinx folks about (1) whether
> >>there's a potential issue with truncating a 64-bit address, and
> >>(2) whether that hardware works like Tegra, where the MSI write never
> >>reaches memory so we don't actually need to allocate a page.
> >>
> >>If all we need is to allocate a little bus address space for the MSI
> >>target, I'd like to figure out a better way to do that than
> >>__get_free_pages().  The current code seems a little buggy, and
> >>it's getting propagated through several drivers.
> 
> The really neat version is to take a known non-memory physical
> address like the host controller's own MMIO region, which has no
> legitimate reason to ever be used as a DMA address.

True - that could be safe enough.

What about IOVAs though ? I suspect we should reserve the MSI address
range - it looks like there is something missing here.

> pcie-mediatek almost gets this right, but by using virt_to_phys() on
> an ioremapped address they end up with nonsense rather than the
> correct address

That definitely needs fixing given that it works by chance.

> (although realistically you would have to be extremely unlucky for
> said nonsense to collide with a real DMA address given to a PCI
> endpoint later). Following on from above, dma_map_resource() would
> be the foolproof way to get that right.

That's how it should be done then lest it trickles into other drivers
requiring a similar set-up.

Thanks,
Lorenzo
