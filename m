Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 23 Oct 2015 15:46:31 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
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
Message-ID: <20151023144631.GZ32532@n2100.arm.linux.org.uk>
References: <1445432201-16007-1-git-send-email-w-kwok2@ti.com>
 <56295B9E.9030201@ti.com>
 <CAPw-ZTk1vJA3YSwLHBNMYP0t5k2tW0HTKse+37rL8izWN33y-w@mail.gmail.com>
 <3702663.07h6YO0UjY@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3702663.07h6YO0UjY@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 23, 2015 at 11:17:06AM +0200, Arnd Bergmann wrote:
> On Thursday 22 October 2015 15:27:05 Loc Ho wrote:
> > >
> > > phy-xgene.c
> > > -----------
> > >
> > > Looking at other drivers under drivers/phy, I could find phy-xgene.c which
> > > is close Keystone SerDes driver (. This is called APM X-Gene Multi-Purpose
> > > PHY driver. It defines following mode per the driver code
> > >
> > >         MODE_SATA       = 0,    /* List them for simple reference */
> > >         MODE_SGMII      = 1,
> > >         MODE_PCIE       = 2,
> > >         MODE_USB        = 3,
> > >         MODE_XFI        = 4,
> > >
> > > But seems to support only MODE_SATA. From the code, it appears, this driver
> > > is expected to be enhanced in the future to support additional modes. I have
> > > copied the author to this email to participate in this discussion.
> > 
> > Let me comment on this APM X-Gene driver. This driver is dead and
> > won't be supported in near or foreseeable future. And someday, it will
> > be ripped out. Based on experience, this solution (having PHY driver
> > in Linux) can't be supported across boards and etc as it is just too
> > much maintenance. And therefore, we followed Arnd B guidance and move
> > all this into the boot loader. From Linux or OS perspective, it only
> > cares about the interface in which its interface with. This is just
> > your reference and may be this will help you as well.
> 
> This depends a lot on the use case. If the chip is only used on server
> parts that have a real firmware and you can deliver bug fixes for the
> firmware if necessary, it's always best to do as much of the setup as
> possible there, and let Linux see a simplified view of the hardware.
> 
> However, for embedded systems that tend to ship with a minimal binary
> bootloader and no way to update that as an end-user, we rely on Linux
> to know about all the hardware that requires some form of setup, which
> is why we have all sorts of drivers and frameworks in the kernel that
> a server can easily ignore.
> 
> While keystone can show up in servers that won't use this driver, my
> impression is that its main market is actually in embedded space.

That's an interesting point of view - especially as you can't make the
argument that Marvell Armada chips would ever be anything but the
embedded space, but we're so far getting away with having the serdes
setup in u-boot - and even Marvell's BSP doesn't have it in the kernel.

The real question here is:

  Why would we want to statically setup serdes links in the kernel
  according to the DTB, rather than having the boot loader set them up?

For the most part, the choice between the serdes modes is fairly static,
depending on the board wiring.  You wouldn't ever want to configure a
mini-PCIe socket for gigabit ethernet.

However, there are cases when you would want to change it, and I'm
aware of these cases:

* Serdes routed to a mini-PCIe socket, which is compatible with mSATA.
  There's an argument here to allow the serdes link to be switched at
  runtime between PCIe and mSATA.  However, the card type can't be
  detected at run time, so this would have to be a manual configuration
  change by the user.

  Since mini-PCIe is not hot-pluggable, this configuration isn't
  something that could be changed without powering the system down.

* Serdes routed to a SFP cage, where the serdes link is configured
  for gigabit (or faster for SFP+) ethernet.  For gigabit only, serdes
  is configured in either 1000base-X or Cisco SGMII mode (SGMII is a
  non-802.3 modification to 1000base-X) depending on the type of
  transceiver plugged in.

  Arguably, there's a third option here, which is SATA as well -  I'm
  aware of one non-standard SFP module on the market which provides a
  SATA connector, but this is highly non-standard, is not covered by
  the SFP specifications, so such a switch to this mode would have to
  be done manually.

The difference between 1000base-X vs SGMII is to do with the generation
and interpretation of a 16-bit configuration word passed across the
link.  Otherwise, the two are identical - and so far I've seen the
configuration word mode is determined by the ethernet block rather than
the serdes block.

My argument would be that even in the case of the last paragraph,
normal use for serdes reconfiguration would be a power cycle, even in
the embedded environment.

Now, that all said, it looks to me like TI's serdes implementation can't
be switched between different modes - it's statically configured to
whatever the DTB says it should be.

So, this brings up the obvious question: why do we need to support
serdes configuration in the kernel rather than statically in the boot
loader according to the board setup?

Specifically on this patch series, I think that if we're going to have
code doing serdes configuration in the kernel, we need to come up with
a common set of DT properties for it, rather than having everyone doing
their own thing.  I'd also like to see the code shrink in size - it
doesn't do anything beyond configuring the hardware for the settings
that DTB tells it to, so why it has to be 2.5k lines I've no idea.

There's some specific comments I have about it using readl/writel, and
its wrapping of those, which IMHO it shouldn't be doing, and the horrid
for loops (what's wrong with the standard Linux way of defining a
for_each_xxx() operator and leaving the body at the callsite?)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
