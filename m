Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:44686 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717Ab3BATwZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Feb 2013 14:52:25 -0500
Date: Fri, 1 Feb 2013 12:52:25 -0700
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
Message-ID: <20130201195225.GB19335@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201301312046.22560.arnd@arndb.de>
 <20130131224459.GA11846@obsidianresearch.com>
 <201302011130.18442.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201302011130.18442.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 01, 2013 at 11:30:18AM +0000, Arnd Bergmann wrote:

> IO Resources are always expressed in the kernel's view, so they are
> in the range from 0 to IO_SPACE_LIMIT. The idea is that you can have
> multiple buses that each have their own address space start at 0,
> but can put them into the kernel address space at a different
> address.

Sure, I see that.. and that seems reasonable as long as any IO bus
address aliases are put in separate PCI domains. It would be wonky if
devices on different PCI bus numbers in a single PCI domain had
overlaping IO addresses.

> > No, for *all* links. You use a mmap scheme with 4k granularity, I
> > explained in a past email, but to quickly review..
> > 
> > - Each link gets 64k of reserved physical address space for IO,
> >   this is just set aside, no MBUS windows are permantently assigned.
> > - Linux is told to use a 64k IO range with bus IO address 0->0xFFFF
> > - When the IO base/limit register in the link PCI-PCI bridge is programmed
> >   the driver gets a 4k aligned region somewhere from 0->0xFFFF and then:
> >     - Allocates a 64k MBUS window that translates physical address
> >       0xZZZZxxxx to IO bus address 0x0000xxxx (goes in the TLP) for
> >       that link
> >     - Uses pci_ioremap_io to map the fraction of the link's 64k MBUS window
> >       allocated to that bridge to the correct offset in the 
> >       PCI_IO_VIRT_BASE region
> 
> We'd have to change pci_ioremap_io to allow mapping less than 64k, but
> yes, that would work, too. I don't see an advantage to it though,
> other than having io_offset always be zero.

Erm, that is the whole point. No PCI device in the system, on any of
the 10 links, would be required to use a 32 bit IO address. All are 16
bit and there is no compatibility problem on any links. You don't need
to declare any one link as being 'io supporting' or something like
that, it just works out of the box.

Jason
