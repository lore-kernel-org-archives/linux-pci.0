Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:58141 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234Ab3CKVvX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Mar 2013 17:51:23 -0400
Message-ID: <513E519B.6010503@firmworks.com>
Date: Mon, 11 Mar 2013 11:50:19 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
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
References: <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de> <20130308165228.GB4094@obsidianresearch.com> <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de> <513A3F4F.2090501@firmworks.com> <20130308200245.GC29435@obsidianresearch.com> <513A7845.6040304@firmworks.com> <20130309013152.GA3883@obsidianresearch.com> <513C117D.6080800@firmworks.com> <20130310065539.GA14704@obsidianresearch.com> <513D6F9C.9000100@firmworks.com> <20130311181554.GA10992@obsidianresearch.com>
In-Reply-To: <20130311181554.GA10992@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/11/2013 8:15 AM, Jason Gunthorpe wrote:
> On Sun, Mar 10, 2013 at 07:46:04PM -1000, Mitch Bradley wrote:
> 
>> So it seems that we are faced with two requirements that are somewhat at
>> odds with one another.
>>
>> 1) Some of the root port bridge registers have to be accessed via config
>> space access functions so common PCI enumeration code will work.  To
>> represent this with the usual DT structure, the top root-complex needs
>> to define a 3/2 address space so its children
>> can have standard PCI reg properties.  Presumably, if those registers
>> are being programmed by common code, Marvell-specific code would
>> restrict its role to setting up config-space access functions, leaving
>> the actual touching of the registers to the common code.
>>
>> 2) Marvell chips have additional non-standard per-root-port registers
>> that generic PCI code would not understand.  These registers would be
>> touched only by Marvell-specific code.
>>
>> The two kinds of registers are adjacent in MMIO space.  However, unless
>> I am misunderstanding this MV78230 manual, the highest "config header"
>> register index is 0x134, well below the 0x1000 size limit of a PCIe
>> config header.  Some of the extra registers are at 0x8xx, and others are
>> above 0x1800.
> 
> The register block you are looking at is for the cores 'target end
> port mode', and the MMIO version is for internal use only, to allow
> the CPU to configure RO bits, and other tasks. The target core will
> allow access to that space via config cycles, either internally
> (through the indirection register) or externally (from the off-chip
> root complex) generated.
> 
> However - the driver runs the core in a 'root port bridge mode' where
> the config header register block you are looking at is inhibited. The
> Marvell IP block requires software support to run in bridge mode. So
> Marvell really has only (2), while Tegra has only (1).

Interesting.

For Marvell, if Marvell has only (2), does that imply that standard PCI
discovery and enumeration code cannot find the root port bridges, and
also there is no way to auto-configure the bridges with common pci-pci
bridge code?

> 
>> For requirement (2), the top node has a reg property listing the
>> portions of the address space that are consumed by the driver at the top
>> level instead of being passed through to the PCI addressing domain.  E.g.
>>
>>   reg = <0xd0040800 0x1800>, <0xd0080800 0x1800>;
> 
> Okay, so this is agreeing with what Thomas already has:
> 
> http://www.spinics.net/lists/arm-kernel/msg228749.html
> 
> With your two notes:
>  - Correct the pcie@x,y to match the OF spec
>  - Add a 'device_type = "pci"' to the pcie-controller node
> 
> Is that right?

At this point I am confused again.  There was talk of the need to use
standard PCI enumeration code to deal with the bridges, thus the need
for 3/2 to describe the interface between root-complex and the child
root-port nodes.  But now I think I'm hearing that these particular root
ports bear no resemblance to standard pcie bridges.  So I am back to
"not sure why we are using 3/2 PCI addresses across an interface
boundary that has no relation to PCI addressing".  Sorry if I'm being
obtuse.

For Tegra, I think it all makes sense, and I still like the ranges
representation to control the config-space spoofing.  But for Marvell,
it seems like there is neither the need for nor the possibility of
spoofing, nor for PCI-style addressing at the complex/port boundary.

>  
>> I said that it was bogus to use size=0x2000 for a config space header.
>>  That was based on an interpretation - which I now dislike - of the
>> meaning of 3-cell config addresses.  By that old interpretation,
>> size=0x800 would also be bogus, because bits 10-8 of the config address
>> are for the function number.
> 
> Hum, I thought the spec was pretty clear on this point:
> 
>  00 denotes Configuration Space, in which case:
>   [..]
>      bbbbbbbb,ddddd,fff,rrrrrrrrr is the Configuration Space address
>      hh...hh,ll...ll must be zero
> 
> And also the text at 2.1.4.4..
> 
> So you get an 8 bit register offset, placed in the highest DW..
> 
> Can you read things another way?

