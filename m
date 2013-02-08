Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:59445 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab3BHAoR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Feb 2013 19:44:17 -0500
Date: Thu, 7 Feb 2013 17:44:14 -0700
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
Message-ID: <20130208004414.GA32245@obsidianresearch.com>
References: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130207183743.5c97d8b8@skate>
 <20130207182153.GB24688@obsidianresearch.com>
 <201302072325.23483.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201302072325.23483.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 07, 2013 at 11:25:23PM +0000, Arnd Bergmann wrote:
> > link@0 {
> > reg = <0x800 0 0  0 0>; // Bus 0, Dev 0x10, Fn 0
> > interrupt-mask = <0x0 0 0 7>;
> > interrupt-map = <0x0000 0 0 1 &mpic 58 // INTA
> >                  0x0000 0 0 2 &mpic 58 // INTB
> >                  0x0000 0 0 3 &mpic 58 // INTC
> >                  0x0000 0 0 4 &mpic 58>; // INTD
> > }
> 
> The interrupt-map property only makes sense for the host bridge,
> not for bridges below it, which don't normally get represented
> in the device tree.

Linux scans up the PCI bus until it finds a PCI device with a matching
OF node. It then constructs an interrupt map 'laddr' (ie the
bus:dev.fn) for the child device of this OF node.

If you don't have any DT PCI nodes then this should always fold down
to doing a lookup with bus=0, and device representing the 'slot' in
legacy PCI.

However, as soon as you provide a node for a bridge in DT this halts
the 'fold down' and goes to the interrupt-map with a device on the
subordinate bus number of the bridge.

This makes *lots* of sense, if you have bridges providing bus slots
then you include the bridge in DT to stop the 'fold down' at that
known bridge, giving you a chance to see the interrupt wiring behind
the bridge.

This matches the design of PCI - if you know how interrupts are hooked
up then use that information, otherwise assume the INTx interrupts
swizzle and search upward. This is how add-in cards with PCI bridges
are supported.

This behavior seems complex, but sane to me. I wouldn't change it as
Andrew suggested.

Thomas's problem is the presence of the static DT node for the root
port bridge. Since the node is static you can't know what the runtime
determined subordinate bus numbers will be, so there is no possible
way to write an interrupt-map at the host bridge.

Putting the map in the bridge's DT node seems elegant and correct to
me - the map is describing the actual hardware - the root port bridge
is actually terminating INTx from downstream devices and converting
them to CPU interrupts. (FWIW discrete HT to PCIe bridges do something
similar)

If you imagine the case you alluded to, a PCI-E root port, connected
to a PCI-E to PCI bridge, with 2 physical PCI bus slots. The
interrupts for the 2 slots are routed to the CPU directly:

link@0 {
 reg = </* Bus 0, Dev 0x10, Fn 0 */>; // Root Port bridge

  // Match on INTx (not used since the pci-bridge doesn't create inband INTx)
  interrupt-mask = <0x0 0 0 7>;
  interrupt-map = <0x0000 0 0 1 &pic 0  // Inband INTA
                   0x0000 0 0 2 &pic 1  // Inband INTB
		   ..
 pci_bridge@0 {
    reg = </* Bus 1, Dev 0x10, Fn 0 */>; // PCIe to PCI bridge
  
    // Match on the device/slot and INTx pin
    interrupt-mask = <0x7f 0 0 7>;
    interrupt-map = <0x00xx 0 0 1 &pic 2 // Slot 0 physical INTA
                     0x00xx 0 0 1 &pic 3 // Slot 1 physical INTA
                     ..
 }
}

To me, this seems to be a much more accurate description of how the
hardware is constructed then trying to cram all this information into
the host bridge's interrupt map. It shows clearly where inband INTA
messages arriving at the root port are directed as well as where the
slot by slot out-of-band interrupt wires on the PCI bus are directed.

Jason
