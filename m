Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:49354 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3CFSKD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Mar 2013 13:10:03 -0500
Date: Wed, 6 Mar 2013 11:09:46 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130306180946.GA2433@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 06, 2013 at 01:11:19PM +0100, Thierry Reding wrote:

> I agree here. It seems that back at the time when the PCI DT bindings
> were devised no hardware existed with these properties. So I think that
> maybe it needs to be revised to take into account some of these new
> requirements. Just adding a bunch of properties to work around
> shortcomings in the specification doesn't seem very desirable to me.

Well, all the PCI hosts should use the same mechanism, and it should
make sense in the context of the rest of the spec. So I think some
approval/comment on this specific issue by Grant/Rob/Arnd is important
at this point.

The way the spec is written, 'reg' in a 'device_type = pci' context is
the device's config address - it is like 'reg' in a CPU block, or I2C
bus - the value has nothing to do with CPU mappable memory.

> space. According to the PCI DT specification this isn't allowed, but it
> works on Linux and quite frankly I don't see why it shouldn't be
> allowed.

AFAIK, this only works because you are not using 'device_type = pci'.

IMHO, 'device_type = pci' is not optional, so you need to come up with
something that works under those conditions, and it changes how the OF
core handles 'reg' and the like.

As I said before, the two best options to me seem to be:

pcie-controller {
 compatible = "marvell,armada-370-xp-pcie";

  // Index by marvell,pcie-port/reg-names/etc
  regs = <0xd0040000 0x00002000
          0xd0080000 0x00002000>;

  ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
            0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchable memory */

  pcie@0,0 {
       device_type = "pci";
       reg = <0x0800 0 0 0>; // 00:01.0  (????)
       marvell,pcie-port = <0>;
  };
}

or:

pcie-controller {
  compatible = "marvell,armada-370-xp-pcie";

  ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
            0x82000000 0 0  0xc1000000  0 0x08000000   /* non-prefetchable memory */
            // Mapping for per-port host controller registers
            0x82000000 0x10000000 0xd0040000  0xd0040000  0 0x2000>;

  pcie@0,0 {
       device_type = "pci";
       reg = <0x0800 0 0 0>; // 00:01.0  (????)
       marvell,pcie-port = <0>;
       
       assigned-addresses = <0 0 0  0 0 // BAR 0 of the bridge, unused
       			     0 0 0  0 0 // BAR 1 of the bridge, unused
                             0x82000000 0x10000000 0xd0040000  0 0x2000>; // Extended

  };
}

Both have various problems, but I think I prefer the first one as it
doesn't conflate the contoller registers and host apertures in a
single ranges..

Jason