The reading is clear, but there is a crucial point that is missing.

I don't recall ever having seen anything but 0 in rrrrrrrr.  PCI reg
properties always list the base address of config header.  There is
never a need for a reg entry to point into the middle of a config
header.  The granularity is always at the dev,function level.  So the
fact that the spec puts the offset in those bits is moot, because the
offset is never used.  (I will address your counterargument below.)

I didn't anticipate that fact when I developed the representation, nor
did I anticipate that the rather-rigidly structured config space would
be extended years later.

With my "new interpretation", you still never actually set any of the
"offset bits".  The only thing you get from it is permission to use
larger size values without creating algebraic nonsense.  You never
actually do arithmetic on that representation.

> 
> Is there an updated spec that supports PCI-E extended config space?

http://www.openfirmware.org/ofwg/bindings/pci/pci-express.txt

It puts the extended config address bits in 27:24 of the high word - but
that said, I doubt that those bits have ever been set to nonzero.  Again
because you never need to point to an individual register using this
representation.  I will call David Kahn, who lives down the street from
me, later today and see what he thinks.


> 
>> Consider the following question, which I have never previously
>> considered, at least not explicitly:
>>
>> Q: What would be the 3-cell representation of the Command/Status
>> register address (offset 4) in device 1, function 1?
> 
> Well, see section 11.1.2, where it provides an example
> for the 'Expansion ROM base address register (0x30)' as being:
> 
>    02xxxx30 00000000 00000000 
> 
> Also the f-code bindings say:
> 
>  The data type 'config-addr' refers to the 'phys.hi' cell of the
>  numerical representation of a Configuration Space address.
> 
> So there is an strong convention to use the 'r' bits as the
> offset..

You're right, the spec does indeed say that.  But in practice, it never
actually happened that way.  Expansion ROMs, in practice, had to be
copied into memory because the tended to disappear under certain
settings of various enable bits.  And even that copying had to be done
very carefully, because expansion ROM access had an annoying tendency to
hang some bus interfaces.

So, yeah, the spec implies the convention, but I don't think it was ever
used.

> 
> Further, review section 12 about how ranges should be treated - it
> specifically says that the b,d,f bits in ranges should be 0, and the
> child address should have those bits masked prior to searching the
> ranges.
> 
> Section 12 would seem to forbid this:
> 
>       ranges = <0x00000800 0 0          0xd4004000 0 0x00000800   /* Root port config header */
>                 0x00001000 0 0          0xd4008000 0 0x00000800   /* Root port config header */
> 
> Are you reading that differently?

I wasn't reading it at all, until you pointed it out to me :-)  I was
just reasoning based on my mental model.

Again, I agree with your reading of the spec, but I can't think of any
reason why relaxing that restriction to permit config space mappings
would be a problem.

> 
>>> Two things bothered me
>>>   - Describing a CPU MMIO mapping with a config address space seems
>>>     wonky
>>
>> I agree that mapping config space is sort of a jarring concept, but I
>> think that's because PCs have polluted the mindspace, not because
>> there
> 
> I'm well aware of MMIO config space acces, that isn't so jarring. What
> is so jarring is the idea that the OF translation would work like:
> 
> <0x00000900 0 0> -> 0xd4004000
> <0x00000901 0 0> -> 0xd4004001
> 
> Which is completely unlike any ranges translation I've ever seen.

You never actually say <0x901 0 0> in the DT.  What you say "there is a
config header based at <0x900 0 0>".  The offset is maintained
separately, not added directly to the DT representation of the config
header base address.

The most useful interpretation of a ranges entry is that the tuples
(child_base,offset) and (parent_base,offset) correspond for 0 <= offset
< size.  In some cases, you might be able to use arithmetic to merge
base and offset; in other cases you can't.

> 
> Basically, I look at how the register offset is encoded in the higest
> dword plus the statement in section 12, and and conclude the there
> wasn't an intention to model a memory map'd config space through OF.
> 
> What am I missing here?

The real point of section 12 is that you have to attend to the fact that
PCI a structured address space, not just a single linear space.

As you say, the text does not convey the intention of mapping config
space, but I can say categorically that I certainly did not intent "thou
shalt not map config space".


> 
> Regards,
> Jason
> 
