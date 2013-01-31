Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57568 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab3AaUr0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 15:47:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Thu, 31 Jan 2013 20:46:22 +0000
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <2776630.gp5gC9tvLk@wuerfel> <20130131180249.GA30869@obsidianresearch.com>
In-Reply-To: <20130131180249.GA30869@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301312046.22560.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 31 January 2013, Jason Gunthorpe wrote:
> Thinking about this some more, which of these methods to choose is
> going to be dictated by what the Marvell HW does.
> 
> Since the IO space in the TLP is a full 32 bits, it matters what 32
> bit value the HW PCI core places in the IO Rd/Wr transaction. This
> value must match the value given to the Linux PCI core for resource
> allocation, because it must be correctly programmed by Linux into the
> downstream BARs/bridge windows.
> 
> So there are probably two choices for what the HW does, given a MBUS
> window of 0xDEAD0000 -> 0xDEADFFFF set for IO, a read from physical
> address 0xDEAD0000 produces a IO Rd TLP with either '0x00000000' or
> '0xDEAD0000' in the address field.
> 
> If it is 0xDEAD0000, then Thomas has to keep what he has now, you
> can't mess with this address. Verify that the full 32 bit address
> exactly matching the MBUS window address is written to the PCI-PCI
> bridge IO base/limit registers.

If you do this, you break all sorts of expectations in the kernel and
I guess you'd have to set the io_offset value of that bus to 0x21530000
in order to make Linux I/O port 0 go to the first byte of the window
and come out as 0xDEAD0000 on the bus, but you still won't be able to
use legacy devices with hardcoded I/O port numbers.

> If it is 0x00000000 then the mmap scheme I outlined before must be
> used, and verify that only 0->0xFFFF is written to the PCI-PCI bridge
> IO base/limit registers..

For the primary bus, yes, but there are still two options for the
second one: you can either start at 0 again or you can continue
at 0x10000 as we do for mv78xx0 and kirkwood for instance. Both
approaches probably have their merit.

	Arnd
