Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15035 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932425AbbGGTOT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2015 15:14:19 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Dave Jiang <dave.jiang@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	<iommu@lists.linux-foundation.org>,
	Jerome Glisse <jglisse@redhat.com>,
	<linux-pci@vger.kernel.org>,
	Terence Ripperda <tripperda@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Hounschell <markh@compro.net>,
	"joro@8bytes.org" <joro@8bytes.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 7/7] x86: add pci-nommu implementation of map_resource
Date: Tue, 7 Jul 2015 13:59:40 -0500
Message-ID: <1436295580-3034-1-git-send-email-wdavis@nvidia.com>
In-Reply-To: <20150707153428.GA14784@google.com>
References: <20150707153428.GA14784@google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> [+cc Mark, Joerg, Konrad, Alex]
> 
> Hi Will,
> 
> On Wed, Jul 01, 2015 at 01:14:30PM -0500, Will Davis wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > On Fri, May 29, 2015 at 12:14:46PM -0500, wdavis@nvidia.com wrote:
> > > > From: Will Davis <wdavis@nvidia.com>
> > > > 
> > > > Lookup the bus address of the resource by finding the parent host bridge,
> > > > which may be different than the parent host bridge of the target device.
> > > > 
> > > > Signed-off-by: Will Davis <wdavis@nvidia.com>
> > > > ---
> > > >  arch/x86/kernel/pci-nommu.c | 32 ++++++++++++++++++++++++++++++++
> > > >  1 file changed, 32 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
> > > > index da15918..6384482 100644
> > > > --- a/arch/x86/kernel/pci-nommu.c
> > > > +++ b/arch/x86/kernel/pci-nommu.c
> > > > @@ -38,6 +38,37 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
> > > >  	return bus;
> > > >  }
> > > >  
> > > > +static dma_addr_t nommu_map_resource(struct device *dev, struct resource *res,
> > > > +				     unsigned long offset, size_t size,
> > > > +				     enum dma_data_direction dir,
> > > > +				     struct dma_attrs *attrs)
> > > > +{
> > > > +	struct pci_bus *bus;
> > > > +	struct pci_host_bridge *bridge;
> > > > +	struct resource_entry *window;
> > > > +	resource_size_t bus_offset = 0;
> > > > +	dma_addr_t dma_address;
> > > > +
> > > > +	/* Find the parent host bridge of the resource, and determine the
> > > > +	 * relative offset.
> > > > +	 */
> > > > +	list_for_each_entry(bus, &pci_root_buses, node) {
> > > > +		bridge = to_pci_host_bridge(bus->bridge);
> > > > +		resource_list_for_each_entry(window, &bridge->windows) {
> > > > +			if (resource_contains(window->res, res))
> > > > +				bus_offset = window->offset;
> > > > +		}
> > > > +	}
> > > 
> > > I don't think this is safe.  Assume we have the following topology, and
> > > we want to set it up so 0000:00:00.0 can perform peer-to-peer DMA to
> > > 0001:00:01.0:
> > > 
> > >   pci_bus 0000:00: root bus resource [mem 0x80000000-0xffffffff] (bus address [0x80000000-0xffffffff])
> > >   pci 0000:00:00.0: ...
> > >   pci_bus 0001:00: root bus resource [mem 0x180000000-0x1ffffffff] (bus address [0x80000000-0xffffffff])
> > >   pci 0001:00:01.0: reg 0x10: [mem 0x180000000-0x1803fffff 64bit]
> > > 
> > > I assume the way this works is that the driver for 0000:00:00.0 would call
> > > this function with 0001:00:01.0 and [mem 0x180000000-0x1803fffff 64bit].
> > > 
> > 
> > The intention is that pci_map_resource() would be called with the device to
> > map the region to, and the resource to map. So in this example, we would
> > call pci_map_resource(0000:00:00.0, [mem 0x180000000-0x1803fffff 64bit]).
> > The driver for 0000:00:00.0 needs to pass some information to
> > pci_map_resource() indicating that the mapping is for device 0000:00:00.0.
> 
> Oh, of course; that's sort of analogous to the way the other DMA
> mapping interfaces work.
> 
> > > We'll figure out that the resource belongs to 0001:00, so we return a
> > > dma_addr of 0x80000000, which is the bus address as seen by 0001:00:01.0.
> > > But if 0000:00:00.0 uses that address, it refers to something in the
> > > 0000:00 hierarchy, not the 0001:00 hierarchy.
> > 
> > If the bus addresses are organized as described, is peer-to-peer DMA even
> > possible with this nommu topology? Is there any way in which device
> > 0000:00:00.0 can address resources under the 0001:00: root bus, since the
> > bus address range is identical?
> 
> It doesn't seem possible on conventional PCI, because the host bridge
> to 0000:00 believes the transaction is intended for a device under it,
> not for a device under 0001:00.
> 
> On PCIe, I think it would depend on ACS configuration and the IOMMU
> and whether there's anything that can route transactions between host
> bridges.
> 
> Is it important to support peer-to-peer between host bridges?  If it's
> not important, you could probably simplify things by disallowing that
> case.
>

I've mostly been focused on peer-to-peer under a single root complex. At
least for our hardware (which is what I've had to test with), we only
support peer-to-peer when both devices are under the same root complex,
due to some performance and/or functional issues that I am not entirely
clear on, seen when trying to peer-to-peer to a device under another root
complex via Intel QPI [1]:

"The ability to use the peer-to-peer
protocol among GPUs, and its performance, is constrained
by the PCIe topology; performance is excellent when two
GPUs share the same PCIe root-complex, e.g. they are directly
connected to a PCIe switch or to the same hub. Otherwise,
when GPUs are linked to different bus branches, performance
may suffers or malfunctionings can arise. This can be an issue
on multi-socket Sandy Bridge Xeon platforms, where PCIe
slots might be connected to different processors, therefore
requiring GPU peer-to-peer traffic to cross the inter-socket
QPI channel(s)."

Apparently the QPI protocol is not quite compatible with PCIe peer-to-peer,
so perhaps that is what is being referred to [2]:

"The IOH does not support non-contiguous byte enables from PCI Express for
remote peer-to-peer MMIO transactions. This is an additional restriction
over the PCI Express standard requirements to prevent incompatibility with
Intel QuickPath Interconnect."

[1] http://arxiv.org/pdf/1307.8276.pdf
[2] http://www.intel.com/content/www/us/en/chipsets/5520-5500-chipset-ioh-datasheet.html

I'm trying to find some more details on the issues behind this but it
seems that they are Intel-specific. Although if we can't determine an
easy way to tell if inter-root-complex peer-to-peer is supported, per
the other sub-thread, then maybe it would be best to just disable that
case for now.

> The pci_map_resource(struct pci_dev *, struct resource *, offset, ...)
> interface is analogous to dma_map_single() and similar interfaces.
> But we're essentially using the resource as a proxy to identify the
> other device: we use the resource, i.e., the CPU physical address of
> one of the BARs, to search for the host bridge.
> 
> What would you think about explicitly passing both devices, e.g.,
> replacing the "struct resource *" with a "struct pci_dev *, int bar"
> pair?  It seems like then we'd be better prepared to figure out
> whether it's even possible to do peer-to-peer between the two devices.
> 

Yes, that does sound better to me. I'll work this into the next version.

Thanks,
Will

> I don't know how to discover that today, but I assume that's just
> because I'm ignorant or there's a hole in the system description that
> might be filled eventually.
> 
> Bjorn
> 
