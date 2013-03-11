Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:56831 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab3CKSQI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Mar 2013 14:16:08 -0400
Date: Mon, 11 Mar 2013 12:15:54 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130311181554.GA10992@obsidianresearch.com>
References: <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <513A7845.6040304@firmworks.com>
 <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513D6F9C.9000100@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 10, 2013 at 07:46:04PM -1000, Mitch Bradley wrote:

> So it seems that we are faced with two requirements that are somewhat at
> odds with one another.
> 
> 1) Some of the root port bridge registers have to be accessed via config
> space access functions so common PCI enumeration code will work.  To
> represent this with the usual DT structure, the top root-complex needs
> to define a 3/2 address space so its children
> can have standard PCI reg properties.  Presumably, if those registers
> are being programmed by common code, Marvell-specific code would
> restrict its role to setting up config-space access functions, leaving
> the actual touching of the registers to the common code.
> 
> 2) Marvell chips have additional non-standard per-root-port registers
> that generic PCI code would not understand.  These registers would be
> touched only by Marvell-specific code.
> 
> The two kinds of registers are adjacent in MMIO space.  However, unless
> I am misunderstanding this MV78230 manual, the highest "config header"
> register index is 0x134, well below the 0x1000 size limit of a PCIe
> config header.  Some of the extra registers are at 0x8xx, and others are
> above 0x1800.

The register block you are looking at is for the cores 'target end
port mode', and the MMIO version is for internal use only, to allow
the CPU to configure RO bits, and other tasks. The target core will
allow access to that space via config cycles, either internally
(through the indirection register) or externally (from the off-chip
root complex) generated.

However - the driver runs the core in a 'root port bridge mode' where
the config header register block you are looking at is inhibited. The
Marvell IP block requires software support to run in bridge mode. So
Marvell really has only (2), while Tegra has only (1).

> For requirement (2), the top node has a reg property listing the
> portions of the address space that are consumed by the driver at the top
> level instead of being passed through to the PCI addressing domain.  E.g.
> 
>   reg = <0xd0040800 0x1800>, <0xd0080800 0x1800>;

Okay, so this is agreeing with what Thomas already has:

http://www.spinics.net/lists/arm-kernel/msg228749.html

With your two notes:
 - Correct the pcie@x,y to match the OF spec
 - Add a 'device_type = "pci"' to the pcie-controller node

Is that right?
 
> I said that it was bogus to use size=0x2000 for a config space header.
>  That was based on an interpretation - which I now dislike - of the
> meaning of 3-cell config addresses.  By that old interpretation,
> size=0x800 would also be bogus, because bits 10-8 of the config address
> are for the function number.

Hum, I thought the spec was pretty clear on this point:

 00 denotes Configuration Space, in which case:
  [..]
     bbbbbbbb,ddddd,fff,rrrrrrrrr is the Configuration Space address
     hh...hh,ll...ll must be zero

And also the text at 2.1.4.4..

So you get an 8 bit register offset, placed in the highest DW..

Can you read things another way?

Is there an updated spec that supports PCI-E extended config space?

> Consider the following question, which I have never previously
> considered, at least not explicitly:
>
> Q: What would be the 3-cell representation of the Command/Status
> register address (offset 4) in device 1, function 1?

Well, see section 11.1.2, where it provides an example
for the 'Expansion ROM base address register (0x30)' as being:

   02xxxx30 00000000 00000000 

Also the f-code bindings say:

 The data type 'config-addr' refers to the 'phys.hi' cell of the
 numerical representation of a Configuration Space address.

So there is an strong convention to use the 'r' bits as the
offset..

Further, review section 12 about how ranges should be treated - it
specifically says that the b,d,f bits in ranges should be 0, and the
child address should have those bits masked prior to searching the
ranges.

Section 12 would seem to forbid this:

      ranges = <0x00000800 0 0          0xd4004000 0 0x00000800   /* Root port config header */
                0x00001000 0 0          0xd4008000 0 0x00000800   /* Root port config header */

Are you reading that differently?

> > Two things bothered me
> >   - Describing a CPU MMIO mapping with a config address space seems
> >     wonky
> 
> I agree that mapping config space is sort of a jarring concept, but I
> think that's because PCs have polluted the mindspace, not because
> there

I'm well aware of MMIO config space acces, that isn't so jarring. What
is so jarring is the idea that the OF translation would work like:

<0x00000900 0 0> -> 0xd4004000
<0x00000901 0 0> -> 0xd4004001

Which is completely unlike any ranges translation I've ever seen.

Basically, I look at how the register offset is encoded in the higest
dword plus the statement in section 12, and and conclude the there
wasn't an intention to model a memory map'd config space through OF.

What am I missing here?

Regards,
Jason
