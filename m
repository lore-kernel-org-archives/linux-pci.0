Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:59653 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbaCZLPJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 07:15:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Phil.Edworthy@renesas.com
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Date: Wed, 26 Mar 2014 12:14:24 +0100
Message-ID: <5228683.eofaEcInBi@wuerfel>
In-Reply-To: <OF5271824A.6BF6DD0C-ON80257CA7.003BC04D-80257CA7.003C95A1@eu.necel.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <5768554.vihmtytclA@wuerfel> <OF5271824A.6BF6DD0C-ON80257CA7.003BC04D-80257CA7.003C95A1@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 26 March 2014 11:01:46 Phil.Edworthy@renesas.com wrote:
> On: 26/03/2014 10:34, Arnd wrote:
> > Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes 
> for R8A7790
> > 
> > On Wednesday 26 March 2014 09:55:04 Phil.Edworthy@renesas.com wrote:
> > > Hi Arnd,
> > > 
> > > On: 25/03/2014 18:42, Arnd wrote:
> > > > Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree 
> nodes 
> > > for R8A7790
> > > > 
> > > > On Tuesday 25 March 2014 16:56:41 Phil Edworthy wrote:
> > > > > +               /* Map all possible DDR as inbound ranges */
> > > > > +               dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 
> 0 
> > > 0x80000000
> > > > > +                             0x43000000 1 0x80000000 1 0x80000000 
> 0 
> > > 0x80000000>;
> > > > 
> > > > Typo: 0x43000000 should be 0x42000000 I guess.
> > > I used 0x43000000 as this is a 64-bit type. The OF PCI range code 
> > > currently treats both 32 and 64-bit types the same way, but I thought 
> it 
> > > would be good to set this in case we ever need to use it.
> > 
> > Ah, I forgot about the space identifier. It looks correct then, but
> > it seems  a little strange to use a 32-bit identifier in one case
> > and a 64-bit one in the other.
> 
> If the OF PCI range code allowed the PCIe host driver to determine if it's 
> a 32-bit mapping, we could use that and get a small performance 
> improvement with PCIe throughput.

I don't think it's supposed to care. Soem of the upper bits of the ranges
only really make sense of PCI device registers, not for the top-level
ranges property. The driver can however still look at the address itself
to get that information.

> > > Since the OF PCi range code treats both 32 and 64-bit types the same 
> way, 
> > > my PCIe driver only creates 64-bit mappings. In addition, the PCIe 
> > > controller has to use a 64-bit mapping for anything over 2GiB. Based 
> on 
> > > this, I think it's sensible to leave the mappings as 1-to-1.
> > 
> > I'm not following, sorry. What is the hardware requirement in the
> > controller?
> With this controller, you can only specify maps whose size are a power of 
> two, and the size must be less than or equal to the cpu address alignment. 
> Further, when the size is 4GiB, you have to use a 64-bit mapping. Thinking 
> about it, the 4GiB case is not relevant to our discussion about 32-bit vs 
> 64-bit mappings.

But the ranges you specified in the property don't actually fit in those
constraints: you have a range with size 0x8000000 and start 0x40000000,
which you say can't be programmed into the hardware.

> Still, my comment about the OF PCI range code treating both 32 and 64-bit 
> types the same way means that PCIe host driver has to assume it's a 64-bit 
> mapping.

I was thinking more of PCI devices than the host itself. If the host
driver can verify that all mappings are in the first 4GB and cover all of
RAM, we won't have to use an swiotlb for devices that don't support 64-bit
DMA, which is a very significant performance difference.

	Arnd
