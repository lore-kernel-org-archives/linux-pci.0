Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:59709 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab3CJGzw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 10 Mar 2013 01:55:52 -0500
Date: Sat, 9 Mar 2013 23:55:39 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130310065539.GA14704@obsidianresearch.com>
References: <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <513A7845.6040304@firmworks.com>
 <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513C117D.6080800@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 09, 2013 at 06:52:13PM -1000, Mitch Bradley wrote:

> Okay, I think I finally get it.  The Marvell root port bridge setup
> registers look like standard config headers, even though they aren't
> really in config space (because you need a different access method for
> them, compared to real config accesses to downstream devices).

Well, thats pretty close. On Marvell the MMIO space has a lot of
stuff, some of it is config related, lots of it isn't. In fact most of
it isn't. Tegra is different, the MMIO region is exactly the config
space of the root port bridge.

Tegra could probably happily and sanely do as you've described (well,
see below), but it is wonky for Marvell. It looks like there are more
drivers coming that have this need - so I had hoped for a general
answer to the 'per-port MMIO space' problem that is unrelated to the
MMIO spaces role in config access.

> So, in order for the common code that enumerates the PCI bus to work,
> you need to "spoof" the config accesses so that when you try to access
> those particular "pseudo config headers", it uses the MMIO method
> instead of the real config access method.

There are rules for config access in both Tegra and Marvell that are
not trivial. Again, the driver takes are of this and all Linux sees is
a nice compliant config space.

> If that is indeed the case, them I would vote for a slight modification
> of the intermediate patch that I cited earlier - the one in which the
> ranges property includes translations from those special config
> addresses into CPU addresses.  The modification is to fix the sizes,
> changing 0x2000 to 0x800, so those ranges entries do not overlap in the
> child address domain.

On Marvell the size of the MMIO space is 0x2000, there are imporant
registers there beyond index 0x800 (todays driver may not touch them
but HW has them). Reducing the size doesn't seem appropriate.

> pcie-controller {
> 	compatible = "marvell,armada-370-pcie";
> 	status = "disabled";

        device_type = "pci";                                                                    

Here as well, as you noted before?

> 	#address-cells = <3>;
> 	#size-cells = <2>;
> 
> 	bus-range = <0x00 0xff>;
> 
> 	ranges = <0x00000800 0 0          0xd4004000 0 0x00000800   /* Root
> port config header */
> 	          0x00001000 0 0          0xd4008000 0 0x00000800   /* Root
> port config header */
> 		  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /*
> non-prefetchable memory */
> 	          0x81000000 0 0          0xe8000000 0 0x00100000>; /*
> downstream I/O */
> 
> 	pcie@1,0 {
> 		device_type = "pci";
> 		reg = <0x0800 0 0 0 0>;

Okay, this was Thierry's original idea, and it was my note that this
didn't seem like a good choice. I'm not wedded to that, but I'll
explain my reasoning a bit.

Two things bothered me
  - Describing a CPU MMIO mapping with a config address space seems
    wonky
  - Linux's OF core doesn't parse a 'reg' property under
    'device_type = "pci"' as something CPU mappable, it only looks
    to assigned-addresses for that. So the OF core would need to learn
    how to handle this case, and it would have to be well defined..

    Thierry's original patch avoided this problem by not using
    device_type = "pci"..

Also, did you mean to have a 0 size for the 'reg'? How will things
know how big the MMIO region is? Can't just assume 0x800..

Again, thanks!
Jason
