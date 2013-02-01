Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:46351 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab3BABlh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jan 2013 20:41:37 -0500
Date: Thu, 31 Jan 2013 18:41:38 -0700
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
Message-ID: <20130201014138.GA16234@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <510B0D9C.1000101@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510B0D9C.1000101@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 31, 2013 at 05:34:36PM -0700, Stephen Warren wrote:
> On 01/28/2013 11:56 AM, Thomas Petazzoni wrote:
> > This driver implements the support for the PCIe interfaces on the
> > Marvell Armada 370/XP ARM SoCs. In the future, it might be extended to
> > cover earlier families of Marvell SoCs, such as Dove, Orion and
> > Kirkwood.
> 
> Bjorn and I happen to live very close, so we got together today and
> talked about PCIe on ARM.
> 
> One of the questions he asked is: why does the window management on the
> Marvell SoCs need to be dynamic?

> (Sorry if this was covered earlier; I vaguely recall some discussion on
> the topic, but couldn't find it quickly)

Well I've answered it several times, so has Thomas.. Lets try again,
please save for future reference :)

Lets seperate two things.

The CPU physical address ranges reserved for PCI bus access are not
dynamic. This is set in DT, or whatever, statically. Just like every
other PCI case on ARM. Just like Tegra. That is not the issue.

What is required is that the division of this space amongst the 10
physical PCI-E links must be dynamic. Just like x86. Just like the new
tegra driver. [1]

Is that clear?

> As background, PCIe enumeration in Linux usually works like:
> 
> 1) You start off with some CPU physical address regions that generate
> transactions on the PCIe bus.
> 
> 2) You enumerate all the PCIe devices, and assign an address to each BAR
> found, carved out of the PCIe address range corresponding to the regions
> you knew from (1).

Step 2 also includes 'assign address windows to all the physical PCI-E
links'. This is very important because it is what this entire
discussion is about.

Look at how tegra or x86 works, the CPU physical addresses for PCI-E
do nothing until the PCI-to-PCI bridge window registers in each link's
configuration space are setup. Until that is done the SOC doesn't know
which link to send the transaction to.

Marvell is the same, until the link's window registers are setup the
CPU addresses don't go anywhere.

Notice this has absolutely no effect on the host bridge aperture.
This is a link-by-link configuration of what addresses *go down that
link*.

The big difference is the link window registers for Marvell do not
conform to the PCI configuration space specification. They are Marvell
specific.

This is what the glue code in the host driver does, it converts the
Marvell specificness into something the kernel can undertstand and
control. There are countless ways to do this, but please accept it
is necessary that it be done...

> Now, I recall that a related issue was that you are tight on CPU
> physical address space, and the second algorithm above would allow the
> size of the PCIe controller's window configuration to be as small as
> possible, and hence there would be more CPU physical address space
> available to fit in other peripherals.

Physical address space is certainly a concern, but availability of
decoder windows is the major one. Each link requires one decoder
window for MMIO and one for IO, and possibly one for prefetch. The
chip doesn't have 30 decoder windows. So the allocation of decoders to
links must be dynamic, based on the requirements of the downstream
endports on the link.

> However, why does this need to be dynamic? On a particular board, you
> know all the other (non-PCIe) peripherals that you need to fit into the
> CPU physical address space, so you know how much is left over for PCIe,
> so why not always make the PCIe window fill up all the available
> space,

Because there is no such thing as an all-links PCIe window on this
hardware.

Each link has a seperate window.

If you get rid of all the dynamic allocation then every link must
statically reserve some portion of physical address space and some
number of decoder windows.

That more or less means you need to know what is going to be on the
other side of every link when you write the DT.

> With a static window configuration in DT, you'd end up with a system
> that worked much like any x86 system or Tegra, with some static memory
> range available to PCIe. It's just that in your case, the region
> location/size could change from boot to boot based on DT, whereas it's
> hard-coded in HW for Tegra and I assume x86 too.

How is this better? Now you have a system where you have to customize
the DT before you connect a PCI-E device. What if someone uses this
chip in a configuration with physical slots? How does that work? What
about hotplug? What about a unified kernel? That is *not* like x86 or
tegra.

IMHO Thomas's direction in his proposed driver ends up working very
close to the new tegra driver, and has the sort of dynamic allocation
and discovery people expect from PCI-E.

Jason

1 - The new tegra driver switches from calling ARM's pci_common_init
    once for every physical link, to once for the SOC. It does this by
    fixing the routing of config transactions so that the kernel sees
    the per-link PCI-PCI root port bridge config space provided by the
    hardware at the correct place. By doing this it changes from
    statically allocating a physical memory region for each link to
    statically allocating a region for all the links, and dynamically
    dividing that region amongst the links.
