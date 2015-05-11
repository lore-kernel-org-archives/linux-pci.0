Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21926 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbbEKOao (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 10:30:44 -0400
Date: Mon, 11 May 2015 10:30:25 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: wdavis@nvidia.com, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org, jglisse@redhat.com,
	jhubbard@nvidia.com, tripperda@nvidia.com,
	Yinghai Lu <yinghai@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/6] dma-mapping: pci: add pci_(un)map_resource
Message-ID: <20150511143025.GD20282@l.oracle.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <1430505138-2877-4-git-send-email-wdavis@nvidia.com>
 <20150507151905.GL24643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150507151905.GL24643@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 07, 2015 at 10:19:05AM -0500, Bjorn Helgaas wrote:
> [+cc Dave for sparc64, Yinghai]
> 
> On Fri, May 01, 2015 at 01:32:15PM -0500, wdavis@nvidia.com wrote:
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
> > +{
> > +	return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
> > +}
> 
> On sparc64, PCI bus addresses, e.g., raw BAR values, can be 64 bits wide,
> but dma_addr_t is only 32 bits [1].  So dma_addr_t is a bit of a problem
> here.  It's likely that we will add a pci_bus_addr_t, but that hasn't
> happened yet [2].

Why not just expand the 'dma_addr_t' to be unsigned long (if to support
the T5-8 box)?
> 
> We do have existing problems already, e.g,. pci_bus_address() returns a
> dma_addr_t, so it has the same problem.  So I guess this is just a heads-up
> that this needs to be fixed eventually.
> 
> Bjorn
> 
> [1] http://lkml.kernel.org/r/20150327.145016.86183910134380870.davem@davemloft.net
> [2] http://lkml.kernel.org/r/1427857069-6789-2-git-send-email-yinghai@kernel.org
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
