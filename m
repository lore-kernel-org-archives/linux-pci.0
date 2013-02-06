Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52609 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962Ab3BFRS7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 12:18:59 -0500
Date: Wed, 6 Feb 2013 18:18:52 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
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
Message-ID: <20130206181852.4eca53e3@skate>
In-Reply-To: <20130206170903.GA28198@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
	<2776630.gp5gC9tvLk@wuerfel>
	<20130131180249.GA30869@obsidianresearch.com>
	<201301312046.22560.arnd@arndb.de>
	<20130131224459.GA11846@obsidianresearch.com>
	<20130206175128.1b64196d@skate>
	<20130206170903.GA28198@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Wed, 6 Feb 2013 10:09:03 -0700, Jason Gunthorpe wrote:

> Link 0 translates like:
> 
> - Linux driver does inl(0x4)
> - ARM layer converts that into a read from PCI_IO_VIRT_BASE + 0x4
> - The CPU TLB converts that into a read from CPU physical
>   0xc0000000 + 0x4
> - The MBUS window remap register converts that into a read from IO
>   space 0x4
> - The address 0x4 is placed in the PCI-E IO transaction of link 0
> 
> Link 1 translates like:
> 
> - Linux driver does inl(0x1004)
> - ARM layer converts that into a read from PCI_IO_VIRT_BASE + 0x1004
> - The CPU TLB converts that into a read from CPU physical
>   0xc0000000 + 0x11004 (ie the mbus window for the link 1)
> - The MBUS window remap register converts that into a read from IO
>   space 0x1004
> - The address 0x1004 is placed in the PCI-E IO transaction of link 1

This last step is exactly what I thought would not work. If the PCIe
device has say 64 bytes of I/O space, then this 0x1004 PCI-E
transaction will be out of bounds, no?

Sorry, still learning how PCI works...

> > I understand that I have two choices here:
> > 
> >  * First one is to make the I/O regions of all PCIe links fit below the
> >    default IO_SPACE_LIMIT (0xffff) by doing the mapping trick you
> >    described above.
> > 
> >  * Second one is to have one 64 KB block for each PCIe link, which
> >    would require raising the IO_SPACE_LIMIT on this platform.
> 
> Yes, however, AFIAK this is the environment you should be running in:
> 
> #define IO_SPACE_LIMIT  ((resource_size_t)0xfffff)
> 
> Which is 5 f's not 4.

Aaah, you're right. My eyes got the number of f wrong. So I have 16
times 64 KB. So why would I bother doing the MMU trick if I can just
nicely remap 64 KB for each PCIe link ?

> > Can't this be solved using the window_alignement() hook we've been
> > discussing separately? Just like we teach the Linux PCI core about our
> > alignment requirements of 64K for the I/O regions, we could teach it
> > about our alignment requirement on memory regions as well. No?
> 
> Hopefully :) As long as it can adjust the start and length you should
> be fine.

Why would you need to adjust the length? If Linux allocates a 2 MB
resource on a 1 MB boundary, we simply increase the start address to
the next 2 MB boundary, and that's it. Why would the length need to
change?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
