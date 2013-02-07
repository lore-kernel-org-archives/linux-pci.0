Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:43909 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759110Ab3BGRtj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Feb 2013 12:49:39 -0500
Date: Thu, 7 Feb 2013 10:49:39 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
Message-ID: <20130207174939.GA24688@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-23-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302062241.14444.arnd@arndb.de>
 <20130207010502.GA7435@obsidianresearch.com>
 <20130207072824.GA24827@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130207072824.GA24827@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 07, 2013 at 08:28:24AM +0100, Thierry Reding wrote:
> On Wed, Feb 06, 2013 at 06:05:02PM -0700, Jason Gunthorpe wrote:
> [...]
> > Also, what should 'reg' be so that the PCI core binds the OF nodes
> > properly?  The standard says reg should have the configuration space
> > address of the bridge, and I noticed Thierry was using something that
> > almost looked like a config space address in his driver..
> > 
> > But that seems overly tricky.. When using the link stanzas, shouldn't
> > this scheme be more like this:
> > 
> > // The PCI-E host bridge
> > pex@0 {
> >    device_type = "pciex"; // <<-- Important!!
> 
> That might actually work but is somewhat dangerous. I originally tried
> to trick the OF code into parsing the ranges properly by setting this to
> "pci". However that breaks horribly because of_bus_pci_match() in
> drivers/of/address.c will cause the parent bus of the pex@0 controller
> to be PCI, which will cause #address-cells == 3 and #size-cells == 2,
> and thus messing up the address translation because you actually have
> #address-cells == 1 and #size-cells == 1.

Oh right, yes, I ment it to be "pci", specifically to engage that
code. Ditto for the other instance.

Not sure about the side effect you are talking about, I am using that
pattern in my DT and it is OK, but the PEX node is off the root node
directly.. It shouldn't affect the parent. Other DT examples using
device_type = pci (ie in PPC) also put it on the top PCI node and have
that node buried, so it should be correct, but all the stuff below has
to be correct first..
 
> >    ranges = <
> >       // Driver internal control registers in MMIO space
> >       0x82000000 0x10000000 0xd0040000  0xd0040000  0x0 0x8000000
> 
> I'm not sure I understand what you're doing here. Where does the
> 0x10000000 in cell 2 come from?

It is just a marker to keep the internal regs distinct from the PCI
MMIO window. I don't really like it, but something is necessary to
pass the non-PCI items into the link stanza. It would probably be
better to just place them outside the link as I did in my other
example..

> I also just noticed that I used 0x00000800 in the first cell, maybe that
> should be 0x02000800, though I think that didn't quite work for some
> reason. I'll need to check that. The odd part about this is that the

I think that is the trickyness you have, 0x00000800 is probably the
correct config space address number for your root port bridge. You are
overriding it to be both a config space address and something that
translates back to a CPU MMIO address.

If you use 0x02000800 then it is no longer a config space address, it is
an MMIO address and your 'reg' won't match anymore.

> address is in fact not within PCI MMIO space at all, so I'm not sure
> this is even a correct way to represent it. However I find it quite
> intuitive to do so and it is really the only way to make the translation
> from the PCI-PCI bridge's reg property work while at the same time
> having a proper PCI address for the port.

Your problem is that in PCI devices 'reg' is not supposed to be
translated to a CPU address. It is the config space address of the PCI
device followed by the *sizes* of all the BARs.

assigned-addresses is the MMIO location (and size) of the 'BARs', and
is intended to be translated to a CPU address.

When the bus is properly in PCI mode the OF address code automatically
uses assigned-addresses instead of regs, that is why you need
device_type = pci

> >    // PCI-PCI bridge to Physical link 0
> >    pcie@0,0 {
> >      device_type = "pciex";
> >      // The configuration space address of the PCI-PCI bridge required by OF
> >      reg = <0x80 0 0  0 0>; // Bus 0, Dev 0x10, Fn 0
> 
> I think the first cell should be 0x800.

Right.

> >      /* The 'bar' on the PCI-PCI bridge, maps to internal control
> >         registers, required by the driver. */
> >      assigned-addresses = <0x82000000 0x10000000 0xd0040000  0 0x2000>;
> >      // ..
> >   }
> 
> The PCI DT binding says that each entry in the assigned-addresses
> property is to correspond to one of the PCI device's base address
> registers. So unless this is actually the value that ends up being
> written to one of the BARs I don't think this is correct.

Yes, but, it is a compromise, of sorts. DT has no way to pass a
non-PCI described resource into this stanza. It would ideal if the
driver didn't require that at all, but if it does I think it has to be
through assigned-addresses...

Now, perhaps this is better:

assigned-addresses = <0 0 0  0 0 // BAR 0 of the bridge, unused
                      0 0 0  0 0 // BAR 1 of the bridge, unused
                      0x82000000 0x10000000 0xd0040000  0 0x2000>; // Extended

Mark the only two BARs in the bridge as unused and put your non-BAR
registers after them.

Certainly, trying to use reg to convey that the link has an internal
MMIO region at CPU address 0xd0040000 would be even worse..

Jason
