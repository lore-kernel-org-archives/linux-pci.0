Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62963 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3BGIY7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 03:24:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations for Armada XP
Date: Thu, 7 Feb 2013 08:24:50 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201302062241.14444.arnd@arndb.de> <20130207010502.GA7435@obsidianresearch.com>
In-Reply-To: <20130207010502.GA7435@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302070824.51125.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 07 February 2013, Jason Gunthorpe wrote:
> On Wed, Feb 06, 2013 at 10:41:14PM +0000, Arnd Bergmann wrote:
> 
> > This would mean that rather than putting the mapped physical address
> > (0xc0000000, 0xc1000000, ...) in here, you would actually have 64-bit
> > address as the destination as well, in whatever format the
> > address map hardware uses, I assume using a numbered 32 bit
> > address space for each object that can be remapped.
> 
> Do you mean like:
> 
> mbus_matrix {
>    /* At this level addresses are
>        <32 bit MBUS target ID> <32 bit target address offset>
>       target_id is an internal MBUS specification
>      */
>    #address-cells = <2>;
>    #size-cells = <1>;
> 
>    pex0 {
>        ranges = <
>       // CPU window bridged to PCI MMIO
>       0x82000000 0x00000000 0x00000000  0x<target_id> 0x0 0x0 0x8000000
>       // CPU IO window bridged to PCI IO
>       0x81000000 0x00000000 0x00000000  0x<target_id> 0x0  0x0 0xa0000
>       ...>;
>    }
> 
>    nand {
>        reg = <0x<target_id> 0 0x200>;
>    };
> 
>    internal_regs {
>        ranges = <0 0x<target_id> 0 0x10000>;
> 
>        timer {
>            reg = <0x20300 0x20>;
>       };
>    };
> }
> 
> ?

Yes, but the mbus-matrix node in the example would need a ranges property
to map the addresses according to how the windows are set up.

> I think the big issue would go back to how to pool all the link
> decoders together in a way that fits OF and Linux's PCI core will
> understand?
> 
> How does of_translate_address work in a world like this?

The trick is that the root node must still be #address-cells=<1> and
refer to the CPU's translated view of the world, rather the raw
view with individul windows. When we set up the address map in
Linux, we would initially read the windows from the ranges property,
but if we make changes to the windows, that property has to be
adapted on the fly. of_translate_address will then for any
device go through the intermediate 64 bit address but end up with
the correct physical address at the root node.

> > This would also let you do the PCI memory address assignment for
> > each port separately, starting at bus address 0, followed by
> > finding a location in the CPU address space and passing
> > the start as the sys->mem_offset argument to
> > pci_add_resource_offset.
> 
> That goes back to the original problem - the goal is to have only one
> pci_sys_data, not one for every link.
> 
> The host driver would have to request a large region of physical
> address space and still dole it out on a link by link basis. Not sure
> how to model that in DT??
> 
> In any event, changing how all the dynamic windows are configured in
> DT is a big job (there was another thread about this) it seems
> orthogonal to the PCI host driver..

Yes, it is orthogonal, you are right, but I think it would make it
easier to understand what we are trying to do here with the PCI
node. 

I'm not sure why you say "the goal is to have only one pci_sys_data",
as far as I'm concerned, the goal is to have a working system that
is both as sensible and as simple as possible. When in hardware
you have a bunch of independent PCIe host bridges, each with their
own address translation, that means to me that (if possible) we 
should in the device tree show multiple independent PCIe host bridges
and how they are set up with address translation, and Linux should
see multiple independent host bridges as well.
Having a single pci_sys_data is a hack to defeat some of the problems
associated with getting bus probing to work in practice, but it's
not necessarily the best solution.

> > > +                       pcie@0,0 {
> > > +                               device_type = "pciex";
> > > +                               reg = <0x0800 0 0xd0040000 0 0x2000>;
> > > +                               #address-cells = <3>;
> > > +                               #size-cells = <2>;
> > > +                               marvell,pcie-port = <0>;
> > > +                               marvell,pcie-lane = <0>;
> > > +                               interrupts = <1>;
> > > +                               clocks = <&gateclk 5>;
> > > +                               status = "disabled";
> > > +                       };
> > 
> > I think you are missing a "ranges" property here, at least an empty
> > one, which is required by the standard but not currently enforced
> > in the code.
> 
> Maybe.. according to the standard the ranges in this stanza should
> reflect the bridge configuration, but that isn't known when the DT is
> written. An empty ranges means identity and that isn't really right
> either.

Ok, I thought it was an identity mapping here.

> Also, what should 'reg' be so that the PCI core binds the OF nodes
> properly?  The standard says reg should have the configuration space
> address of the bridge, and I noticed Thierry was using something that
> almost looked like a config space address in his driver..

Well, that assumes that a bridge is addressed using configuration space,
which IIRC is normally the case but not here.

