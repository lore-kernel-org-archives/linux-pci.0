Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:57321 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754566Ab3BATjj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Feb 2013 14:39:39 -0500
Date: Fri, 1 Feb 2013 12:39:35 -0700
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
Message-ID: <20130201193935.GA19335@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <510B0D9C.1000101@wwwdotorg.org>
 <20130201014138.GA16234@obsidianresearch.com>
 <510B268E.2040104@wwwdotorg.org>
 <20130201094613.38fa2ad0@skate>
 <510C0200.5040505@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510C0200.5040505@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 01, 2013 at 10:57:20AM -0700, Stephen Warren wrote:

> > We have 20 windows on Armada XP if I remember correctly, and they are
> > not only used for PCIe, but also to map the BootROM (needed to boot
> > secondary CPUs), to map SPI flashes or NOR flashes, for example. So
> > they are really shared between many uses. In terms of PCIe, there are
> > only two types of windows: I/O and Memory, there is no notion of
> > Prefetchable Memory window as far as I could see.
> 
> In Tegra, we end up having separate MMIO vs. Prefetchable MMIO
> chunks of our overall PCIe aperture. However, the HW setup appears
> the same for both of those. I'm not sure if it's a bug in the
> driver, or if it's just to separate the two address spaces so that
> the page tables can be configured for those two regions with large
> rather than small granularity. I need to go investigate that.

The only purpose of prefetchable space is for legacy PCI. When a P2P
bridge targets legacy PCI it has different behavior for its
prefetchable memory window compared to the non-prefetchable memory
window.

IIRC (though it has been a long time since I looked really close at
this) PCI-X and PCI-E did away with this special bridge behaviour but
kept the prefetchable memory space for compatibility.

These days it is typically used to mark cachable memory on an end
device.

>From a SOC perspective, there is no need to treat MMIO and prefetch
areas any differently. ARM's per-page cachability flags can be used to
deal with the differing caching requirements.

However, the bus tree downstream of each root port will require the
prefetch window to be contiguous. On Marvell, today, this means you
need to burn two mbus windows to get this. If the Linux pci core could
allocate the prefetch space for each root port bridge contiguously
with the mmio space for the same root port then this could be reduced
to one window covering both spaces for the port.

> So there are 10 PCIe interfaces (root ports). That's on the SoC itself
> right. Are all 10 (or a large number of them) actually used at once on
> any given board design? I suppose this must be the case, or Marvell
> wouldn't have wasted the silicon space on 10 root ports... Still, that's
> a rather large number of ports!

Agreed.. I have no idea what the target is for this..
 
> I think the only difference on the Marvell HW is:
> 
> * The overall total size of the physical address space is dynamic rather
> than fixed, because it's programmed through windows rather than
> hard-coded into HW.

Is it hard coded on tegra? I thought there was a register set that was
used to set the overall PCI-E MMIO window location and size. I know
even on x86 the PCI window is set via register, though that typically
isn't disclosed except to bios writers.. 

Jason
