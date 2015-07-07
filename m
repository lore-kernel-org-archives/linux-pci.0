Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53754 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757274AbbGGPlW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 11:41:22 -0400
Message-ID: <1436283678.1391.50.camel@redhat.com>
Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mark Hounschell <markh@compro.net>, wdavis@nvidia.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, tripperda@nvidia.com,
	jhubbard@nvidia.com, jglisse@redhat.com, konrad.wilk@oracle.com,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>
Date: Tue, 07 Jul 2015 09:41:18 -0600
In-Reply-To: <20150707151517.GA14215@google.com>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
	 <1431973504-5903-5-git-send-email-wdavis@nvidia.com>
	 <20150519234300.GA31666@google.com> <555C79E5.9040507@compro.net>
	 <20150707151517.GA14215@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-07-07 at 10:15 -0500, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> Hi Mark,
> 
> On Wed, May 20, 2015 at 08:11:17AM -0400, Mark Hounschell wrote:
> > Most currently available hardware doesn't allow reads but will allow
> > writes on PCIe peer-to-peer transfers. All current AMD chipsets are
> > this way. I'm pretty sure all Intel chipsets are this way also. What
> > happens with reads is they are just dropped with no indication of
> > error other than the data will not be as expected. Supposedly the
> > PCIe spec does not even require any peer-to-peer support. Regular
> > PCI there is no problem and this API could be useful. However I
> > doubt seriously you will find a pure PCI motherboard that has an
> > IOMMU.
> > 
> > I don't understand the chipset manufactures reasoning for disabling
> > PCIe peer-to-peer reads. We would like to make PCIe versions of our
> > cards but their application requires  peer-to-peer reads and writes.
> > So we cannot develop PCIe versions of the cards.
> 
> I'd like to understand this better.  Peer-to-peer between two devices
> below the same Root Port should work as long as ACS doesn't prevent
> it.  If we find an Intel or AMD IOMMU, I think we configure ACS to
> prevent direct peer-to-peer (see "pci_acs_enable"), but maybe it could
> still be done with the appropriate IOMMU support.  And if you boot
> with "iommu=off", we don't do that ACS configuration, so peer-to-peer
> should work.

The assumption I work from in vfio is that peer-to-peer should be able
to take a path through the IOMMU, that is from one endpoint, up through
to the RC (with ACS enabled), be translated by the IOMMU and directed
back downstream to the specified endpoint.  Whether that actually works
for any/all transactions, I can't say, I don't know how to test it.
It'd be interesting to know if this is a false assumption.

> I suppose the problem is that peer-to-peer doesn't work between
> devices under different Root Ports or even devices under different
> Root Complexes?
> 
> PCIe r3.0, sec 6.12.1.1, says Root Ports that support peer-to-peer
> traffic are required to implement ACS P2P Request Redirect, so if a
> Root Port doesn't implement RR, we can assume it doesn't support
> peer-to-peer.  But unfortunately the converse is not true: if a Root
> Port implements RR, that does *not* imply that it supports
> peer-to-peer traffic.  

ACS is a much overlooked part of the spec, afaict we can't assume
anything about a root port that doesn't implement ACS, and most of them
don't.  Thanks,

Alex

> So I don't know how to discover whether peer-to-peer between Root
> Ports or Root Complexes is supported.  Maybe there's some clue in the
> IOMMU?  The Intel VT-d spec mentions it, but "peer" doesn't even
> appear in the AMD spec.
> 
> And I'm curious about why writes sometimes work when reads do not.
> That sounds like maybe the hardware support is there, but we don't
> understand how to configure everything correctly.
> 
> Can you give us the specifics of the topology you'd like to use, e.g.,
> lspci -vv of the path between the two devices?
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



