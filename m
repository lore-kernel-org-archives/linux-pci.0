Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33488 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098Ab3BAR5Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 12:57:25 -0500
Message-ID: <510C0200.5040505@wwwdotorg.org>
Date: Fri, 01 Feb 2013 10:57:20 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com> <510B0D9C.1000101@wwwdotorg.org> <20130201014138.GA16234@obsidianresearch.com> <510B268E.2040104@wwwdotorg.org> <20130201094613.38fa2ad0@skate>
In-Reply-To: <20130201094613.38fa2ad0@skate>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/01/2013 01:46 AM, Thomas Petazzoni wrote:
> Dear Stephen Warren,
> 
> Thanks for this great discussion. I see that Jason has already answered
> most of the questions on the why we need this "dynamicity" in the window
> configuration. A few comments below.
> 
> On Thu, 31 Jan 2013 19:21:02 -0700, Stephen Warren wrote:
> 
>> So, the dynamic programming of the windows on Marvell HW is the exact
>> logical equivalent of programming a standard PCIe root port's BAR
>> registers. It makes perfect sense that should be dynamic. Presumably
>> this is something you can make work inside your emulated PCIe/PCIe
>> bridge module, simply by capturing writes to the BAR registers, and
>> translating them into writes to the Marvell window registers.
> 
> That's what I'm doing. In the PATCHv2, my PCIe host driver was reading
> back the BARs in the PCI-to-PCI bridges configuration space, and was
> setting up the windows according to the addresses that had been
> assigned to each bridge.
> 
> I am currently working in making this more dynamic: it is directly when
> the BAR is being written to in the PCI-to-PCI bridge configuration
> space that a window will be setup.
> 
>> Now, I do have one follow-on question: You said you don't have 30
>> windows, but how many do you have free after allocating windows to any
>> other peripherals that need them, relative to (3 *
>> number-of-root-ports-in-the-SoC)? (3 being IO+Mem+PrefetchableMem.)
> 
> We have 20 windows on Armada XP if I remember correctly, and they are
> not only used for PCIe, but also to map the BootROM (needed to boot
> secondary CPUs), to map SPI flashes or NOR flashes, for example. So
> they are really shared between many uses. In terms of PCIe, there are
> only two types of windows: I/O and Memory, there is no notion of
> Prefetchable Memory window as far as I could see.

In Tegra, we end up having separate MMIO vs. Prefetchable MMIO chunks of
our overall PCIe aperture. However, the HW setup appears the same for
both of those. I'm not sure if it's a bug in the driver, or if it's just
to separate the two address spaces so that the page tables can be
configured for those two regions with large rather than small
granularity. I need to go investigate that.

> We have up to 10 PCIe interfaces, and only 20 windows. It means that
> you basically can't use all PCIe interfaces, there will necessarily be
> some limit, due to the limited number of windows.

So there are 10 PCIe interfaces (root ports). That's on the SoC itself
right. Are all 10 (or a large number of them) actually used at once on
any given board design? I suppose this must be the case, or Marvell
wouldn't have wasted the silicon space on 10 root ports... Still, that's
a rather large number of ports!

If only a few PCIe ports are ever in use at once on a design and/or the
PCIe ports generally contain soldered-down devices rather than
user-accessible ports, the statically assigning window *IDs* to
individual ports would make for easier code in the driver, since the BAR
register emulation would never have to allocate/de-allocate windows, but
rather only ever have to enable/disable/configure them.

However, if many PCIe ports are in use at once and there are
user-accessible ports, you can't know ahead of time which ports will
need MMIO vs. MMIO prefetch vs. IO, so you'd have to dynamically
allocate window IDs to ports, in addition to dynamically setting up the
address/size of windows.

> Also, I'd like to point out that the dynamic configuration is needed
> for two reasons:
> 
>  * The number of windows, as we are discussing now.

OK.

>  * The amount of physical address space available. If you don't
>    dynamically configure those windows, then you have to account the
>    "worst case", i.e the PCIe devices that require very large memory
>    areas. So you end up creating static windows that reserve 32M or 64M
>    or 128M *per* PCIe link. You can see that it "consumes" pretty
>    quickly a large part of the 4G physical address space that we have.
>    Thanks to the dynamic window configuration that we do with the
>    PCI-to-PCI bridge, we can size the windows exactly the size needed
>    by the downstream device on each PCIe interface.

That aspect is applicable to any PCIe system; there's always some chunk
of physical address space that maps to PCIe, and which must be divided
into per-root-port chunks.

I think the only difference on the Marvell HW is:

* The overall total size of the physical address space is dynamic rather
than fixed, because it's programmed through windows rather than
hard-coded into HW.

* Hence, the windows /both/ define the physical address space layout
/and/ define the routing of transactions to individual root ports. On
regular PCIe, the root port BARs only divide up the overall physical
(PCIe bus 0 really) address space and hence perform routing; they have
no influence over the CPU physical address space.

So I think the crux of the problem is that you really have 10 PCIe root
ports, each of which is a nominally a separate PCIe domain (since the
windows connect CPU physical address space to an individual/specific
root port's PCIe address space, rather than having separate connections
from CPU -> PCIe bus 0 address space, then BARs/windows connecting PCIe
bus 0 address space to individual root port/subordinate bus address
space), but you're attempting to treat all 10 ports as a single PCIe
domain so that you don't have to dedicate separate physical CPU address
space to each port, which you would have to do if they were actually
treated as separate domains.

>> The thing here is that when the PCIe core writes to a root port BAR
>> window to configure/enable it the first time, you'll need to capture
>> that transaction and dynamically allocate a window and program it in a
>> way equivalent to what the BAR register write would have achieved on
>> standard HW. Later, the window might need resizing, or even to be
>> completely disabled, if the PCIe core were to change the standard BAR
>> register. Dynamically allocating a window when the BAR is written
>> seems a little heavy-weight.
> 
> Why?

Well, it's just a bunch more code; much more than a simple writel().
