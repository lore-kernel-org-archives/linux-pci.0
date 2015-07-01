Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37424 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbbGASbf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2015 14:31:35 -0400
Received: by igblr2 with SMTP id lr2so40865375igb.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2015 11:31:34 -0700 (PDT)
Date: Wed, 1 Jul 2015 13:31:27 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: wdavis@nvidia.com
Cc: Joerg Roedel <joro@8bytes.org>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Mark Hounschell <markh@compro.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Yijing Wang <wangyijing@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dma-mapping: pci: add pci_(un)map_resource
Message-ID: <20150701183127.GD13409@google.com>
References: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
 <1432919686-32306-4-git-send-email-wdavis@nvidia.com>
 <20150701160606.GA13409@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150701160606.GA13409@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 01, 2015 at 11:06:06AM -0500, Bjorn Helgaas wrote:
> On Fri, May 29, 2015 at 12:14:42PM -0500, wdavis@nvidia.com wrote:
> > From: Will Davis <wdavis@nvidia.com>
> > 
> > Simply route these through to the new dma_(un)map_resource APIs.
> > 
> > Signed-off-by: Will Davis <wdavis@nvidia.com>
> > Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  include/asm-generic/pci-dma-compat.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
> > index c110843..ac4a4ad 100644
> > --- a/include/asm-generic/pci-dma-compat.h
> > +++ b/include/asm-generic/pci-dma-compat.h
> > @@ -61,6 +61,20 @@ pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
> >  	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
> >  }
> >  
> > +static inline dma_addr_t
> > +pci_map_resource(struct pci_dev *hwdev, struct resource *resource,
> > +		 unsigned long offset, size_t size, int direction)
> 
> After 3a9ad0b4fdcd ("PCI: Add pci_bus_addr_t"), which will appear in
> v4.2-rc1, there is a pci_bus_addr_t, and I think you need that instead
> of dma_addr_t.
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3a9ad0b4fdcd

This wasn't a very good response, sorry.  I don't think just
changing dma_addr_t to pci_bus_addr_t is a good resolution.

Isn't there an implicit assumption here that either you're using an IOMMU
driver that always returns bus addresses that fit in a dma_addr_t, or
you're not using an IOMMU and dma_addr_t is big enough for any bus address?

What happens on a system with 64-bit PCI bus addresses, 32-bit dma_addr_t,
and no IOMMU?  Would this return failure somehow?

> > +{
> > +	return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
> > +}
> > +
> > +static inline void
> > +pci_unmap_resource(struct pci_dev *hwdev, dma_addr_t dma_address, size_t size,
> > +		   int direction)
> > +{
> > +	dma_unmap_resource(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
> > +}
> > +
> >  static inline int
> >  pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
> >  	   int nents, int direction)
> > -- 
> > 2.4.0
> > 
