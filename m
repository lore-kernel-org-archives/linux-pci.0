Return-Path: <SRS0=lRfe=YF=intel.com=ashok.raj@kernel.org>
Return-Path: <SRS0=lRfe=YF=intel.com=ashok.raj@kernel.org>
Date: Thu, 22 Dec 2016 15:32:38 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	rwright@hpe.com, ashok.raj@intel.com
Subject: Re: possible dmar_init_reserved_ranges() error
Message-ID: <20161222233238.GA20861@otc-nc-03>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
 <20161222162713.GF17255@8bytes.org>
 <20161222202803.GA16855@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161222202803.GA16855@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

On Thu, Dec 22, 2016 at 02:28:03PM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 22, 2016 at 05:27:14PM +0100, Joerg Roedel wrote:
> > Hi Bjorn,
> > 
> > On Mon, Dec 19, 2016 at 03:20:44PM -0600, Bjorn Helgaas wrote:
> > > I have some questions about dmar_init_reserved_ranges().  On systems
> > > where CPU physical address space is not identity-mapped to PCI bus
> > > address space, e.g., where the PCI host bridge windows have _TRA
> > > offsets, I'm not sure we're doing the right thing.
> > > 
> > > Assume we have a PCI host bridge with _TRA that maps CPU addresses
> > > 0x80000000-0x9fffffff to PCI bus addresses 0x00000000-0x1fffffff, with
> > > two PCI devices below it:

This is the first time I'm hearing about it too!,and tracked it to 
2002, one of Bjorn's patches from past life :-)

> > > 
> > >   PCI host bridge domain 0000 [bus 00-3f]
> > >   PCI host bridge window [mem 0x80000000-0x9fffffff] (bus 0x00000000-0x1fffffff]
> > >   00:00.0: BAR 0 [mem 0x80000000-0x8ffffffff] (0x00000000-0x0fffffff on bus)
> > >   00:01.0: BAR 0 [mem 0x90000000-0x9ffffffff] (0x10000000-0x1fffffff on bus)
> > > 
> > > The IOMMU init code in dmar_init_reserved_ranges() reserves the PCI
> > > MMIO space for all devices:
> > > 
> > >   pci_iommu_init()
> > >     intel_iommu_init()
> > >       dmar_init_reserved_ranges()
> > >         reserve_iova(0x80000000-0x8ffffffff)
> > >         reserve_iova(0x90000000-0x9ffffffff)
> > > 
> > > This looks odd because we're reserving CPU physical addresses, but
> > > the IOVA space contains *PCI bus* addresses.  On most x86 systems they
> > > would be the same, but not on all.
> > 
> > Interesting, I wasn't aware of that. Looks like we are not doing the
> > right thing in dmar_init_reserved_ranges(). How is that handled without
> > an IOMMU, when the bus-addresses overlap with ram addresses?

I'm not sure if there are platforms that i'm aware of that do _TRA. I'm 
checking internally if others have come across something like that.

> 
> I don't know enough about these systems to answer that.  One way would
> be to avoid overlaps, e.g., by using bus addresses
> 0x80000000-0xffffffff and not putting RAM at those addresses.  Or
> maybe the host bridge could apply a constant offset to bus addresses
> before forwarding transactions up to the sytem bus.
> 
> > > Assume the driver for 00:00.0 maps a page of main memory for DMA.  It
> > > may receive a dma_addr_t of 0x10000000:
> > > 
> > >   00:00.0: intel_map_page() returns dma_addr_t 0x10000000
> > >   00:00.0: issues DMA to 0x10000000
> > > 
> > > What happens here?  The DMA access should go to main memory.  In
> > > conventional PCI it would be a peer-to-peer access to device 00:01.0.
> > > Is there enough PCIe smarts (ACS or something?) to do otherwise?
> > 
> > If there is a bridge doing ACS between the devices, the IOMMU will see
> > the request and re-map it to its RAM address.

True, if its all acs enabled, we don't need this, probably true for legacy.
But it doesn't matter in big scheme of things to reserve.

> > 
> > > The dmar_init_reserved_ranges() comment says "Reserve all PCI MMIO to
> > > avoid peer-to-peer access."  Without _TRA, CPU addresses and PCI bus
> > > addresses would be identical, and I think these reserve_iova() calls
> > > *would* prevent this situation.  So maybe we're just missing a
> > > pcibios_resource_to_bus() here?
> > 
> > I'll have a look, the AMD IOMMU driver implements this too, so it needs
> > also be fixed there. Do you know which x86 systems are configured like
> > this?
> 
Let me check and keep you posted if we have such platforms to make sure if
we need this considerations for _TRA.

Cheers,
Ashok
