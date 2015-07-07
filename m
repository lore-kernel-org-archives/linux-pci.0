Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757692AbbGGQlf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 12:41:35 -0400
Message-ID: <1436287293.1391.74.camel@redhat.com>
Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mark Hounschell <markh@compro.net>,
	William Davis <wdavis@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>
Date: Tue, 07 Jul 2015 10:41:33 -0600
In-Reply-To: <CAErSpo74X7ny_30L2uDWJ==vQJKq3KgFk8CPVsKuJ7=-DwNo3w@mail.gmail.com>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
	 <1431973504-5903-5-git-send-email-wdavis@nvidia.com>
	 <20150519234300.GA31666@google.com> <555C79E5.9040507@compro.net>
	 <20150707151517.GA14215@google.com> <1436283678.1391.50.camel@redhat.com>
	 <CAErSpo74X7ny_30L2uDWJ==vQJKq3KgFk8CPVsKuJ7=-DwNo3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-07-07 at 11:16 -0500, Bjorn Helgaas wrote:
> On Tue, Jul 7, 2015 at 10:41 AM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Tue, 2015-07-07 at 10:15 -0500, Bjorn Helgaas wrote:
> >> [+cc Alex]
> >>
> >> Hi Mark,
> >>
> >> On Wed, May 20, 2015 at 08:11:17AM -0400, Mark Hounschell wrote:
> >> > Most currently available hardware doesn't allow reads but will allow
> >> > writes on PCIe peer-to-peer transfers. All current AMD chipsets are
> >> > this way. I'm pretty sure all Intel chipsets are this way also. What
> >> > happens with reads is they are just dropped with no indication of
> >> > error other than the data will not be as expected. Supposedly the
> >> > PCIe spec does not even require any peer-to-peer support. Regular
> >> > PCI there is no problem and this API could be useful. However I
> >> > doubt seriously you will find a pure PCI motherboard that has an
> >> > IOMMU.
> >> >
> >> > I don't understand the chipset manufactures reasoning for disabling
> >> > PCIe peer-to-peer reads. We would like to make PCIe versions of our
> >> > cards but their application requires  peer-to-peer reads and writes.
> >> > So we cannot develop PCIe versions of the cards.
> >>
> >> I'd like to understand this better.  Peer-to-peer between two devices
> >> below the same Root Port should work as long as ACS doesn't prevent
> >> it.  If we find an Intel or AMD IOMMU, I think we configure ACS to
> >> prevent direct peer-to-peer (see "pci_acs_enable"), but maybe it could
> >> still be done with the appropriate IOMMU support.  And if you boot
> >> with "iommu=off", we don't do that ACS configuration, so peer-to-peer
> >> should work.
> >
> > The assumption I work from in vfio is that peer-to-peer should be able
> > to take a path through the IOMMU, that is from one endpoint, up through
> > to the RC (with ACS enabled), be translated by the IOMMU and directed
> > back downstream to the specified endpoint.  Whether that actually works
> > for any/all transactions, I can't say, I don't know how to test it.
> > It'd be interesting to know if this is a false assumption.
> 
> That's what I assume as well.
> 
> >> I suppose the problem is that peer-to-peer doesn't work between
> >> devices under different Root Ports or even devices under different
> >> Root Complexes?
> >>
> >> PCIe r3.0, sec 6.12.1.1, says Root Ports that support peer-to-peer
> >> traffic are required to implement ACS P2P Request Redirect, so if a
> >> Root Port doesn't implement RR, we can assume it doesn't support
> >> peer-to-peer.  But unfortunately the converse is not true: if a Root
> >> Port implements RR, that does *not* imply that it supports
> >> peer-to-peer traffic.
> >
> > ACS is a much overlooked part of the spec, afaict we can't assume
> > anything about a root port that doesn't implement ACS, and most of them
> > don't.
> 
> I think we can assume a Root Port that does not implement ACS P2P
> Request Redirect does not support peer-to-peer traffic with other Root
> Ports, right?  That's how I read sec 6.12.1.1.

I think that means that *if* the device supports ACS and does not
implement RR then it does not support peer-to-peer.  The assumption we
make in IOMMU grouping is that if ACS is not supported at all, then the
hardware is providing us with no indication for or against peer-to-peer
and we therefore assume peer-to-peer is possible, but that's for
isolation, not actually trying to make use of p2p.  It seems overly
optimistic to assume the designers of a device that does not implement
ACS evaluated the capability and determined it not to be necessary.
Besides, ACS was only introduced in PCIe rev 2.

> If we're trying to set up a peer-to-peer path between devices under
> different Root ports, I think it would make sense to check the ACS
> support somewhere in the pci_map_resource() path and fail if P2P RR is
> not implemented.

There are multiple options here:

1) No ACS
2) ACS, no RR
3) ACS, RR enabled
4) ACS, RR disabled

In case 1), we have no idea.  Cases 2) and 3) are really the same,
neither does peer-to-peer and I think whether we can support any sort of
peer-to-peer mapping depends on whether there's an IOMMU upstream that
can do the redirect.  For case 4), possibly we can assume the redirect
happens at the root port, but you'll never see this case if an IOMMU is
present and enabled.  Thanks,

Alex

