Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:37957 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293Ab3BLT0S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Feb 2013 14:26:18 -0500
Date: Tue, 12 Feb 2013 12:26:15 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130212192615.GC1471@obsidianresearch.com>
References: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302072325.23483.arnd@arndb.de>
 <20130208004414.GA32245@obsidianresearch.com>
 <201302092223.11796.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201302092223.11796.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 09, 2013 at 10:23:11PM +0000, Arnd Bergmann wrote:

> > This makes *lots* of sense, if you have bridges providing bus slots
> > then you include the bridge in DT to stop the 'fold down' at that
> > known bridge, giving you a chance to see the interrupt wiring behind
> > the bridge.
>
> I would argue that it matters not so much what Linux does but what
> the standard says, but it seems they both agree with you in this
> case: http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf
> defines that "At any level in the interrupt tree, a mapping may
> need to take place between the child interrupt domain and the
> parent???s. This is represented by a new property called 'interrupt-map'".

Right, the standard (and Linux) allows the property in any node.

> > This matches the design of PCI - if you know how interrupts are hooked
> > up then use that information, otherwise assume the INTx interrupts
> > swizzle and search upward. This is how add-in cards with PCI bridges
> > are supported.
> 
> Note that the implicit swizzling was not part of the original PCI
> binding, which assumed that all devices were explicitly represented
> in the device tree, and we don't normally do that any more because

Yes, if the tree includes all PCI devices then you don't need
interrupt-map, just place an interrupt property directly on the end
nodes.

However the implicit swizzling and 'fold down' is pretty much
essential to support the PCI standards for hot plug behind bridges.

> PCI can be probed easily, and we cannot assume that all PCI BARs
> have been correctly assigned by the firmware before the OS
> is booting. Having the interrupt-map at PCI host controller
> node is convenient because it lets us define unit interrupt
> specifiers for devices that are not represented in the device
> tree themselves.

Right, interrupt-map is actually only needed when the DT is
incomplete, or to support hot pluggable ports.

> I think the key question here is whether there is just one interrupt
> domain across all bridges because the hardware requires the unit
> address to be unique, or whether each PCIe port has its own
> unit address space, and thereby interrupt domain that requires
> its own interrupt-map.

IMHO, the interrupt domains should describe the underlying hardware,
and in many cases the HW is designed so that every PCI bus bridge has
it's own downstream interrupt layout - and thus is an interrupt domain.

> > If you imagine the case you alluded to, a PCI-E root port, connected
> > to a PCI-E to PCI bridge, with 2 physical PCI bus slots. The
> > interrupts for the 2 slots are routed to the CPU directly:
> > 
> > link@0 {
> >  reg = </* Bus 0, Dev 0x10, Fn 0 */>; // Root Port bridge
> > 
> >   // Match on INTx (not used since the pci-bridge doesn't create inband INTx)
> >   interrupt-mask = <0x0 0 0 7>;
> >   interrupt-map = <0x0000 0 0 1 &pic 0  // Inband INTA
> >                    0x0000 0 0 2 &pic 1  // Inband INTB
> 
> What are these two interrupts in the example then?

This shows that the HW block 'link@0' - which is a PCI Express root
port bridge - accepts inband INTx messages and converts them to CPU
interrupts pic 0/1/...

Since this is a general function, and fully self contained, it can be
placed in the general SOC's dtsi.

However, the board has a hard-wired PCIe to PCI bridge with PCI slots,
and never generates inband INTx. We can then describe that chip via
the following stanza in the board specific dts:

> >  pci_bridge@0 {
> >     reg = </* Bus 1, Dev 0x10, Fn 0 */>; // PCIe to PCI bridge
> 
> The device would be "pci@10", right?

Probably best to use the hex version of the regs value /* Bus 1, Dev
0x10, Fn 0 */, but nothing inspects that, right?

> >     // Match on the device/slot and INTx pin
> >     interrupt-mask = <0x7f 0 0 7>;
> >     interrupt-map = <0x00xx 0 0 1 &pic 2 // Slot 0 physical INTA
> >                      0x00xx 0 0 1 &pic 3 // Slot 1 physical INTA
> >                      ..
> >  }
> > }
> 
> You are accidentally matching the on the register number, not the
> device number here, right? The interrupt-map-mask should be
> <0xf800 0 0 7> to match the device.

Right, only match the device, ignore the bus.

There is also another variant, if the PCIe to PCI bridge provides its
own interrupt pins and converts those to inband PCIe INTx messages,
then the PCB can wire up the PCI bus slots to the bridge's INTx pins
according to some pattern and describe that pattern in DT:

pci_bridge@0 {
   reg = </* Bus 1, Dev 0x10, Fn 0 */>; // PCIe to PCI bridge
   interrupt-mask = <0xf800 0 0 7>;
   interrupt-map = <0x00xx 0 0 1 &pci_bridge0 0 0 0 1 // Slot 0 physical INTA to inband INTA
                    0x00xx 0 0 1 &pci_bridge0 0 0 0 2 // Slot 1 physical INTA to inband INTB
		    ...
}

(minus errors, haven't tried this one, but the standard says it should
be OK)

Which would be processed as:
 - pci_bridge@0 converts out of brand interrupts into in-band
   interrupts according its interrupt-map, and then sends those
   upstream.
 - link@0 converts in band interrupts into CPU interrupts according
   to its interrupt map.

In my experience the above is a common case.

Boot firmware could fold all this down to a single interrupt map, and
hide the programming of the IOAPIC/etc from the OS, but the HW is
still undertaking these transformations..

Anyhow, it sounds like Thomas has had success using this approach, so
it works.

Cheers,
Jason
