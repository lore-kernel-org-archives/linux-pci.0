Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:58928 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab3CKFrO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Mar 2013 01:47:14 -0400
Message-ID: <513D6F9C.9000100@firmworks.com>
Date: Sun, 10 Mar 2013 19:46:04 -1000
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
References: <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de> <51392B4D.9040404@gmail.com> <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de> <20130308165228.GB4094@obsidianresearch.com> <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de> <513A3F4F.2090501@firmworks.com> <20130308200245.GC29435@obsidianresearch.com> <513A7845.6040304@firmworks.com> <20130309013152.GA3883@obsidianresearch.com> <513C117D.6080800@firmworks.com> <20130310065539.GA14704@obsidianresearch.com>
In-Reply-To: <20130310065539.GA14704@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/9/2013 8:55 PM, Jason Gunthorpe wrote:
> On Sat, Mar 09, 2013 at 06:52:13PM -1000, Mitch Bradley wrote:
> 
>> Okay, I think I finally get it.  The Marvell root port bridge setup
>> registers look like standard config headers, even though they aren't
>> really in config space (because you need a different access method for
>> them, compared to real config accesses to downstream devices).
> 
> Well, thats pretty close. On Marvell the MMIO space has a lot of
> stuff, some of it is config related, lots of it isn't. In fact most of
> it isn't. Tegra is different, the MMIO region is exactly the config
> space of the root port bridge.
> 
> Tegra could probably happily and sanely do as you've described (well,
> see below), but it is wonky for Marvell. It looks like there are more
> drivers coming that have this need - so I had hoped for a general
> answer to the 'per-port MMIO space' problem that is unrelated to the
> MMIO spaces role in config access.
> 
>> So, in order for the common code that enumerates the PCI bus to work,
>> you need to "spoof" the config accesses so that when you try to access
>> those particular "pseudo config headers", it uses the MMIO method
>> instead of the real config access method.
> 
> There are rules for config access in both Tegra and Marvell that are
> not trivial. Again, the driver takes are of this and all Linux sees is
> a nice compliant config space.

Thanks for explaining that.

So it seems that we are faced with two requirements that are somewhat at
odds with one another.

1) Some of the root port bridge registers have to be accessed via config
space access functions so common PCI enumeration code will work.  To
represent this with the usual DT structure, the top root-complex needs
to define a 3/2 address space so its children
can have standard PCI reg properties.  Presumably, if those registers
are being programmed by common code, Marvell-specific code would
restrict its role to setting up config-space access functions, leaving
the actual touching of the registers to the common code.

2) Marvell chips have additional non-standard per-root-port registers
that generic PCI code would not understand.  These registers would be
touched only by Marvell-specific code.

The two kinds of registers are adjacent in MMIO space.  However, unless
I am misunderstanding this MV78230 manual, the highest "config header"
register index is 0x134, well below the 0x1000 size limit of a PCIe
config header.  Some of the extra registers are at 0x8xx, and others are
above 0x1800.

That suggests the following:

For the "config header" registers that use generic PCI code, use a
ranges entry to associate (pass through) MMIO addresses to the config
header portion of the register block.  This parameterizes the code that
sets up the special-case PCI config access.  That specification
technique is general and could be used not only for the Marvell case,
but also for any other chip that has some number of direct-mapped config
headers.

For requirement (2), the top node has a reg property listing the
portions of the address space that are consumed by the driver at the top
level instead of being passed through to the PCI addressing domain.  E.g.

  reg = <0xd0040800 0x1800>, <0xd0080800 0x1800>;

Thus we have accurately described the two aspects of the true situation.
 The PCI-compliant "config header" registers are passed through to the
child nodes where they can be dealt with in the normal PCI fashion.  The
non-PCI-compliant register footprint lives within the Marvell-specific
root-complex driver.

The root-complex driver presumably needs associate non-compliant
register blocks with specific child nodes.  That can be done by
requiring that the reg entries are in the same order as the config-space
ranges entries.

Anticipating the possible objection that ARM's 0x1000-byte page size
does not permit virtual-to-physical mapping at 0x800-byte granularity:
The device tree does not guarantee that reg entries are page-aligned; it
simply tries to describe the reality, even though it might be messy.

> 
>> If that is indeed the case, them I would vote for a slight modification
>> of the intermediate patch that I cited earlier - the one in which the
>> ranges property includes translations from those special config
>> addresses into CPU addresses.  The modification is to fix the sizes,
>> changing 0x2000 to 0x800, so those ranges entries do not overlap in the
>> child address domain.

BTW I have completely changed my mind about the overlap thing.

I said that it was bogus to use size=0x2000 for a config space header.
 That was based on an interpretation - which I now dislike - of the
meaning of 3-cell config addresses.  By that old interpretation,
size=0x800 would also be bogus, because bits 10-8 of the config address
are for the function number.

Consider the following question, which I have never previously
considered, at least not explicitly:

Q: What would be the 3-cell representation of the Command/Status
register address (offset 4) in device 1, function 1?

