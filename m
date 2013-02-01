Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49570 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab3BAIqS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 03:46:18 -0500
Date: Fri, 1 Feb 2013 09:46:13 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
Message-ID: <20130201094613.38fa2ad0@skate>
In-Reply-To: <510B268E.2040104@wwwdotorg.org>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<510B0D9C.1000101@wwwdotorg.org>
	<20130201014138.GA16234@obsidianresearch.com>
	<510B268E.2040104@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Stephen Warren,

Thanks for this great discussion. I see that Jason has already answered
most of the questions on the why we need this "dynamicity" in the window
configuration. A few comments below.

On Thu, 31 Jan 2013 19:21:02 -0700, Stephen Warren wrote:

> So, the dynamic programming of the windows on Marvell HW is the exact
> logical equivalent of programming a standard PCIe root port's BAR
> registers. It makes perfect sense that should be dynamic. Presumably
> this is something you can make work inside your emulated PCIe/PCIe
> bridge module, simply by capturing writes to the BAR registers, and
> translating them into writes to the Marvell window registers.

That's what I'm doing. In the PATCHv2, my PCIe host driver was reading
back the BARs in the PCI-to-PCI bridges configuration space, and was
setting up the windows according to the addresses that had been
assigned to each bridge.

I am currently working in making this more dynamic: it is directly when
the BAR is being written to in the PCI-to-PCI bridge configuration
space that a window will be setup.

> Now, I do have one follow-on question: You said you don't have 30
> windows, but how many do you have free after allocating windows to any
> other peripherals that need them, relative to (3 *
> number-of-root-ports-in-the-SoC)? (3 being IO+Mem+PrefetchableMem.)

We have 20 windows on Armada XP if I remember correctly, and they are
not only used for PCIe, but also to map the BootROM (needed to boot
secondary CPUs), to map SPI flashes or NOR flashes, for example. So
they are really shared between many uses. In terms of PCIe, there are
only two types of windows: I/O and Memory, there is no notion of
Prefetchable Memory window as far as I could see.

We have up to 10 PCIe interfaces, and only 20 windows. It means that
you basically can't use all PCIe interfaces, there will necessarily be
some limit, due to the limited number of windows.

Also, I'd like to point out that the dynamic configuration is needed
for two reasons:

 * The number of windows, as we are discussing now.

 * The amount of physical address space available. If you don't
   dynamically configure those windows, then you have to account the
   "worst case", i.e the PCIe devices that require very large memory
   areas. So you end up creating static windows that reserve 32M or 64M
   or 128M *per* PCIe link. You can see that it "consumes" pretty
   quickly a large part of the 4G physical address space that we have.
   Thanks to the dynamic window configuration that we do with the
   PCI-to-PCI bridge, we can size the windows exactly the size needed
   by the downstream device on each PCIe interface.

> The thing here is that when the PCIe core writes to a root port BAR
> window to configure/enable it the first time, you'll need to capture
> that transaction and dynamically allocate a window and program it in a
> way equivalent to what the BAR register write would have achieved on
> standard HW. Later, the window might need resizing, or even to be
> completely disabled, if the PCIe core were to change the standard BAR
> register. Dynamically allocating a window when the BAR is written
> seems a little heavy-weight.

Why?

> So while it's obvious that window base address and size shouldn't be
> static, I wonder if the assignment of a specific window ID to a
> specific root port ID shouldn be dynamic or static. For example, if
> your HW configuration leaves you with 6 windows available, you could
> support 2 PCIe root ports by statically assigning 3 windows to serve
> each of those 2 root ports. Would that work, or are there systems
> where over-commit is needed, e.g. if there's no IO space behind a
> root port, you could get away with two windows per root port, and
> hence be able to run 3 root ports rather than just 2? Still, if you
> know which PCIe devices are being the root ports, you could still
> represent the over-commit statically in DT

For now, I haven't figured out how not to allocate an I/O window if the
downstream device doesn't use I/O, but I'd like to achieve that, as it
would save one of the two windows needed per PCIe interface... and many
PCIe devices don't need the I/O window.

> Still, I supose doing it dynamically in the driver does end up being a
> lot less to think about for someone creating the DT for a new board.

Indeed.

> Having to translate standard root port BAR register writes to Marvell
> window register allocation/writes would imply that the emulated root
> port code has to be very closely tied into the Marvell PCIe driver,
> and not something that could be at all generic in the most part.

Right. I've already moved the PCI-to-PCI bridge code from the generic
drivers/pci/sw-pci-pci-bridge.c location to be directly into the
driver. It also to integrate more tightly things like window allocation.

> Right. Now that I really understand what the windows are doing, I can
> see that a static window configuration (address/size, perhaps rather
> than windows are used) would not be appropriate.

Glad to see we reached the same conclusion :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
