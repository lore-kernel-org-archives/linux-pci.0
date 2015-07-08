Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36695 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292AbbGHPLj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2015 11:11:39 -0400
Received: by igrv9 with SMTP id v9so202159027igr.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2015 08:11:38 -0700 (PDT)
Date: Wed, 8 Jul 2015 10:11:32 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mark Hounschell <markh@compro.net>
Cc: wdavis@nvidia.com, joro@8bytes.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	tripperda@nvidia.com, jhubbard@nvidia.com, jglisse@redhat.com,
	konrad.wilk@oracle.com, Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
Message-ID: <20150708151132.GB14784@google.com>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
 <1431973504-5903-5-git-send-email-wdavis@nvidia.com>
 <20150519234300.GA31666@google.com>
 <555C79E5.9040507@compro.net>
 <20150707151517.GA14215@google.com>
 <559C08F3.7010103@compro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <559C08F3.7010103@compro.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael]

On Tue, Jul 07, 2015 at 01:14:27PM -0400, Mark Hounschell wrote:
> On 07/07/2015 11:15 AM, Bjorn Helgaas wrote:
> >On Wed, May 20, 2015 at 08:11:17AM -0400, Mark Hounschell wrote:
> >>Most currently available hardware doesn't allow reads but will allow
> >>writes on PCIe peer-to-peer transfers. All current AMD chipsets are
> >>this way. I'm pretty sure all Intel chipsets are this way also. What
> >>happens with reads is they are just dropped with no indication of
> >>error other than the data will not be as expected. Supposedly the
> >>PCIe spec does not even require any peer-to-peer support. Regular
> >>PCI there is no problem and this API could be useful. However I
> >>doubt seriously you will find a pure PCI motherboard that has an
> >>IOMMU.
> >>
> >>I don't understand the chipset manufactures reasoning for disabling
> >>PCIe peer-to-peer reads. We would like to make PCIe versions of our
> >>cards but their application requires  peer-to-peer reads and writes.
> >>So we cannot develop PCIe versions of the cards.
> >
> >I'd like to understand this better.  Peer-to-peer between two devices
> >below the same Root Port should work as long as ACS doesn't prevent
> >it.  If we find an Intel or AMD IOMMU, I think we configure ACS to
> >prevent direct peer-to-peer (see "pci_acs_enable"), but maybe it could
> >still be done with the appropriate IOMMU support.  And if you boot
> >with "iommu=off", we don't do that ACS configuration, so peer-to-peer
> >should work.
> >
> >I suppose the problem is that peer-to-peer doesn't work between
> >devices under different Root Ports or even devices under different
> >Root Complexes?
> >
> >PCIe r3.0, sec 6.12.1.1, says Root Ports that support peer-to-peer
> >traffic are required to implement ACS P2P Request Redirect, so if a
> >Root Port doesn't implement RR, we can assume it doesn't support
> >peer-to-peer.  But unfortunately the converse is not true: if a Root
> >Port implements RR, that does *not* imply that it supports
> >peer-to-peer traffic.
> >
> >So I don't know how to discover whether peer-to-peer between Root
> >Ports or Root Complexes is supported.  Maybe there's some clue in the
> >IOMMU?  The Intel VT-d spec mentions it, but "peer" doesn't even
> >appear in the AMD spec.
> >
> >And I'm curious about why writes sometimes work when reads do not.
> >That sounds like maybe the hardware support is there, but we don't
> >understand how to configure everything correctly.
> >
> >Can you give us the specifics of the topology you'd like to use, e.g.,
> >lspci -vv of the path between the two devices?
> 
> First off, writes always work for me. Not just sometimes. Only reads
> NEVER do.
> 
> Reading the AMD-990FX-990X-970-Register-Programming-Requirements-48693.pdf
> in section 2.5 "Enabling/Disabling Peer-to-Peer Traffic Access", it
> states specifically that
> only P2P memory writes are supported. This has been the case with
> older AMD chipset also. In one of the older chipset documents I read
> (I think the 770 series) , it said this was a security feature.
> Makes no sense to me.
> 
> As for the topology I'd like to be able to use. This particular
> configuration (MB) has a single regular pci slot and the rest are
> pci-e. In two of those pci-e slots is a pci-e to pci expansion
> chassis interface card connected to a regular pci expansion rack. I
> am trying to to peer to peer between a regular pci card in one of
> those chassis to another regular pci card in the other chassis. In
> turn through the pci-e subsystem. Attached is the lcpci -vv output
> from this particular box. The cards that initiate the P2P are these:
> 
> 04:04.0 Intelligent controller [0e80]: PLX Technology, Inc. Device
> 0480 (rev 55)
> 04:05.0 Intelligent controller [0e80]: PLX Technology, Inc. Device
> 0480 (rev 55)
> 04:06.0 Intelligent controller [0e80]: PLX Technology, Inc. Device
> 0480 (rev 55)
> 04:07.0 Intelligent controller [0e80]: PLX Technology, Inc. Device
> 0480 (rev 55)
> 
> The card they need to P2P to and from is this one.
> 
> 0a:05.0 Network controller: VMIC GE-IP PCI5565,PMC5565 Reflective
> Memory Node (rev 01)

Peer-to-peer traffic initiated by 04:04.0 and targeted at 0a:05.0 has
to be routed up to Root Port 00:04.0, over to Root Port 00:0b.0, and
back down to 0a:05.0:

  00:04.0: Root Port to [bus 02-05] Slot #4 ACS ReqRedir+
  02:00.0: PCIe-to-PCI bridge to [bus 03-05]
  03:04.0: PCI-to-PCI bridge to [bus 04-05]
  04:04.0: PLX intelligent controller

  00:0b.0: Root Port to [bus 08-0e] Slot #11 ACS ReqRedir+
  00:0b.0:   bridge window [mem 0xd0000000-0xd84fffff]
  08:00.0: PCIe-to-PCI bridge to [bus 09-0e]
  08:00.0:   bridge window [mem 0xd0000000-0xd84fffff]
  09:04.0: PCI-to-PCI bridge to [bus 0a-0e]
  09:04.0:   bridge window [mem 0xd0000000-0xd84fffff]
  0a:05.0: VMIC GE-IP reflective memory node
  0a:05.0: BAR 3 [mem 0xd0000000-0xd7ffffff]

Both Root Ports do support ACS, including P2P RR, but that doesn't
tell us anything about whether the Root Complex actually supports
peer-to-peer traffic between the Root Ports.  Per the AMD
990FX/990X/970 spec, your hardware supports it for writes but not
reads.

So your hardware is what it is, and a general-purpose interface should 
probably not allow peer-to-peer at all unless we wanted to complicate
it by adding a read vs. write distinction.

My question is how we can figure that out without having to add a
blacklist or whitelist of specific platforms.  We haven't found
anything in the PCIe specs that tells us whether peer-to-peer is
supported between Root Ports.

The ACPI _DMA method does mention peer-to-peer, and I don't think
Linux looks at _DMA at all.  But you should have a single PNP0A08
bridge that leads to bus 0000:00, with a _CRS that includes the
windows of all the Root Ports, and I don't see how a _DMA method would
help carve that up into separate bus address regions.

Rafael, do you have any idea how we can discover peer-to-peer
capabilities of a platform?

Bjorn
