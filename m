Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:46607 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753540AbaCZLB4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 07:01:56 -0400
In-Reply-To: <5768554.vihmtytclA@wuerfel>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <14997425.EPjrKhVy10@wuerfel> <OF61E4A09E.4D57F668-ON80257CA7.0035A569-80257CA7.00367A70@eu.necel.com> <5768554.vihmtytclA@wuerfel>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OF5271824A.6BF6DD0C-ON80257CA7.003BC04D-80257CA7.003C95A1@eu.necel.com>
Date: Wed, 26 Mar 2014 11:01:46 +0000
Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On: 26/03/2014 10:34, Arnd wrote:
> Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes 
for R8A7790
> 
> On Wednesday 26 March 2014 09:55:04 Phil.Edworthy@renesas.com wrote:
> > Hi Arnd,
> > 
> > On: 25/03/2014 18:42, Arnd wrote:
> > > Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree 
nodes 
> > for R8A7790
> > > 
> > > On Tuesday 25 March 2014 16:56:41 Phil Edworthy wrote:
> > > > +               /* Map all possible DDR as inbound ranges */
> > > > +               dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 
0 
> > 0x80000000
> > > > +                             0x43000000 1 0x80000000 1 0x80000000 
0 
> > 0x80000000>;
> > > 
> > > Typo: 0x43000000 should be 0x42000000 I guess.
> > I used 0x43000000 as this is a 64-bit type. The OF PCI range code 
> > currently treats both 32 and 64-bit types the same way, but I thought 
it 
> > would be good to set this in case we ever need to use it.
> 
> Ah, I forgot about the space identifier. It looks correct then, but
> it seems  a little strange to use a 32-bit identifier in one case
> and a 64-bit one in the other.

If the OF PCI range code allowed the PCIe host driver to determine if it's 
a 32-bit mapping, we could use that and get a small performance 
improvement with PCIe throughput.

> > > Since you control the mapping, I wonder if you could also do this as
> > > 
> > >                dma-ranges = <0x42000000 0 0x00000000 0 0x40000000 0 
> > 0x80000000
> > >                              0x43000000 0 0x80000000 1 0x80000000 0 
> > 0x80000000>;
> > > 
> > > i.e. map all the RAM into PCI bus addresses below the 32-bit 
boundary.
> > > This would be really nice from the perspective that now all PCI
> > > devices could access all of RAM without using an IOMMU or the
> > > relying on 64-bit master capability.
> > > 
> > > The downside of this is that you'd probably need a custom 
dma_map_ops
> > > wrapper.
> > Since the OF PCi range code treats both 32 and 64-bit types the same 
way, 
> > my PCIe driver only creates 64-bit mappings. In addition, the PCIe 
> > controller has to use a 64-bit mapping for anything over 2GiB. Based 
on 
> > this, I think it's sensible to leave the mappings as 1-to-1.
> 
> I'm not following, sorry. What is the hardware requirement in the
> controller?
With this controller, you can only specify maps whose size are a power of 
two, and the size must be less than or equal to the cpu address alignment. 
Further, when the size is 4GiB, you have to use a 64-bit mapping. Thinking 
about it, the 4GiB case is not relevant to our discussion about 32-bit vs 
64-bit mappings.

Still, my comment about the OF PCI range code treating both 32 and 64-bit 
types the same way means that PCIe host driver has to assume it's a 64-bit 
mapping.

Thanks
Phil
