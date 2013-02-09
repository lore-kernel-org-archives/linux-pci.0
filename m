Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55272 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563Ab3BIWXS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Feb 2013 17:23:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Sat, 9 Feb 2013 22:23:11 +0000
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
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
References: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com> <201302072325.23483.arnd@arndb.de> <20130208004414.GA32245@obsidianresearch.com>
In-Reply-To: <20130208004414.GA32245@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201302092223.11796.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 08 February 2013, Jason Gunthorpe wrote:
> On Thu, Feb 07, 2013 at 11:25:23PM +0000, Arnd Bergmann wrote:
> > > link@0 {
> > > reg = <0x800 0 0  0 0>; // Bus 0, Dev 0x10, Fn 0
> > > interrupt-mask = <0x0 0 0 7>;
> > > interrupt-map = <0x0000 0 0 1 &mpic 58 // INTA
> > >                  0x0000 0 0 2 &mpic 58 // INTB
> > >                  0x0000 0 0 3 &mpic 58 // INTC
> > >                  0x0000 0 0 4 &mpic 58>; // INTD
> > > }
> > 
> > The interrupt-map property only makes sense for the host bridge,
> > not for bridges below it, which don't normally get represented
> > in the device tree.
> 
> Linux scans up the PCI bus until it finds a PCI device with a matching
> OF node. It then constructs an interrupt map 'laddr' (ie the
> bus:dev.fn) for the child device of this OF node.
> 
> If you don't have any DT PCI nodes then this should always fold down
> to doing a lookup with bus=0, and device representing the 'slot' in
> legacy PCI.
> 
> However, as soon as you provide a node for a bridge in DT this halts
> the 'fold down' and goes to the interrupt-map with a device on the
> subordinate bus number of the bridge.
> 
> This makes *lots* of sense, if you have bridges providing bus slots
> then you include the bridge in DT to stop the 'fold down' at that
> known bridge, giving you a chance to see the interrupt wiring behind
> the bridge.

I would argue that it matters not so much what Linux does but what
the standard says, but it seems they both agree with you in this
case: http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf
defines that "At any level in the interrupt tree, a mapping may
need to take place between the child interrupt domain and the
parent’s. This is represented by a new property called 'interrupt-map'".

> This matches the design of PCI - if you know how interrupts are hooked
> up then use that information, otherwise assume the INTx interrupts
> swizzle and search upward. This is how add-in cards with PCI bridges
> are supported.

Note that the implicit swizzling was not part of the original PCI
binding, which assumed that all devices were explicitly represented
in the device tree, and we don't normally do that any more because
PCI can be probed easily, and we cannot assume that all PCI BARs
have been correctly assigned by the firmware before the OS
is booting. Having the interrupt-map at PCI host controller
node is convenient because it lets us define unit interrupt
specifiers for devices that are not represented in the device
tree themselves.

I think the key question here is whether there is just one interrupt
domain across all bridges because the hardware requires the unit
address to be unique, or whether each PCIe port has its own
unit address space, and thereby interrupt domain that requires
its own interrupt-map.

If there is just one domain, we have the choice whether to have
one interrupt-map for the entire domain, or to have one
interrupt map per PCIe port for the devices under that port.
I would consider it more logical to have a single interrupt-map
for the interrupt domain, because that is essentially what
lets us describe the interrupt daomain as a whole.

Of course, if each port has its own domain, we have to have
a separate interrupt map for each one.

> Thomas's problem is the presence of the static DT node for the root
> port bridge. Since the node is static you can't know what the runtime
> determined subordinate bus numbers will be, so there is no possible
> way to write an interrupt-map at the host bridge.

Right, that is a problem if there are additional bridges. I guess
we could represent all devices on bus 0 easily because their
address would be fixed,  but can't uniquely identify anything
below them.

> If you imagine the case you alluded to, a PCI-E root port, connected
> to a PCI-E to PCI bridge, with 2 physical PCI bus slots. The
> interrupts for the 2 slots are routed to the CPU directly:
> 
> link@0 {
>  reg = </* Bus 0, Dev 0x10, Fn 0 */>; // Root Port bridge
> 
>   // Match on INTx (not used since the pci-bridge doesn't create inband INTx)
>   interrupt-mask = <0x0 0 0 7>;
>   interrupt-map = <0x0000 0 0 1 &pic 0  // Inband INTA
>                    0x0000 0 0 2 &pic 1  // Inband INTB

What are these two interrupts in the example then?

>  pci_bridge@0 {
>     reg = </* Bus 1, Dev 0x10, Fn 0 */>; // PCIe to PCI bridge

The device would be "pci@10", right?

>     // Match on the device/slot and INTx pin
>     interrupt-mask = <0x7f 0 0 7>;
>     interrupt-map = <0x00xx 0 0 1 &pic 2 // Slot 0 physical INTA
>                      0x00xx 0 0 1 &pic 3 // Slot 1 physical INTA
>                      ..
>  }
> }

You are accidentally matching the on the register number, not the
device number here, right? The interrupt-map-mask should be
<0xf800 0 0 7> to match the device.

> To me, this seems to be a much more accurate description of how the
> hardware is constructed then trying to cram all this information into
> the host bridge's interrupt map. It shows clearly where inband INTA
> messages arriving at the root port are directed as well as where the
> slot by slot out-of-band interrupt wires on the PCI bus are directed.

Yes, I guess you're right.

	Arnd
