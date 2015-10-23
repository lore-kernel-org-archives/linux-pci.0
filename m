Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Loc Ho <lho@apm.com>, Murali Karicheri <m-karicheri2@ti.com>,
	KISHON VIJAY <kishon@ti.com>, WingMan Kwok <w-kwok2@ti.com>,
	Rob Herring <robh+dt@kernel.org>, pawel.moll@arm.com,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	galak@codeaurora.org, rogerq@ti.com, bhelgaas@google.com,
	ssantosh@kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] Common SerDes driver for TI's Keystone Platforms
Date: Fri, 23 Oct 2015 17:41:13 +0200
Message-ID: <4105684.I1HD0kYY7F@wuerfel>
In-Reply-To: <20151023144631.GZ32532@n2100.arm.linux.org.uk>
References: <1445432201-16007-1-git-send-email-w-kwok2@ti.com> <3702663.07h6YO0UjY@wuerfel> <20151023144631.GZ32532@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 23 October 2015 15:46:31 Russell King - ARM Linux wrote:
> On Fri, Oct 23, 2015 at 11:17:06AM +0200, Arnd Bergmann wrote:
> > On Thursday 22 October 2015 15:27:05 Loc Ho wrote:
> > However, for embedded systems that tend to ship with a minimal binary
> > bootloader and no way to update that as an end-user, we rely on Linux
> > to know about all the hardware that requires some form of setup, which
> > is why we have all sorts of drivers and frameworks in the kernel that
> > a server can easily ignore.
> > 
> > While keystone can show up in servers that won't use this driver, my
> > impression is that its main market is actually in embedded space.
> 
> That's an interesting point of view - especially as you can't make the
> argument that Marvell Armada chips would ever be anything but the
> embedded space, but we're so far getting away with having the serdes
> setup in u-boot - and even Marvell's BSP doesn't have it in the kernel.
> 
> The real question here is:
> 
>   Why would we want to statically setup serdes links in the kernel
>   according to the DTB, rather than having the boot loader set them up?
> 
> For the most part, the choice between the serdes modes is fairly static,
> depending on the board wiring.  You wouldn't ever want to configure a
> mini-PCIe socket for gigabit ethernet.

To rephrase what I was saying above: we need to know whether we can
trust the bootloader to get it right. In servers, it's absolutely
required for the firmware to do this properly as far as I'm concerned.

If Marvell's bootloader gets this right reliably as well, that's great.
However, certain companies have been known in the past to ship
crazy broken bootloaders and for each thing that they get wrong, we
have to make up in the kernel unless we can get all users to upgrade
their bootloaders to a fixed version.

> However, there are cases when you would want to change it, and I'm
> aware of these cases:
> 
> * Serdes routed to a mini-PCIe socket, which is compatible with mSATA.
>   There's an argument here to allow the serdes link to be switched at
>   runtime between PCIe and mSATA.  However, the card type can't be
>   detected at run time, so this would have to be a manual configuration
>   change by the user.
> 
>   Since mini-PCIe is not hot-pluggable, this configuration isn't
>   something that could be changed without powering the system down.

Right, but isn't this something that the firmware ought to be able
to figure out? For a server, I would expect that there needs to be
a way to detect what card is plugged and, have it set up correctly
and put all the right entries into the DT.

u-boot could probably do the same thing, but I would expect at least
some hardware vendors to get some part of it wrong on an embedded
machine.

> * Serdes routed to a SFP cage, where the serdes link is configured
>   for gigabit (or faster for SFP+) ethernet.  For gigabit only, serdes
>   is configured in either 1000base-X or Cisco SGMII mode (SGMII is a
>   non-802.3 modification to 1000base-X) depending on the type of
>   transceiver plugged in.
> 
>   Arguably, there's a third option here, which is SATA as well -  I'm
>   aware of one non-standard SFP module on the market which provides a
>   SATA connector, but this is highly non-standard, is not covered by
>   the SFP specifications, so such a switch to this mode would have to
>   be done manually.
> 
> The difference between 1000base-X vs SGMII is to do with the generation
> and interpretation of a 16-bit configuration word passed across the
> link.  Otherwise, the two are identical - and so far I've seen the
> configuration word mode is determined by the ethernet block rather than
> the serdes block.
> 
> My argument would be that even in the case of the last paragraph,
> normal use for serdes reconfiguration would be a power cycle, even in
> the embedded environment.
> 
> Now, that all said, it looks to me like TI's serdes implementation can't
> be switched between different modes - it's statically configured to
> whatever the DTB says it should be.

Right, otherwise we would use a single compatible string and use the
settings as an argument.

> So, this brings up the obvious question: why do we need to support
> serdes configuration in the kernel rather than statically in the boot
> loader according to the board setup?
> 
> Specifically on this patch series, I think that if we're going to have
> code doing serdes configuration in the kernel, we need to come up with
> a common set of DT properties for it, rather than having everyone doing
> their own thing.  I'd also like to see the code shrink in size - it
> doesn't do anything beyond configuring the hardware for the settings
> that DTB tells it to, so why it has to be 2.5k lines I've no idea.

I can think of one more point that you have not mentioned: we may need
to want to include the PHY in the runtime power management. If the PHY
loses its state in low-power mode, we need to either read it out on
suspend to program it back, or regenerate the settings from DT.

	Arnd
