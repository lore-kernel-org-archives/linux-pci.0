Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63508 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab3BGIES (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 03:04:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations for Armada XP
Date: Thu, 7 Feb 2013 08:04:12 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201302062241.14444.arnd@arndb.de> <20130207000715.0b3d662d@skate>
In-Reply-To: <20130207000715.0b3d662d@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302070804.12256.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 06 February 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Wed, 6 Feb 2013 22:41:14 +0000, Arnd Bergmann wrote:
> 
> > I've been thinking some more about this, and I wonder if it would
> > make more sense to describe the address remapping correctly as
> > a node on top of the pcie-controller node.
> > 
> > This would mean that rather than putting the mapped physical address
> > (0xc0000000, 0xc1000000, ...) in here, you would actually have 64-bit
> > address as the destination as well, in whatever format the
> > address map hardware uses, I assume using a numbered 32 bit
> > address space for each object that can be remapped.
> > 
> > This would also let you do the PCI memory address assignment for
> > each port separately, starting at bus address 0, followed by
> > finding a location in the CPU address space and passing
> > the start as the sys->mem_offset argument to
> > pci_add_resource_offset.
> 
> Hum, good you give a skeleton example, because I'm not sure to
> understand your suggestion.

I mean (roughly, since I don't know how that hardware defines it)

/ {
	#address-cells = <1>;
	#size-cells = <1>;

	memory@0 {
		/* this node can not get remapped */
		reg = <0x0 0x40000000>;
	};

	address-map {
		/* this device translates 64 bit MMIO bus addresses into 32 bit CPU addresses */
		compatible = "marvell,armada-addr-decoding-controller";
		reg = <0xd0020000 0x258>;
		#addres-cells = <2>;
		#address-cells = <1>;

		/* each remapped window has one entry here */
		ranges = <0xa 0 0xc0000000 0x10000>,     /* map window a to 0xc0000000 */
		         <0xb 0 0xc1000000 0x08000000>,  /* map window b to 0xc1000000 */
			 <...>; /* more windows */

		pciex {
			#addres-cells = <3>;
			#size-cells = <2>;
			ranges = <0x81000000 0 0 0xa 0 0 0x00010000,  /* I/O is window a */
				  0x82000000 0 0 0xb 0 0 0x08000000>; /* non-prefetchable memory */
			...
		};


		something-else {
			...
			reg = <0xc 0 0x10000>; /* window c */
		};
	};
};

> > 
> > > +                       pcie@0,0 {
> > > +                               device_type = "pciex";
> > > +                               reg = <0x0800 0 0xd0040000 0
> > > 0x2000>;
> > > +                               #address-cells = <3>;
> > > +                               #size-cells = <2>;
> > > +                               marvell,pcie-port = <0>;
> > > +                               marvell,pcie-lane = <0>;
> > > +                               interrupts = <1>;
> > > +                               clocks = <&gateclk 5>;
> > > +                               status = "disabled";
> > > +                       };
> > 
> > I think you are missing a "ranges" property here, at least an empty
> > one, which is required by the standard but not currently enforced
> > in the code.
> 
> Is it really wise to have DT properties that are not used by anything,
> and therefore have a very high chance of either being incorrect, or
> becoming incorrect?

In this case, definitely. It's mandated by an IEEE standard and the only reason
why we let some mistakes slip here is that some ancient PowerMac systems
get it wrong in their firmware. There are lots of cases where the difference
between an empty "ranges" property and an absent one is very significant
and I would really prefer to change the kernel to be standard compliant
here.

	Arnd
