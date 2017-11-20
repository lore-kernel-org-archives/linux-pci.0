Return-Path: <SRS0=Wo73=CS=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=Wo73=CS=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 20 Nov 2017 17:07:08 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <treding@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	kthota@nvidia.com, swarren@nvidia.com, mmaddireddy@nvidia.com,
	Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Simon Horman <horms@verge.net.au>, ryder.lee@mediatek.com
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
Message-ID: <20171120170708.GA1941@red-moon>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <20171110112201.GA25235@red-moon>
 <3887d62c-98bb-04d5-5b40-96d5b7b43e63@arm.com>
 <20171110130704.GA31316@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110130704.GA31316@ulmo>
List-ID: <linux-pci.vger.kernel.org>

[+ryder]

On Fri, Nov 10, 2017 at 02:07:05PM +0100, Thierry Reding wrote:

[...]

> > The really neat version is to take a known non-memory physical address like
> > the host controller's own MMIO region, which has no legitimate reason to
> > ever be used as a DMA address. pcie-mediatek almost gets this right, but by
> > using virt_to_phys() on an ioremapped address they end up with nonsense
> > rather than the correct address (although realistically you would have to be
> > extremely unlucky for said nonsense to collide with a real DMA address given
> > to a PCI endpoint later). Following on from above, dma_map_resource() would
> > be the foolproof way to get that right.
> 
> Yes, that was our intention as well. Our initial plan was to use an
> address from the PCI aperture within Tegra that wasn't being used for
> any other purpose.

Hi Thierry,

to wrap up this thread, why an address from the PCI aperture and
not a host bridge register ?

I CC'ed Ryder so that he can explain to me please what:

PCIE_MSI_VECTOR and PCIE_IMSI_ADDR offsets in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/host/pcie-mediatek.c?h=v4.14

register space represent (IIUC the driver uses:

virt_to_phys(port->base + PCIE_MSI_VECTOR);

as MSI doorbell address, which is wrong anyway as Robin explained, just
want to understand how that register was chosen - it is never written or
read in the driver so it is hard to figure that out) to understand
whether the approach can be replicated instead of relying on GFP_DMA
for pages allocation.

Thanks,
Lorenzo

> However, we ran into some odd corner cases where this wasn't working
> as expected. As a temporary solution we wanted to move to GFP_DMA32
> (or GFP_DMA) in order to support 32-bit only MSI endpoints.
> 
> Eventually we'll want to get rid of the allocation altogether, we just
> need to find a set of values that work reliably. In the meantime, it
> looks as though GFP_DMA would be the right solution as long as we have
> to stick with __get_free_pages().
> 
> Alternatively, since we've already verified that the MSI writes are
> never committed to memory, we could choose some random address pointing
> to system memory as well, but I'm reluctant to do that because it could
> end up being confusing for users (and developers) to see some random
> address showing up somewhere. A physical address such as the beginning
> of system memory should always work and might be unique enough to
> indicate that it is special.
> 
> Thierry
