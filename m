Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:37555 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766Ab3BFRJS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Feb 2013 12:09:18 -0500
Date: Wed, 6 Feb 2013 10:09:03 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
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
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130206170903.GA28198@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <2776630.gp5gC9tvLk@wuerfel>
 <20130131180249.GA30869@obsidianresearch.com>
 <201301312046.22560.arnd@arndb.de>
 <20130131224459.GA11846@obsidianresearch.com>
 <20130206175128.1b64196d@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130206175128.1b64196d@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 06, 2013 at 05:51:28PM +0100, Thomas Petazzoni wrote:

> > So you'd end up with a MMU mapping something like:
> >   PCI_IO_VIRT_BASE    MBUS_IO_PHYS_BASE
> >     0->4k          => 0      -> 4k             // 4k assigned to link0
> >     4k->8k         => 64k+4k -> 64k+8k         // 4k assigned to link1
> >     8k->24k        => 128k+8k -> 128k+24k      // 8k assigned to link2
> 
> I am not sure to understand your example, starting at the second line.
> Shouldn't the second line have been
> 
>       4k->8k         => 64k -> 64k+4k

No..
 
> as you suggested, then when the device driver will do an inl(0x4) on
> this device, the device will receive the equivalent of an inl(0x1004),
> no?

Link 0 translates like:

- Linux driver does inl(0x4)
- ARM layer converts that into a read from PCI_IO_VIRT_BASE + 0x4
- The CPU TLB converts that into a read from CPU physical
  0xc0000000 + 0x4
- The MBUS window remap register converts that into a read from IO
  space 0x4
- The address 0x4 is placed in the PCI-E IO transaction of link 0

Link 1 translates like:

- Linux driver does inl(0x1004)
- ARM layer converts that into a read from PCI_IO_VIRT_BASE + 0x1004
- The CPU TLB converts that into a read from CPU physical
  0xc0000000 + 0x11004 (ie the mbus window for the link 1)
- The MBUS window remap register converts that into a read from IO
  space 0x1004
- The address 0x1004 is placed in the PCI-E IO transaction of link 1

Noting that in both instances the IO address passed to inl is what
eventually appears on the PCI-E link after all the translation is
completed.

The CPU MMU is being used used to route 4k aligned ranges to the
correct link.

> I understand that I have two choices here:
> 
>  * First one is to make the I/O regions of all PCIe links fit below the
>    default IO_SPACE_LIMIT (0xffff) by doing the mapping trick you
>    described above.
> 
>  * Second one is to have one 64 KB block for each PCIe link, which
>    would require raising the IO_SPACE_LIMIT on this platform.

Yes, however, AFIAK this is the environment you should be running in:

#define IO_SPACE_LIMIT  ((resource_size_t)0xfffff)

Which is 5 f's not 4.

> > Though, there is still a problem with the MMIO mbus window
> > alignment. mbus windows are aligned to a multiple of their size, PCI
> > MMIO bridge windows are always aligned to 1M...
> 
> Can't this be solved using the window_alignement() hook we've been
> discussing separately? Just like we teach the Linux PCI core about our
> alignment requirements of 64K for the I/O regions, we could teach it
> about our alignment requirement on memory regions as well. No?

Hopefully :) As long as it can adjust the start and length you should
be fine.

Jason
