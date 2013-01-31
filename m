Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:36809 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab3AaSCx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jan 2013 13:02:53 -0500
Date: Thu, 31 Jan 2013 11:02:49 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130131180249.GA30869@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <20130131162237.79de29c4@skate>
 <20130131153625.GB23505@n2100.arm.linux.org.uk>
 <2776630.gp5gC9tvLk@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2776630.gp5gC9tvLk@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 31, 2013 at 05:18:46PM +0100, Arnd Bergmann wrote:

> For all I could tell, the safest solution with the I/O space would
> be to pretend we had a shared 64K I/O space for all of the PCIe
> ports on Armada XP, and map a separate 64K window for each port
> using a different io_offset for each one.
> This way, you can have a device on the second PCIe port use e.g. I/O
> port number 0x3f8 for a legacy UART on the bus, which gets translated
> into the Linux-visible port number 0x103f8.
> 
> The currently used method to have io_offset=0 for all PCIe ports
> and use separate I/O port ranges of 64K for each PCIe port probably
> still works for most devices, except those where we hardcode a port
> number in the Linux device driver, or where the high address bits
> don't get decoded properly.

Thinking about this some more, which of these methods to choose is
going to be dictated by what the Marvell HW does.

Since the IO space in the TLP is a full 32 bits, it matters what 32
bit value the HW PCI core places in the IO Rd/Wr transaction. This
value *must* match the value given to the Linux PCI core for resource
allocation, because it must be correctly programmed by Linux into the
downstream BARs/bridge windows.

So there are probably two choices for what the HW does, given a MBUS
window of 0xDEAD0000 -> 0xDEADFFFF set for IO, a read from physical
address 0xDEAD0000 produces a IO Rd TLP with either '0x00000000' or
'0xDEAD0000' in the address field.

If it is 0xDEAD0000, then Thomas has to keep what he has now, you
can't mess with this address. Verify that the full 32 bit address
exactly matching the MBUS window address is written to the PCI-PCI
bridge IO base/limit registers.

If it is 0x00000000 then the mmap scheme I outlined before must be
used, and verify that only 0->0xFFFF is written to the PCI-PCI bridge
IO base/limit registers..

My guess is the Marvell PCI-E copies whatever address is it given into
the IO TLP, so it would be the 0xDEAD0000 behaviour, however I bet you
can use the MBUS window target address remapping feature to get the
0x00000000 behaviour as well (though there are a limited number of
remappable MBUS windows, so that is probably not a good idea)

Jason
