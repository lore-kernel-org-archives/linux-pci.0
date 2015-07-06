Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13509 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbGFPbB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 11:31:01 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
CC: Will Davis <wdavis@nvidia.com>, Dave Jiang <dave.jiang@intel.com>,
	"John Hubbard" <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	<iommu@lists.linux-foundation.org>,
	Jerome Glisse <jglisse@redhat.com>,
	<linux-pci@vger.kernel.org>,
	Terence Ripperda <tripperda@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 3/7] dma-mapping: pci: add pci_(un)map_resource
Date: Mon, 6 Jul 2015 10:16:11 -0500
Message-ID: <1436195771-11816-1-git-send-email-wdavis@nvidia.com>
In-Reply-To: <20150701183127.GD13409@google.com>
References: <20150701183127.GD13409@google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> On Wed, Jul 01, 2015 at 11:06:06AM -0500, Bjorn Helgaas wrote:
> > On Fri, May 29, 2015 at 12:14:42PM -0500, wdavis@... wrote:
> > > From: Will Davis <wdavis@...>
> > > 
> > > Simply route these through to the new dma_(un)map_resource APIs.
> > > 
> > > Signed-off-by: Will Davis <wdavis@...>
> > > Reviewed-by: Terence Ripperda <tripperda@...>
> > > Reviewed-by: John Hubbard <jhubbard@...>
> > > ---
> > >  include/asm-generic/pci-dma-compat.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
> > > index c110843..ac4a4ad 100644
> > > --- a/include/asm-generic/pci-dma-compat.h
> > > +++ b/include/asm-generic/pci-dma-compat.h
> > >  <at>  <at>  -61,6 +61,20  <at>  <at>  pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
> > >  	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
> > >  }
> > >  
> > > +static inline dma_addr_t
> > > +pci_map_resource(struct pci_dev *hwdev, struct resource *resource,
> > > +		 unsigned long offset, size_t size, int direction)
> > 
> > After 3a9ad0b4fdcd ("PCI: Add pci_bus_addr_t"), which will appear in
> > v4.2-rc1, there is a pci_bus_addr_t, and I think you need that instead
> > of dma_addr_t.
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3a9ad0b4fdcd
> 
> This wasn't a very good response, sorry.  I don't think just
> changing dma_addr_t to pci_bus_addr_t is a good resolution.
> 
> Isn't there an implicit assumption here that either you're using an IOMMU
> driver that always returns bus addresses that fit in a dma_addr_t, or
> you're not using an IOMMU and dma_addr_t is big enough for any bus address?
> 
> What happens on a system with 64-bit PCI bus addresses, 32-bit dma_addr_t,
> and no IOMMU?  Would this return failure somehow?
> 

I think I see your point. Even if pci_map_resource() were changed to return
a pci_bus_addr_t, we would have the same problem again where the dma_addr_t
would either need to expand (a non-starter as already discussed) or replace
the return type of dma_map_resource() with something wider to accommodate,
or prevent such platforms from attempting to return a valid address that
will be truncated.

PCI devices on the platform in question (64-bit PCI bus addresses, 32-bit
dma_addr_t, and no IOMMU) should theoretically still be capable of PCI
peer-to-peer traffic, but would only be limited by the API, which we do not
want.

What about introducing another always-64-bit type, like peer_dma_addr_t,
for use with the new DMA APIs?

> > > +{
> > > +	return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
> > > +}
> > > +
> > > +static inline void
> > > +pci_unmap_resource(struct pci_dev *hwdev, dma_addr_t dma_address, size_t size,
> > > +		   int direction)
> > > +{
> > > +	dma_unmap_resource(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
> > > +}
> > > +
> > >  static inline int
> > >  pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
> > >  	   int nents, int direction)
> > > -- 
> > > 2.4.0
> > >