> But that seems overly tricky.. When using the link stanzas, shouldn't
> this scheme be more like this:
> 
> // The PCI-E host bridge
> pex@0 {
>    device_type = "pciex"; // <<-- Important!!
> 
>    ranges = <
>       // Driver internal control registers in MMIO space
>       0x82000000 0x10000000 0xd0040000  0xd0040000  0x0 0x8000000
> 
>       // CPU 0xe0000000 -> e8000000 bridged to PCI MMIO
>       0x82000000 0x00000000 0xe0000000  0xe0000000  0x0 0x8000000
>       // CPU IO bus 0x0000000 -> 0xa0000 bridged to PCI IO
>       0x81000000 0x00000000 0x00000000  0x00000000  0x0 0xa0000
>       // CPU 0xe8000000 -> f0000000 bridged to PCI MMIO, prefetchable
>       0xC2000000 0x00000000 0xe8000000  0xe8000000  0x0 0x8000000
>       >;
> 
>    //...
> 
>    // PCI-PCI bridge to Physical link 0
>    pcie@0,0 {
>      device_type = "pciex";
>      // The configuration space address of the PCI-PCI bridge required by OF
>      reg = <0x80 0 0  0 0>; // Bus 0, Dev 0x10, Fn 0
> 
>      /* The 'bar' on the PCI-PCI bridge, maps to internal control
>         registers, required by the driver. */
>      assigned-addresses = <0x82000000 0x10000000 0xd0040000  0 0x2000>;
>      // ..
>   }
> }
> 
> Thierry, what do you think?
> 
> I struggled with this particular area of the OF system recently and
> Grant Likely was very helpful - the above is based on that
> discussion..

I never really understood the 'assigned-addresses' property, but it looks
sensible.

> ======
> 
> Thomas, here is one possible alternate idea, not sure on the merit,
> just including it because it is close to what I've got in my DT right
> now..:
> 
> // The entire multi-lane controller and PCI root bus
> pex@0 {
>    device_type = "pciex";
> 
>    /* This section configures the Linux PCI host driver. Each line is a
>       physical PCI-Link. (Erorrs included :) */
>    compatible = "marvell,armada-370-xp-pcie";
>    regs = <0xd0040000 0x00002000   // port 0.0
>            0xd0042000 0x00002000   // port 2.0
>            0xd0044000 0x00002000   // port 0.1
>            0xd0048000 0x00002000   // port 0.2
>            0xd004C000 0x00002000>; // port 0.3
>    io-cpu-window = <0xc0000000 0xa0000>;
>    interrupts = <58 59 60 61 99>;
>    clocks = <&gateclk 5
>              &gateclk 6
>              &gateclk 7
>              &gateclk 8
>              &gateclk 26>
>    marvell,port-lane <0 0
>                       0 1
>                       0 2
>                       0 3
>                       2 0>;
> 
>    /* Below here configures the aggregate PCI bus the PEX0 stanza
>       describes */
> 
>    #address-cells = <3>;
>    #size-cells = <2>;
> 
>    // CPU resources allocated to this PCI host bridge
>    bus-range = <0x00 0xff>;
>    ranges = <
>       // CPU 0xe0000000 -> e8000000 bridged to PCI MMIO
>       0x82000000 0x00000000 0xe0000000  0xe0000000  0x0 0x8000000
>       // CPU IO bus 0x0000000 -> 0xa0000 bridged to PCI IO
>       0x81000000 0x00000000 0x00000000  0x00000000  0x0 0xa0000
>       // CPU 0xe8000000 -> f0000000 bridged to PCI MMIO, prefetchable
>       0xC2000000 0x00000000 0xe8000000  0xe8000000  0x0 0x8000000
>       >;
> 
>    /* Any PCI devices associated with this bus go here, relative to
>       the above ranges. As example: */
>    link@0 {
>    	device_type = "pciex";
>         // Root port at bus 0, device 0x10, function 0
> 	reg = <0x00000080 0 0  0 0>;
> 
>        ep {
>    	 device_type = "pciex";
>          // End port on bus 1, device 0, function 0
> 	 reg = <0x00000100 0 0  0 0>;
>        } 
>    }
> }
> 
> Thoughts:
>  - 'regs' in the main stanza, keep to CPU addresses instead of
>    confusing translated fake ranges address

Yes, I like that. If we follow the address translation method I suggested,
this would be a 64-bit address of course, but still easier to understand
than what we have now.

>  - each regs line is matches to an interrupt, clock and port-lane
>    line to describe a link. The above describes 5 links.

nice.

>  - The CPU physical address window to use for the IO space
>    is set via io-cpu-window, not much choice here, the PCI
>    format ranges must be 0 based.

I don't think I understand this part. Why can't you put this into
ranges as before?

-       0x81000000 0x00000000 0x00000000  0x00000000  0x0 0xa0000
+	0x81000000 0x00000000 0x00000000  0xc0000000  0x0 0xa0000

>  - It is not necessary to have per-root port stanzas at all
>    with the above.
>  - There is only one PCI bus stanza, the top level.

Ok.

	Arnd
