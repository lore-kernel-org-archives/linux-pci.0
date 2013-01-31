Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60279 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab3AaPs4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 10:48:56 -0500
Date: Thu, 31 Jan 2013 15:48:38 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
	systems
Message-ID: <20130131154838.GC23505@n2100.arm.linux.org.uk>
References: <20130130151934.GK23505@n2100.arm.linux.org.uk> <20130130163659.75360dba@skate> <20130130154602.GL23505@n2100.arm.linux.org.uk> <20130131153041.35fa3b60@skate> <20130131145002.GZ23505@n2100.arm.linux.org.uk> <20130131155737.4ab97a0b@skate> <20130131150801.GA23505@n2100.arm.linux.org.uk> <20130131162237.79de29c4@skate> <20130131153625.GB23505@n2100.arm.linux.org.uk> <20130131164735.3e1d4a88@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130131164735.3e1d4a88@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 31, 2013 at 04:47:35PM +0100, Thomas Petazzoni wrote:
> Dear Russell King - ARM Linux,
> 
> On Thu, 31 Jan 2013 15:36:25 +0000, Russell King - ARM Linux wrote:
> 
> > > The fixup is already specific to those bridges, since I am just setting
> > > pci_sys_data->win_align_io to 64K for the particular buses that are
> > > downstream the problematic bridges. So it doesn't affect any other bus
> > > on the system, and therefore I don't think this fixup needs to be made
> > > specific to a given vendor:device, no?
> > 
> > The pci_sys_data is not specific to one bus.  It's specific from the
> > root bus downwards, and is shared by all child busses.
> 
> Ah, ok, that's the part I was missing.
> 
> > The problem is if you have some card or a conventional P2P bridge which
> > has 4K windows.  If you merely set the alignment to 64K for all bridges,
> > then all bridges get this treatment whether or not they need it.  That's
> > what I'm trying to avoid.
> > 
> > Take, for instance, a cardbus bridge (remember, there are PCI cards which
> > can be plugged in to give you a cardbus slot.)  I have a device here which
> > can be plugged into a cardbus slot which has not just one P2P bridge but
> > two, and a bunch of downsteam devices, including VGA, ethernet, USB, PS/2
> > etc.  (Okay, Linux doesn't support this hardware because of crappy X86
> > stuff, despite the fact Windows cope with it just fine.)
> > 
> > There have been cards in the past which have had P2P bridges on them as
> > well.
> > 
> > So, simply believing that the only P2P bridges in the system will be
> > those on the physical board is a mistake.
> 
> Yes, indeed, I understand this. I just thought this pci_sys_data
> structure was per-bus. Of course, if it's shared by all buses on the
> system, we need a way to apply this fixup only to the Marvell bridges.
> 
> Should I just hard-code this special fixup in
> pcibios_window_alignment() with a check on VID/PID ?

Yes please.
