Return-Path: <SRS0=dvAb=KQ=bootlin.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=dvAb=KQ=bootlin.com=thomas.petazzoni@kernel.org>
Date: Wed, 1 Aug 2018 11:37:41 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement
 <gregory.clement@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Victor
 Gu <xigu@marvell.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Zachary Zhang <zhangzg@marvell.com>, Wilson
 Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Ray Jui
 <ray.jui@broadcom.com>, Ley Foon Tan <lftan@altera.com>, Simon Horman
 <horms@verge.net.au>
Subject: Re: [PATCH 1/3] PCI: Introduce PCI software bridge common logic
Message-ID: <20180801113741.06fceba9@windsurf>
In-Reply-To: <20180801092119.GB30658@n2100.armlinux.org.uk>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
	<20180629092231.32207-2-thomas.petazzoni@bootlin.com>
	<20180712195802.GC28466@bhelgaas-glaptop.roam.corp.google.com>
	<20180801104957.1b01b847@windsurf>
	<20180801092119.GB30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello Russell,

Thanks for your feedback.

On Wed, 1 Aug 2018 10:21:19 +0100, Russell King - ARM Linux wrote:

> >  (2) Agreeing on whether a RAM-like behavior is acceptable, and if not,
> >      which solution do you propose instead.  
> 
> Please take the time to read the PCI(e) specifications and implement
> what it recommends, rather than doing something else.  That's what I
> did when I originally reworked the mvebu PCIe driver for Armada 388,
> and it's the only sensible approach to have something that works with
> the rest of the Linux PCI(e) layer.

Actually, all what I'm doing is generalizing what the mvebu PCIe driver
is doing (which you significantly contributed) to, and try to make it
usable by other drivers that have the same need.

So, I'm precisely trying to make sure we implement this stuff once,
correctly, rather than duplicate it in several drivers. I'm not
pretending that my first iteration is entirely correct, and your review
of it to make it better is much appreciated.

> Going off and implementing a non-standard behaviour is a recipe for
> things breaking as the PCIe kernel support evolves.

Sure.

> The spec requires reserved registers to read back as zero and ignore
> writes, whereas implemented registers have a mixture of behaviours:
> 
> - read/write
> - read, write to clear
> - read-only
> 
> Here's the extract(s):
> 
>    All PCI devices must treat Configuration Space write operations
>    to reserved registers as no-ops; that is, the access must be
>    completed normally on the bus and the data discarded. Read
>    accesses to reserved or unimplemented registers must be completed
>    normally and a data value of 0 returned.
> 
> (eg) PCI status:
>    Reserved bits should be read-only and return zero when read.
>    A one bit is reset (if it is not read-only) whenever the register
>    is written, and the write data in the corresponding bit location
>    is a 1.

Right. This pci-sw-bridge layer should implement this behavior.

> [which is why doing the read-modify-write action that some host
>  bridges that only support 32-bit accesses is dangerous - it leads
>  to various status bits being inadvertently reset.]
> 
> Getting this right in a software emulation of the register space for
> each bit in every register makes for a happy Linux PCIe layer.

Absolutely.

> Now, configuration read/writes use naturally aligned addresses.  The
> PCI specification defines the PC IO 0xcf8/0xcfc configuration access
> mechanism.  The first register defines the address with a 6 bit
> "double-word" address to cover the 256 bytes of standard config space.
> Accesses to 0xcfc are forwarded to the PCI bus as a single
> configuration request - and that means there is nothing to deal with
> an attempt to access a mis-aligned word.
> 
> Indeed, if 0xcfe was to be accessed as a double word, this would
> result in the processor reading the two bytes from IO address 0xcfe,
> 0xcff, as well as 0xd00 and 0xd01 which are not part of the
> configuration data register - resulting in undefined data being read.
> 
> So, basically, misaligned configuration accesses are not supported.

OK. So the where & 2 that the RCAR driver is doing for 2 bytes accesses
is OK, because bit 0 of where will always be 0 for a 2 bytes access.

Thanks,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
