Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51886 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab3BACVF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 21:21:05 -0500
Message-ID: <510B268E.2040104@wwwdotorg.org>
Date: Thu, 31 Jan 2013 19:21:02 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com> <510B0D9C.1000101@wwwdotorg.org> <20130201014138.GA16234@obsidianresearch.com>
In-Reply-To: <20130201014138.GA16234@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/31/2013 06:41 PM, Jason Gunthorpe wrote:
> On Thu, Jan 31, 2013 at 05:34:36PM -0700, Stephen Warren wrote:
>> On 01/28/2013 11:56 AM, Thomas Petazzoni wrote:
>>> This driver implements the support for the PCIe interfaces on the
>>> Marvell Armada 370/XP ARM SoCs. In the future, it might be extended to
>>> cover earlier families of Marvell SoCs, such as Dove, Orion and
>>> Kirkwood.
>>
>> Bjorn and I happen to live very close, so we got together today and
>> talked about PCIe on ARM.
>>
>> One of the questions he asked is: why does the window management on the
>> Marvell SoCs need to be dynamic?
> 
>> (Sorry if this was covered earlier; I vaguely recall some discussion on
>> the topic, but couldn't find it quickly)
> 
> Well I've answered it several times, so has Thomas.. Lets try again,
> please save for future reference :)
> 
> Lets seperate two things.
> 
> The CPU physical address ranges reserved for PCI bus access are not
> dynamic. This is set in DT, or whatever, statically. Just like every
> other PCI case on ARM. Just like Tegra. That is not the issue.
> 
> What is required is that the division of this space amongst the 10
> physical PCI-E links must be dynamic. Just like x86. Just like the new
> tegra driver. [1]
> 
> Is that clear?

Yes.

>> As background, PCIe enumeration in Linux usually works like:
>>
>> 1) You start off with some CPU physical address regions that generate
>> transactions on the PCIe bus.
>>
>> 2) You enumerate all the PCIe devices, and assign an address to each BAR
>> found, carved out of the PCIe address range corresponding to the regions
>> you knew from (1).
> 
> Step 2 also includes 'assign address windows to all the physical PCI-E
> links'. This is very important because it is what this entire
> discussion is about.

OK.

> Look at how tegra or x86 works, the CPU physical addresses for PCI-E
> do nothing until the PCI-to-PCI bridge window registers in each link's
> configuration space are setup. Until that is done the SOC doesn't know
> which link to send the transaction to.

>From my perspective, this is slightly the wrong way of describing the
issue, but I see what you mean:

