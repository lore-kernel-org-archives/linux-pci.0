Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932521AbbGGR2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 13:28:11 -0400
Message-ID: <1436290089.1391.95.camel@redhat.com>
Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
From: Alex Williamson <alex.williamson@redhat.com>
To: markh@compro.net
Cc: Bjorn Helgaas <bhelgaas@google.com>, wdavis@nvidia.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, tripperda@nvidia.com,
	jhubbard@nvidia.com, jglisse@redhat.com, konrad.wilk@oracle.com,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>
Date: Tue, 07 Jul 2015 11:28:09 -0600
In-Reply-To: <559C08F3.7010103@compro.net>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
	 <1431973504-5903-5-git-send-email-wdavis@nvidia.com>
	 <20150519234300.GA31666@google.com> <555C79E5.9040507@compro.net>
	 <20150707151517.GA14215@google.com> <559C08F3.7010103@compro.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-07-07 at 13:14 -0400, Mark Hounschell wrote:
> Hi Bjorn.
> 
> On 07/07/2015 11:15 AM, Bjorn Helgaas wrote:
> > [+cc Alex]
> >
> > Hi Mark,
> >
> > On Wed, May 20, 2015 at 08:11:17AM -0400, Mark Hounschell wrote:
> >> Most currently available hardware doesn't allow reads but will allow
> >> writes on PCIe peer-to-peer transfers. All current AMD chipsets are
> >> this way. I'm pretty sure all Intel chipsets are this way also. What
> >> happens with reads is they are just dropped with no indication of
> >> error other than the data will not be as expected. Supposedly the
> >> PCIe spec does not even require any peer-to-peer support. Regular
> >> PCI there is no problem and this API could be useful. However I
> >> doubt seriously you will find a pure PCI motherboard that has an
> >> IOMMU.
> >>
> >> I don't understand the chipset manufactures reasoning for disabling
> >> PCIe peer-to-peer reads. We would like to make PCIe versions of our
> >> cards but their application requires  peer-to-peer reads and writes.
> >> So we cannot develop PCIe versions of the cards.
> >
> > I'd like to understand this better.  Peer-to-peer between two devices
> > below the same Root Port should work as long as ACS doesn't prevent
> > it.  If we find an Intel or AMD IOMMU, I think we configure ACS to
> > prevent direct peer-to-peer (see "pci_acs_enable"), but maybe it could
> > still be done with the appropriate IOMMU support.  And if you boot
> > with "iommu=off", we don't do that ACS configuration, so peer-to-peer
> > should work.
> >
> > I suppose the problem is that peer-to-peer doesn't work between
> > devices under different Root Ports or even devices under different
> > Root Complexes?
> >
> > PCIe r3.0, sec 6.12.1.1, says Root Ports that support peer-to-peer
> > traffic are required to implement ACS P2P Request Redirect, so if a
> > Root Port doesn't implement RR, we can assume it doesn't support
> > peer-to-peer.  But unfortunately the converse is not true: if a Root
> > Port implements RR, that does *not* imply that it supports
> > peer-to-peer traffic.
> >
> > So I don't know how to discover whether peer-to-peer between Root
> > Ports or Root Complexes is supported.  Maybe there's some clue in the
> > IOMMU?  The Intel VT-d spec mentions it, but "peer" doesn't even
> > appear in the AMD spec.
> >
> > And I'm curious about why writes sometimes work when reads do not.
> > That sounds like maybe the hardware support is there, but we don't
> > understand how to configure everything correctly.
> >
> > Can you give us the specifics of the topology you'd like to use, e.g.,
> > lspci -vv of the path between the two devices?
> >
> 
> First off, writes always work for me. Not just sometimes. Only reads 
> NEVER do.
> 
> Reading the AMD-990FX-990X-970-Register-Programming-Requirements-48693.pdf
> in section 2.5 "Enabling/Disabling Peer-to-Peer Traffic Access", it 
> states specifically that
> only P2P memory writes are supported. This has been the case with older 
> AMD chipset also. In one of the older chipset documents I read (I think 
> the 770 series) , it said this was a security feature. Makes no sense to 
> me.
> 
> As for the topology I'd like to be able to use. This particular 
> configuration (MB) has a single regular pci slot and the rest are pci-e. 
> In two of those pci-e slots is a pci-e to pci expansion chassis 
> interface card connected to a regular pci expansion rack. I am trying to 
> to peer to peer between a regular pci card in one of those chassis to 
> another regular pci card in the other chassis. In turn through the pci-e 
> subsystem. Attached is the lcpci -vv output from this particular box. 
> The cards that initiate the P2P are these:
> 
> 04:04.0 Intelligent controller [0e80]: PLX Technology, Inc. Device 0480 
> (rev 55)
> 04:05.0 Intelligent controller [0e80]: PLX Technology, Inc. Device 0480 
> (rev 55)
> 04:06.0 Intelligent controller [0e80]: PLX Technology, Inc. Device 0480 
> (rev 55)
> 04:07.0 Intelligent controller [0e80]: PLX Technology, Inc. Device 0480 
> (rev 55)
> 
> The card they need to P2P to and from is this one.
> 
> 0a:05.0 Network controller: VMIC GE-IP PCI5565,PMC5565 Reflective Memory 
> Node (rev 01)
> 
> Like wise, reversing the chassis the initiator lives in from these cards.
> 
> 0b:00.0 Unassigned class [ff00]: Compro Computer Services, Inc. Device 
> 4710 (rev 41)
> 0c:00.0 Unassigned class [ff00]: Compro Computer Services, Inc. Device 
> 4710 (rev 41)
> 0d:00.0 Unassigned class [ff00]: Compro Computer Services, Inc. Device 
> 4710 (rev 41)
> 0e:00.0 Unassigned class [ff00]: Compro Computer Services, Inc. Device 
> 0100 (rev 42)
> 
> to this card
> 
> 04:0a.0 Memory controller: Compro Computer Services, Inc. Device 4360 
> (rev 4d)
> 
> Again, I can go between both pci chassis as long as I am doing writes. 
> Only reads do not work.
> 
> I can send the AMD-990FX-990X-970-Register-Programming-Requirements if 
> you would like. It's available for download on AMD web site. Let me know.


It would be interesting to know if this already works if you assign all
the endpoints to a QEMU/KVM VM with vfio-pci.  We make an attempt to map
the device MMIO BARs through the IOMMU, but as I said, I don't know how
to test it.  Does the register programming guide provide any indication
if there are any restrictions on p2p when bounced through the IOMMU?  So
long as the IOMMU does the translation and redirection, I don't see why
the rest of the topology would handle it differently than a DMA to
memory.  Thanks,

Alex

