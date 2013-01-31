Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:33157 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326Ab3AaWpK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jan 2013 17:45:10 -0500
Date: Thu, 31 Jan 2013 15:44:59 -0700
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
Message-ID: <20130131224459.GA11846@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <2776630.gp5gC9tvLk@wuerfel>
 <20130131180249.GA30869@obsidianresearch.com>
 <201301312046.22560.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301312046.22560.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 31, 2013 at 08:46:22PM +0000, Arnd Bergmann wrote:

> > If it is 0xDEAD0000, then Thomas has to keep what he has now, you
> > can't mess with this address. Verify that the full 32 bit address
> > exactly matching the MBUS window address is written to the PCI-PCI
> > bridge IO base/limit registers.
> 
> If you do this, you break all sorts of expectations in the kernel and
> I guess you'd have to set the io_offset value of that bus to 0x21530000
> in order to make Linux I/O port 0 go to the first byte of the window
> and come out as 0xDEAD0000 on the bus, but you still won't be able to
> use legacy devices with hardcoded I/O port numbers.

I'm not sure exactly how the PCI core handles this, but it does look
like pci_add_resource_offset via io_offset is the answer. I'm not sure
what goes in the struct resource passed to the PCI core - the *bus* IO
address range or the *kernel* IO address range..

> > If it is 0x00000000 then the mmap scheme I outlined before must be
> > used, and verify that only 0->0xFFFF is written to the PCI-PCI bridge
> > IO base/limit registers..
> 
> For the primary bus, yes, but there are still two options for the
> second one: you can either start at 0 again or you can continue

No, for *all* links. You use a mmap scheme with 4k granularity, I
explained in a past email, but to quickly review..

- Each link gets 64k of reserved physical address space for IO,
  this is just set aside, no MBUS windows are permantently assigned.
- Linux is told to use a 64k IO range with bus IO address 0->0xFFFF
- When the IO base/limit register in the link PCI-PCI bridge is programmed
  the driver gets a 4k aligned region somewhere from 0->0xFFFF and then:
    - Allocates a 64k MBUS window that translates physical address
      0xZZZZxxxx to IO bus address 0x0000xxxx (goes in the TLP) for
      that link
    - Uses pci_ioremap_io to map the fraction of the link's 64k MBUS window
      allocated to that bridge to the correct offset in the 
      PCI_IO_VIRT_BASE region

So you'd end up with a MMU mapping something like:
  PCI_IO_VIRT_BASE    MBUS_IO_PHYS_BASE
    0->4k          => 0      -> 4k             // 4k assigned to link0
    4k->8k         => 64k+4k -> 64k+8k         // 4k assigned to link1
    8k->24k        => 128k+8k -> 128k+24k      // 8k assigned to link2

Where the physical mbus window for each link starts on each 64k block.

Thomas: This solves the need to have alignment of the IO regions, and
gets rid of any trouble with 32 bit IO addreses, however you'll need
to allocate the remap capable mbus windows separately for use by IO
mappings..

Though, there is still a problem with the MMIO mbus window
alignment. mbus windows are aligned to a multiple of their size, PCI
MMIO bridge windows are always aligned to 1M...

> at 0x10000 as we do for mv78xx0 and kirkwood for instance. Both
> approaches probably have their merit.

Kirkwood uses the MBUS remapping registers to set the TLP address of
link 0 to start at 0 and of link 1 to start at 0x10000 - so it is
consistent with what you describe..

However, this is a suboptimal way to run the HW. It would be much
better to place each link in a seperate PCI domain and have each link
start its bus IO address at 0, and assign the kernel IO address in
sequential 64k blocks as today.

Though, it is my hope that Thomas's driver will work on Kirkwood as
well...

Jason
