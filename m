Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:57576 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab3BADvX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jan 2013 22:51:23 -0500
Date: Thu, 31 Jan 2013 20:51:15 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130201035115.GA23649@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <510B0D9C.1000101@wwwdotorg.org>
 <20130201014138.GA16234@obsidianresearch.com>
 <510B268E.2040104@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510B268E.2040104@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 31, 2013 at 07:21:02PM -0700, Stephen Warren wrote:

> I originally thought the issue was that the windows were between CPU
> physical address space and the PCIe host controller itself. But in fact,
> the windows are between PCIe bus 0 and the root ports, so they're
> the

Donno what exactly is inside tegra, but on Marvell the docs describe
an an internal bus cross bar/whatever and each PCI-E link gets a port
on that structure. There is no such physical thing as a 'PCI bus 0',
and they didn't arrange the hardware in a way that makes it easy for
the host driver to create one like tegra did :(

> equivalent of the standard PCIe root port (or PCIe/PCIe bridge) BAR
> registers. And related, these BAR/window registers are usually part of
> each PCIe root port itself, and hence there's a whole number dedicated
> to each root port, but on Marvell there's a *global* pool of these
> BARs/windows instead.

Right, that is all following the PCI-E spec, and is reasonable and
sane. What Marvell did is take an *end port core* and jam'd it on
their internal bus without adjusting things to follow the PCI-E spec
regarding config space and what not.

> > That more or less means you need to know what is going to be on the
> > other side of every link when you write the DT.
> 
> So, the dynamic programming of the windows on Marvell HW is the exact
> logical equivalent of programming a standard PCIe root port's BAR
> registers. It makes perfect sense that should be dynamic. Presumably
> this is something you can make work inside your emulated PCIe/PCIe
> bridge module, simply by capturing writes to the BAR registers, and
> translating them into writes to the Marvell window registers.

Yes, that is exactly the idea.
 
> Now, I do have one follow-on question: You said you don't have 30
> windows, but how many do you have free after allocating windows to any
> other peripherals that need them, relative to (3 *
> number-of-root-ports-in-the-SoC)? (3 being IO+Mem+PrefetchableMem.)

Thomas will have to answer this, it varies depending on the SOC, and
what other on chip peripherals are in use. For instance Kirkwood has
the same design but there are plenty of windows for the two PCI-E
links.

Still how would you even connect a limited number of regions on a link
by link basis to the common PCI code?

> The thing here is that when the PCIe core writes to a root port BAR
> window to configure/enable it the first time, you'll need to capture
> that transaction and dynamically allocate a window and program it in a
> way equivalent to what the BAR register write would have achieved on
> standard HW. Later, the window might need resizing, or even to be
> completely disabled, if the PCIe core were to change the standard
> BAR

Right. This is pretty straightforward except for the need to hook the
alignment fixup..

> register. Dynamically allocating a window when the BAR is written seems
> a little heavy-weight.

I think what Thomas had here was pretty small, and the windows need to
be shared with other on chip periphals beyond PCI-E..
 
> needed, e.g. if there's no IO space behind a root port, you could get
> away with two windows per root port, and hence be able to run 3 root
> ports rather than just 2?

Right, this is the main point. If you plug in 3 devices and they all
only use MMIO regions then you only need to grab 3 windows. The kernel
disables the unused windows on the bridge so it is easy to tell when
they are disused.

> Still, I supose doing it dynamically in the driver does end up being a
> lot less to think about for someone creating the DT for a new board.

Agreed, these restrictions are all so HW specific, subtle and have
nothing to do with the PCI-E spec. Codifying them once in the driver
seems like the way to keep this crazyness out of the PCI core and away
from users of the SOC.
 
> Having to translate standard root port BAR register writes to Marvell
> window register allocation/writes would imply that the emulated root
> port code has to be very closely tied into the Marvell PCIe driver, and
> not something that could be at all generic in the most part.

Agreed.. At the very least generic code would need call back
functions to the driver... It has a fair bit to do for Marvell:
 - Translate MMIO, prefetch and IO ranges to mbus windows
 - Keep track of the secondary/subordinate bus numbers and fiddle
   with other hardware registers to set those up
 - Copy the link state/control regsiters from the end port config
   space into the bridge express root port capability
 - Probably ditto for AER as well..

Probably simpler just to make one for marvell then mess excessively
with callbacks..

Cheers,
Jason
