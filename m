Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47293 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbcEDTrQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 May 2016 15:47:16 -0400
Date: Wed, 4 May 2016 14:47:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST] Extend PCIE_BUS_PEER2PEER to set MRSS=128 to fix
 CNS3xxx BM DMA.
Message-ID: <20160504194711.GB3117@localhost>
References: <m3h9fghbfh.fsf@t19.piap.pl>
 <20160421154234.GB32739@localhost>
 <20160502165322.GC24851@localhost>
 <m3y47qdl6g.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <m3y47qdl6g.fsf@t19.piap.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 04, 2016 at 03:09:27PM +0200, Krzysztof Hałasa wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > It looks like 498a92d42596 merely fixed a warning, at the expense of
> > breaking DMA on Cavium.  Reverting it would bring the warning back, but
> > that's better than broken DMA.
> 
> Perhaps we should change PCIE_BUS_PEER2PEER to also write MRRS anyway.
> 
> I realize the CNS3xxx patch is some sort of clever workaround, and that
> PCIE_BUS_PEER2PEER (which normally comes from kernel command line
> parameter "pcie_bus_peer2peer") was not exactly intended for this. But
> if one asks for "peer2peer" (which means limiting transfers to 128
> bytes), how could it all work if the bus mastering read requests are
> not equally limited?

MPS=128 means a function will never generate a TLP exceeding 128
bytes.  MRRS=128 means a function will never generate a Read Request
with a size exceeding 128 bytes.

The comment in pcie_write_mrrs() claims:

  ... the MRRS ... cannot be configured larger than the MPS the
  device or the bus can support.

I think this comment is wrong, at least from a hardware point of view.
Setting all devices to MRRS=512 and MPS=128 is a legal configuration
that means functions may receive Read Requests for up to 512 bytes,
and they will have to respond with 4 128-byte TLPs.

The spec (PCIe r3.0, 7.8.4 implementation note) says:

  The Max_Read_Request_Size mechanism allows improved control of
  bandwidth allocation in systems where quality of service (QoS) is
  important for the target applications. For example, an arbitration
  scheme based on counting Requests (and not the sizes of those
  Requests) provides imprecise bandwidth allocation when some
  Requesters use much larger sizes than others. The
  Max_Read_Request_Size mechanism can be used to force more uniform
  allocation of bandwidth, by restricting the upper size of Read
  Requests.

The Linux usage of tying it to MRRS to MPS is part of a plan to use
MRRS to restrict the TLP size in one direction and MPS to restrict TLP
size in the other.  See b03e7495a862 ("PCI: Set PCI-E Max Payload Size
on fabric").  But this is not in line with the spec intention, and I'm
not 100% convinced that it works reliably.

So I'm a little wary of tweaking our MPS/MRRS configuration without a
more extensive analysis and (hopefully) some simplification of the
code.

Bjorn
