Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39541 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750894AbaBUTVO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 14:21:14 -0500
Date: Fri, 21 Feb 2014 20:21:00 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221202100.3286c5d6@skate>
In-Reply-To: <CAErSpo5c=iMHM_uATxsiUthaHtt-UvX6ySQx2pVgfJT4ABuWGQ@mail.gmail.com>
References: <20130711163220.2b3adf38@skate>
	<53039894.10905@keymile.com>
	<20140218212751.07c2aeb5@skate>
	<53046D98.6020801@keymile.com>
	<20140219102658.76eec91e@skate>
	<53047BBB.6040108@keymile.com>
	<20140219143749.65ff3155@skate>
	<CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
	<20140220095518.7ca36f0a@skate>
	<CAErSpo5pG3eOG58MiCCOHgr_jQReH0uBnWQFvzQYg3qrOGpZEw@mail.gmail.com>
	<20140221002438.GE19893@obsidianresearch.com>
	<CAErSpo5c=iMHM_uATxsiUthaHtt-UvX6ySQx2pVgfJT4ABuWGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Fri, 21 Feb 2014 12:05:49 -0700, Bjorn Helgaas wrote:

> Thanks for making this more concrete.  Let me see if I understand any better:

Good to see that Jason Gunthorpe could explain this in better words.
I'll try to answer to your questions below, I'm sure Jason will correct
me if I say incorrect things, or things that are imprecise.

> - e0000000-efffffff is the "host bridge aperture" but it doesn't
> correspond to an actual aperture in hardware (there are no registers
> where you set this range).  The only real use for this range is to be
> the arena within which the PCI core can assign space to the Root
> Ports.  This is static and you don't need to change it based on what
> devices we discover.

Correct. We don't configure this in any hardware register. We just give
this aperture to the Linux PCI core to tell it "please allocate all
BAR physical ranges from this global aperture".

> - There may be several MBus/PCIe Root Ports, and you want to configure
> their apertures at enumeration-time based on what devices are below
> them.  As you say, the PCI core supports this except that MBus
> apertures must be a power-of-two in size and aligned on their size,
> while ordinary PCI bridge windows only need to start and end on 1MB
> boundaries.

Exactly.

> - e0000000-e00fffff is an example of one MBus/PCIe aperture, and this
> space is available on PCI bus 01.  This one happens to be 1MB in size,
> but it could be 2MB, 4MB, etc., but not 3MB like a normal bridge
> window could be.

Absolutely.

Note that we have the possibility of mapping a 3 MB BAR, by using a 2
MB window followed by a 1 MB window. However, since the number of
windows is limited (8 on Kirkwood, 20 on Armada 370/XP), we will prefer
to enlarge the BAR size if it's size is fairly small, and only resort
to using multiple windows if the amount of lost physical space is big.

So, for a 3 MB BAR, we will definitely prefer to extend it to a single 4
MB window, because losing 1 MB of physical address space is preferable
over losing one window.

For a 192 MB BAR, we may prefer to use one 128 MB window followed by
one 64 MB window.

But as long as the pci-mvebu driver can control the size of the BAR, it
can decide on its own whether its prefers enlarging the BAR, or using
multiple windows.

> - You're currently using the ARM ->align_resource() hook (part of
> pcibios_align_resource()), which is used in the bowels of the
> allocator (__find_resource()) and affects the starting address of the
> region we allocate, but not the size.  So you can force the start of
> an MBus aperture to be power-of-two aligned, but not the end.

Correct.

Happy to see that we've managed to get an understanding on what the
problem.

> The allocate_resource() alignf argument is only used by PCI and
> PCMCIA, so it doesn't seem like it would be too terrible to extend the
> alignf interface so it could control the size, too.  Would something
> like that solve this problem?

I don't know, I would have to look more precisely into this alignf
argument, and see how it could be extended to solve our constraints.

> I first wondered if you could use pcibios_window_alignment(), but it
> doesn't know the amount of space we need below the bridge, and it also
> can't affect the size of the window or the ending address, so I don't
> think it will help.
> 
> But I wonder if powerpc has a similar issue here: I think EEH might
> need, for example 16MB bridge window alignment.  Since
> pcibios_window_alignment() only affects the *starting* address, could
> the core assign a 9MB window whose starting address is 16MB-aligned?
> Could EEH deal with that?  What if the PCI core assigned the space
> right after the 9MB window to another device?

I'll let the other PCI people answer this :-)

Thanks a lot for your feedback!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
