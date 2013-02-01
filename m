Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55372 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3BALad (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 06:30:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Fri, 1 Feb 2013 11:30:18 +0000
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
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <201301312046.22560.arnd@arndb.de> <20130131224459.GA11846@obsidianresearch.com>
In-Reply-To: <20130131224459.GA11846@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302011130.18442.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 31 January 2013, Jason Gunthorpe wrote:
> On Thu, Jan 31, 2013 at 08:46:22PM +0000, Arnd Bergmann wrote:
> 
> > > If it is 0xDEAD0000, then Thomas has to keep what he has now, you
> > > can't mess with this address. Verify that the full 32 bit address
> > > exactly matching the MBUS window address is written to the PCI-PCI
> > > bridge IO base/limit registers.
> > 
> > If you do this, you break all sorts of expectations in the kernel and
> > I guess you'd have to set the io_offset value of that bus to 0x21530000
> > in order to make Linux I/O port 0 go to the first byte of the window
> > and come out as 0xDEAD0000 on the bus, but you still won't be able to
> > use legacy devices with hardcoded I/O port numbers.
> 
> I'm not sure exactly how the PCI core handles this, but it does look
> like pci_add_resource_offset via io_offset is the answer. I'm not sure
> what goes in the struct resource passed to the PCI core - the *bus* IO
> address range or the *kernel* IO address range..

IO Resources are always expressed in the kernel's view, so they are in
the range from 0 to IO_SPACE_LIMIT. The idea is that you can have multiple
buses that each have their own address space start at 0, but can put
them into the kernel address space at a different address.

Each device on any bus can still use I/O addresses starting at zero,
and you could have e.g. a VGA card on two buses each respond to I/O cycles
on port 0x3c0, but the PCI core will translate the resources to appear
in the kernel space at 0x103c0 for the second one.

> > > If it is 0x00000000 then the mmap scheme I outlined before must be
> > > used, and verify that only 0->0xFFFF is written to the PCI-PCI bridge
> > > IO base/limit registers..
> > 
> > For the primary bus, yes, but there are still two options for the
> > second one: you can either start at 0 again or you can continue
> 
> No, for *all* links. You use a mmap scheme with 4k granularity, I
> explained in a past email, but to quickly review..
> 
> - Each link gets 64k of reserved physical address space for IO,
>   this is just set aside, no MBUS windows are permantently assigned.
> - Linux is told to use a 64k IO range with bus IO address 0->0xFFFF
> - When the IO base/limit register in the link PCI-PCI bridge is programmed
>   the driver gets a 4k aligned region somewhere from 0->0xFFFF and then:
>     - Allocates a 64k MBUS window that translates physical address
>       0xZZZZxxxx to IO bus address 0x0000xxxx (goes in the TLP) for
>       that link
>     - Uses pci_ioremap_io to map the fraction of the link's 64k MBUS window
>       allocated to that bridge to the correct offset in the 
>       PCI_IO_VIRT_BASE region

We'd have to change pci_ioremap_io to allow mapping less than 64k, but
yes, that would work, too. I don't see an advantage to it though,
other than having io_offset always be zero.

> > at 0x10000 as we do for mv78xx0 and kirkwood for instance. Both
> > approaches probably have their merit.
> 
> Kirkwood uses the MBUS remapping registers to set the TLP address of
> link 0 to start at 0 and of link 1 to start at 0x10000 - so it is
> consistent with what you describe..

Right, so it also uses io_offset = 0 all the time, which means the
bus I/O port numbers are identical to the Linux I/O port numbers,
but they go beyond 64K on the bus on the second and later links.

> However, this is a suboptimal way to run the HW. It would be much
> better to place each link in a seperate PCI domain and have each link
> start its bus IO address at 0, and assign the kernel IO address in
> sequential 64k blocks as today.

I agree.

	Arnd
