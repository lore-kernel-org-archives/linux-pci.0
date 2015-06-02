Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12310 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759078AbbFBO1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2015 10:27:07 -0400
From: William Davis <wdavis@nvidia.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Terence Ripperda <TRipperda@nvidia.com>,
	"John Hubbard" <jhubbard@nvidia.com>,
	"jglisse@redhat.com" <jglisse@redhat.com>
Subject: RE: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
Date: Tue, 2 Jun 2015 14:27:05 +0000
Message-ID: <37dbe5add91042539fd8dffd596d7738@HQMAIL106.nvidia.com>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
 <1431973504-5903-5-git-send-email-wdavis@nvidia.com>
 <20150601212528.GC7354@konrad-lan.dumpdata.com>
In-Reply-To: <20150601212528.GC7354@konrad-lan.dumpdata.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Monday, June 1, 2015 4:25 PM
> To: William Davis
> Cc: joro@8bytes.org; bhelgaas@google.com; iommu@lists.linux-foundation.org;
> linux-pci@vger.kernel.org; Terence Ripperda; John Hubbard;
> jglisse@redhat.com
> Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource()
> documentation
> 
> On Mon, May 18, 2015 at 01:25:01PM -0500, wdavis@nvidia.com wrote:
> > From: Will Davis <wdavis@nvidia.com>
> >
> > Add references to both the general API documentation as well as the
> HOWTO.
> >
> > Signed-off-by: Will Davis <wdavis@nvidia.com>
> > ---
> >  Documentation/DMA-API-HOWTO.txt | 39
> +++++++++++++++++++++++++++++++++++++--
> >  Documentation/DMA-API.txt       | 36 +++++++++++++++++++++++++++++++----
> -
> >  2 files changed, 68 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/DMA-API-HOWTO.txt
> > b/Documentation/DMA-API-HOWTO.txt index 0f7afb2..89bd730 100644
> > --- a/Documentation/DMA-API-HOWTO.txt
> > +++ b/Documentation/DMA-API-HOWTO.txt
> > @@ -138,6 +138,10 @@ What about block I/O and networking buffers?  The
> > block I/O and  networking subsystems make sure that the buffers they
> > use are valid  for you to DMA from/to.
> >
> > +In some systems, it may also be possible to DMA to and/or from a peer
> > +device's MMIO region, as described by a 'struct resource'. This is
> > +referred to as a peer-to-peer mapping.
> > +
> >  			DMA addressing limitations
> >
> >  Does your device have any DMA addressing limitations?  For example,
> > is @@ -648,6 +652,35 @@ Every dma_map_{single,sg}() call should have
> > its dma_unmap_{single,sg}()  counterpart, because the bus address
> > space is a shared resource and  you could render the machine unusable by
> consuming all bus addresses.
> >
> > +Peer-to-peer DMA mappings can be obtained using dma_map_resource() to
> > +map another device's MMIO region for the given device:
> > +
> > +	struct resource *peer_mmio_res = &other_dev->resource[0];
> > +	dma_addr_t dma_handle = dma_map_resource(dev, peer_mmio_res,
> > +						 offset, size, direction);
> > +	if (dma_handle == 0 || dma_mapping_error(dev, dma_handle))
> 
> Don't check for 0. That can be a valid value.
> 
> > +	{
> > +		/*
> > +		 * If dma_handle == 0, dma_map_resource() is not
> > +		 * implemented, and peer-to-peer transactions will not
> > +		 * work.
> 
> Perhaps we should just have an dma_can_map_resource function instead to
> check for this?

In v3 of this patch set, I've added a BUG_ON(ops->map_resource == NULL) to
dma_map_resource() instead of possibly returning 0, at Joerg's suggestion.

In that case, a dma_can_map_resource() would do the same check a driver
would before calling dma_map_resource(), e.g., that
ops->map_resource != NULL. It does seem nicer to wrap that in an API call.

Thanks,
Will

--
nvpublic
