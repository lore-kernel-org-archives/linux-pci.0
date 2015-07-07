Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37116 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188AbbGGPee (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2015 11:34:34 -0400
Received: by igau2 with SMTP id u2so39634315iga.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2015 08:34:34 -0700 (PDT)
Date: Tue, 7 Jul 2015 10:34:28 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Will Davis <wdavis@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux-foundation.org,
	Jerome Glisse <jglisse@redhat.com>, linux-pci@vger.kernel.org,
	Terence Ripperda <tripperda@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Hounschell <markh@compro.net>,
	"joro@8bytes.org" <joro@8bytes.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 7/7] x86: add pci-nommu implementation of map_resource
Message-ID: <20150707153428.GA14784@google.com>
References: <20150701164520.GC13409@google.com>
 <1435774470-2917-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435774470-2917-1-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mark, Joerg, Konrad, Alex]

Hi Will,

On Wed, Jul 01, 2015 at 01:14:30PM -0500, Will Davis wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > On Fri, May 29, 2015 at 12:14:46PM -0500, wdavis@nvidia.com wrote:
> > > From: Will Davis <wdavis@nvidia.com>
> > > 
> > > Lookup the bus address of the resource by finding the parent host bridge,
> > > which may be different than the parent host bridge of the target device.
> > > 
> > > Signed-off-by: Will Davis <wdavis@nvidia.com>
> > > ---
> > >  arch/x86/kernel/pci-nommu.c | 32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
> > > index da15918..6384482 100644
> > > --- a/arch/x86/kernel/pci-nommu.c
> > > +++ b/arch/x86/kernel/pci-nommu.c
> > > @@ -38,6 +38,37 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
> > >  	return bus;
> > >  }
> > >  
> > > +static dma_addr_t nommu_map_resource(struct device *dev, struct resource *res,
> > > +				     unsigned long offset, size_t size,
> > > +				     enum dma_data_direction dir,
> > > +				     struct dma_attrs *attrs)
> > > +{
> > > +	struct pci_bus *bus;
> > > +	struct pci_host_bridge *bridge;
> > > +	struct resource_entry *window;
> > > +	resource_size_t bus_offset = 0;
> > > +	dma_addr_t dma_address;
> > > +
> > > +	/* Find the parent host bridge of the resource, and determine the
> > > +	 * relative offset.
> > > +	 */
> > > +	list_for_each_entry(bus, &pci_root_buses, node) {
> > > +		bridge = to_pci_host_bridge(bus->bridge);
> > > +		resource_list_for_each_entry(window, &bridge->windows) {
> > > +			if (resource_contains(window->res, res))
> > > +				bus_offset = window->offset;
> > > +		}
> > > +	}
> > 
> > I don't think this is safe.  Assume we have the following topology, and
> > we want to set it up so 0000:00:00.0 can perform peer-to-peer DMA to
> > 0001:00:01.0:
> > 
> >   pci_bus 0000:00: root bus resource [mem 0x80000000-0xffffffff] (bus address [0x80000000-0xffffffff])
> >   pci 0000:00:00.0: ...
> >   pci_bus 0001:00: root bus resource [mem 0x180000000-0x1ffffffff] (bus address [0x80000000-0xffffffff])
> >   pci 0001:00:01.0: reg 0x10: [mem 0x180000000-0x1803fffff 64bit]
> > 
> > I assume the way this works is that the driver for 0000:00:00.0 would call
> > this function with 0001:00:01.0 and [mem 0x180000000-0x1803fffff 64bit].
> > 
> 
> The intention is that pci_map_resource() would be called with the device to
> map the region to, and the resource to map. So in this example, we would
> call pci_map_resource(0000:00:00.0, [mem 0x180000000-0x1803fffff 64bit]).
> The driver for 0000:00:00.0 needs to pass some information to
> pci_map_resource() indicating that the mapping is for device 0000:00:00.0.

Oh, of course; that's sort of analogous to the way the other DMA
mapping interfaces work.

> > We'll figure out that the resource belongs to 0001:00, so we return a
> > dma_addr of 0x80000000, which is the bus address as seen by 0001:00:01.0.
> > But if 0000:00:00.0 uses that address, it refers to something in the
> > 0000:00 hierarchy, not the 0001:00 hierarchy.
> 
> If the bus addresses are organized as described, is peer-to-peer DMA even
> possible with this nommu topology? Is there any way in which device
> 0000:00:00.0 can address resources under the 0001:00: root bus, since the
> bus address range is identical?

It doesn't seem possible on conventional PCI, because the host bridge
to 0000:00 believes the transaction is intended for a device under it,
not for a device under 0001:00.

On PCIe, I think it would depend on ACS configuration and the IOMMU
and whether there's anything that can route transactions between host
bridges.

Is it important to support peer-to-peer between host bridges?  If it's
not important, you could probably simplify things by disallowing that
case.

The pci_map_resource(struct pci_dev *, struct resource *, offset, ...)
interface is analogous to dma_map_single() and similar interfaces.
But we're essentially using the resource as a proxy to identify the
other device: we use the resource, i.e., the CPU physical address of
one of the BARs, to search for the host bridge.

What would you think about explicitly passing both devices, e.g.,
replacing the "struct resource *" with a "struct pci_dev *, int bar"
pair?  It seems like then we'd be better prepared to figure out
whether it's even possible to do peer-to-peer between the two devices.

I don't know how to discover that today, but I assume that's just
because I'm ignorant or there's a hole in the system description that
might be filled eventually.

Bjorn
