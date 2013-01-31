Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50108 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab3AaQTH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 11:19:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Thu, 31 Jan 2013 17:18:46 +0100
Message-ID: <2776630.gp5gC9tvLk@wuerfel>
In-Reply-To: <20130131153625.GB23505@n2100.arm.linux.org.uk>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <20130131162237.79de29c4@skate> <20130131153625.GB23505@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 31 January 2013 15:36:25 Russell King - ARM Linux wrote:
> The pci_sys_data is not specific to one bus.  It's specific from the
> root bus downwards, and is shared by all child busses.
> 
> The problem is if you have some card or a conventional P2P bridge which
> has 4K windows.  If you merely set the alignment to 64K for all bridges,
> then all bridges get this treatment whether or not they need it.  That's
> what I'm trying to avoid.
> 
> Take, for instance, a cardbus bridge (remember, there are PCI cards which
> can be plugged in to give you a cardbus slot.)  I have a device here which
> can be plugged into a cardbus slot which has not just one P2P bridge but
> two, and a bunch of downsteam devices, including VGA, ethernet, USB, PS/2
> etc.  (Okay, Linux doesn't support this hardware because of crappy X86
> stuff, despite the fact Windows cope with it just fine.)
> 
> There have been cards in the past which have had P2P bridges on them as
> well.
> 
> So, simply believing that the only P2P bridges in the system will be
> those on the physical board is a mistake.

I was going to write something similar. Actually I think it's worse because
the case of an extra P2P bridge is quite likely for devices that actually
use I/O space, given that the use of I/O space is deprecated on PCIe.

This also means that a lot of devices using I/O space are legacy crap
and have random bugs regarding PCI standard compliance. I would not
expect those devices in general to do the right thing when I/O ports
beyond 65535 are used, although a lot of them would work.

For all I could tell, the safest solution with the I/O space would
be to pretend we had a shared 64K I/O space for all of the PCIe
ports on Armada XP, and map a separate 64K window for each port
using a different io_offset for each one.
This way, you can have a device on the second PCIe port use e.g. I/O
port number 0x3f8 for a legacy UART on the bus, which gets translated
into the Linux-visible port number 0x103f8.

The currently used method to have io_offset=0 for all PCIe ports
and use separate I/O port ranges of 64K for each PCIe port probably
still works for most devices, except those where we hardcode a port
number in the Linux device driver, or where the high address bits
don't get decoded properly.

	Arnd