At least on Tegra and I think x86, any transaction that goes to the
physical PCIe aperture is translated onto (internal) PCIe bus 0, so the
lack of window or PCIe/PCIe bridge BAR register programming doesn't
prevent the transaction going /somewhere/ (even if "somewhere" is only
half way to where it's useful!). The difference is pretty subtle. The
issue is that without the PCIe/PCIe bridge BARs programmed, the PCIe
transactions won't get off bus 0 and onto a downstream bus of one of the
PCIe/PCIe bridges, or put another way, no PCIe/PCIe will claim the
transaction that happens on PCIe bus 0

(Using "PCIe/PCIe bridge" above to mean "PCIe root port")

> Marvell is the same, until the link's window registers are setup the
> CPU addresses don't go anywhere.
> 
> Notice this has absolutely no effect on the host bridge aperture.
> This is a link-by-link configuration of what addresses *go down that
> link*.

Right.

> The big difference is the link window registers for Marvell do not
> conform to the PCI configuration space specification. They are Marvell
> specific.
> 
> This is what the glue code in the host driver does, it converts the
> Marvell specificness into something the kernel can undertstand and
> control. There are countless ways to do this, but please accept it
> is necessary that it be done...

Sure.

>> Now, I recall that a related issue was that you are tight on CPU
>> physical address space, and the second algorithm above would allow the
>> size of the PCIe controller's window configuration to be as small as
>> possible, and hence there would be more CPU physical address space
>> available to fit in other peripherals.
> 
> Physical address space is certainly a concern, but availability of
> decoder windows is the major one. Each link requires one decoder
> window for MMIO and one for IO, and possibly one for prefetch. The
> chip doesn't have 30 decoder windows. So the allocation of decoders to
> links must be dynamic, based on the requirements of the downstream
> endports on the link.

Oh I see...

I originally thought the issue was that the windows were between CPU
physical address space and the PCIe host controller itself. But in fact,
the windows are between PCIe bus 0 and the root ports, so they're the
equivalent of the standard PCIe root port (or PCIe/PCIe bridge) BAR
registers. And related, these BAR/window registers are usually part of
each PCIe root port itself, and hence there's a whole number dedicated
to each root port, but on Marvell there's a *global* pool of these
BARs/windows instead.

Now I think I finally understand the architecture of your HW.

>> However, why does this need to be dynamic? On a particular board, you
>> know all the other (non-PCIe) peripherals that you need to fit into the
>> CPU physical address space, so you know how much is left over for PCIe,
>> so why not always make the PCIe window fill up all the available
>> space,
> 
> Because there is no such thing as an all-links PCIe window on this
> hardware.
> 
> Each link has a seperate window.
> 
> If you get rid of all the dynamic allocation then every link must
> statically reserve some portion of physical address space and some
> number of decoder windows.
> 
> That more or less means you need to know what is going to be on the
> other side of every link when you write the DT.

So, the dynamic programming of the windows on Marvell HW is the exact
logical equivalent of programming a standard PCIe root port's BAR
registers. It makes perfect sense that should be dynamic. Presumably
this is something you can make work inside your emulated PCIe/PCIe
bridge module, simply by capturing writes to the BAR registers, and
translating them into writes to the Marvell window registers.

Now, I do have one follow-on question: You said you don't have 30
windows, but how many do you have free after allocating windows to any
other peripherals that need them, relative to (3 *
number-of-root-ports-in-the-SoC)? (3 being IO+Mem+PrefetchableMem.)

The thing here is that when the PCIe core writes to a root port BAR
window to configure/enable it the first time, you'll need to capture
that transaction and dynamically allocate a window and program it in a
way equivalent to what the BAR register write would have achieved on
standard HW. Later, the window might need resizing, or even to be
completely disabled, if the PCIe core were to change the standard BAR
register. Dynamically allocating a window when the BAR is written seems
a little heavy-weight.

So while it's obvious that window base address and size shouldn't be
static, I wonder if the assignment of a specific window ID to a specific
root port ID shouldn be dynamic or static. For example, if your HW
configuration leaves you with 6 windows available, you could support 2
PCIe root ports by statically assigning 3 windows to serve each of those
2 root ports. Would that work, or are there systems where over-commit is
needed, e.g. if there's no IO space behind a root port, you could get
away with two windows per root port, and hence be able to run 3 root
ports rather than just 2? Still, if you know which PCIe devices are
being the root ports, you could still represent the over-commit
statically in DT

Still, I supose doing it dynamically in the driver does end up being a
lot less to think about for someone creating the DT for a new board.

Having to translate standard root port BAR register writes to Marvell
window register allocation/writes would imply that the emulated root
port code has to be very closely tied into the Marvell PCIe driver, and
not something that could be at all generic in the most part.

>> With a static window configuration in DT, you'd end up with a system
>> that worked much like any x86 system or Tegra, with some static memory
>> range available to PCIe. It's just that in your case, the region
>> location/size could change from boot to boot based on DT, whereas it's
>> hard-coded in HW for Tegra and I assume x86 too.
> 
> How is this better? Now you have a system where you have to customize
> the DT before you connect a PCI-E device. What if someone uses this
> chip in a configuration with physical slots? How does that work? What
> about hotplug? What about a unified kernel? That is *not* like x86 or
> tegra.

Right. Now that I really understand what the windows are doing, I can
see that a static window configuration (address/size, perhaps rather
than windows are used) would not be appropriate.

> IMHO Thomas's direction in his proposed driver ends up working very
> close to the new tegra driver, and has the sort of dynamic allocation
> and discovery people expect from PCI-E.
> 
> Jason
> 
> 1 - The new tegra driver switches from calling ARM's pci_common_init
>     once for every physical link, to once for the SOC. It does this by
>     fixing the routing of config transactions so that the kernel sees
>     the per-link PCI-PCI root port bridge config space provided by the
>     hardware at the correct place. By doing this it changes from
>     statically allocating a physical memory region for each link to
>     statically allocating a region for all the links, and dynamically
>     dividing that region amongst the links.

Right, we have both (or all 3) root ports show up in the same PCIe domain.
