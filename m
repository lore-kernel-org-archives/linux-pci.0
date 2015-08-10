Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11034 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbbHJS3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 14:29:36 -0400
From: William Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	"Mark Hounschell" <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <TRipperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: RE: [PATCH v4 09/12] iommu/vt-d: implement (un)map_peer_resource
Date: Mon, 10 Aug 2015 18:29:35 +0000
Message-ID: <350bf3a78cf840bd8d45d1ca7df07271@HQMAIL106.nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
 <1437601197-6481-10-git-send-email-wdavis@nvidia.com>
 <20150810170217.GB32452@google.com>
In-Reply-To: <20150810170217.GB32452@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, August 10, 2015 12:02 PM, Bjorn Helgaas wrote:
> On Wed, Jul 22, 2015 at 04:39:54PM -0500, Will Davis wrote:
> > Implement 'map_peer_resource' for the Intel IOMMU driver. Simply translate
> > the resource to a physical address and route it to the same handlers used
> > by the 'map_page' API.
> >
> > This allows a device to map another's resource, to enable peer-to-peer
> > transactions.
> >
> > These functions are guarded behind CONFIG_HAS_DMA_P2P, since the
> > dma_map_ops members are as well.
> >
> > Signed-off-by: Will Davis <wdavis@nvidia.com>
> > Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index a98a7b2..66b371c 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -3544,6 +3544,40 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
> >  	intel_unmap(dev, dev_addr);
> >  }
> >
> > +#ifdef CONFIG_HAS_DMA_P2P
> > +static dma_peer_addr_t intel_map_peer_resource(struct device *dev,
> > +					       struct device *peer,
> > +					       struct resource *res,
> > +					       unsigned long offset,
> > +					       size_t size,
> > +					       enum dma_data_direction dir,
> > +					       struct dma_attrs *attrs)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct pci_dev *ppeer = to_pci_dev(peer);
> 
> You got "struct device" pointers, so they might not be PCI devices.  You
> should probably return an error if one is not PCI.
> 
> > +	struct pci_host_bridge *hbdev = pci_find_host_bridge(pdev->bus);
> > +	struct pci_host_bridge *hbpeer = pci_find_host_bridge(ppeer->bus);
> > +
> > +	/*
> > +	 * Disallow the peer-to-peer mapping if the devices do not share a host
> > +	 * bridge.
> > +	 */
> > +	if (hbdev != hbpeer)
> > +		return 0;
> 
> I think the only thing guaranteed by the spec is peer-to-peer between
> devices in the same hierarchy, where the hierarchy is rooted at a PCIe Root
> Port or a conventional PCI host bridge.  I don't remember anything about
> transactions between Root Ports or conventional PCI host bridges.
> 
> If there is some language in the spec about those transactions, a citation
> here would be nice.
> 

The only thing I could find in the conventional PCI spec was in section
3.10.7 (PCI Local Bus Specification Revision 3.0):

"7.  Peer-to-peer transactions crossing multiple host bridges
     PCI host bridges may, but are not required to, support PCI peer-to-peer
     transactions that traverse multiple PCI host bridges."

In the PCIe spec (PCI Express Base Specification Revision 3.0), section 1.3.1:
"The capability to route peer-to-peer transactions between hierarchy domains
 through a Root Complex is optional and implementation dependent. For example,
 an implementation may incorporate a real or virtual Switch internally within
 the Root Complex to enable full peer-to-peer support in a software transparent
 way."

And then as noted in a previous thread, the ACS part of the spec does not
make it possible to know for sure (section 6.12.1.1 and footnote 80):

"ACS P2P Request Redirect: must be implemented by Root Ports that support
 peer-to-peer traffic with other Root Ports;80 must be implemented by Switch
 Downstream Ports.
 ...
 80 Root Port indication of ACS P2P Request Redirect or ACS P2P Completion
 Redirect support does not imply any particular level of peer-to-peer support
 by the Root Complex, or that peer-to-peer traffic is supported at all"

I could add these citations to the comment, noting that we disable this case
because we don't have any way to know for sure (short of a chipset whitelist).

> This decision might be better made by a PCI interface.  This same basic
> logic is repeated here, in the AMD equivalent, and in the x86 code, and I
> suspect it will end up being a little more complicated for the reasons
> above.
>

Agreed, I will move this to a separate interface (something like
pci_is_p2p_possible(dev, peer)).

Thanks,
Will
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
