Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49656 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab3BAJDe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 04:03:34 -0500
Date: Fri, 1 Feb 2013 10:03:29 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
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
Message-ID: <20130201100329.4d57fa55@skate>
In-Reply-To: <20130201035115.GA23649@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<510B0D9C.1000101@wwwdotorg.org>
	<20130201014138.GA16234@obsidianresearch.com>
	<510B268E.2040104@wwwdotorg.org>
	<20130201035115.GA23649@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

Thanks again for continuing this discussion while I was sleeping :-)

On Thu, 31 Jan 2013 20:51:15 -0700, Jason Gunthorpe wrote:

> > Now, I do have one follow-on question: You said you don't have 30
> > windows, but how many do you have free after allocating windows to
> > any other peripherals that need them, relative to (3 *
> > number-of-root-ports-in-the-SoC)? (3 being IO+Mem+PrefetchableMem.)
> 
> Thomas will have to answer this, it varies depending on the SOC, and
> what other on chip peripherals are in use. For instance Kirkwood has
> the same design but there are plenty of windows for the two PCI-E
> links.

Right. I already answered this point directly to Stephen. On Kirkwood,
there are many windows and two PCIe links, so the windows were
statically allocated. On Armada XP, there are 20 windows and 10 PCIe
links. Static allocation is no longer reasonable.

> > The thing here is that when the PCIe core writes to a root port BAR
> > window to configure/enable it the first time, you'll need to capture
> > that transaction and dynamically allocate a window and program it
> > in a way equivalent to what the BAR register write would have
> > achieved on standard HW. Later, the window might need resizing, or
> > even to be completely disabled, if the PCIe core were to change the
> > standard BAR
> 
> Right. This is pretty straightforward except for the need to hook the
> alignment fixup..
> 
> > register. Dynamically allocating a window when the BAR is written
> > seems a little heavy-weight.
> 
> I think what Thomas had here was pretty small, and the windows need to
> be shared with other on chip periphals beyond PCI-E..

Yes, it is not very complicated. We already have some common code that
creates/removes those windows, so it is just a matter of calling the
right thing at the right time. Definitely not hundreds of line of crap.

> Right, this is the main point. If you plug in 3 devices and they all
> only use MMIO regions then you only need to grab 3 windows. The kernel
> disables the unused windows on the bridge so it is easy to tell when
> they are disused.

Ah, I'm interested in further discussing this. I currently have a setup
with one SATA PCIe card and one NIC PCIe card. On the NIC, the I/O
ports are said to be "disabled", but still an I/O region gets allocated
in the PCI-to-PCI bridge that gives access to this particular device.

The device in question is:

05:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
	Subsystem: Intel Corporation PRO/1000 PT Server Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 106
	Region 0: Memory at c1200000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c1220000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at c0010000 [disabled] [size=32]
	[virtual] Expansion ROM at c1300000 [disabled] [size=128K]

So the Region 2 is disabled. But, in the corresponding bridge:

00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 1092 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: c0010000-c001ffff
	Memory behind bridge: c1200000-c12fffff
	Prefetchable memory behind bridge: c1300000-c13fffff

So there is really a range of I/O addresses associated to it, even
though the device will apparently not use it. Would it be possible to
detect that the I/O range is not used by the device, and therefore
avoid the allocation of an address decoding window for this I/O range?

> Agreed.. At the very least generic code would need call back
> functions to the driver... It has a fair bit to do for Marvell:
>  - Translate MMIO, prefetch and IO ranges to mbus windows
>  - Keep track of the secondary/subordinate bus numbers and fiddle
>    with other hardware registers to set those up
>  - Copy the link state/control regsiters from the end port config
>    space into the bridge express root port capability
>  - Probably ditto for AER as well..
> 
> Probably simpler just to make one for marvell then mess excessively
> with callbacks..

As replied to Stephen, I've chosen to bring the PCI-to-PCI bridge
emulation code directly into the driver, specifically for this reason.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
