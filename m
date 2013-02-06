Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51344 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab3BFWmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 17:42:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations for Armada XP
Date: Wed, 6 Feb 2013 22:41:14 +0000
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
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-23-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-23-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201302062241.14444.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 28 January 2013, Thomas Petazzoni wrote:
> +
> +               /*
> +                * MV78230 has 2 PCIe units Gen2.0: One unit can be
> +                * configured as x4 or quad x1 lanes. One unit is
> +                * x4/x1.
> +                */
> +               pcie-controller {
> +                       compatible = "marvell,armada-370-xp-pcie";
> +                       status = "disabled";
> +
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +
> +                       bus-range = <0x00 0xff>;
> +
> +                       ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
> +                                 0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
> +                                 0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
> +                                 0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
> +                                 0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
> +                                 0x81000000 0 0          0xc0000000 0 0x00010000   /* downstream I/O */
> +                                 0x82000000 0 0          0xc1000000 0 0x08000000>; /* non-prefetchable memory */
> +

I've been thinking some more about this, and I wonder if it would
make more sense to describe the address remapping correctly as
a node on top of the pcie-controller node.

This would mean that rather than putting the mapped physical address
(0xc0000000, 0xc1000000, ...) in here, you would actually have 64-bit
address as the destination as well, in whatever format the
address map hardware uses, I assume using a numbered 32 bit
address space for each object that can be remapped.

This would also let you do the PCI memory address assignment for
each port separately, starting at bus address 0, followed by
finding a location in the CPU address space and passing
the start as the sys->mem_offset argument to
pci_add_resource_offset.

> +                       pcie@0,0 {
> +                               device_type = "pciex";
> +                               reg = <0x0800 0 0xd0040000 0 0x2000>;
> +                               #address-cells = <3>;
> +                               #size-cells = <2>;
> +                               marvell,pcie-port = <0>;
> +                               marvell,pcie-lane = <0>;
> +                               interrupts = <1>;
> +                               clocks = <&gateclk 5>;
> +                               status = "disabled";
> +                       };

I think you are missing a "ranges" property here, at least an empty
one, which is required by the standard but not currently enforced
in the code.
	Arnd