One obvious - but weak - answer is  <0x00000904 0 0> .  It's obvious
because the value 0x80000904 is what you put in the cf8 indirect access
address register.  But it is weak because it unnecessarily restricts the
config header size, and because it works differently than offsets
applied to memory and I/O space addresses.  Furthermore, coupling the
offset to the cf8 register is dodgy because of the funniness where you
have to but the byte-selector bits 1..0 not in the address register cf8,
but rather in the data register cfc.

The better answer is  <0x00000900 0 4>, using the third cell for the
offset, as with IO and memory space offsets.

Under this better interpretation, config space sizes larger than 0x100
are no problem.  The first cell is just a selector.  The size is "added"
to the third cell, so it does not encroach into the first cell's
device,function bits.

This better interpretation easily handles PCIe's 0x1000-byte extended
config headers, and trivially accomodates even larger sizes should a
future PCI variant further increase the header size. as described way
down below.

> 
> On Marvell the size of the MMIO space is 0x2000, there are imporant
> registers there beyond index 0x800 (todays driver may not touch them
> but HW has them). Reducing the size doesn't seem appropriate.

Per the above, the current idea is not to reduce the size, but rather to
split the 0x2000 into two pieces, accurately reflecting the fact that
part of it is PCI-compliant and can be handled by generic PCI drivers,
while the rest must be handled differently, outside of standard PCI
land.  Commingling the two seems dubious.

> 
>> pcie-controller {
>> 	compatible = "marvell,armada-370-pcie";
>> 	status = "disabled";
> 
>         device_type = "pci";                                                                    
> 
> Here as well, as you noted before?
> 
>> 	#address-cells = <3>;
>> 	#size-cells = <2>;
>>
>> 	bus-range = <0x00 0xff>;
>>
>> 	ranges = <0x00000800 0 0          0xd4004000 0 0x00000800   /* Root
>> port config header */
>> 	          0x00001000 0 0          0xd4008000 0 0x00000800   /* Root
>> port config header */
>> 		  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /*
>> non-prefetchable memory */
>> 	          0x81000000 0 0          0xe8000000 0 0x00100000>; /*
>> downstream I/O */
>>
>> 	pcie@1,0 {
>> 		device_type = "pci";
>> 		reg = <0x0800 0 0 0 0>;
> 
> Okay, this was Thierry's original idea, and it was my note that this
> didn't seem like a good choice. I'm not wedded to that, but I'll
> explain my reasoning a bit.
> 
> Two things bothered me
>   - Describing a CPU MMIO mapping with a config address space seems
>     wonky

I agree that mapping config space is sort of a jarring concept, but I
think that's because PCs have polluted the mindspace, not because there
is anything inherently bad about it.  The original PCI spec
fundamentally treated config space as just another (rather segmented)
linear address space.  It specified the cf8/cfc indirect access
mechanism not as a deep semantic feature, but rather as an
implementation hack to work around addressing limitations of PC chipsets
and the addressing-deficient popular OS of the time (Windows 3.1 which
was a veneer over DOS).  The PCI spec defined configuration mechanism #2
as a direct map into PC I/O space.  RISC chipsets of that era (e.g.
Alpha, Power PC) often direct-mapped config space into some form of
load/store space.

But PCs soon encroached on the RISC market and RISC system vendors
started to "leverage" PC I/O chipsets.  The indirect access "config
mechanism #1" became part of the mindset.  Indirect access was hardcoded
in enough software that chipset designers would provide indirect access
even if direct-mapping was possible.

Fundamentally, a config header is just a block of registers, addressable
as an index relative to some base.  It might require some specific
access path - but that is true with any block of registers.  Even
direct-mapped MMIO registers often require specific semantics such as
non-cached, non-write-buffered, or special address space ids.

The PCI SIG expected PCIe extended config space to be direct-mapped -
see slide 25 of

http://www.pcisig.com/specifications/pciexpress/technical_library/dev_con_09_02/specifications/pciexpress/PCIExpress_SoftwareandConfigurationModel.pdf

So mappability of config space was intended from the get-go.  The real
wonky thing is the "indirect access zombie that cannot die".

>   - Linux's OF core doesn't parse a 'reg' property under
>     'device_type = "pci"' as something CPU mappable, it only looks
>     to assigned-addresses for that. So the OF core would need to learn
>     how to handle this case, and it would have to be well defined..

The way I envisioned it working is that the root-complex node defines
its own config space access functions (the "ops" argument to
pci_scan_root_bus).  For config addresses listed in ranges, the
functions do MMIO.  For others, they use the chipset's indirect-access
registers.  The OF core is not involved.

> 
>     Thierry's original patch avoided this problem by not using
>     device_type = "pci"..
> 
> Also, did you mean to have a 0 size for the 'reg'? How will things
> know how big the MMIO region is? Can't just assume 0x800..

Sorry, that was a typo.

> 
> Again, thanks!
> Jason
> 
