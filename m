Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:49392 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaCZKeb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 06:34:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Phil.Edworthy@renesas.com, Simon Horman <horms@verge.net.au>,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Date: Wed, 26 Mar 2014 11:34:18 +0100
Message-ID: <5768554.vihmtytclA@wuerfel>
In-Reply-To: <OF61E4A09E.4D57F668-ON80257CA7.0035A569-80257CA7.00367A70@eu.necel.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <14997425.EPjrKhVy10@wuerfel> <OF61E4A09E.4D57F668-ON80257CA7.0035A569-80257CA7.00367A70@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 26 March 2014 09:55:04 Phil.Edworthy@renesas.com wrote:
> Hi Arnd,
> 
> On: 25/03/2014 18:42, Arnd wrote:
> > Subject: Re: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes 
> for R8A7790
> > 
> > On Tuesday 25 March 2014 16:56:41 Phil Edworthy wrote:
> > > +               /* Map all possible DDR as inbound ranges */
> > > +               dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 
> 0x80000000
> > > +                             0x43000000 1 0x80000000 1 0x80000000 0 
> 0x80000000>;
> > 
> > Typo: 0x43000000 should be 0x42000000 I guess.
> I used 0x43000000 as this is a 64-bit type. The OF PCI range code 
> currently treats both 32 and 64-bit types the same way, but I thought it 
> would be good to set this in case we ever need to use it.

Ah, I forgot about the space identifier. It looks correct then, but
it seems  a little strange to use a 32-bit identifier in one case
and a 64-bit one in the other.

> > Since you control the mapping, I wonder if you could also do this as
> > 
> >                dma-ranges = <0x42000000 0 0x00000000 0 0x40000000 0 
> 0x80000000
> >                              0x43000000 0 0x80000000 1 0x80000000 0 
> 0x80000000>;
> > 
> > i.e. map all the RAM into PCI bus addresses below the 32-bit boundary.
> > This would be really nice from the perspective that now all PCI
> > devices could access all of RAM without using an IOMMU or the
> > relying on 64-bit master capability.
> > 
> > The downside of this is that you'd probably need a custom dma_map_ops
> > wrapper.
> Since the OF PCi range code treats both 32 and 64-bit types the same way, 
> my PCIe driver only creates 64-bit mappings. In addition, the PCIe 
> controller has to use a 64-bit mapping for anything over 2GiB. Based on 
> this, I think it's sensible to leave the mappings as 1-to-1.

I'm not following, sorry. What is the hardware requirement in the
controller?

	Arnd
